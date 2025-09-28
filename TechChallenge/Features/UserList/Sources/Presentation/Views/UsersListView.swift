//
//  Created by Elias Asskali Assakali
//

import SwiftUI

struct UsersListView: View {
    @ObservedObject var viewModel: UsersListViewModel
    @State private var searchText = ""

    var filteredUsers: [User] {
        return if searchText.isEmpty {
            viewModel.users
        } else {
            viewModel.filterUsers(by: searchText)
        }
    }
    
    init(viewModel: UsersListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                List {
                    ForEach(filteredUsers, id: \.self) { user in
                        NavigationLink(value: user) {
                            UserListItemView(user: user)
                                .onAppear {
                                    if user == viewModel.users.last && searchText.isEmpty {
                                        Task {
                                            await viewModel.loadMoreUsers()
                                        }
                                    }
                                }
                        }
                    }
                    .onDelete(perform: deleteUser)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, idealHeight: 80)
                }
            }
            .task {
                await viewModel.loadUsers()
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
            .alert(
                "error".localized,
                isPresented: .constant(viewModel.errorMessage != nil),
                actions: {
                    Button("ok".localized) { viewModel.errorMessage = nil }
                }, message: {
                    Text(viewModel.errorMessage ?? "")
                }
            )
        }
    }
    
    private func deleteUser(at offsets: IndexSet) {
        for index in offsets {
            let userId = viewModel.users[index].id
            Task {
                await viewModel.deleteUser(with: userId)
            }
        }
    }
}
    
#Preview {
    UsersListView(
        viewModel: UsersListViewModel(
            loadUsersUseCase: LoadUsersUseCaseDefault(
                dataSource: UsersDataSourceDefault()
            ),
            deleteUserUseCase: DeleteUserUseCaseDefault(
                dataSource:  UsersDataSourceDefault()
            ),
            searchUsersUseCase: SearchUsersUseCaseDefault()
        )
    )
}
