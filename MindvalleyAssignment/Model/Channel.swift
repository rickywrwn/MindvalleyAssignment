//
//  Channel.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import Foundation

struct ChannelData: Codable {
    let channels: [Channel]?
}

struct Channel: Codable {
    let title: String?
    let series: [Media]?
    let mediaCount: Int?
    let latestMedia: [Media]?
    let id: String?
    let iconAsset: IconAsset?
    let coverAsset: CoverAsset?
}
