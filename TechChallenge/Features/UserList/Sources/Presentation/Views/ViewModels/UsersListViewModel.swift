//
//  Created by Elias Asskali Assakali
//

import Foundation

@MainActor
class UsersListViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var users: [User] = []
    
    let loadUsersUseCase: LoadUsersUseCase
    
    init(loadUsersUseCase: LoadUsersUseCase) {
        self.loadUsersUseCase = loadUsersUseCase
    }
    
    func loadUsers() async {
        isLoading = true
        users = await loadUsersUseCase.execute()
        isLoading = false
    }
}
