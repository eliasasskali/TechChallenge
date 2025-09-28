//
//  Created by Elias Asskali Assakali
// 

import SwiftUI

struct UserDetailLabelView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(label)
                .bold()
            Text(" \(value)")
        }
    }
}

#Preview {
    UserDetailLabelView(
        label: "Email:", 
        value: "testEmail@mail.com"
    )
}
