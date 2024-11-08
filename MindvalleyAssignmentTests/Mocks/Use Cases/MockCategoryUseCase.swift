//
//  MockCategoryUseCase.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockCategoryUseCaseImpl: CategoryUseCaseProtocol {
    private let repository: MockCategoryRepositoryImpl
    
    var mockData: Data?
    var mockResult: Result<[ChannelSectionData], NetworkError>?
    
    init(repository: MockCategoryRepositoryImpl) {
        print("init MockCategoryUseCaseImpl")
        self.repository = repository
    }
    
    func execute() async -> Result<[ChannelSectionData], NetworkError> {
        
        repository.mockData = mockData
        
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
            
            print("result in MockCategoryUseCaseImpl ", sectionData)
            return .success(sectionData)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
