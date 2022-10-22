//
//  HomeTabBarCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import UIKit

class HomeTabBarCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        initializeHomeTabBar()
    }
    
    func initializeHomeTabBar() {
        let tabVC = UITabBarController()
        
        // Setup for profile tab
        let profileNavigationC = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationC)
        
        profileCoordinator.parentCoordinator = parentCoordinator
        
        // Create the tabbar item for tabbar.
        let profilItem = UITabBarItem()
        profilItem.title = "PROFILE"
        profilItem.image = UIImage(systemName: "person.fill")
        profileNavigationC.tabBarItem = profilItem
        
        // Setup for feed tab
        
        let feedNavigationC = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationC)
        
        feedCoordinator.parentCoordinator = parentCoordinator
        
        // Create the tabbar item for tabbar.
        
        let feddItem = UITabBarItem()
        feddItem.title = "FEED"
        feddItem.image = UIImage(systemName: "house.fill")
        feedNavigationC.tabBarItem = feddItem
        
        tabVC.viewControllers = [feedNavigationC, profileNavigationC]
        navigationController.pushViewController(tabVC, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
        
        // Add the coordinator into parent's child
        parentCoordinator?.childCoordinators.append(feedCoordinator)
        parentCoordinator?.childCoordinators.append(profileCoordinator)
        
        feedCoordinator.start()
        profileCoordinator.start()
    }
}
