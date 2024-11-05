//
//  AppCoordinator.swift
//  MindvalleyAssignment
//
//  Created by ricky wirawan on 05/11/24.
//

import UIKit

//use anyobject: protocol to be adopted only by classes & need to store weak references to conforming instances, as weak references only work with class types
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}

// App Coordinator to handle main app flow
class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        showHome()
    }
    
    private func showHome() {
        let viewController = ViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}
