//
//  Created by Elias Asskali Assakali
// 

import XCTest
@testable import TechChallenge

final class LoadUsersUseCaseTests: XCTestCase {
    func test_whenLoadUsersIsCalled_thenReturnsDataSourceUsers() async throws {
        let mockDataSource = UsersDataSourceMock()
        mockDataSource.storedUsers = UsersDataSourceMock.jsonUsers
        let useCase = LoadUsersUseCaseDefault(dataSource: mockDataSource)
        
        let users = try await useCase.loadStoredUsersOrFetch()
        
        XCTAssertTrue(mockDataSource.loadStoredUsersCalled)
        XCTAssertEqual(users, UsersDataSourceMock.jsonUsers)
    }
    
    func test_whenFetchingNextPage_thenReturnsDataSourceUsers() async throws {
        let mockDataSource = UsersDataSourceMock()
        let nextPageUsers = [User(
            id: "12345",
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
        )]
        mockDataSource.storedUsers = UsersDataSourceMock.jsonUsers
        mockDataSource.nextPageUsers = nextPageUsers
        let useCase = LoadUsersUseCaseDefault(dataSource: mockDataSource)
        
        let users = try await useCase.fetchNextPage()
        
        XCTAssertTrue(mockDataSource.fetchNextPageCalled)
        XCTAssertEqual(users, UsersDataSourceMock.jsonUsers + nextPageUsers)
    }
}

