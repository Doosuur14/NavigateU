//
//  ProfileViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 12.04.2024.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import CoreData

class ProfileViewModel {

    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var cityOfResidence: String?
    var nationality: String?
    var profileImage: UIImage?
    var onProfileUpdated: (() -> Void)?
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }

    init() {
        applyTheme()
    }

    @objc func toggleTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        UserDefaults.standard.set(!isDarkMode, forKey: "isDarkMode")
        applyTheme()
    }
    
    private func applyTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        let interfaceStyle: UIUserInterfaceStyle = isDarkMode ? .dark : .light
        allWindows().forEach { window in
            window.overrideUserInterfaceStyle = interfaceStyle
        }
        if let appDelegate = UIApplication.shared.delegate as? SceneDelegate,
           let window = appDelegate.window {
            window.overrideUserInterfaceStyle = interfaceStyle
        }
    }

    func heightForRowAt() -> Int {
        return 100
    }

    func fetchUserProfile() {
        ProfileService.shared.fetchUserProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let (userProfile)):
                firstName = userProfile.firstName
                lastName = userProfile.lastName
                email = userProfile.email
                if let urlString = userProfile.profileImageURL {
                    self.loadProfilePicture(urlString)
                } else {
                    self.onProfileUpdated?()
                }
            case .failure(_):
                print("Error while fetching user's profile")
            }
        }
    }

    func loadProfilePicture(_ urlString: String) {
        ProfileService.shared.loadUserProfile(urlString) { [weak self] image in
            guard let self = self else { return }
            self.profileImage = image
            self.onProfileUpdated?()
        }
    }
    func uploadProfilePhoto(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        ProfileService.shared.uploadProfilePhoto(image) { result in
            switch result {
            case .success(let urlString):
                self.updateUserProfileImageURL(urlString, for: currentUser)
                completion(.success(urlString))
            case .failure(let error):
                print("Failed to upload profile photo")
                completion(.failure(error))
            }
        }
    }


    private func updateUserProfileImageURL(_ urlString: String, for user: String) {
        guard let currentUser = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(currentUser).updateData(["profileImageUrl": urlString]) { [weak self] error in
            if let error = error {
                print("Failed to update profile image URL in Firestore: \(error)")
                return
            }
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "uid == %@", user)

            do {

                let users = try self?.context.fetch(fetchRequest)
                if let user = users?.first {
                    user.profileImageUrl = urlString
                    try self?.context.save()
                    self?.loadPhoto(urlString)
                } else {
                    print("User not found in Core Data")
                }
            } catch {
                print("Failed to update profile image URL in Core Data: \(error)")
            }
        }
    }

    func loadPhoto(_ urlString: String) {
        ProfileService.shared.loadUserProfile(urlString) { [weak self] image  in
            guard self != nil else {return}
        }
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.profileReuseIdentifier, for: indexPath) as? ProfileTableViewCell
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell?.configureCell(with: Profile(photo: UIImage(systemName: "person.fill"), label: "Edit profile"))
            cell?.redirectButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)

        case (1, 0):
            let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
            let modeLabel = isDarkMode ? "Dark Mode" : "Light Mode"

            cell?.configureCell(with: Profile(photo: UIImage(systemName: "rays"), label: modeLabel))
             cell?.redirectButton.setImage(UIImage(systemName: "switch.2"), for: .normal)
            cell?.redirectButton.addTarget(self, action: #selector(toggleTheme), for: .touchUpInside)
            cell?.redirectButton.isEnabled = true
            cell?.isUserInteractionEnabled = true
        case (2, 0):
            cell?.configureCell(with: Profile(photo: UIImage(systemName: "questionmark.circle.fill"), label: "FAQ"))
        case (2, 1):
            cell?.configureCell(with: Profile(photo: UIImage(systemName: "phone.fill"), label: "Contact Us"))
        default:
            cell?.configureCell(with: Profile(photo: nil, label: ""))
        }
        return cell ?? ProfileTableViewCell(style: .default, reuseIdentifier: ProfileTableViewCell.profileReuseIdentifier)
    }

    func deleteAccount() {
        UserDefaults.standard.set(nil, forKey: "curUser")
        UserService.shared.deleteAccount()
    }

    func logOut() {
        UserDefaults.standard.set(nil, forKey: "curUser")
        UserService.shared.logout()
    }

    func updateUserProfile(firstName: String, lastName: String, email: String, password: String, cityOfResidence: String, nationality: String,  completion: @escaping (Result<Void, Error>) -> Void) {

    }

    private func allWindows() -> [UIWindow] {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
        } else {
            return UIApplication.shared.windows
        }
    }
}
