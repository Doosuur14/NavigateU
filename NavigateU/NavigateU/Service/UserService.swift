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
                completion(.success(authResult))
            }
        }
    }

    func deleteAccount() {
        guard let user = Auth.auth().currentUser else {
            print("No user found")
            return
        }
        user.delete { error in
            if let error = error {
                print("Error deleting user account: \(error.localizedDescription)")
            } else {
                self.logout()
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error signing out user account: \(error.localizedDescription)")
        }
    }
}

enum LoginError: Error {
    case userNotFound
}
