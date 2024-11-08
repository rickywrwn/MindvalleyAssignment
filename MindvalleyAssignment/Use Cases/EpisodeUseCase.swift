//
//  EpisodeUseCase.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - Use Case Protocols
protocol NewEpisodeUseCaseProtocol {
    func execute() async -> Result<[ChannelSectionData], NetworkError>
}

class NewEpisodeUseCaseImpl: NewEpisodeUseCaseProtocol {
    private let repository: EpisodeRepositoryProtocol
    
    init(repository: EpisodeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<[ChannelSectionData], NetworkError> {
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
