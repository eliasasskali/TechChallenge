//
//  Created by Elias Asskali Assakali
// 

import Foundation

struct UserLocationDto: Codable {
    struct Street: Codable {
        let number: Int
        let name: String
    }
    
    let street: Street
    let city: String
    let state: String
}
