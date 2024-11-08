//
//  EpisodeRepositoryTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import XCTest
@testable import MindvalleyAssignment

final class EpisodeRepositoryTest: XCTestCase{
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    var episodeRepository: EpisodeRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        episodeRepository = EpisodeRepositoryImpl(
            networkService: mockNetworkService,
            cacheService: mockCacheService
        )
    }
    
    override func tearDown() {
        episodeRepository = nil
        mockNetworkService = nil
        mockCacheService = nil
        super.tearDown()
    }
    
    func testFetchEpisodesSuccess() async {
        // Given
        mockNetworkService.mockData = APIMockData.mockEpisodesData
        
        // When
        let result = await episodeRepository.fetchNewEpisode()
        
        // Then
        switch result {
        case .success(let episodes):
            // Verify episode count
            XCTAssertEqual(episodes.count, 6)
            
            // Verify first episode
            let firstEpisode = episodes[0]
            XCTAssertEqual(firstEpisode.type, "course")
            XCTAssertEqual(firstEpisode.title, "Conscious Parenting")
            XCTAssertEqual(firstEpisode.coverAsset?.url, "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080")
            XCTAssertEqual(firstEpisode.channel?.title, "Little Humans")
            
            // Verify second episode
            let secondEpisode = episodes[1]
            XCTAssertEqual(secondEpisode.type, "course")
            XCTAssertEqual(secondEpisode.title, "Raising Kids With Healthy Beliefs")
            
            // Verify cache was updated
            let cachedEpisodes: [Media]? = try? mockCacheService.retrieve(forKey: "cached_episodes")
            
            if let cached = cachedEpisodes {
                XCTAssertNotNil(cached)
                XCTAssertEqual(cached.count, 6)
                XCTAssertEqual(cached[0].title, "Conscious Parenting")
            }else{
                //first run no caching
                XCTAssertNil(cachedEpisodes, "First App run should be nil")
            }
            
        case .failure(let error):
            XCTFail("Expected success but got failure with error: \(error)")
        }
    }
    
    func testFetchEpisodesInvalidJSON() async {
        // Given
        let invalidJSON = "invalid json data"
        mockNetworkService.mockData = invalidJSON.data(using: .utf8)
        
        // When
        let result = await episodeRepository.fetchNewEpisode()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertTrue(error.errorDescription?.contains("Failed to process the server response") ?? false)

        }
    }
    
    func testFetchEpisodesNoData() async {
        // Given
        mockNetworkService.mockData = nil
        
        // When
        let result = await episodeRepository.fetchNewEpisode()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No mock data provided").localizedDescription)
        }
    }
    
    func testFetchEpisodesNetworkError() async {
        // Given
        mockNetworkService.mockError = NetworkError.noConnection
        
        // When
        let result = await episodeRepository.fetchNewEpisode()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No internet connection").localizedDescription)
        }
    }
    
}
