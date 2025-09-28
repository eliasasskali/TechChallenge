//
//  Created by Elias Asskali Assakali
// 

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: user.largePicture) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipped()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .aspectRatio(1.5, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                
                Group {
                    UserDetailLabelView(
                        label: "product_detail_info_name".localized,
                        value: user.formattedName
                    )
                    
                    UserDetailLabelView(
                        label: "product_detail_info_gender".localized,
                        value: user.gender
                    )
                    
                    UserDetailLabelView(
                        label: "product_detail_info_location".localized,
                        value: user.location.formatted
                    )
                    
                    UserDetailLabelView(
                        label: "product_detail_info_email".localized,
                        value: user.email
                    )
                    
                    if let registeredDate = user.formattedRegisteredDate {
                        UserDetailLabelView(
                            label: "product_detail_info_registered_date".localized,
                            value: registeredDate
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    UserDetailView(
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
            largePicture: URL(string: "https://picsum.photos/800/600")!
        )
    )
}
