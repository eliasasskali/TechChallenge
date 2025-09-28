//
//  Created by Elias Asskali Assakali
//

import Foundation

@MainActor
class UsersListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var users: [User] = []
    @Published var errorMessage: String? = nil

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
        defer { isLoading = false }
        
        do {
            users = try await loadUsersUseCase.loadStoredUsersOrFetch()
        } catch {
            handle(error)
        }
    }
    
    func loadMoreUsers() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newUsers = try await loadUsersUseCase.fetchNextPage()
            users.append(contentsOf: newUsers)
        } catch {
            handle(error)
        }
        isLoading = false
    }
    
    func deleteUser(with id: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            users = try await deleteUserUseCase.execute(id: id)
        } catch {
            handle(error)
        }
    }
    
    func filterUsers(by searchText: String) -> [User] {
        searchUsersUseCase.execute(users: users, searchText: searchText)
    }
}

private extension UsersListViewModel {
    func handle(_ error: Error) {
        if let dataSourceError = error as? UsersDataSourceError {
            errorMessage = dataSourceError.localizedDescription
        } else {
            errorMessage = "generic_error".localized
        }
    }
}
