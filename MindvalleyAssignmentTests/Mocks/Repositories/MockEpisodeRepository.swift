//
//  MockEpisodeRepository.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockEpisodeRepositoryImpl: EpisodeRepositoryProtocol {
    private let networkService: MockNetworkService
    private let cacheService: CacheServiceProtocol
    private let cacheKey = "cached_channels"
    
    var mockData: Data?
    var mockResult: Result<[Media], NetworkError>?
    
    init(networkService: MockNetworkService, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchNewEpisode() async -> Result<[Media], NetworkError> {
        
        let endpoint = APIEndpoint(
            path: "",
            method: .get
        )
        
        networkService.mockData = mockData
        
        let result: Result<DataResponse<MediaData>, NetworkError> = await networkService.request(endpoint: endpoint)
        
        switch result {
        case .success(let response):
            let media = response.data?.media ?? []
            
            // Cache the fetched data
            do {
                try cacheService.save(media, forKey: cacheKey)
            } catch {
                print("Cache save error: \(error.localizedDescription)")
            }
            return .success(media)
            
        case .failure(let error):
            // Try to retrieve cached data if network request fails
            if let cachedMedia: [Media] = try? cacheService.retrieve(forKey: cacheKey) {
                return .success(cachedMedia)
            }
            return .failure(error)
        }
        
    }
}
