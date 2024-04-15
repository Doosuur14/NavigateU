//
//  RegistrationScreenViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 19.03.2024.
//

import UIKit

class RegistrationScreenViewController: UIViewController {
    var registrationView: RegistrationScreenView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        navigationItem.hidesBackButton = true
    }

    private func setUpView() {
        registrationView = RegistrationScreenView(frame: view.bounds)
        view = registrationView
        view.backgroundColor = .white
    }
}
