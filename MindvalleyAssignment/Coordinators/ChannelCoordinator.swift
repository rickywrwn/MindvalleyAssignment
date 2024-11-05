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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
    }
    
    func start() {
        showChannel()
    }
    
    private func showChannel() {
        let viewController = ChannelViewController()
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
