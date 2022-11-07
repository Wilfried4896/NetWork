//
//  TabBarCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.

import UIKit
import FirebaseAuth

class TabBarCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UITabBarController
    
    required init(navigationController: UITabBarController) {
        self.navigationController = navigationController
    }
    
    func start() {
        initializeHomeTabBar()
    }
    
    func initializeHomeTabBar() {
        
        var controller: [UIViewController] = []
        let user = Auth.auth().currentUser
        // Setup for profile tab
        let profileNavigationC = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationC)
        
        profileCoordinator.parentCoordinator = parentCoordinator
        
        
        // Create the tabbar item for tabbar.
        let profilItem = UITabBarItem()
        if user != nil {
            profilItem.title = "\(user?.email ?? "PROFILE")"
        }
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
       
        
        controller.append(feedNavigationC)
        controller.append(profileNavigationC)
        
        navigationController.setViewControllers(controller, animated: true)
        
        // Add the coordinator into parent's child
        parentCoordinator?.childCoordinators.append(feedCoordinator)
        parentCoordinator?.childCoordinators.append(profileCoordinator)
        
        feedCoordinator.start()
        profileCoordinator.start()
    }
}
