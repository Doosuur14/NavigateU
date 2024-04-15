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
    private var coordinator: FlowCoordinator?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        coordinator = FlowCoordinator(rootViewController: navigationController ?? UINavigationController())

        loginDesignview?.login.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

    }

    private func setUpView() {
        loginDesignview = LoginView(frame: view.bounds)
        view = loginDesignview
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
    }

    private func gotoHomePage() {
//        let viewController = MainScreenViewController()
//        self.navigationController?.pushViewController(viewController, animated: true)
        coordinator?.toHomeScreen()
    }
    
    @objc private func loginButtonTapped() {
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
