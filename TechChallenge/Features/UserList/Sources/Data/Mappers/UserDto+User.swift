//
//  Created by Elias Asskali Assakali
// 

import Foundation

// MARK: - Mappers

extension UserDto {
    func toDomain() -> User {
        .init(
            id: login.uuid,
            name: name.first,
            surname: name.last,
            email: email,
            phone: phone,
            gender: gender,
            registeredDate: registered.date,
            location: UserLocation(
                streetName: location.street.name,
                streetNumber: location.street.number,
                city: location.city,
                state: location.state
            ),
            thumbnailPicture: picture.thumbnail,
            largePicture: picture.large
        )
    }
}
