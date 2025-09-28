//
//  Created by Elias Asskali Assakali
//

import Foundation

struct UserLocation: Codable {
    let streetName: String
    let streetNumber: Int
    let city: String
    let state: String
    
    var formatted: String {
        return "\(streetName) \(streetNumber), \(city), \(state)"
    }
}
