//
//  RegistrationScreenViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 19.03.2024.
//

import UIKit
import Combine

class RegistrationScreenViewController<ViewModel: RegistrationViewModelProtocol>: UIViewController {
    var registrationView: RegistrationScreenView?
    let viewModel: ViewModel
    private var coordinator: AuthFlowCoordinator?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        coordinator = AuthFlowCoordinator(rootViewController: navigationController ?? UINavigationController())
        configureIO()
        registrationView?.registerButton.addTarget(self, action:#selector(registerButtonTapped), for: .touchUpInside)
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        registrationView = RegistrationScreenView(frame: view.bounds)
        view = registrationView
        view.backgroundColor = .white
    }

    @objc func registerButtonTapped() {
        guard let firstName = registrationView?.firstName.text,
                let lastName = registrationView?.lastName.text,
              let email = registrationView?.email.text,
              let password = registrationView?.password.text,
              let countryOfOrigin = registrationView?.countryOfOrigin.text,
              let cityOfResidence = registrationView?.cityOfResidence.text else {return }
        viewModel.register(.didTapRegisterButton, firstName: firstName, lastName: lastName, email: email, password: password, countryOfOrigin: countryOfOrigin, cityOfResidence: cityOfResidence)
    }

    private func configureIO() {
        viewModel.stateDidChangeForReg.receive(on: DispatchQueue.main)
            .sink { [weak self]  in
                self?.render()
            }
            .store(in: &cancellables)
    }
    

    private func render() {
        switch viewModel.state {
        case.initial:
            print("Application is running")
        case.isregisteredSuccessfully:
            coordinator?.toLoginScreen()
            print("registration was successful")
        case .registrationFailed:
            AlertManager.shared.showRegistrationFailedAlert(viewCon: self)
            break
        }
    }
}
