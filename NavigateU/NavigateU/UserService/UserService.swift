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
    func login(email: String, password: String, completion: @escaping((Result<AuthDataResult, LoginError>) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if error != nil {
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
