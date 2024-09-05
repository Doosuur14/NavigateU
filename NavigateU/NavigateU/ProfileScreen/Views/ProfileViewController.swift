//
//  ProfileViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 12.04.2024.
//

import UIKit
import Combine

final class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileViewDelegate {

    var profileView: ProfileView?
    let viewModel: ProfileViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
        viewModel.onProfileUpdated = { [weak self] in
            self?.setupBindings()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUserProfile()
        self.profileView?.tableView.reloadData()
    }


    private func setupView() {
        profileView = ProfileView(frame: view.bounds)
        profileView?.delegate = self
        profileView?.setupDelegate(with: self)
        profileView?.setupDataSource(with: self)
        profileView?.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.profileReuseIdentifier)
        profileView?.tableView.separatorStyle = .none
        view = profileView
        view.backgroundColor = .systemBackground

    }


    private func setupBindings() {
        viewModel.$firstName
            .receive(on: DispatchQueue.main )
            .sink { [weak self] newValue in
                self?.profileView?.firstName.text = newValue
            }
            .store(in: &cancellables)
        viewModel.$lastName
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.profileView?.lastName.text = newValue
            }
            .store(in: &cancellables)

        viewModel.$email
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                self?.profileView?.userEmail.text = newValue
            }
            .store(in: &cancellables)
        viewModel.$profileImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newImage in
                self?.profileView?.avatarImage.image = newImage
                self?.profileView?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return 3
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let pviewModel = EditProfileViewModel()
            let viewCon = EditProfileViewController(viewModel: pviewModel)
            self.navigationController?.pushViewController(viewCon, animated: true)
        case (1, 0):
            viewModel.toggleTheme()
            profileView?.tableView.reloadData()
        case (2, 0):
            let fviewModel = FAQViewModel()
            let viewCon = FAQViewController(viewModel: fviewModel)
            self.navigationController?.pushViewController(viewCon, animated: true)
        default:
            break
        }
    }


    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Account"
        case 1:
            return "Settings"
        case 2:
            return "Support"
        default:
            return nil
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func didPressLogoutButton() {
        viewModel.logOut()
        let appCoordinator = AppCoordinator(navigationController: self.navigationController ?? UINavigationController())
        appCoordinator.start()
    }

    func didPressDeleteButton() {
        viewModel.deleteAccount()
        let appCoordinator = AppCoordinator(navigationController: self.navigationController ?? UINavigationController())
        appCoordinator.start()
    }

    func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTaponAvatar))
        profileView?.avatarImage.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func didTaponAvatar() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicker = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileView?.avatarImage.image = imagePicker
            uploadSelectedImage(imagePicker)
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileView?.avatarImage.image = imageOriginal
            uploadSelectedImage(imageOriginal)
        }
        picker.dismiss(animated: true, completion: nil)
    }


    private func uploadSelectedImage(_ image: UIImage) {
        viewModel.uploadProfilePhoto(image) { result in
            switch result {
            case .success(let urlString):
                print("Successfully uploaded image. URL: \(urlString)")
            case .failure(let error):
                print("Failed to upload image with error: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Upload Failed", message: "Please check your internet connection and try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
