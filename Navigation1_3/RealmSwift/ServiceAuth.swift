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
}


class Service: ServiceProtocol {
    let realm = try! Realm()
    
    func saveAuth(_ login: String, _ password: String) {
        let auth = Authentification()
        auth.login = login
        auth.password = password
        auth.isConnected = true
        UserDefaults.standard.set(auth.isConnected, forKey: "isConnected")
        
        try! realm.write {
            realm.add(auth)
        }
    }
}
