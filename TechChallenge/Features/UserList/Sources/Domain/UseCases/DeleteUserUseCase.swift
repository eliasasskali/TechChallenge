//
//  Created by Elias Asskali Assakali
// 

import Foundation

protocol DeleteUserUseCase {
    func execute(id: String) async -> [User]
}

struct DeleteUserUseCaseDefault: DeleteUserUseCase {
    let dataSource: UsersDataSource
    
    func execute(id: String) async -> [User] {
        await dataSource.deleteUser(with: id)
    }
}
