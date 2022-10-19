//
//  AppCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 03.10.2022.
//

import UIKit

enum AppConfiguration: String {
    case people
    case starships
    case planets
}

extension AppConfiguration: CustomStringConvertible {
    var description: String {
        switch self {
        case.people:
            return "https://swapi.dev/api/people/8"
        case .planets:
            return "https://swapi.dev/api/planets/5"
        case.starships:
            return "https://swapi.dev/api/starships/3"
        }
    }
}

struct NetworkManager {
    static func request(for configuration: AppConfiguration) {
        
        guard let url = URL(string: configuration.description) else {
            print("FailResquest")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, reponse, error in
            
            if let error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let MyReponse = reponse as? HTTPURLResponse {
                print("Reponse \(MyReponse.statusCode)\n")
                print("AllHeaderFields: \(MyReponse.allHeaderFields)\n")
            }
            
            guard let data else {
                print("Data nil")
                return
            }
            do {
                let anwser = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print(anwser ?? [])
            } catch {
                print(error)
            }
                        
        }.resume()
    }
}

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
        
        NetworkManager.request(for: .people)
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
