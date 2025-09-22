//
//  Created by Elias Asskali Assakali
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        UsersListView(
            viewModel: UsersListViewModel(
                loadUsersUseCase: LoadUsersUseCaseDefault(
                    dataSource: UsersDataSourceDefault()
                )
            )
        )
    }
}

#Preview {
    ContentView()
}
