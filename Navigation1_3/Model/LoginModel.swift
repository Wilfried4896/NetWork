//
//  LoginModel.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import Foundation
import FirebaseAuth

protocol LoginViewControllerDelegate {
    func checkCredentials(_ email: String, _ password: String, _ complition: @escaping ((Result<(String), AuthErrorCode>) -> Void))
    func signUp(_ email: String, _ password: String)
}

struct LoginInspector: LoginViewControllerDelegate {
  
    let checkerService = CheckerService()
    
    func checkCredentials(_ email: String, _ password: String, _ complition: @escaping ((Result<(String), AuthErrorCode>) -> Void)) {
        checkerService.checkCredentials(email, password) { auth in
            switch auth {
            case .success(let auth):
                complition(.success(auth))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }

//    func checkCredentials(_ email: String, _ password: String) {
//        checkerService.checkCredentials(email, password)
//    }
    
    func signUp(_ email: String, _ password: String) {
        checkerService.signUp(email, password)
    }
}

