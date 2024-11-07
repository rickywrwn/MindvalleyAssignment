//
//  CategoryUseCase.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - Use Case Protocols
protocol CategoryUseCaseProtocol {
    func execute() async throws -> [ChannelSectionData]
}

class CategoryUseCaseImpl: CategoryUseCaseProtocol {
    private let repository: CategoryRepositoryProtocol
    
    init(repository: CategoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [ChannelSectionData] {
        let episodeData = try await repository.fetchCategories()
        
        // Transform each Media object into ChannelItem.newEpisode
        let channelItems = episodeData.map { category in
            ChannelItem.category(category)
        }
        
        // Create ChannelSectionData with type .newEpisodes
        return [ChannelSectionData(
            type: .categories,
            title: "Browse by categories",
            subtitle: "",
            iconUrl: "",
            items: channelItems
        )]
        
    }
}
