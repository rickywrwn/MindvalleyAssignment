//
//  ChannelViewModel.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 07/11/24.
//

import Foundation

// MARK: - ViewModel Protocol
protocol ChannelViewModelProtocol: AnyObject {
    var state: ViewState { get }
    var episodeData: [ChannelSectionData]? { get }
    var channelData: [ChannelSectionData]? { get }
    var categoryData: [ChannelSectionData]? { get }
    var sectionData: [ChannelSectionData]? { get }
    
    var onStateChanged: ((ViewState) -> Void)? { get set }
    var onEpisodeDataChanged: (() -> Void)? { get set }
    var onChannelDataChanged: (() -> Void)? { get set }
    var onCategoryDataChanged: (() -> Void)? { get set }
    var onSectionDataChanged: (() -> Void)? { get set }
    
    func viewDidLoad()
    func fetchNewEpisode() async
    func fetchChannels() async
    func fetchCategories() async
}

final class ChannelViewModel: ChannelViewModelProtocol{
    
    private let newEpisodeUseCase: NewEpisodeUseCaseProtocol
    private let channelUseCase: ChannelUseCaseProtocol
    private let categoryUseCase: CategoryUseCaseProtocol
    
    private var completedFetchCount = 0
    private var totalFetchCount = 3 // episodes, channels, categories
    private var firstError: Error?
    
    private(set) var state: ViewState = .idle {
        didSet {
            onStateChanged?(state)
        }
    }
    
    private(set) var episodeData: [ChannelSectionData]? {
        didSet {
            onEpisodeDataChanged?()
        }
    }
    
    private(set) var channelData: [ChannelSectionData]? {
        didSet {
            onChannelDataChanged?()
        }
    }
    
    private(set) var categoryData: [ChannelSectionData]? {
        didSet {
            onCategoryDataChanged?()
        }
    }
    
    private(set) var sectionData: [ChannelSectionData]? {
        didSet {
            onSectionDataChanged?()
        }
    }
    
    // MARK: - Callbacks
    var onStateChanged: ((ViewState) -> Void)?
    var onEpisodeDataChanged: (() -> Void)?
    var onChannelDataChanged: (() -> Void)?
    var onCategoryDataChanged: (() -> Void)?
    var onSectionDataChanged: (() -> Void)?
    
    init(
        newEpisodeUseCase: NewEpisodeUseCaseProtocol,
        channelUseCase: ChannelUseCaseProtocol,
        categoryUseCase: CategoryUseCaseProtocol
    ) {
        self.newEpisodeUseCase = newEpisodeUseCase
        self.channelUseCase = channelUseCase
        self.categoryUseCase = categoryUseCase
    }
    
    func viewDidLoad() {
        state = .loading
        completedFetchCount = 0
        firstError = nil
        
        Task {
            async let episodeResult = fetchNewEpisode()
            async let channelsResult = fetchChannels()
            async let categoriesResult = fetchCategories()
            _ = await [episodeResult, channelsResult, categoriesResult]
        }
    }
    
    private func redorderSectionData() {
        guard let sections = sectionData else { return }
        let episodeSections = sections.filter { $0.type == .newEpisodes }
        let channelSections = sections.filter { $0.type != .newEpisodes &&  $0.type != .categories}
        let categorySections = sections.filter { $0.type == .categories }
        
        sectionData = episodeSections + channelSections + categorySections
    }
    
    private func markFetchComplete(error: Error? = nil) {
        completedFetchCount += 1
        
        if let error = error, firstError == nil {
            firstError = error
        }
        
        if completedFetchCount == totalFetchCount {
            if let error = firstError {
                state = .error(error)
            } else {
                state = .loaded
            }
        }
    }
    
    @MainActor
    func fetchNewEpisode() async {
        let result = await newEpisodeUseCase.execute()
        
        switch result {
        case .success(let episode):
            episodeData = episode
            sectionData = (sectionData ?? []) + episode
            redorderSectionData()
            markFetchComplete()
            
        case .failure(let error):
            markFetchComplete(error: error)
        }
    }
    
    @MainActor
    func fetchChannels() async {
        
        let result = await channelUseCase.execute()
        
        
        switch result {
        case .success(let channels):
            channelData = channels
            sectionData = (sectionData ?? []) + channels
            redorderSectionData()
            markFetchComplete()
            
        case .failure(let error):
            markFetchComplete(error: error)
        }
    }
    
    @MainActor
    func fetchCategories() async {
        
        let result = await categoryUseCase.execute()
        
        switch result {
        case .success(let categories):
            categoryData = categories
            sectionData = (sectionData ?? []) + categories
            redorderSectionData()
            markFetchComplete()
            
        case .failure(let error):
            markFetchComplete(error: error)
        }
    }
}
