//
//  AppCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 03.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

enum AppConfiguration: String {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/planets/5"
    case planets = "https://swapi.dev/api/starships/3"
}

//struct NetworkManager {
//    static func request(for configuration: AppConfiguration) {
//
//        guard let url = URL(string: configuration.rawValue) else {
//            print("FailResquest")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, reponse, error in
//
//            if let error {
//                print("Error: \(error.localizedDescription)")
//            }
//
//            if let MyReponse = reponse as? HTTPURLResponse {
//                print("Reponse \(MyReponse.statusCode)\n")
//                print("AllHeaderFields: \(MyReponse.allHeaderFields)\n")
//            }
//
//            guard let data else {
//                print("Data nil")
//                return
//            }
//            do {
//                let anwser = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//                print(anwser ?? [])
//            } catch {
//                print(error)
//            }
//
//        }.resume()
//    }
//}

class AppCoordinator: Coordinator {
    
    var window: UIWindow?
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        window?.makeKeyAndVisible()
        goToLogin()
        FirebaseApp.configure()
        
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
