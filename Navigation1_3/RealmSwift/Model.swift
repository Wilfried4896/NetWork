//
//  Model.swift
//  Navigation1_3
//
//  Created by Вилфриэд Оди on 15.11.2022.
//

import Foundation
import RealmSwift

class Authentification: Object {
    @Persisted var login = ""
    @Persisted var password = ""
    @Persisted var isConnected = false
}
