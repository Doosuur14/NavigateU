//
//  EditProfileViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.08.2024.
//

import Foundation
import FirebaseFirestore
import CoreData
import FirebaseAuth

class EditProfileViewModel {
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var cityOfResidence: String?
    var nationality: String?

    var onProfileDetails: (() -> Void)?
    var onProfileUpdated: (() -> Void)?


    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }

    func fetchUserProfile() {
        ProfileService.shared.fetchUserProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let (userProfile)):
                firstName = userProfile.firstName
                lastName = userProfile.lastName
                email = userProfile.email
                password = userProfile.password
                cityOfResidence = userProfile.cityOfResidence
                nationality = userProfile.nationality
                self.onProfileDetails?()
            case .failure(_):
                print("Error while fetching user's profile")
            }
        }
    }

    func updateUserProfile(firstName: String, lastName: String, password: String, cityOfResidence: String, nationality: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }

        let updatedData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "cityOfResidence": cityOfResidence,
            "nationality": nationality
        ]
        let dispatchGroup = DispatchGroup()
        if password != self.password {
            dispatchGroup.enter()
            Auth.auth().currentUser?.updatePassword(to: password) { error in

                if let error = error as NSError? {
                    print("Failure to update password: \(error.localizedDescription)")
                    switch AuthErrorCode(rawValue: error.code) {
                    case .weakPassword:
                        print("Password is too weak.")
                    default:
                        print("An unknown error occurred: \(error.localizedDescription)")
                    }
                    completion(.failure(error))
                    dispatchGroup.leave()
                    return
                }
                print("password successfully updated.")
                self.password = password
                dispatchGroup.leave()

            }
        }

        dispatchGroup.notify(queue: .main) {

            let db = Firestore.firestore()
            db.collection("users").document(currentUser).updateData(updatedData) { [weak self] error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                self?.updateCoreData(firstName: firstName, lastName: lastName, cityOfResidence: cityOfResidence, nationality: nationality)
                self?.onProfileUpdated?()
                completion(.success(()))
            }
        }
    }

    private func updateCoreData(firstName: String, lastName: String, cityOfResidence: String, nationality: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", Auth.auth().currentUser?.uid ?? "")

        do {
            let users = try self.context.fetch(fetchRequest)
            if let user = users.first {
                user.firstname = firstName
                user.lastname = lastName
                user.cityOfResidence = cityOfResidence
                user.nationality = nationality
                try self.context.save()
                print("Successfully updated user profile in Core Data")
            } else {
                print("User not found in Core Data")
            }
        } catch {
            print("Failed to update user profile in Core Data: \(error)")
        }
    }

}
