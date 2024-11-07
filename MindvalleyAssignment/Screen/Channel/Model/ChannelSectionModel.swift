//
//  ChannelSectionModel.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import Foundation

enum SectionType: Int {
    case newEpisodes
    case courses
    case series
    case categories
}

enum ChannelItem {
    case newEpisode(Media)
    case course(Media)
    case series(Media)
    case category(Category)
}

struct ChannelSectionData {
    let type: SectionType
    let title: String
    let subtitle: String //for course & series header
    let iconUrl: String //for course & series header
    let items: [ChannelItem]
}
