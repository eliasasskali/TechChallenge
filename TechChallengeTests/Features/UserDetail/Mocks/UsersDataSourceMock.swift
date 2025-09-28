//
//  Created by Elias Asskali Assakali
// 

import Foundation
@testable import TechChallenge

final class UsersDataSourceMock: UsersDataSource {
    var storedUsers: [User] = []
    var nextPageUsers: [User] = []
    
    var loadStoredUsersCalled = false
    var fetchNextPageCalled = false
    var deleteUserCalled = false
    
    func loadStoredUsersOrFetch() async -> [User] {
        loadStoredUsersCalled = true
        return storedUsers
    }
    
    func fetchNextPage() async -> [User] {
        fetchNextPageCalled = true
        return storedUsers + nextPageUsers
    }
    
    func deleteUser(with id: String) async -> [User] {
        deleteUserCalled = true
        storedUsers.removeAll { $0.id == id }
        nextPageUsers.removeAll { $0.id == id }
        return storedUsers
    }
}

extension UsersDataSourceMock {
    static var jsonUsers: [User] {
        [
            User(
                id: "1e184e87-7716-4544-88fe-6ecf828e7e24",
                name: "Andreas",
                surname: "Sørensen",
                email: "andreas.sorensen@example.com",
                phone: "51594912",
                gender: "male",
                registeredDate: ISO8601DateFormatter().date(from: "2017-09-11T02:14:12.938Z"),
                location: UserLocation(
                    streetName: "Grønnevej",
                    streetNumber: 5460,
                    city: "Ugerløse",
                    state: "Nordjylland"
                ),
                thumbnailPicture: URL(string: "https://randomuser.me/api/portraits/thumb/men/95.jpg")!,
                largePicture: URL(string: "https://randomuser.me/api/portraits/men/95.jpg")!
            ),
            User(
                id: "1388ce33-803d-4015-962b-bd482bda292e",
                name: "Alice",
                surname: "Breidenbach",
                email: "alice.breidenbach@example.com",
                phone: "0850-4284584",
                gender: "female",
                registeredDate: ISO8601DateFormatter().date(from: "2011-01-28T00:17:35.973Z"),
                location: UserLocation(
                    streetName: "Birkenweg",
                    streetNumber: 4074,
                    city: "Radevormwald",
                    state: "Saarland"
                ),
                thumbnailPicture: URL(string: "https://randomuser.me/api/portraits/thumb/women/59.jpg")!,
                largePicture: URL(string: "https://randomuser.me/api/portraits/women/59.jpg")!
            ),
            User(
                id: "179d9164-d78d-4638-80c3-7bdf4d8260e5",
                name: "Deniz",
                surname: "Velioğlu",
                email: "deniz.velioglu@example.com",
                phone: "(658)-961-7129",
                gender: "female",
                registeredDate: ISO8601DateFormatter().date(from: "2006-04-13T11:36:50.744Z"),
                location: UserLocation(
                    streetName: "Atatürk Sk",
                    streetNumber: 3779,
                    city: "Bartın",
                    state: "Giresun"
                ),
                thumbnailPicture: URL(string: "https://randomuser.me/api/portraits/thumb/women/70.jpg")!,
                largePicture: URL(string: "https://randomuser.me/api/portraits/women/70.jpg")!
            ),
            User(
                id: "693974a4-c300-43ba-8de9-2b14fc85bde5",
                name: "Maureen",
                surname: "Jacobs",
                email: "maureen.jacobs@example.com",
                phone: "(636) 798-7566",
                gender: "female",
                registeredDate: ISO8601DateFormatter().date(from: "2004-12-09T19:09:49.033Z"),
                location: UserLocation(
                    streetName: "Plum St",
                    streetNumber: 7816,
                    city: "Denver",
                    state: "Tennessee"
                ),
                thumbnailPicture: URL(string: "https://randomuser.me/api/portraits/thumb/women/68.jpg")!,
                largePicture: URL(string: "https://randomuser.me/api/portraits/women/68.jpg")!
            ),
            User(
                id: "5fda7dbc-93de-4935-b71f-de585a2b94ab",
                name: "Lilli",
                surname: "Dalsbø",
                email: "lilli.dalsbo@example.com",
                phone: "25472118",
                gender: "female",
                registeredDate: ISO8601DateFormatter().date(from: "2006-07-20T09:41:09.692Z"),
                location: UserLocation(
                    streetName: "Bleikøya",
                    streetNumber: 1545,
                    city: "Tromsø",
                    state: "Bergen"
                ),
                thumbnailPicture: URL(string: "https://randomuser.me/api/portraits/thumb/women/18.jpg")!,
                largePicture: URL(string: "https://randomuser.me/api/portraits/women/18.jpg")!
            )
        ]
    }
}
