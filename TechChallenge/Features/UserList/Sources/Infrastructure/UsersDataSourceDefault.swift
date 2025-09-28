//
//  Created by Elias Asskali Assakali
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let results: [UserDto]
}

// MARK: - UsersDataSource Errors

enum UsersDataSourceError: Error, LocalizedError {
    case networkError
    case saveError
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "users_fetch_network_error".localized
        case .saveError:
            return "users_save_error".localized
        }
    }
}

// MARK: - UsersDataSourceDefault

final actor UsersDataSourceDefault: UsersDataSource {
    enum Constants {
        static let fileName = "users.json"
        static let seed = "techchallenge"
        static let resultsPerPage = 5
        
        // UserDefaults keys
        static let deletedUsersIDs = "deletedUsersIDs"
        static let pageKey = "currentPage"
    }
    
    private var fileURL: URL? {
        FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(Constants.fileName)
    }
    
    private var currentPage: Int {
        get { UserDefaults.standard.integer(forKey: Constants.pageKey) }
        set { UserDefaults.standard.set(newValue, forKey: Constants.pageKey) }
    }
    
    private var deletedUsersIDs: Set<String> {
        get { Set(UserDefaults.standard.stringArray(forKey: Constants.deletedUsersIDs) ?? []) }
        set { UserDefaults.standard.set(Array(newValue), forKey: Constants.deletedUsersIDs) }
    }
    
    func fetchNextPage() async throws -> [User] {
        let nextPage = currentPage + 1

        guard let url = URL(string: urlString(for: nextPage)) else {
            throw UsersDataSourceError.networkError
        }
                
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw UsersDataSourceError.networkError
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let newUsers = try decoder.decode(UsersResponse.self, from: data).results
            
            var allUsers = loadUsersFromFile() ?? []
            
            // Remove duplicates and removed users based on user ID
            let existingUserIDs = Set(allUsers.map { $0.login.uuid })
            let filteredNewUsers = newUsers.filter {
                !existingUserIDs.contains($0.login.uuid) &&
                !deletedUsersIDs.contains($0.login.uuid)
            }
                        
            allUsers.append(contentsOf: filteredNewUsers)
            try saveUsersToFile(allUsers)
            
            currentPage = nextPage
            
            return filteredNewUsers.map { $0.toDomain() }
        } catch {
            throw UsersDataSourceError.networkError
        }
    }
    
    func loadStoredUsersOrFetch() async throws -> [User] {
        guard let localUsers = loadUsersFromFile(), !localUsers.isEmpty else {
            return try await fetchNextPage()
        }
        return localUsers.map { $0.toDomain() }
    }
    
    func deleteUser(with id: String) async throws -> [User] {
        var users = loadUsersFromFile() ?? []
        users.removeAll { $0.login.uuid == id }
        try saveUsersToFile(users)
        deletedUsersIDs.insert(id)
        return users.map { $0.toDomain() }
    }
}

// MARK: - Private Methods

private extension UsersDataSourceDefault {
    func urlString(for page: Int) -> String { "https://randomuser.me/api/?page=\(page)&results=\(Constants.resultsPerPage)&seed=\(Constants.seed)&inc=name,email,phone,gender,location,registered,picture,login"
    }
    
    func loadUsersFromFile() -> [UserDto]? {
        guard let fileURL,
              let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode([UserDto].self, from: data)
    }
    
    private func saveUsersToFile(_ users: [UserDto]) throws {
        guard let fileURL else {
            throw UsersDataSourceError.saveError
        }
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(users)
            try data.write(to: fileURL)
        } catch {
            throw UsersDataSourceError.saveError
        }
    }
}
