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
        ScrollView {
            VStack(spacing: .zero) {
                LazyVStack {
                    ForEach(viewModel.users, id: \.self) { user in
                        UserListItemView(user: user)
                    }
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
        .padding()
    }
}

#Preview {
    UsersListView(
        viewModel: UsersListViewModel(
            loadUsersUseCase: LoadUsersUseCaseDefault(
                dataSource: UsersDataSourceDefault()
            )
        )
    )
}
