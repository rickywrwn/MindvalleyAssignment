//
//  DIContainer.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

final class DIContainer {
    private let factory: DIContainerFactory
    
    let networkService: NetworkServiceProtocol
    let cacheService: CacheServiceProtocol
    let channelRepository: ChannelRepositoryProtocol
    let episodeRepository: EpisodeRepositoryProtocol
    let categoryRepository: CategoryRepositoryProtocol
    
    let channelUseCase: ChannelUseCaseProtocol
    let newEpisodeUseCase: NewEpisodeUseCaseProtocol
    let categoryUseCase: CategoryUseCaseProtocol
    
    init(factory: DIContainerFactory) {
        self.factory = factory
        
        // Initialize services with explicit dependencies
        self.networkService = factory.makeNetworkService()
        self.cacheService = factory.makeCacheService()
        
        // Initialize repositories
        self.channelRepository = factory.makeChannelRepository(networkService: networkService, cacheService: cacheService)
        self.episodeRepository = factory.makeEpisodeRepository(networkService: networkService, cacheService: cacheService)
        self.categoryRepository = factory.makeCategoryRepository(networkService: networkService, cacheService: cacheService)
        
        // Initialize use cases
        self.channelUseCase = ChannelUseCaseImpl(repository: channelRepository)
        self.newEpisodeUseCase = NewEpisodeUseCaseImpl(
            repository: episodeRepository
        )
        self.categoryUseCase = CategoryUseCaseImpl(repository: categoryRepository)
    }
}
