//
//  LoginViewModel.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 04.10.2022.
//

import Foundation

protocol LoginNavigation {
    func goToHome()
}

class LoginViewModel: LoginNavigation {
    
    var loginDelegate: LoginFactory?
    var navigation: LoginNavigation?
    
    func goToHome() {
        navigation?.goToHome()
    }
}
