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
    
    func fetchNewEpisode() async
    func fetchChannels() async
    func fetchCategories() async
}

final class ChannelViewModel: ChannelViewModelProtocol{
    
    private let newEpisodeUseCase: NewEpisodeUseCaseProtocol
    private let channelUseCase: ChannelUseCaseProtocol
    private let categoryUseCase: CategoryUseCaseProtocol
    
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
    
    // MARK: - Initialization
    init(
        newEpisodeUseCase: NewEpisodeUseCaseProtocol, channelUseCase: ChannelUseCaseProtocol, categoryUseCase: CategoryUseCaseProtocol
    ) {
        self.newEpisodeUseCase = newEpisodeUseCase
        self.channelUseCase = channelUseCase
        self.categoryUseCase = categoryUseCase
    }
    
    @MainActor
    func fetchNewEpisode() async {
        state = .loading
        
        do {
            let episode = try await newEpisodeUseCase.execute()
            episodeData = episode
            
            // Update section data while maintaining order
            if var currentSections = sectionData {
                // Remove existing new episodes section if any
                currentSections.removeAll { section in
                    section.type == .newEpisodes
                }
                
                // Insert new episodes at the beginning
                currentSections.insert(contentsOf: episode, at: 0)
                sectionData = currentSections
            } else {
                // Initialize with episode data
                sectionData = episode
            }
            
            state = .loaded
        } catch {
            state = .error(error)
        }
    }
    
    @MainActor
    func fetchChannels() async {
        state = .loading
        
        do {
            let channels = try await channelUseCase.execute()
            channelData = channels
            
            sectionData = (sectionData ?? []) + channels
            
            state = .loaded
        } catch {
            state = .error(error)
        }
    }
    
    @MainActor
    func fetchCategories() async {
        state = .loading
        
        do {
            let categories = try await categoryUseCase.execute()
            categoryData = categories
            
            sectionData = (sectionData ?? []) + categories
            
            state = .loaded
        } catch {
            state = .error(error)
        }
    }
}
