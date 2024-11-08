//
//  CategoryUseCaseTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import XCTest
@testable import MindvalleyAssignment

class CategoryUseCaseTest: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    var mockRepository: MockCategoryRepositoryImpl!
    
    var categoryUseCase: CategoryUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        mockRepository = MockCategoryRepositoryImpl(networkService: mockNetworkService, cacheService: mockCacheService)
        categoryUseCase = CategoryUseCaseImpl(repository: mockRepository)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        mockCacheService = nil
        mockRepository = nil
        categoryUseCase = nil
        super.tearDown()
    }
    
    
    func testFetchCategorySuccess() async {
        // Given
        mockRepository.mockData = APIMockData.mockCategoriesData
        
        // When
        let result = await categoryUseCase.execute()
        
        // Then
        switch result {
        case .success(let categories):
            // Verify channel count
            XCTAssertEqual(categories.count, 1)
            
            // Verify first media details
            let category = categories[0]
            XCTAssertEqual(category.title, "Browse by categories")
            XCTAssertEqual(category.type, .categories)
            XCTAssertEqual(category.items.count, 12)
            
            if case .category(let categoryItem) = category.items[0] {
                XCTAssertEqual(categoryItem.name, "Career")
            }
        case .failure(let error):
            XCTFail("Expected success but got failure with error: \(error)")
        }
    }
    
    func testFetchCategoryNoData() async {
        // Given
        mockNetworkService.mockData = nil
        
        // When
        let result = await categoryUseCase.execute()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No mock data provided").localizedDescription)
        }
    }
    
}


