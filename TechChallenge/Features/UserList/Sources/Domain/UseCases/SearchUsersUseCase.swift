//
//  Created by Elias Asskali Assakali
// 

import Foundation

protocol SearchUsersUseCase {
    func execute(
        users: [User],
        searchText: String
    ) -> [User]
}

struct SearchUsersUseCaseDefault: SearchUsersUseCase {
    func execute(
        users: [User],
        searchText: String
    ) -> [User] {
        let query = searchText.lowercased()
        
        return users.filter { user in
            user.name.lowercased().contains(query) ||
            user.surname.lowercased().contains(query) ||
            user.email.lowercased().contains(query)
        }
    }
}
