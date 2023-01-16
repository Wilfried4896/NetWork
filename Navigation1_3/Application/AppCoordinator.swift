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


//enum Localization: String {
//    case appCoordinator_Out_in_App = "appCoordinator_Out_in_App"
//    case setStatusButton = "setStatusButton"
//    case statusTextField = "statusTextField"
//    case actionButtonsetStatus = "actionButtonsetStatus"
//    case photoLabel = "photoLabel"
//    case profilItem_title = "profilItem_title"
//    case feddItem_title = "feddItem_title"
//    case saveFileItem_title = "saveFileItem_title"
//    case SavedFileController_title = "SavedFileController_title"
//    case InfoViewController_title = "InfoViewController_title"
//    case planeteLabel_text = "planeteLabel_text"
//    case tableView_title = "tableView_title"
//    case emailLogin_placeholder = "emailLogin_placeholder"
//    case passwordLogin_placeholder = "passwordLogin_placeholder"
//    case logInButton_title = "logInButton_title"
//    case buttonGetPassword_title = "buttonGetPassword_title"
//    case ShowAlert_UIAlertAction_title = "ShowAlert_UIAlertAction_title"
//    case logInButton_actionButton_error_title = "logInButton_actionButton_error_title"
//    case logInButton_actionButton_error_message = "logInButton_actionButton_error_message"
//    case message_alert_title = "message_alert_title"
//    case message_alert_message = "message_alert_message"
//    case message_destructive_title = "message_destructive_title"
//    case message_cancel_title = "message_cancel_title"
//    case ShowAlert_RealmSwift = "ShowAlert_RealmSwift"
//    case PhotosViewController_title = "PhotosViewController_title"
//    case checkGuessButton_title = "checkGuessButton_title"
//    case textFielFeed_placeholderTitle = "textFielFeed_placeholderTitle"
//    case feedViewController_title = "feedViewController_title"
//    case noDataAvaible_value = "noDataAvaible_value"
//    case invaliddURL_value = "invaliddURL_value"
//    case dataNotFound_value = "dataNotFound_value"
//    case noData_value = "noData_value"
//    case loginError_value = "loginError_value"
//    case userCurrent_status = "userCurrent_status"
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
        FirebaseApp.configure()
        let service = Service()
        guard service.signInWithRealm() else {
            goToLogin()
            return
        }
       goToHome()
    }
    
    func finish() {
        do {
            try Auth.auth().signOut()
            print("appCoordinator_Out_in_App".localized)
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
