//
//  AppCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 03.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import RealmSwift

class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController?
    let realm = try! Realm()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        
        guard UserDefaults.standard.bool(forKey: "isConnected") else {
            goToLogin()
            return
        }
       goToHome()
        
    }
    
    func finish() {
        do {
            try Auth.auth().signOut()
            print("Sign Out")
        } catch {
            print(error.localizedDescription)
        }
    }


    func goToLogin() {
        rootViewController = UINavigationController()
        window?.rootViewController = rootViewController
        
        let loginCoordinator = LoginCoordinator(navigationController: rootViewController as! UINavigationController)
        childCoordinators.removeAll()
        
        loginCoordinator.parentCoordinator = self
        childCoordinators.append(loginCoordinator)
        
        loginCoordinator.start()
    }
    
    func goToHome() {
        rootViewController = UITabBarController()
        window?.rootViewController = rootViewController
        
        let tabBarCoordinator = TabBarCoordinator(navigationController: rootViewController as! UITabBarController)
        childCoordinators.removeAll()
        
        tabBarCoordinator.parentCoordinator = self
        childCoordinators.append(tabBarCoordinator)
        
        tabBarCoordinator.start()
    }
}
