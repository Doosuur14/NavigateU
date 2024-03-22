//
//  ViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.03.2024.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    var loginDesignview: LoginView?
    let viewModel =  LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        navigationItem.hidesBackButton = true
        loginDesignview?.email.autocapitalizationType = .none
        loginDesignview?.login.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

    }

    private func setUpView() {
        loginDesignview = LoginView(frame: view.bounds)
        view = loginDesignview
        view.backgroundColor = .white
    }

    private func gotoHomePage() {
        let viewController = MainScreenViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc private func loginButtonTapped() {
        print("Login button tapped")
        guard let email = loginDesignview?.email.text, let password = loginDesignview?.password.text else {
            print("Please enter email and password")
            return
        }
            viewModel.login(email: email, password: password)
            configureIO()

    }
    private func configureIO() {
        viewModel.$error.sink { [weak self] error in
            if let error = error {
                print(error)
            } else {
                self?.gotoHomePage()
            }

        }.store(in: &cancellables)
    }
}
