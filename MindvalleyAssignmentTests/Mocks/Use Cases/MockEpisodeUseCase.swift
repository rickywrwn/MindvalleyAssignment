//
//  MockEpisodeUseCase.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockEpisodeUseCaseImpl: NewEpisodeUseCaseProtocol {
    private let repository: MockEpisodeRepositoryImpl
    
    var mockData: Data?
    var mockResult: Result<[ChannelSectionData], NetworkError>?
    
    init(repository: MockEpisodeRepositoryImpl) {
        self.repository = repository
    }
    
    func execute() async -> Result<[ChannelSectionData], NetworkError> {
        
        repository.mockData = mockData
        
        let result = await repository.fetchNewEpisode()
        
        switch result {
        case .success(let episodeData):
            // Transform each Media object into ChannelItem.newEpisode
            let channelItems = episodeData.map { media in
                ChannelItem.newEpisode(media)
            }
            
            // Create ChannelSectionData with type .newEpisodes
            let sectionData = [ChannelSectionData(
                type: .newEpisodes,
                title: "New Episodes",
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
