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
    var sectionData: [ChannelSectionData]? { get }
    
    var onStateChanged: ((ViewState) -> Void)? { get set }
    var onEpisodeDataChanged: (() -> Void)? { get set }
    var onSectionDataChanged: (() -> Void)? { get set }
    
    func fetchNewEpisode() async
}

final class ChannelViewModel: ChannelViewModelProtocol{
    
    private let newEpisodeUseCase: NewEpisodeUseCaseProtocol
    
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
    
    private(set) var sectionData: [ChannelSectionData]? {
        didSet {
            onSectionDataChanged?()
        }
    }
    
    // MARK: - Callbacks
    var onStateChanged: ((ViewState) -> Void)?
    var onEpisodeDataChanged: (() -> Void)?
    var onSectionDataChanged: (() -> Void)?
    
    // MARK: - Initialization
    init(
        newEpisodeUseCase: NewEpisodeUseCaseProtocol
    ) {
        self.newEpisodeUseCase = newEpisodeUseCase
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
            
            print("section data ", sectionData)
            state = .loaded
        } catch {
            state = .error(error)
        }
    }
}
