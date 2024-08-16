//
//  AppCoordinator.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {

    var navigationController: UINavigationController
    var flowCoordinator: Coordinator?
//    var isLogged: Bool {
//        return UserDefaults.standard.string(forKey: "curUser") != nil
//    }
    var isLogged = false

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if isLogged {
            print("main \(isLogged)")
            print("User is logged in, showing main flow")
            showMainFlow()
        } else {
            print("auth \(isLogged)")
            print("User is not logged in, showing auth flow")
            showAuthFlow()
        }
    }

    func didLogout() {
        showAuthFlow()
    }
}

private extension AppCoordinator {
    func showMainFlow() {
        flowCoordinator = MainFlowCoordinator(
            navigationController: navigationController, mainFlowCoordinatorProtocol: self)
        flowCoordinator?.start()
    }

    func showAuthFlow() {
        flowCoordinator = AuthFlowCoordinator(
            navigationController: navigationController, authFlowCoordinatorOutput: self)
        flowCoordinator?.start()
    }
}

extension AppCoordinator: AuthFlowCoordinatorOutput, MainFlowCoordinatorProtocol {
    func mainFlowSignOutUser() {
        showAuthFlow()
    }

    func authFlowCoordinatorEnteredUser() {
        showMainFlow()
    }
}
