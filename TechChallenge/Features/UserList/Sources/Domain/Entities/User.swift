//
//  Created by Elias Asskali Assakali
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let surname: String
    let email: String
    let phone: String
    let gender: String
    let registeredDate: String
    let location: UserLocation
    let thumbnailPicture: URL
    let largePicture: URL
    
    var formattedName: String {
        return "\(name) \(surname)"
    }
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
