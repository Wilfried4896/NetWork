//
//  LoginCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginPage()
    }
}

extension LoginCoordinator: LoginNavigation {
    
    func  goToLoginPage() {
        let loginInspector = LoginInspector()
        
        // Instantiate LoginViewController
        let loginVC = LogInViewController()
        let serviceAuth = Service()
        let loginViewModel = LoginViewModel()
        loginViewModel.navigation = self
        loginVC.loginDelegate = loginInspector
        loginVC.viewModel = loginViewModel
        loginVC.serviceDelegate = serviceAuth
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func goToHome() {
        // Get the app coordinator
        let appC = parentCoordinator as? AppCoordinator
        appC?.goToHome()
        parentCoordinator?.childDidFinish(self)
    }
}
