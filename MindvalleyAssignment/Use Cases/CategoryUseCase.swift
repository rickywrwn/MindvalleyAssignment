//
//  CategoryUseCase.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - Use Case Protocols
protocol CategoryUseCaseProtocol {
    func execute() async -> Result<[ChannelSectionData], NetworkError>
}

class CategoryUseCaseImpl: CategoryUseCaseProtocol {
    private let repository: CategoryRepositoryProtocol
    
    init(repository: CategoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<[ChannelSectionData], NetworkError> {
        let result = await repository.fetchCategories()
        
        switch result {
        case .success(let categoryData):
            // Transform each Media object into ChannelItem.newEpisode
            let channelItems = categoryData.map { category in
                ChannelItem.category(category)
            }
            
            // Create ChannelSectionData with type .newEpisodes
            let sectionData = [ChannelSectionData(
                type: .categories,
                title: "Browse by categories",
                subtitle: "",
                iconUrl: "",
                items: channelItems
            )]
            
            return .success(sectionData)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
