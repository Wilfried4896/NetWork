//
//  ServiceAuth.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 15.11.2022.
//

import Foundation
import RealmSwift

protocol ServiceProtocol: AnyObject {
    func saveAuth(_ login: String, _ password: String)
    func signInWithRealm() -> Bool
}


class Service: ServiceProtocol {
    let realm = try! Realm()
    
    func saveAuth(_ login: String, _ password: String) {
        let auth = Authentification()
        auth.login = login
        auth.password = password
        auth.isConnected = true
        
        try! realm.write {
            realm.add(auth)
        }
    }
    
    func signInWithRealm() -> Bool {
        let realm = try! Realm()
        
        let accounts = realm.objects(Authentification.self)
        let user = Array(accounts)
        
        guard let isConnected = user.first?.isConnected, isConnected else {
            return false
        }
        return true
    }
}
