//
//  Created by Elias Asskali Assakali
//

import Foundation

struct UserLocation: Codable {
    struct Street: Codable {
        let number: Int
        let name: String
        
        var formatted: String {
            return "\(name) \(number)"
        }
    }
    
    let street: Street
    let city: String
    let state: String
    
    var formatted: String {
        return "\(street), \(city), \(state)"
    }
}
