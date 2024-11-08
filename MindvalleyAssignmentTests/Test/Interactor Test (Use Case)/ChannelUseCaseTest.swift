//
//  ChannelUseCaseTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import XCTest
@testable import MindvalleyAssignment

class ChannelUseCaseTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    var mockRepository: MockChannelRepositoryImpl!
    
    var channelUseCase: ChannelUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        mockRepository = MockChannelRepositoryImpl(networkService: mockNetworkService, cacheService: mockCacheService)
        channelUseCase = ChannelUseCaseImpl(repository: mockRepository)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        mockCacheService = nil
        mockRepository = nil
        channelUseCase = nil
        super.tearDown()
    }
    
    
    func testFetchChannelsSuccess() async {
        // Given
        mockRepository.mockData = APIMockData.mockChannelsData
        
        // When
        let result = await channelUseCase.execute()
        
        // Then
        switch result {
        case .success(let channels):
            // Verify channel count
            XCTAssertEqual(channels.count, 9)
            
            // Verify first channel details
            let firstChannel = channels[0]
            XCTAssertEqual(firstChannel.title, "Mindvalley Mentoring")
            XCTAssertEqual(firstChannel.type, .courses)
            XCTAssertEqual(firstChannel.items.count, 12)
            XCTAssertEqual(firstChannel.iconUrl, "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png")
            
            // Verify fourth channel details
            let fourthChannel = channels[3]
            XCTAssertEqual(fourthChannel.title, "Coaching Mastery by Evercoach")
            XCTAssertEqual(fourthChannel.type, .series)
            XCTAssertEqual(fourthChannel.items.count, 2)
            XCTAssertEqual(fourthChannel.iconUrl, "https://edgecastcdn.net/80EC13/public/overmind2/asset/5f680a18-5d09-40bf-88b6-23c0a69b4a46/channel-icon-coaching-mastery_thumbnail.png")
            
        case .failure(let error):
            XCTFail("Expected success but got failure with error: \(error)")
        }
    }
    
    func testFetchChannelsNoData() async {
        // Given
        mockNetworkService.mockData = nil
        
        // When
        let result = await channelUseCase.execute()
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.custom("No mock data provided").localizedDescription)
        }
    }
    
}
