//
//  Created by Elias Asskali Assakali
//

import SwiftUI

struct UsersListView: View {
    @ObservedObject var viewModel: UsersListViewModel
    
    init(viewModel: UsersListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            List {
                ForEach(viewModel.users, id: \.self) { user in
                    UserListItemView(user: user)
                        .onAppear {
                            if user == viewModel.users.last {
                                Task {
                                    print("load more users")
                                    await viewModel.loadMoreUsers()
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
            )
        )
    )
}
