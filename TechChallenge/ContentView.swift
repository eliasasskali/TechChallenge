//
//  Created by Elias Asskali Assakali
//

import SwiftUI

struct ContentView: View {
    let usersDataSource: UsersDataSource = UsersDataSourceDefault()
    
    var body: some View {
        UsersListView(
            viewModel: UsersListViewModel(
                loadUsersUseCase: LoadUsersUseCaseDefault(
                    dataSource: usersDataSource
                ),
                deleteUserUseCase: DeleteUserUseCaseDefault(
                    dataSource: usersDataSource
                ),
                searchUsersUseCase: SearchUsersUseCaseDefault()
            )
        )
    }
}

#Preview {
    ContentView()
}
