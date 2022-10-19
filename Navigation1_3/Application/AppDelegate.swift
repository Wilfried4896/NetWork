//
//  AppDelegate.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 02.06.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationContoller = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(window: window, navController: navigationContoller)
        
        coordinator?.start()
        return true
    }
}

