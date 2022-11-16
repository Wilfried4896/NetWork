//
//  LoginViewModel.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import Foundation
import FirebaseAuth
import RealmSwift

protocol LoginNavigation {
    func goToHome()
}

protocol CheckerServiceProtocol {
    func checkCredentials(_ email: String, _ password: String, _ complition: @escaping ((Result<String, AuthErrorCode>) -> Void))
    func signUp(_ email: String, _ password: String)
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(_ email: String, _ password: String, _ complition: @escaping ((Result<String, AuthErrorCode>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard  error == nil else {
                complition(.failure(error as! AuthErrorCode))
                return
            }
            let user = Auth.auth().currentUser
            complition(.success("\(user!.email ?? "")"))
        }
    }

    func signUp(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
}


class LoginViewModel: LoginNavigation {
    
    var navigation: LoginNavigation?
    
    func goToHome() {
        navigation?.goToHome()
    }
}

