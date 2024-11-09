//
//  ChannelRepository.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

protocol ChannelRepositoryProtocol {
    func fetchChannels() async -> Result<[Channel], NetworkError>
}

class ChannelRepositoryImpl: ChannelRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    private let cacheKey = "cached_channels"
    
    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchChannels() async -> Result<[Channel], NetworkError> {
        let endpoint = APIEndpoint(
            path: "/raw/Xt12uVhM",
            method: .get
        )
        
        let result: Result<DataResponse<ChannelData>, NetworkError> = await networkService.request(endpoint: endpoint)
        
        switch result {
        case .success(let response):
            let channel = response.data?.channels ?? []
            
//             Cache the fetched data
            do {
                try cacheService.save(channel, forKey: cacheKey)
            } catch {
                print("Cache save error: \(error.localizedDescription)")
            }
            return .success(channel)
            
        case .failure(let error):
            
            switch error{
            case .noConnection, .timeout:
                // Try to retrieve cached data if network request fails
                if let cachedChannel: [Channel] = try? cacheService.retrieve(forKey: cacheKey) {
                    return .success(cachedChannel)
                }
            default:
                return .failure(error)
            }
            return .failure(error)
        }
    }
}

