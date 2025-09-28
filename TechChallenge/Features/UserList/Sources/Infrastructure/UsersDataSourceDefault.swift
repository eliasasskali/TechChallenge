//
//  Created by Elias Asskali Assakali
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let results: [UserDto]
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
    
    func fetchNextPage() async -> [User] {
        let nextPage = currentPage + 1

        guard let url = URL(string: urlString(for: nextPage)) else {
            return loadUsersFromFile()?.map { $0.toDomain() } ?? []
        }
                
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // TODO: Handle or throw error
                return loadUsersFromFile()?.map { $0.toDomain() } ?? []
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
            saveUsersToFile(allUsers)
            
            currentPage = nextPage
            
            return filteredNewUsers.map { $0.toDomain() }
        } catch {
            // TODO: Handle or throw error
            print("Error fetching users: \(error)")
            return loadUsersFromFile()?.map { $0.toDomain() } ?? []
        }
    }
    
    func loadStoredUsersOrFetch() async -> [User] {
        guard let localUsers = loadUsersFromFile(), !localUsers.isEmpty else {
            return await fetchNextPage()
        }
        return localUsers.map { $0.toDomain() }
    }
    
    func deleteUser(with id: String) async -> [User] {
        var users = loadUsersFromFile() ?? []
        users.removeAll { $0.login.uuid == id }
        saveUsersToFile(users)
        deletedUsersIDs.insert(id)
        return users.map { $0.toDomain() }
    }
}

// MARK: - Private Methods

private extension UsersDataSourceDefault {
    func urlString(for page: Int) -> String { "https://randomuser.me/api/?page=\(page)&results=\(Constants.resultsPerPage)&seed=\(Constants.seed)&inc=name,email,phone,gender,location,registered,picture,login"
    }
    
    func loadUsersFromFile() -> [UserDto]? {
        guard let fileURL = fileURL,
              let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode([UserDto].self, from: data)
    }
    
    private func saveUsersToFile(_ users: [UserDto]) {
        guard let fileURL else { return }
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(users)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save users: \(error)")
        }
    }
}
