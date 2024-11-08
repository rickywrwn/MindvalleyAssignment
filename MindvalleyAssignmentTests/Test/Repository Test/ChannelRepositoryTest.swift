//
//  ChannelRepositoryTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import XCTest
@testable import MindvalleyAssignment

final class ChannelRepositoryTest: XCTestCase{
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    var channelRepository: ChannelRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        channelRepository = ChannelRepositoryImpl(
            networkService: mockNetworkService,
            cacheService: mockCacheService
        )
    }
    
    override func tearDown() {
        channelRepository = nil
        mockNetworkService = nil
        mockCacheService = nil
        super.tearDown()
    }
    
    func testFetchChannelsSuccess() async {
        // Given
        mockNetworkService.mockData = APIMockData.mockChannelsData
        
        // When
        let result = await channelRepository.fetchChannels()
        
        // Then
        switch result {
        case .success(let channels):
            // Verify channel count
            XCTAssertEqual(channels.count, 9)
            
            // Verify first channel details
            let firstChannel = channels[0]
            XCTAssertEqual(firstChannel.title, "Mindvalley Mentoring")
            XCTAssertEqual(firstChannel.mediaCount, 98)
            XCTAssertEqual(firstChannel.id, "11")
            XCTAssertEqual(firstChannel.latestMedia?.count, 12)
            XCTAssertEqual(firstChannel.series?.count, 0, "This channel dont have any series")
            
            let firstChannelMedia = firstChannel.latestMedia?[0]
            XCTAssertEqual(firstChannelMedia?.title, "How Journaling Helped Create a $500M Company")
            
            // Verify fourth channel details
            let fourthChannel = channels[3]
            XCTAssertEqual(fourthChannel.title, "Coaching Mastery by Evercoach")
            XCTAssertEqual(fourthChannel.mediaCount, 27)
            XCTAssertNil(fourthChannel.id, "This channel dont have ID")
            XCTAssertEqual(fourthChannel.latestMedia?.count, 12)
            XCTAssertEqual(fourthChannel.series?.count, 2)
            XCTAssertEqual(fourthChannel.series?[0].title, "Coaching Mastery by Evercoach")
            
            let fourthChannelMedia = fourthChannel.latestMedia?[0]
            XCTAssertEqual(fourthChannelMedia?.title, "Emotional Health")
            
            // Verify cache was updated
            let cachedChannels: [Channel]? = try? mockCacheService.retrieve(forKey: "cached_channels")
            if let cached = cachedChannels {
                XCTAssertNotNil(cached)
                XCTAssertEqual(cached.count, 9)
                XCTAssertEqual(cached[0].title, "Mindvalley Mentoring")
            }else{
                //first run no caching
                XCTAssertNil(cachedChannels, "First App run should be nil")
            }
            
        case .failure(let error):
            XCTFail("Expected success but got failure with error: \(error)")
        }
    }
    
    func testFetchChannelsInvalidJSON() async {
        // Given
        let invalidJSON = "invalid json data"
        mockNetworkService.mockData = invalidJSON.data(using: .utf8)
        
        // When
        let result = await channelRepository.fetchChannels()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertTrue(error.errorDescription?.contains("Failed to process the server response") ?? false)

        }
    }
    
    func testFetchChannelsNoData() async {
        // Given
        mockNetworkService.mockData = nil
        
        // When
        let result = await channelRepository.fetchChannels()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No mock data provided").localizedDescription)
        }
    }
    
    func testFetchChannelsNetworkError() async {
        // Given
        mockNetworkService.mockError = NetworkError.noConnection
        
        // When
        let result = await channelRepository.fetchChannels()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No internet connection").localizedDescription)
        }
    }
    
}

