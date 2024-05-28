//
//  MainModuleBuider.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 19.04.2024.
//

import Foundation
import UIKit

final class MainModuleBuider {

    func buildLogin() -> UIViewController {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }

    func buildRegister() -> UIViewController {
        let viewModel = RegistrationModel()
        let viewController = RegistrationScreenViewController(viewModel: viewModel)
        return viewController
    }
}
