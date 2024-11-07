//
//  ChannelRepository.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

protocol ChannelRepositoryProtocol {
    func fetchChannels() async throws -> [Channel]
}

class ChannelRepositoryImpl: ChannelRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchChannels() async throws -> [Channel] {
        let endpoint = APIEndpoint(
                    path: "/raw/Xt12uVhM",
                    method: .get
                )
                
        let response: DataResponse<ChannelData> = try await networkService.request(endpoint: endpoint)
        
        return response.data?.channels ?? []
    }
}

