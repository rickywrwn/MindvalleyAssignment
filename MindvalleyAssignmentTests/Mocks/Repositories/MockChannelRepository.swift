//
//  MockChannelRepository.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockChannelRepositoryImpl: ChannelRepositoryProtocol {
    private let networkService: MockNetworkService
    private let cacheService: CacheServiceProtocol
    private let cacheKey = "cached_channels"
    
    var mockData: Data?
    var mockResult: Result<[Channel], NetworkError>?
    
    init(networkService: MockNetworkService, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchChannels() async -> Result<[Channel], NetworkError> {
        
        let endpoint = APIEndpoint(
            path: "",
            method: .get
        )
        
        networkService.mockData = mockData
        
        let result: Result<DataResponse<ChannelData>, NetworkError> = await networkService.request(endpoint: endpoint)
        
        switch result {
        case .success(let response):
            let channel = response.data?.channels ?? []
            
//          Cache the fetched data
            do {
                try cacheService.save(channel, forKey: cacheKey)
            } catch {
                print("Cache save error: \(error.localizedDescription)")
            }
            return .success(channel)
            
        case .failure(let error):
//          Try to retrieve cached data if network request fails
            if let cachedChannel: [Channel] = try? cacheService.retrieve(forKey: cacheKey) {
                return .success(cachedChannel)
            }
            return .failure(error)
        }
        
    }
}
