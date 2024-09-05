//
//  ProfileService.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 25.07.2024.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import CoreData
import FirebaseFirestore
import Alamofire

final class ProfileService {
    static let shared = ProfileService()

    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }

    init() {

    }
    func uploadProfilePhoto(_ image: UIImage, completion: @escaping (Result<String, ProfilePhotoError>) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("no user found")
            return
        }
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", currentUser)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                let storageRef = Storage.storage().reference().child("profile_images/\(String(describing: user.uid)).png")
                if let imageData = image.pngData() {
                    storageRef.putData(imageData, metadata: nil) { metaData, error in
                        if error != nil {
                            completion(.failure(.imageUploadFailed))
                            return
                        }
                        storageRef.downloadURL { url, error in
                            if error != nil {
                                completion(.failure(.downloadFailed))
                                return
                            }
                            if let urlString = url?.absoluteString {
                                completion(.success(urlString))
                            } else {
                                completion(.failure(.urlRetrievalFailed))
                            }
                        }
                    }
                } else {
                    completion(.failure(.imageProcessingFailed))
                }
            } else {
                completion(.failure(.userNotFound))
            }
        } catch {
            completion(.failure(.dataFetchingError("An error occurred while fetching user data. Please try again later.")))
        }
    }

    func fetchUserProfile(completion: @escaping (Result<UserProfile, ProfilePhotoError>) -> Void)  {

        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("no user found")
            return
        }
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", currentUser)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                let db = Firestore.firestore()
                db.collection("users").document(currentUser).getDocument { document, error in
                    if let document = document, document.exists {
                        let profileData = UserProfile(firstName: user.firstname,
                                                      lastName: user.lastname,
                                                      email: user.email,
                                                      password: "************",
                                                      nationality: user.nationality,
                                                      cityOfResidence: user.cityOfResidence,
                                                      profileImageURL: user.profileImageUrl)
                        completion(.success(profileData))
                    } else {
                        completion(.failure(.userDocumentNotFound))
                    }
                }
            } else {
                completion(.failure(.userNotFound))
            }
        } catch {
            completion(.failure(.dataFetchingError("An error occuured while fetching user profile.")))
        }
    }

    func loadUserProfile(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        AF.request(urlString).responseData { response in
            if let data = response.data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
