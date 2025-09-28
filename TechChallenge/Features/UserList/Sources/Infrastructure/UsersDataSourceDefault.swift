//
//  Created by Elias Asskali Assakali
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let results: [User]
}

// MARK: - UsersDataSourceDefault

final actor UsersDataSourceDefault: UsersDataSource {
    private let urlString = "https://randomuser.me/api/?results=20&inc=name,email,phone,gender,location,registered,picture,login"
    private let fileName = "users.json"
    
    private var fileURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }

    func fetchUsers() async -> [User] {
        if let savedUsers = loadUsersFromFile() {
            return savedUsers
        }
        
        guard let url = URL(string: urlString) else {
            return []
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // TODO: Handle or throw error
                return []
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let users = try decoder.decode(UsersResponse.self, from: data)
            
            saveUsersToFile(users.results)
            
            return users.results
        } catch {
            // TODO: Handle or throw error
            print("Error fetching users: \(error)")
            return []
        }
    }
}

// MARK: - Private Methods

private extension UsersDataSourceDefault {
    func loadUsersFromFile() -> [User]? {
        guard let fileURL = fileURL,
              let data = try? Data(contentsOf: fileURL) else { return nil }
        return try? JSONDecoder().decode([User].self, from: data)
    }
    
    private func saveUsersToFile(_ users: [User]) {
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
