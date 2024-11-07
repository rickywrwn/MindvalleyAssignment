//
//  EpisodeUseCase.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - Use Case Protocols
protocol NewEpisodeUseCaseProtocol {
    func execute() async throws -> [ChannelSectionData]
}

class NewEpisodeUseCaseImpl: NewEpisodeUseCaseProtocol {
    private let repository: EpisodeRepositoryProtocol
    
    init(repository: EpisodeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [ChannelSectionData] {
        let episodeData = try await repository.fetchNewEpisode()
        
        // Transform each Media object into ChannelItem.newEpisode
        let channelItems = episodeData.map { media in
            ChannelItem.newEpisode(media)
        }
        
        // Create ChannelSectionData with type .newEpisodes
        return [ChannelSectionData(
            type: .newEpisodes,
            title: "New Episodes",
            subtitle: "",
            iconUrl: "",
            items: channelItems
        )]
    
    }
}
