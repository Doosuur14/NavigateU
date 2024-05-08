//
//  UserService.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 22.03.2024.
//

import Foundation
import FirebaseAuth

final class UserService {
    static let shared = UserService()

  //  private var user: User?
//    var users: [User] = [User(firstName: "Doosuur", lastName: "Faki", email: "doosuur14@gmail.com", password: "12345", nationality: "Nigerian", cityOfResidence: "Kazan")]
//
//    private init() {}
//
//    func login(email: String, password: String, completion: @escaping((Result<User, LoginError>) -> ())) {
//        Task {
//            do {
//                if let user = users.first(where: {$0.email == email && $0.password == password}) {
//                    print("User is found")
//                    completion(.success(user))
//                } else {
//                    print("User is not found")
//                    completion(.failure(LoginError.userNotFound))
//                }
//            }
//        }
//    }
//}
    func login(email: String, password: String, completion: @escaping((Result<AuthDataResult, LoginError>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print("errorr while logging in this user")
                completion(.failure(LoginError.userNotFound))
            } else if let authResult = authResult {
                print("user successfully logged in")
                completion(.success(authResult))
            }
        }
    }
}

enum LoginError: Error {
    case userNotFound
}
