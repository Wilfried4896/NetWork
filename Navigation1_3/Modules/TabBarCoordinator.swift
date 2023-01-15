//
//  TabBarCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.

import UIKit

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
        
        // MARK: - Setup for profile tab
        let profileNavigationC = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationC)
        
        profileCoordinator.parentCoordinator = parentCoordinator
        
        
        // MARK: - Create the tabbar item for tabbar.
        let profilItem = UITabBarItem()
        profilItem.title = Localization.profilItem_title.rawValue~
        profilItem.image = UIImage(systemName: "person.fill")
        profileNavigationC.tabBarItem = profilItem
        
        // MARK: - Setup for feed tab
        
        let feedNavigationC = UINavigationController()
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationC)
        
        feedCoordinator.parentCoordinator = parentCoordinator
        
        // MARK: - Create the tabbar item for tabbar.
        
        let feddItem = UITabBarItem()
        feddItem.title = Localization.feddItem_title.rawValue~
        feddItem.image = UIImage(systemName: "house.fill")
        feedNavigationC.tabBarItem = feddItem
        
        // MARK: - love page saved
        let savedFileNavigation = UINavigationController()
        let savedFileCoordinator = SavedFileCoordinator(navigation: savedFileNavigation)
        savedFileCoordinator.parentCoordinator = parentCoordinator
        
        let saveFileItem = UITabBarItem()
        saveFileItem.title = Localization.saveFileItem_title.rawValue~
        saveFileItem.image = UIImage(systemName: "square.and.arrow.up.circle.fill")
        savedFileNavigation.tabBarItem = saveFileItem
        
        controller.append(feedNavigationC)
        controller.append(profileNavigationC)
        controller.append(savedFileNavigation)
        
        navigationController.setViewControllers(controller, animated: true)
        
        // MARK: - Add the coordinator into parent's child
        parentCoordinator?.childCoordinators.append(feedCoordinator)
        parentCoordinator?.childCoordinators.append(profileCoordinator)
        parentCoordinator?.childCoordinators.append(savedFileCoordinator)
        
        feedCoordinator.start()
        profileCoordinator.start()
        savedFileCoordinator.start()
    }
}
