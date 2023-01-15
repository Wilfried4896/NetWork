//
//  SavedFileCoordinator.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 20.11.2022.
//

import UIKit

class SavedFileCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    func start() {
        let vc = SavedFileController()
        vc.coordiantor = self
        vc.title = Localization.SavedFileController_title.rawValue~
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(vc, animated: true)
    }
}
