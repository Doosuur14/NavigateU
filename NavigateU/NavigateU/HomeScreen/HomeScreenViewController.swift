//
//  HomeScreenViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 17.03.2024.
//

import UIKit

class HomeScreenViewController: UIViewController {
    var homeScreenView: HomeScreenView?
    var homeDesignScreen: HomeDesignView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        homeScreenView?.secondView.getStarted.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)

        navigationItem.hidesBackButton = true
    }
    private func setUpView() {
        homeScreenView = HomeScreenView(frame: view.bounds)
        view = homeScreenView
    }
    
   @objc private func getStartedButtonTapped() {
       print("Button tapped")
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
