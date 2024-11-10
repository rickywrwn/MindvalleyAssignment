//
//  NetworkServiceTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 10/11/24.
//

import XCTest
@testable import MindvalleyAssignment

final class NetworkServiceTest: XCTestCase{
    var mockSession: MockURLSession!
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkService = NetworkService(session: mockSession)
    }
    
    override func tearDown() {
        mockSession = nil
        networkService = nil
        super.tearDown()
    }
    
    // MARK: - Test Successful Requests
    
    func testSuccessfulRequest() async {
        // Given
        struct TestResponse: Codable {
            let message: String
        }
        
        let expectedResponse = TestResponse(message: "Success")
        let jsonData = try! JSONEncoder().encode(expectedResponse)
        let response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockSession.mockResponse = (jsonData, response)
        
        let endpoint = APIEndpoint(path: "/test")
        
        // When
        let result: Result<TestResponse, NetworkError> = await networkService.request(endpoint: endpoint)
        
        // Then
        switch result {
        case .success(let response):
            XCTAssertEqual(response.message, "Success")
        case .failure(let error):
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    // MARK: - Test Error Cases
    
    func testInvalidURLError() async {
        // Given
        let endpoint = APIEndpoint(baseURL: "invalid url", path: "/test")
        
        // When
        let result: Result<EmptyResponse, NetworkError> = await networkService.request(endpoint: endpoint)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertTrue(error.errorDescription?.contains("Invalid URL") ?? false)
        }
    }
    
    func testDecodingError() async {
        // Given
        struct TestResponse: Codable {
            let requiredField: String
        }
        
        let invalidJSON = "invalid json".data(using: .utf8)!
        let response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockSession.mockResponse = (invalidJSON, response)
        
        let endpoint = APIEndpoint(path: "/test")
        
        // When
        let result: Result<TestResponse, NetworkError> = await networkService.request(endpoint: endpoint)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertTrue(error.errorDescription?.contains("Failed to process the server response") ?? false)
        }
    }
    
    func testServerError() async {
        // Given
        let response = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )!
        
        mockSession.mockResponse = (Data(), response)
        
        let endpoint = APIEndpoint(path: "/test")
        
        // When
        let result: Result<EmptyResponse, NetworkError> = await networkService.request(endpoint: endpoint)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertTrue(error.errorDescription?.contains("Content not found (404)") ?? false)
        }
    }
    
    // MARK: - Test Retry Mechanism
    
    func testRetryMechanismWithEventualSuccess() async {
        // Given
        struct TestResponse: Codable {
            let message: String
        }
        
        var attemptCount = 0
        mockSession.mockDataTask = { request in
            attemptCount += 1
            if attemptCount < 2 {
                throw NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut)
            }
            
            let successResponse = TestResponse(message: "Success")
            let jsonData = try! JSONEncoder().encode(successResponse)
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (jsonData, response)
        }
        
        let endpoint = APIEndpoint(path: "/test")
        
        // When
        let result: Result<TestResponse, NetworkError> = await networkService.request(endpoint: endpoint)
        
        // Then
        XCTAssertEqual(attemptCount, 2)
        switch result {
        case .success(let response):
            XCTAssertEqual(response.message, "Success")
        case .failure:
            XCTFail("Expected success after retry")
        }
    }
    
    func testMaxRetriesExceeded() async {
        // Given
        let retryConfig = RetryConfig(
            maxAttempts: 3,
            initialDelay: 0.1,
            maxDelay: 0.3,
            multiplier: 2.0
        )
        networkService = NetworkService(session: mockSession, retryConfig: retryConfig)
        
        
        var attemptCount = 0
        // Setup the mock to always timeout
        mockSession.mockDataTask = { _ in
            attemptCount += 1
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut)
        }
        
        let endpoint = APIEndpoint(path: "/test")
        
        // When
        let result: Result<EmptyResponse, NetworkError> = await networkService.request(endpoint: endpoint)
        
        // Then
        XCTAssertEqual(attemptCount, 3)
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            print(error.errorDescription)
            XCTAssertTrue(error.errorDescription?.contains("No internet connection") ?? false)
        }
    }

    
}

// Helper
struct EmptyResponse: Codable {}
