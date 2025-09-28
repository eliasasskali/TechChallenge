//
//  Created by Elias Asskali Assakali
//

import XCTest
@testable import TechChallenge

final class UsersDataSourceDefaultTests: XCTestCase {
    var dataSource: UsersDataSourceDefault!

    override func setUp() {
        super.setUp()
        dataSource = UsersDataSourceDefault()
        
        UserDefaults.standard.removeObject(forKey: UsersDataSourceDefault.Constants.deletedUsersIDs)
        UserDefaults.standard.removeObject(forKey: UsersDataSourceDefault.Constants.pageKey)
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func test_whenLoadUsersFromFile_thenAllUsersAreReturned() async throws {
        copyTestJSONToDocuments()
        
        let users = try await dataSource.loadStoredUsersOrFetch()
        
        XCTAssertEqual(users.count, 5)
        XCTAssertEqual(users, UsersDataSourceMock.jsonUsers)
    }
    
    
    func test_whenDeleteUser_thenUserIsRemoved() async throws {
        copyTestJSONToDocuments()
        var users = try await dataSource.loadStoredUsersOrFetch()
        let userToDelete = users.last!
        
        users = try await dataSource.deleteUser(with: userToDelete.id)
        
        XCTAssertFalse(users.contains(where: { $0.id == userToDelete.id }),)
        
        let deletedIDs = UserDefaults.standard.stringArray(forKey: UsersDataSourceDefault.Constants.deletedUsersIDs)
        XCTAssertTrue(deletedIDs?.contains(userToDelete.id) ?? false)
    }
}

private extension UsersDataSourceDefaultTests {
    var fileURL: URL? {
        FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("users.json")
    }
    
    private func copyTestJSONToDocuments() {
        guard let fileURL else { return }

        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: fileURL.path) {
            try? fileManager.removeItem(at: fileURL)
        }
        
        let bundle = Bundle(for: type(of: self))
        guard let sourceURL = bundle.url(forResource: "users", withExtension: "json") else {
            XCTFail("users.json not found in test bundle")
            return
        }
        
        do {
            try fileManager.copyItem(at: sourceURL, to: fileURL)
        } catch {
            XCTFail("Failed to copy users.json: \(error)")
        }
    }
}
