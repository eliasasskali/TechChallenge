//
//  Created by Elias Asskali Assakali
//

import SwiftUI

struct UserListItemView: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: user.picture.thumbnail) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 60, height: 60)
            .clipped()
            
            VStack(alignment: .leading) {
                Text(user.name.formatted)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
                Text(user.phone)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background()
        .cornerRadius(13)
        .shadow(color: Color.black.opacity(0.15), radius: 3)
        .padding(4)
    }
}

#Preview {
    UserListItemView(
        user: .init(
            name: .init(first: "Jennie", last: "Nichols"),
            email: "jennie.nichols@example.com",
            phone: "(272) 790-0888",
            gender: "female",
            registered: .init(date: "2007-07-09T05:51:59.390Z"),
            location: .init(
                street: .init(number: 8929, name: "Valwood Pkwy"),
                city: "Billings",
                state: "Michigan"
            ),
            picture: .init(
                large: URL(string: "https://randomuser.me/api/portraits/men/75.jpg")!,
                medium: URL(string: "https://randomuser.me/api/portraits/med/men/75.jpg")!,
                thumbnail: URL(string: "https://randomuser.me/api/portraits/thumb/men/75.jpg")!
            ),
            login: .init(uuid: "1234")
        )
    )
}
