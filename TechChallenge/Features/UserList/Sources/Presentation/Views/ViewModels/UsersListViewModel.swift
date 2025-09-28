//
//  Created by Elias Asskali Assakali
//

import Foundation

@MainActor
class UsersListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var users: [User] = []
    
    let loadUsersUseCase: LoadUsersUseCase
    let deleteUserUseCase: DeleteUserUseCase
    
    init(
        loadUsersUseCase: LoadUsersUseCase,
        deleteUserUseCase: DeleteUserUseCase
    ) {
        self.loadUsersUseCase = loadUsersUseCase
        self.deleteUserUseCase = deleteUserUseCase
    }
    
    func loadUsers() async {
        guard !isLoading else { return }
        isLoading = true
        users = await loadUsersUseCase.loadStoredUsers()
        isLoading = false
    }
    
    func loadMoreUsers() async {
        guard !isLoading else { return }
        isLoading = true
        let newUsers = await loadUsersUseCase.fetchNextPage()
        users.append(contentsOf: newUsers)
        isLoading = false
    }
    
    func deleteUser(with id: String) async {
        isLoading = true
        users = await deleteUserUseCase.execute(id: id)
        isLoading = false
    }
}
