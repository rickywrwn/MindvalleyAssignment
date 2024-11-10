//
//  DIContainerFactory.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - Factory Protocol
protocol DIContainerFactory {
    func makeNetworkService() -> NetworkServiceProtocol
    func makeCacheService() -> CacheServiceProtocol
    func makeChannelRepository(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) -> ChannelRepositoryProtocol
    func makeEpisodeRepository(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) -> EpisodeRepositoryProtocol
    func makeCategoryRepository(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) -> CategoryRepositoryProtocol
}

class DIFactory: DIContainerFactory {
    
    func makeNetworkService() -> NetworkServiceProtocol {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        
        let session = URLSession(configuration: configuration)
        return NetworkService(
            session: session
        )
    }
    
    func makeCacheService() -> CacheServiceProtocol {
        return try! CacheService()
    }
    
    func makeChannelRepository(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) -> ChannelRepositoryProtocol {
        return ChannelRepositoryImpl(networkService: networkService, cacheService: cacheService)
    }
    
    func makeEpisodeRepository(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) -> EpisodeRepositoryProtocol {
        return EpisodeRepositoryImpl(networkService: networkService, cacheService: cacheService)
    }
    
    func makeCategoryRepository(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) -> CategoryRepositoryProtocol {
        return CategoryRepositoryImpl(networkService: networkService, cacheService: cacheService)
    }
}
