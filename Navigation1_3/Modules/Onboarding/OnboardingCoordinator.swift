//
//  OnboardingCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.11.2022.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        goToOnboarding()
    }
    
    func goToOnboarding() {
        let vc = OnboardingController()
        vc.coordinator = self
        navigation.pushViewController(vc, animated: true)
    }
    
    func goToLogin() {
        let app = parentCoordinator as? AppCoordinator
        app?.goToLogin()
        parentCoordinator?.childDidFinish(self)
    }
}
