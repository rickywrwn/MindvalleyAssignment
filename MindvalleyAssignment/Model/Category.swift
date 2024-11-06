//
//  Category.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import Foundation

struct CategoriesData: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let name: String
}
