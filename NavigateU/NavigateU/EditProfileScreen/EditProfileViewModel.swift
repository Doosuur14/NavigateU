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

    @Published var profile: UserProfile?

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
                self.profile = UserProfile(firstName: userProfile.firstName,
                                           lastName: userProfile.lastName,
                                           email: userProfile.email,
                                           password: userProfile.password,
                                           nationality: userProfile.nationality,
                                           cityOfResidence: userProfile.cityOfResidence,
                                           profileImageURL: userProfile.profileImageURL)
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
        if password != profile?.password {
            dispatchGroup.enter()
            Auth.auth().currentUser?.updatePassword(to: password) { error in

                if let error = error as NSError? {
                    let errorMessage: String
                    switch AuthErrorCode(rawValue: error.code) {
                    case .weakPassword:
                        errorMessage = "Password is too weak"
                    default:
                        errorMessage = "An unknown error occurred while updating the password."
                    }
                    completion(.failure(NSError(domain: "", code: error.code, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    dispatchGroup.leave()
                    return
                }
                self.profile?.password = password
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

                self?.updateCoreData(firstName: firstName, lastName: lastName, cityOfResidence: cityOfResidence, nationality: nationality) { result in
                    switch result {
                    case .success:
                        self?.onProfileUpdated?()
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }

    private func updateCoreData(firstName: String, lastName: String, cityOfResidence: String, nationality: String, completion: @escaping (Result<Void, Error>) -> Void) {

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
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found in Core Data"])))
            }
        } catch {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: error])))
        }
    }

}
