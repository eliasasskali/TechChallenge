//
//  Created by Elias Asskali Assakali
//

import Foundation

protocol LoadUsersUseCase {
    func loadStoredUsers() async -> [User]
    func fetchNextPage() async -> [User]
}

struct LoadUsersUseCaseDefault: LoadUsersUseCase {
    let dataSource: UsersDataSource
    
    func loadStoredUsers() async -> [User] {
        await dataSource.loadStoredUsers()
    }
    
    func fetchNextPage() async -> [User] {
        await dataSource.fetchNextPage()
    }
    
}
