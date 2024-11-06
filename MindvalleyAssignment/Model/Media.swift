//
//  Media.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import Foundation

struct MediaData: Codable {
    let media: [Media]
}

struct Media: Codable {
    let type: String
    let title: String
    let coverAsset: CoverAsset
    let channel: Channel
}
