//
//  Created by Elias Asskali Assakali
// 

import Foundation

protocol DeleteUserUseCase {
    func execute(id: String) async throws -> [User]
}

struct DeleteUserUseCaseDefault: DeleteUserUseCase {
    let dataSource: UsersDataSource
    
    func execute(id: String) async throws -> [User] {
        try await dataSource.deleteUser(with: id)
    }
}
