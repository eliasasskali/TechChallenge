//
//  Created by Elias Asskali Assakali
//

import Foundation

protocol UsersDataSource {
    func fetchNextPage() async -> [User]
    func loadStoredUsersOrFetch() async -> [User]
    func deleteUser(with id: String) async -> [User]
}
