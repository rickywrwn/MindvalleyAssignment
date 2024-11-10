//
//  MockURLSession.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 10/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockURLSession: URLSessionProtocol {
    var mockResponse: (Data, URLResponse)?
    var mockError: Error?
    var mockDataTask: ((URLRequest) throws -> (Data, URLResponse))?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let mockDataTask = mockDataTask {
            return try mockDataTask(request)
        }
        if let error = mockError {
            throw error
        }
        if let mockResponse = mockResponse {
            return mockResponse
        }
        throw NSError(domain: "MockError", code: -1)
    }
}
