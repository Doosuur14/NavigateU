//
//  ViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.03.2024.
//

import UIKit
import Combine

final class LoginViewController<ViewModel: LoginMainViewModelProtocol>: UIViewController, LoginViewDelegate {

    var loginDesignview: LoginView?
    let viewModel: ViewModel
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
        configureIO()
    }

    private func setUpView() {
        loginDesignview = LoginView(frame: view.bounds)
        view = loginDesignview
        loginDesignview?.delegate = self
        view.backgroundColor = .white
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
            print("login successful, transitioning to main flow")
        case .loginFailed:
            AlertManager.shared.showLoginErrorAlert(viewCon: self)
        }
    }

    func didPressLoginButton() {
        guard let form = loginDesignview?.configureSignInForm() else {
            AlertManager.shared.showEmptyFieldAlert(viewCon: self)
            return
        }
        viewModel.trigger(.didTapLoginButton, email: form.0 ?? "", password: form.1 ?? "")
    }
}
