//
//  URLSessionProtocol.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 10/11/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
