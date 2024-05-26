//
//  FlowCoordinator.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 06.04.2024.
//

import Foundation
import UIKit

protocol FlowCoordinatorProtocol: AnyObject {
    func toRegistrationScreen()
    func toLoginScreen()
    func toHomeScreen()
    func start(viewCon: UIViewController)

}

final class AuthFlowCoordinator: FlowCoordinatorProtocol {


    private let rootViewController: UINavigationController
    private let tabBarController = TabBarViewController()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }


    func start(viewCon: UIViewController) {
        rootViewController.pushViewController(viewCon, animated: true)
    }



    func toRegistrationScreen() {
        let registrationModel = RegistrationModel()
        let registrationViewController = RegistrationScreenViewController(viewModel: registrationModel)
        rootViewController.pushViewController(registrationViewController, animated: true)
    }

    func toLoginScreen() {
        let loginViewController = MainModuleBuider().buildLogin()
        rootViewController.pushViewController(loginViewController, animated: true)
    }

    func toHomeScreen() {
        DispatchQueue.main.async { [weak self] in
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                  let window = sceneDelegate.window else {
                return
            }
            let navigationController = UINavigationController(rootViewController: self?.tabBarController ?? HomeScreenViewController())
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
