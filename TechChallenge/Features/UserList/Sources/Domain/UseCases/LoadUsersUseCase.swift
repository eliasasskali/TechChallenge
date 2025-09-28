//
//  Created by Elias Asskali Assakali
//

import Foundation

protocol LoadUsersUseCase {
    func loadStoredUsersOrFetch() async -> [User]
    func fetchNextPage() async -> [User]
}

struct LoadUsersUseCaseDefault: LoadUsersUseCase {
    let dataSource: UsersDataSource
    
    func loadStoredUsersOrFetch() async -> [User] {
        await dataSource.loadStoredUsersOrFetch()
    }
    
    func fetchNextPage() async -> [User] {
        await dataSource.fetchNextPage()
    }
}
