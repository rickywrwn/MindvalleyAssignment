//
//  CategoryRepository.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

protocol CategoryRepositoryProtocol {
    func fetchCategories() async throws -> [Category]
}

class CategoryRepositoryImpl: CategoryRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCategories() async throws -> [Category] {
        let endpoint = APIEndpoint(
                    path: "/raw/A0CgArX3",
                    method: .get
                )
                
        let response: DataResponse<CategoriesData> = try await networkService.request(endpoint: endpoint)
        
        return response.data?.categories ?? []
    }
}
