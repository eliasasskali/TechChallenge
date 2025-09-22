//
//  Created by Elias Asskali Assakali
//

import Foundation

protocol LoadUsersUseCase {
    func execute() async -> [User]
}

struct LoadUsersUseCaseDefault: LoadUsersUseCase {
    let dataSource: UsersDataSource
    
    func execute() async -> [User] {
        await dataSource.fetchUsers()
    }
}
