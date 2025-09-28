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
    let searchUsersUseCase: SearchUsersUseCase
    
    init(
        loadUsersUseCase: LoadUsersUseCase,
        deleteUserUseCase: DeleteUserUseCase,
        searchUsersUseCase: SearchUsersUseCase
    ) {
        self.loadUsersUseCase = loadUsersUseCase
        self.deleteUserUseCase = deleteUserUseCase
        self.searchUsersUseCase = searchUsersUseCase
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
    
    func filterUsers(by searchText: String) -> [User] {
        let query = searchText.lowercased()
        
        return searchUsersUseCase.execute(users: users, query: query)
    }
}
