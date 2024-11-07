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
//    func makeChannelRepository(networkService: NetworkServiceProtocol) -> ChannelRepositoryProtocol
    func makeEpisodeRepository(networkService: NetworkServiceProtocol) -> EpisodeRepositoryProtocol
//    func makeCategoryRepository(networkService: NetworkServiceProtocol) -> CategoryRepositoryProtocol
}

// MARK: - Production Factory
class ProductionDIFactory: DIContainerFactory {
    
    
    func makeNetworkService() -> NetworkServiceProtocol {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        
        let session = URLSession(configuration: configuration)
        return NetworkService(
            session: session
        )
    }
    
//    func makeChannelRepository(networkService: NetworkServiceProtocol) -> ChannelRepositoryProtocol {
//        return ChannelRepository(networkService: networkService)
//    }
    
    func makeEpisodeRepository(networkService: NetworkServiceProtocol) -> EpisodeRepositoryProtocol {
        return EpisodeRepositoryImpl(networkService: networkService)
    }
    
//    func makeCategoryRepository(networkService: NetworkServiceProtocol) -> CategoryRepositoryProtocol {
//        return CategoryRepository(networkService: networkService)
//    }
}

// MARK: - Mock Factory for Testing
//class MockDIFactory: DIContainerFactory {
//    func makeNetworkService() -> NetworkServiceProtocol {
//        return MockNetworkService()
//    }
//    
//    func makeChannelRepository(networkService: NetworkServiceProtocol) -> ChannelRepositoryProtocol {
//        return MockChannelRepository()
//    }
//    
//    func makeEpisodeRepository(networkService: NetworkServiceProtocol) -> EpisodeRepositoryProtocol {
//        return MockEpisodeRepository()
//    }
//    
//    func makeCategoryRepository(networkService: NetworkServiceProtocol) -> CategoryRepositoryProtocol {
//        return MockCategoryRepository()
//    }
//}
