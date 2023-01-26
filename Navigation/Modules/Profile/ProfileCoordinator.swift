//
//  ProfileCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profilVC = ProfileViewController()
        navigationController.pushViewController(profilVC, animated: true)
    }
    
    
}
