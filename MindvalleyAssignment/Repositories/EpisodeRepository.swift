//
//  EpisodeRepository.swift.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

protocol EpisodeRepositoryProtocol {
    func fetchNewEpisode() async -> Result<[Media], NetworkError>
}

class EpisodeRepositoryImpl: EpisodeRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    private let cacheKey = "cached_episodes"
    
    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchNewEpisode() async -> Result<[Media], NetworkError> {
        let endpoint = APIEndpoint(
            path: "/raw/z5AExTtw",
            method: .get
        )
        
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
