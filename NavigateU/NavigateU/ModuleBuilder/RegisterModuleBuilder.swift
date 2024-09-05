//
//  RegisterModuleBuilder.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

class RegisterModuleBuilder {
    func buildRegister(output: SignUpOutput) -> UIViewController {
        let viewModel = RegistrationModel()
        viewModel.delegate = output
        let viewController = RegistrationScreenViewController(viewModel: viewModel)
        return viewController
    }
}
