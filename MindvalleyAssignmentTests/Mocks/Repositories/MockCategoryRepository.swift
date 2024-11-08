//
//  MockCategoryRepository.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import Foundation
@testable import MindvalleyAssignment

class MockCategoryRepositoryImpl: CategoryRepositoryProtocol {
    private let networkService: MockNetworkService
    private let cacheService: CacheServiceProtocol
    private let cacheKey = "cached_channels"
    
    var mockData: Data?
    var mockResult: Result<[MindvalleyAssignment.Category], NetworkError>?
    
    init(networkService: MockNetworkService, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchCategories() async -> Result<[MindvalleyAssignment.Category], NetworkError> {
        
        let endpoint = APIEndpoint(
            path: "",
            method: .get
        )
        
        networkService.mockData = mockData
        
        let result: Result<DataResponse<CategoriesData>, NetworkError> = await networkService.request(endpoint: endpoint)
        
        switch result {
        case .success(let response):
            let category = response.data?.categories ?? []
            
            // Cache the fetched data
            do {
                try cacheService.save(category, forKey: cacheKey)
            } catch {
                print("Cache save error: \(error.localizedDescription)")
            }
            return .success(category)
            
        case .failure(let error):
            // Try to retrieve cached data if network request fails
            if let cachedCategory: [MindvalleyAssignment.Category] = try? cacheService.retrieve(forKey: cacheKey) {
                return .success(cachedCategory)
            }
            return .failure(error)
        }
        
    }
}

