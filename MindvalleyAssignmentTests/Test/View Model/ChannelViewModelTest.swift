//
//  ChannelViewModelTest.swift
//  MindvalleyAssignmentTests
//
//  Created by ricky wirawan on 08/11/24.
//

import XCTest
@testable import MindvalleyAssignment

class ChannelViewModelTest: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var mockCacheService: MockCacheService!
    var mockEpisodeRepository: MockEpisodeRepositoryImpl!
    var mockChannelRepository: MockChannelRepositoryImpl!
    var mockCategoryRepository: MockCategoryRepositoryImpl!
    var mockEpisodeUseCase: MockEpisodeUseCaseImpl!
    var mockChannelUseCase: MockChannelUseCaseImpl!
    var mockCategoryUseCase: MockCategoryUseCaseImpl!
    
    var channelViewModel: ChannelViewModel!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        mockCacheService = MockCacheService()
        mockEpisodeRepository = MockEpisodeRepositoryImpl(networkService: mockNetworkService, cacheService: mockCacheService)
        mockChannelRepository = MockChannelRepositoryImpl(networkService: mockNetworkService, cacheService: mockCacheService)
        mockCategoryRepository = MockCategoryRepositoryImpl(networkService: mockNetworkService, cacheService: mockCacheService)
        
        mockEpisodeUseCase = MockEpisodeUseCaseImpl(repository: mockEpisodeRepository)
        mockChannelUseCase = MockChannelUseCaseImpl(repository: mockChannelRepository)
        mockCategoryUseCase = MockCategoryUseCaseImpl(repository: mockCategoryRepository)
        
        channelViewModel = ChannelViewModel(
            newEpisodeUseCase: mockEpisodeUseCase,
            channelUseCase: mockChannelUseCase,
            categoryUseCase: mockCategoryUseCase
        )
    }
    
    override func tearDown() {
        mockNetworkService = nil
        mockCacheService = nil
        mockEpisodeRepository = nil
        mockChannelRepository = nil
        mockCategoryRepository = nil
        mockEpisodeUseCase = nil
        mockChannelUseCase = nil
        mockCategoryUseCase = nil
        channelViewModel = nil
        super.tearDown()
    }
    
    func testReroderSectionData() async {
        // Given
        mockEpisodeUseCase.mockData = APIMockData.mockEpisodesData
        mockChannelUseCase.mockData = APIMockData.mockChannelsData
        mockCategoryUseCase.mockData = APIMockData.mockCategoriesData
        
        // When
        await channelViewModel.fetchNewEpisode()
        await channelViewModel.fetchChannels()
        await channelViewModel.fetchCategories()
        
        // Then
        // verify type after reordering
        XCTAssertEqual(channelViewModel.sectionData?.count, 11)
        XCTAssertEqual(channelViewModel.sectionData?[0].type, .newEpisodes)
        XCTAssertEqual(channelViewModel.sectionData?.last?.type, .categories)
        XCTAssertEqual(channelViewModel.sectionData?[4].type, .series)
        
    }
    
    func testFetchEpisodesSuccess() async {
        // Given
        mockEpisodeUseCase.mockData = APIMockData.mockEpisodesData
        
        // When
        await channelViewModel.fetchNewEpisode()
        
        // Then
        // Verify episodes count
        XCTAssertEqual(channelViewModel.episodeData?.count, 1)
        XCTAssertEqual(channelViewModel.episodeData?[0].items.count, 6)
        
        // Verify first episodes details
        let firstEpisode = channelViewModel.episodeData?[0]
        XCTAssertEqual(firstEpisode?.title, "New Episodes")
        XCTAssertEqual(firstEpisode?.type, .newEpisodes)
        XCTAssertEqual(firstEpisode?.items.count, 6)
        
        if case .course(let episodeItem) = firstEpisode?.items[0] {
            XCTAssertEqual(episodeItem.title, "Conscious Parenting")
            XCTAssertEqual(episodeItem.coverAsset?.url, "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080")
        }
    }
    
    func testFetchChannelSuccess() async {
        // Given
        mockChannelUseCase.mockData = APIMockData.mockChannelsData
        
        // When
        await channelViewModel.fetchChannels()
        
        // Then
        // Verify channel count
        XCTAssertEqual(channelViewModel.channelData?.count, 9)
        
        // Verify first channel details
        let firstChannel = channelViewModel.channelData?[0]
        XCTAssertEqual(firstChannel?.title, "Mindvalley Mentoring")
        XCTAssertEqual(firstChannel?.type, .courses)
        XCTAssertEqual(firstChannel?.items.count, 12)
        XCTAssertEqual(firstChannel?.iconUrl, "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png")
        
        // Verify fourth channel details
        let fourthChannel = channelViewModel.channelData?[3]
        XCTAssertEqual(fourthChannel?.title, "Coaching Mastery by Evercoach")
        XCTAssertEqual(fourthChannel?.type, .series)
        XCTAssertEqual(fourthChannel?.items.count, 2)
        XCTAssertEqual(fourthChannel?.iconUrl, "https://edgecastcdn.net/80EC13/public/overmind2/asset/5f680a18-5d09-40bf-88b6-23c0a69b4a46/channel-icon-coaching-mastery_thumbnail.png")
    }
    
    func testFetchCategorySuccess() async {
        // Given
        mockCategoryUseCase.mockData = APIMockData.mockCategoriesData
        
        // When
        await channelViewModel.fetchCategories()
        
        // Then
        // Verify category count
        XCTAssertEqual(channelViewModel.categoryData?.count, 1)
        
        // Verify first category details
        let category = channelViewModel.categoryData?[0]
        XCTAssertEqual(category?.title, "Browse by categories")
        XCTAssertEqual(category?.type, .categories)
        XCTAssertEqual(category?.items.count, 12)
        
        if case .category(let categoryItem) = category?.items[0] {
            XCTAssertEqual(categoryItem.name, "Career")
        }
    }
    
}
