//
//  FeedCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import UIKit

class FeedCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToFeed()
    }
    
    func goToFeed() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.pushViewController(feedVC, animated: true)
    }
    
    
    func goToInfo() {
        let vc = InfoViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}



