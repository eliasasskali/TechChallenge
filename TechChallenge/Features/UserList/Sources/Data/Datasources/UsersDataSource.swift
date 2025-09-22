//
//  Created by Elias Asskali Assakali
//

import Foundation

protocol UsersDataSource {
    func fetchUsers() async -> [User]
}
