//
//  Created by Elias Asskali Assakali
//

import Foundation

protocol UsersDataSource {
    func fetchNextPage() async throws -> [User]
    func loadStoredUsersOrFetch() async throws -> [User]
    func deleteUser(with id: String) async throws -> [User]
}
