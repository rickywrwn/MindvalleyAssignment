//
//  ChannelUseCase.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - Use Case Protocols
protocol ChannelUseCaseProtocol {
    func execute() async throws -> [ChannelSectionData]
}

class ChannelUseCaseImpl: ChannelUseCaseProtocol {
    private let repository: ChannelRepositoryProtocol
    
    init(repository: ChannelRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [ChannelSectionData] {
        let channelData = try await repository.fetchChannels()
        
        
        // Transform each Media object into ChannelItem.series / .course
        let arrChannelData = channelData.compactMap { channel -> ChannelSectionData? in
            
            if let series = channel.series, !series.isEmpty {
                //series
                guard let media = channel.series else { return nil }
                let channelItems = media.map { media in
                    ChannelItem.series(media)
                }
                
                return ChannelSectionData(
                    type: .series,
                    title: channel.title ?? "",
                    subtitle: "\(String(channel.series?.count ?? 0) ) series",
                    iconUrl: channel.iconAsset?.thumbnailUrl ?? channel.iconAsset?.url ?? "",
                    items: channelItems
                )
                
            }else{
                //series null/empty then its course
                guard let media = channel.latestMedia else { return nil }
                let channelItems = media.map { media in
                    ChannelItem.course(media)
                }
                
                return ChannelSectionData(
                    type: .courses,
                    title: channel.title ?? "",
                    subtitle: "\(String(channel.mediaCount ?? 0) ) episodes",
                    iconUrl: channel.iconAsset?.thumbnailUrl ?? channel.iconAsset?.url ?? "",
                    items: channelItems
                )
            }
        }
        
        return arrChannelData
    
    }
}
