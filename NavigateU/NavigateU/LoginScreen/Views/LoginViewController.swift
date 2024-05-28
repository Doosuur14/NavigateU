//
//  ViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.03.2024.
//

import UIKit
import Combine

final class LoginViewController<ViewModel: LoginMainViewModelProtocol>: UIViewController {
    var loginDesignview: LoginView?
    let viewModel: ViewModel
    private var coordinator: AuthFlowCoordinator?
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        coordinator = AuthFlowCoordinator(rootViewController: navigationController ?? UINavigationController())
        configureIO()
        loginDesignview?.login.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setUpView() {
        loginDesignview = LoginView(frame: view.bounds)
        view = loginDesignview
        view.backgroundColor = .white
    }

    @objc private func loginButtonTapped() {
        guard let email = loginDesignview?.email.text, let password = loginDesignview?.password.text else {
            print("Please enter email and password")
            return
        }
        viewModel.trigger(.didTapLoginButton, email: email, password: password)
    }
    
    private func configureIO() {
        viewModel.stateDidChangeForLog.receive(on: DispatchQueue.main)
            .sink { [weak self]  in
                self?.render()
            }
            .store(in: &cancellables)
    }

    private func render() {
        switch viewModel.state {
        case .loading:
            print("loading state")
        case .isloggedSuccessfully:
            coordinator?.toHomeScreen()
        case .loginFailed:
            AlertManager.shared.showLoginErrorAlert(viewCon: self)
            break
        }
    }
}
