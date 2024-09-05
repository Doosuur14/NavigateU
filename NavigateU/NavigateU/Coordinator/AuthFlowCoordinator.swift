//
//  FlowCoordinator.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 06.04.2024.
//

import Foundation
import UIKit

protocol AuthFlowCoordinatorOutput: AnyObject {
    func authFlowCoordinatorEnteredUser()
}

final class AuthFlowCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var authFlowCoordinatorOutput: AuthFlowCoordinatorOutput?

    init(navigationController: UINavigationController, authFlowCoordinatorOutput: AuthFlowCoordinatorOutput) {
        self.navigationController = navigationController
       self.authFlowCoordinatorOutput = authFlowCoordinatorOutput
    }

    func start() {
        let homeController = HomeModuleBuilder().buildHomepage(output: self)
        navigationController.setViewControllers([homeController], animated: true)
    }
}

extension AuthFlowCoordinator: StartOutput, LoginOutput, SignUpOutput {
    func signedInUser() {
        authFlowCoordinatorOutput?.authFlowCoordinatorEnteredUser()
    }

    func signedUpUser() {
        goToLoginController()
    }

    func goToSignUpController() {
        let signUpViewController = RegisterModuleBuilder().buildRegister(output: self)
        navigationController.pushViewController(signUpViewController, animated: true)
    }

    func goToLoginController() {
        let signInViewController = LoginModuleBuilder().buildLogin(output: self)
        navigationController.pushViewController(signInViewController, animated: true)
    }

    func goToReg() {
        goToSignUpController()
    }

    func goToLogin() {
        goToLoginController()
    }

}
