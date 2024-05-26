//
//  LoginViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 16.03.2024.
//

import Foundation
import Combine

protocol LoginMainViewModelProtocol: UIKitViewModel where State == MainViewState, Intent == MainViewIntent {}

final class LoginViewModel: LoginMainViewModelProtocol {

    @Published private(set) var state: MainViewState {
        didSet {
            stateDidChangeForLog.send()
        }
    }

    private(set) var stateDidChangeForLog = ObservableObjectPublisher()

    init () {
        self.state = .loading
    }
    
    func trigger (_ intent:  MainViewIntent, email: String, password: String) {
        switch intent {
        case .didTapLoginButton:
            UserService.shared.login(email: email, password: password) { [weak self] result in
                switch result {
                case .success:
                    print("login successful!")
                    self?.state = .isloggedSuccessfully
                case .failure(let error):
                    self?.state = .loginFailed
                    let loginError = EnumError.loginFailed(error)
                    loginError.handleError()
                }
            }
        }
    }
}
