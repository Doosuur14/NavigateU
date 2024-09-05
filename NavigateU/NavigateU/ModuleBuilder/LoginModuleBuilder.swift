//
//  LoginModuleBuilder.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

class LoginModuleBuilder {
    func buildLogin(output: LoginOutput) -> UIViewController {
        let viewModel = LoginViewModel()
        viewModel.delegate = output
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }
    
}
