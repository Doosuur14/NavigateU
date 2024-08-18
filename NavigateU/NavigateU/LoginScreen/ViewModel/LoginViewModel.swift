//
//  LoginViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 16.03.2024.
//

import Foundation
import Combine

protocol LoginMainViewModelProtocol: UIKitViewModel where State == MainViewState, Intent == MainViewIntent {
    var delegate: LoginOutput? { get set }
}

protocol LoginOutput: AnyObject {
    func goToSignUpController()
    func signedInUser()
}

final class LoginViewModel: LoginMainViewModelProtocol {

    weak var delegate: LoginOutput?
    @Published private(set) var state: MainViewState {
        didSet {
            stateDidChangeForLog.send()
        }
    }

    private(set) var stateDidChangeForLog = ObservableObjectPublisher()

    init () {
        self.state = .loading
    }

    func resetState() {
        self.state = .loading
    }

    func trigger (_ intent: MainViewIntent, email: String, password: String) {
        switch intent {
        case .didTapLoginButton:
            UserService.shared.login(email: email, password: password) { [weak self] result in
                switch result {
                case .success:
                    UserDefaults.standard.set(email, forKey: "curUser")
                    self?.state = .isloggedSuccessfully
                    self?.delegate?.signedInUser()
                case .failure(let error):
                    self?.state = .loginFailed
                    let loginError = EnumError.loginFailed(error)
                    loginError.handleError()
                }
            }
        }
    }

    func goToSignUpController() {
        delegate?.goToSignUpController()
    }
}
