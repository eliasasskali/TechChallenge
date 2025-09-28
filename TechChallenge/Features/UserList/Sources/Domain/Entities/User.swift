//
//  Created by Elias Asskali Assakali
//

import Foundation

struct User: Codable {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        return formatter
    }()
    
    let id: String
    let name: String
    let surname: String
    let email: String
    let phone: String
    let gender: String
    let registeredDate: Date?
    let location: UserLocation
    let thumbnailPicture: URL
    let largePicture: URL
    
    var formattedName: String {
        return "\(name) \(surname)"
    }
    
    var formattedRegisteredDate: String? {
        guard let registeredDate else {
            return nil
        }
        return Self.dateFormatter.string(from: registeredDate)
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
