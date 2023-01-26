

import Foundation
import RealmSwift

class Authentification: Object {
    @Persisted var login = ""
    @Persisted var password = ""
    @Persisted var isConnected = false
}
