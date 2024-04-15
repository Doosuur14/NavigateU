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
    private var coordinator: FlowCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenView?.delegate = self
        setUpView()
        coordinator = FlowCoordinator(rootViewController: navigationController ?? UINavigationController())
        pressedGetStartedButton()
        pressedRegistrateredButton()

    }

    private func setUpView() {
        homeScreenView = HomeScreenView(frame: view.bounds)
        view = homeScreenView

    }
    @objc private func alreadyHaveAcct() {
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func pressedGetStartedButton() {
        homeScreenView?.secondView.getStartedButtonAction = { [weak self] in
            self?.coordinator?.toRegisterationScreen()
        }
    }
    func pressedRegistrateredButton() {
        homeScreenView?.secondView.alreadyRegisteredaction = { [weak self] in
            self?.coordinator?.toLoginScreen()
        }
    }
}

