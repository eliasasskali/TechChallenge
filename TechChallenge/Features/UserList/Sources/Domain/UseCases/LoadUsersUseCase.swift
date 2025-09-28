//
//  Created by Elias Asskali Assakali
//

import Foundation

protocol LoadUsersUseCase {
    func loadStoredUsersOrFetch() async throws -> [User]
    func fetchNextPage() async throws -> [User]
}

struct LoadUsersUseCaseDefault: LoadUsersUseCase {
    let dataSource: UsersDataSource
    
    func loadStoredUsersOrFetch() async throws -> [User] {
        try await dataSource.loadStoredUsersOrFetch()
    }
    
    func fetchNextPage() async throws -> [User] {
        try await dataSource.fetchNextPage()
    }
}
