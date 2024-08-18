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
    var isLogged = false

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if isLogged {
            showMainFlow()
        } else {
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
