//
//  HomeScreenViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 17.03.2024.
//

import UIKit

final class HomeScreenViewController: UIViewController, HomeViewDelegate {

    var homeScreenView: HomeScreenView?
    var homeDesignScreen: HomeDesignView?
    private let viewModel: HomeViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpView() {
        homeScreenView = HomeScreenView(frame: view.bounds)
        view = homeScreenView
        homeScreenView?.secondView.delegate = self
    }

    func alreadyRegisteredaction() {
        viewModel.delegate?.goToLogin()
    }

    func getStartedButtonAction() {
        viewModel.delegate?.goToReg()
    }
}
