//
//  DataResponse.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 06/11/24.
//

import Foundation

struct DataResponse<T: Codable>: Codable {
    let data: T
}
