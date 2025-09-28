//
//  Created by Elias Asskali Assakali
// 

import Foundation

// MARK: - Mappers

extension UserDto {
    func toDomain() -> User {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        var date = formatter.date(from: registered.date)
        if date == nil {
            formatter.formatOptions = [.withInternetDateTime]
            date = formatter.date(from: registered.date)
        }
        
        return User(
            id: login.uuid,
            name: name.first,
            surname: name.last,
            email: email,
            phone: phone,
            gender: gender,
            registeredDate: date,
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
