//
//  Created by Elias Asskali Assakali
// 

import XCTest
@testable import TechChallenge

final class SearchUsersUseCaseTests: XCTestCase {

    func test_whenSearchingForUsers_thenReturnsFilteredUsers() {
        let sut = SearchUsersUseCaseDefault()
        let jsonUsers = UsersDataSourceMock.jsonUsers
        
        guard let lastUser = jsonUsers.last else {
            XCTFail("No users")
            return
        }
        
        let filteredUserByName = sut.execute(
            users: jsonUsers,
            searchText: lastUser.name
        )
        let filteredUserBySurname = sut.execute(
            users: jsonUsers,
            searchText: lastUser.name
        )
        let filteredUserByEmail = sut.execute(
            users: jsonUsers,
            searchText: lastUser.email
        )
        
        XCTAssertEqual(filteredUserByName, [lastUser])
        XCTAssertEqual(filteredUserBySurname, [lastUser])
        XCTAssertEqual(filteredUserByEmail, [lastUser])
    }
}
