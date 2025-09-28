//
//  Created by Elias Asskali Assakali
// 

import XCTest
@testable import TechChallenge

final class DeleteUserUseCaseTest: XCTestCase {

    func test_whenDeleteUserIsCalled_thenUsersAreReturned() async throws {
        let mockDataSource = UsersDataSourceMock()
        let jsonUsers = UsersDataSourceMock.jsonUsers
        guard let lastUser = jsonUsers.last else {
            XCTFail("No users")
            return
        }
        mockDataSource.storedUsers = jsonUsers
        let useCase = DeleteUserUseCaseDefault(dataSource: mockDataSource)
        let expected = Array(jsonUsers.dropLast())
        
        let users = try await useCase.execute(id: lastUser.id)
        
        XCTAssertTrue(mockDataSource.deleteUserCalled)
        XCTAssertEqual(users, expected)
    }
}
