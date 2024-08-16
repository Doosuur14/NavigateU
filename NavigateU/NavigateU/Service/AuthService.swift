//
//  AuthService.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 05.05.2024.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    static let shared = AuthService()

    private init() {}

    func register(firstName: String, lastName: String, email: String,
                  password: String, countryOfOrigin: String, cityOfResidence: String, completion: @escaping((Result<User, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else if let user = authResult?.user {
                print("user created successfully")
                let dataBase = Firestore.firestore()
                let dbRef =  dataBase.collection("users").document(user.uid)
                let data = [
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": email,
                    "password": password,
                    "countryOfOrgin": countryOfOrigin,
                    "cityOfResidence": cityOfResidence
                ]
                dbRef.setData(data) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        self?.saveUserToCoreData(uid: user.uid,
                                                 firstName: firstName,
                                                 lastName: lastName,
                                                 email: email,
                                                 password: password,
                                                 nationality: countryOfOrigin,
                                                 cityOfResidence: cityOfResidence,
                                                 completion: completion)
                    }
                }
            }
        }
    }
    private func saveUserToCoreData(uid: String,
                                    firstName: String,
                                    lastName: String,
                                    email: String,
                                    password: String,
                                    nationality: String,
                                    cityOfResidence: String,
                                    completion: @escaping((Result<User, Error>) -> Void)) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let user = User(context: context)
        user.uid = uid
        user.firstname = firstName
        user.lastname = lastName
        user.email = email
        user.password = password
        user.nationality = nationality
        user.cityOfResidence = cityOfResidence

        do {
            try context.save()
            print("User successfully added to Core Data!")
            completion(.success(user))
        } catch {
            print("Failed to save user to Core Data: \(error)")
            completion(.failure(error))
        }
    }
}
