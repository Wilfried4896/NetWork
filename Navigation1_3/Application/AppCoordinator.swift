//
//  AppCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 03.10.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(window: UIWindow?, navController: UINavigationController) {
        self.window = window
        self.navigationController = navController
    }
    
    func start() {
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        goToLogin()
    }

    func goToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        childCoordinators.removeAll()
        
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator)
        
        loginCoordinator.start()
    }
    
    func goToHome() {
        let homeTabBarCoordinator = HomeTabBarCoordinator(navigationController: navigationController)
        childCoordinators.removeAll()
        
        homeTabBarCoordinator.parentCoordinator = self
        childCoordinators.append(homeTabBarCoordinator)
        
        homeTabBarCoordinator.start()
    }
}



