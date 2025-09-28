//
//  Created by Elias Asskali Assakali
//

import Foundation

struct User: Codable {
    struct Name: Codable {
        let first: String
        let last: String
        
        var formatted: String {
            return "\(first) \(last)"
        }
    }
    
    struct Picture: Codable {
        let large: URL
        let medium: URL
        let thumbnail: URL
    }
    
    struct Login: Codable {
        let uuid: String
    }
    
    struct Registered: Codable {
        let date: String
    }
    
    let name: Name
    let email: String
    let phone: String
    let gender: String
    let registered: Registered
    let location: UserLocation
    let picture: Picture
    let login: Login
    
    var id: String { login.uuid }
    var data: String { registered.date }
}

// MARK: - Hashable

extension User: Hashable {
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
