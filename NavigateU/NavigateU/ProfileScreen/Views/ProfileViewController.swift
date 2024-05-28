//
//  ProfileViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 12.04.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    var profileView: ProfileView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }
    private func setUpView() {
        profileView = ProfileView(frame: view.bounds)
        view = profileView
        view.backgroundColor = .white
        navigationItem.title = "My Profile"
    }

}
