//
//  FlowCoordinator.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 06.04.2024.
//

import Foundation
import UIKit

protocol SomeFlowCoordinator: AnyObject {
    func toRegisterationScreen()
    func toLoginScreen()
    func toHomeScreen()
}

final class FlowCoordinator: SomeFlowCoordinator {

    private let rootViewController: UINavigationController
    private let tabBarController = TabBarViewController()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    func toRegisterationScreen() {
        let registrationViewController = RegistrationScreenViewController()
        rootViewController.pushViewController(registrationViewController, animated: true)
    }
    func toLoginScreen() {
        let loginViewController = LoginViewController()
        rootViewController.pushViewController(loginViewController, animated: true)
    }
    func toHomeScreen() {
//        let homeScreenViewController = TabBarViewController()
//        rootViewController.pushViewController(homeScreenViewController, animated: true)

        if let tabViewController = rootViewController.viewControllers.first(where: { $0 is TabBarViewController }) {
            rootViewController.popToViewController(tabViewController, animated: true)
        } else {
            rootViewController.pushViewController(tabBarController, animated: true)
        }
    }

}
