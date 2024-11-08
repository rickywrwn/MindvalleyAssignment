//
//  CategoryRepositoryTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import XCTest
@testable import MindvalleyAssignment

final class CategoryRepositoryTest: XCTestCase{
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    var categoryRepository: CategoryRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        categoryRepository = CategoryRepositoryImpl(
            networkService: mockNetworkService,
            cacheService: mockCacheService
        )
    }
    
    override func tearDown() {
        categoryRepository = nil
        mockNetworkService = nil
        mockCacheService = nil
        super.tearDown()
    }
    
    func testFetchCategoriesSuccess() async {
        // Given
        mockNetworkService.mockData = APIMockData.mockCategoriesData
        
        // When
        let result = await categoryRepository.fetchCategories()
        
        // Then
        switch result {
        case .success(let categories):
            // Verify categories count
            XCTAssertEqual(categories.count, 12)
            
            // Verify first category details
            let firstCategory = categories[0]
            XCTAssertEqual(firstCategory.name, "Career")
            
            // Verify second category details
            let secondCategory = categories[1]
            XCTAssertEqual(secondCategory.name, "Character")
            
            // Verify cache was updated
            let cachedCategory: [Channel]? = try? mockCacheService.retrieve(forKey: "cached_categories")
            if let cached = cachedCategory {
                XCTAssertNotNil(cached)
                XCTAssertEqual(cached.count, 12)
                XCTAssertEqual(cached[0].title, "Career")
            }else{
                //first run no caching
                XCTAssertNil(cachedCategory, "First App run should be nil")
            }
            
        case .failure(let error):
            XCTFail("Expected success but got failure with error: \(error)")
        }
    }
    
    func testFetchCategoriesInvalidJSON() async {
        // Given
        let invalidJSON = "invalid json data"
        mockNetworkService.mockData = invalidJSON.data(using: .utf8)
        
        // When
        let result = await categoryRepository.fetchCategories()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertTrue(error.errorDescription?.contains("Failed to process the server response") ?? false)

        }
    }
    
    func testFetchCategoriesNoData() async {
        // Given
        mockNetworkService.mockData = nil
        
        // When
        let result = await categoryRepository.fetchCategories()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No mock data provided").localizedDescription)
        }
    }
    
    func testFetchCategoriesNetworkError() async {
        // Given
        mockNetworkService.mockError = NetworkError.noConnection
        
        // When
        let result = await categoryRepository.fetchCategories()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No internet connection").localizedDescription)
        }
    }
    
}

