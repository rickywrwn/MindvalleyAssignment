//
//  MockNetworkService.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    var mockError: NetworkError?
    var requestedEndpoint: Endpoint?
    
    func request<T: Codable>(endpoint: Endpoint) async -> Result<T, NetworkError> {
        requestedEndpoint = endpoint
        
        if let error = mockError {
            return .failure(error)
        }
        
        guard let data = mockData else {
            return .failure(.custom("No mock data provided"))
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.decodingError)
        }
    }
}
