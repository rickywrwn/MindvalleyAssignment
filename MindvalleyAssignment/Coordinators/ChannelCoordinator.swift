//
//  HomeCoordinator.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 05/11/24.
//

import UIKit

class ChannelCoordinator: Coordinator {
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let container: DIContainer
    
    init(navigationController: UINavigationController, container: DIContainer) {
        self.navigationController = navigationController
        self.container = container
        setupNavigationBar()
    }
    
    func start() {
        showChannel()
    }
    
    private func showChannel() {
        let newEpisodeUseCase = container.newEpisodeUseCase
        let viewModel = ChannelViewModel(newEpisodeUseCase: newEpisodeUseCase)
        
        let viewController = ChannelViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.channelNavigationTextColor]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.channelNavigationTextColor]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        
        navigationController.navigationBar.tintColor = .white
    }
}
