//
//  LoginModel.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(loginUser: String, passwordUser: String) -> Bool
}

// фабрика
protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    let loginInspector: LoginInspector
    
    func makeLoginInspector() -> LoginInspector {
        return loginInspector
    }
}

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(loginUser: String, passwordUser: String) -> Bool {
        Checker.shared.check(loginUser: loginUser, passwordUser: passwordUser)
    }
}


class Checker: LoginViewControllerDelegate {
    
    static let shared = Checker()
    
    private init() {}
    
    var login: String = ""
    var password: String = ""
    
    func check(loginUser: String, passwordUser: String) -> Bool {
        return loginUser == login && passwordUser == password
    }
}

