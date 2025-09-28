//
//  Created by Elias Asskali Assakali
//

import SwiftUI

struct UserListItemView: View {
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: user.thumbnailPicture) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 60, height: 60)
            .clipped()
            
            VStack(alignment: .leading) {
                Text(user.formattedName)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
                Text(user.phone)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    UserListItemView(
        user: .init(
            id: "1",
            name: "Jennie",
            surname: "Nichols",
            email: "jennie.nichols@example.com",
            phone: "(272) 790-0888",
            gender: "female",
            registeredDate: ISO8601DateFormatter().date(from: "2007-07-09T05:51:59.390Z"),
            location: .init(
                streetName: "Valwood Pkwy",
                streetNumber: 8929,
                city: "Billings",
                state: "Michigan"
            ),
            thumbnailPicture: URL(string: "https://picsum.photos/100/100")!,
            largePicture: URL(string: "https://picsum.photos/800/800")!
        )
    )
}
