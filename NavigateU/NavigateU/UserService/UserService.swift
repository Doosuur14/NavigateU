//
//  UserService.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 22.03.2024.
//

import Foundation

final class UserService {
    static let shared = UserService()

  //  private var user: User?
    var users: [User] = [User(firstName: "Doosuur", lastName: "Faki", email: "doosuur14@gmail.com", password: "12345", nationality: "Nigerian", cityOfResidence: "Kazan")]

    private init() {}

    func login(email: String, password: String, completion: @escaping((Result<User, LoginError>) -> ())) {
        Task {
            do {
                if let user = users.first(where: {$0.email == email && $0.password == password}) {
                    print("User is found")
                    completion(.success(user))
                } else {
                    print("User is not found")
                    completion(.failure(LoginError.userNotFound))
                }
            }
        }
    }
}

enum LoginError: Error {
    case userNotFound
}
