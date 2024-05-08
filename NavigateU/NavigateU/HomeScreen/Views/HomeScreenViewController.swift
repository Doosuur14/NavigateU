//
//  HomeScreenViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 17.03.2024.
//

import UIKit

final class HomeScreenViewController: UIViewController, HomeScreenDelegate {

    var homeScreenView: HomeScreenView?
    var homeDesignScreen: HomeDesignView?
    private var coordinator: AuthFlowCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenView?.delegate = self
        setUpView()
        coordinator = AuthFlowCoordinator(rootViewController: navigationController ?? UINavigationController())
        pressedGetStartedButton()
        pressedRegistrateredButton()

    }

    private func setUpView() {
        homeScreenView = HomeScreenView(frame: view.bounds)
        view = homeScreenView

    }
//    @objc private func alreadyHaveAcct() {
//        let viewModel = LoginViewModel()
//        let viewController = LoginViewController(viewModel: viewModel)
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }

    func pressedGetStartedButton() {
        homeScreenView?.secondView.getStartedButtonAction = { [weak self] in
            self?.coordinator?.toRegistrationScreen()
        }
    }
    func pressedRegistrateredButton() {
        homeScreenView?.secondView.alreadyRegisteredaction = { [weak self] in
            self?.coordinator?.toLoginScreen()
        }
    }
}
