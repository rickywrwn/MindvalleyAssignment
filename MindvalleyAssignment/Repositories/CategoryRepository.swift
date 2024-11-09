//
//  CategoryRepository.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func fetchCategories() async -> Result<[Category], NetworkError>
}

class CategoryRepositoryImpl: CategoryRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    private let cacheKey = "cached_categories"
    
    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchCategories() async -> Result<[Category], NetworkError> {
        let endpoint = APIEndpoint(
            path: "/raw/A0CgArX3",
            method: .get
        )
        
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
            
            switch error{
            case .noConnection, .timeout:
                // Try to retrieve cached data if network request fails
                if let cachedCategory: [Category] = try? cacheService.retrieve(forKey: cacheKey) {
                    return .success(cachedCategory)
                }
            default:
                return .failure(error)
            }
            return .failure(error)
        }
    }
}
