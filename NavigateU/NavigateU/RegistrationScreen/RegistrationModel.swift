//
//  RegistrationModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 05.05.2024.
//

import Foundation
import Combine


protocol RegistrationViewModelProtocol: RegViewModel where State == RegisterViewState {}

final class RegistrationModel: RegistrationViewModelProtocol {
    

    @Published private(set) var state: RegisterViewState {
        didSet {
            stateDidChangeForReg.send()
        }
    }

    private(set) var stateDidChangeForReg = ObservableObjectPublisher()
    init () {
        self.state = .initial
    }
    

    func register(firstName: String, lastName: String, email: String, password: String, countryOfOrigin: String, cityOfResidence: String) {
        AuthService.shared.register(firstName: firstName, lastName: lastName,
                                    email:email, password: password, countryOfOrigin: countryOfOrigin,
                                    cityOfResidence: cityOfResidence) { [weak self] result in
            switch result {
            case .success:
                print("User was registered successfully")
                self?.state = .isregisteredSuccessfully
            case .failure:
                print("There was a problem while registering the user")
                self?.state = .registrationFailed
//                let registrationCon = RegistrationScreenViewController()
//                AlertManager.shared.showRegistrationFailedAlert(viewCon: registrationCon)
            }
        }
    }
}
