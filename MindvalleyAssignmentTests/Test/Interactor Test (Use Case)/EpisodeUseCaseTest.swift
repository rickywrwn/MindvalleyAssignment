//
//  EpisodeUseCaseTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import XCTest
@testable import MindvalleyAssignment

class EpisodeUseCaseTest: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    var mockRepository: MockEpisodeRepositoryImpl!
    
    var episodeUseCase: NewEpisodeUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        mockRepository = MockEpisodeRepositoryImpl(networkService: mockNetworkService, cacheService: mockCacheService)
        episodeUseCase = NewEpisodeUseCaseImpl(repository: mockRepository)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        mockCacheService = nil
        mockRepository = nil
        episodeUseCase = nil
        super.tearDown()
    }
    
    func testFetchEpisodesSuccess() async {
        // Given
        mockRepository.mockData = APIMockData.mockEpisodesData
        
        // When
        let result = await episodeUseCase.execute()
        
        // Then
        switch result {
        case .success(let episodes):
            // Verify channel count
            XCTAssertEqual(episodes.count, 1)
            
            // Verify first media details
            let firstEpisode = episodes[0]
            XCTAssertEqual(firstEpisode.title, "New Episodes")
            XCTAssertEqual(firstEpisode.type, .newEpisodes)
            XCTAssertEqual(firstEpisode.items.count, 6)
            
            if case .course(let episodeItem) = firstEpisode.items[0] {
                XCTAssertEqual(episodeItem.title, "Conscious Parenting")
                XCTAssertEqual(episodeItem.coverAsset?.url, "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080")
            }
        case .failure(let error):
            XCTFail("Expected success but got failure with error: \(error)")
        }
    }
    
    func testFetchEpisodesNoData() async {
        // Given
        mockNetworkService.mockData = nil
        
        // When
        let result = await episodeUseCase.execute()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No mock data provided").localizedDescription)
        }
    }
    
}

