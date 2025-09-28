//
//  Created by Elias Asskali Assakali
// 

import Foundation

struct UserDto: Codable {
    struct Name: Codable {
        let first: String
        let last: String
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
    let location: UserLocationDto
    let picture: Picture
    let login: Login
}

// MARK: - Hashable

extension UserDto: Hashable {
    public static func == (lhs: UserDto, rhs: UserDto) -> Bool {
        lhs.login.uuid == rhs.login.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(login.uuid)
    }
}
