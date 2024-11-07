//
//  EpisodeRepository.swift.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

protocol EpisodeRepositoryProtocol {
    func fetchNewEpisode() async throws -> [Media]
}

class EpisodeRepositoryImpl: EpisodeRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchNewEpisode() async throws -> [Media] {
        let endpoint = APIEndpoint(
                    path: "/raw/z5AExTtw",
                    method: .get
                )
                
        let response: DataResponse<MediaData> = try await networkService.request(endpoint: endpoint)
        
        return response.data?.media ?? []
    }
}
