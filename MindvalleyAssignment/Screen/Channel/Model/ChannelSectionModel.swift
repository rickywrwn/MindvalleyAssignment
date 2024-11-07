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
    
    var title: String {
        switch self {
        case .newEpisodes: return "New Episodes"
        case .courses: return ""
        case .series: return ""
        case .categories: return "Browse by categories"
        }
    }
}

enum ChannelItem {
    case newEpisode(Media)
    case course(Channel)
    case series(Channel)
    case category(Category)
}

struct ChannelSectionData {
    let type: SectionType
    let items: [ChannelItem]
}
