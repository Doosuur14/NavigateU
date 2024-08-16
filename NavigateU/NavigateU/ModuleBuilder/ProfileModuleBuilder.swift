//
//  ProfileModuleBuilder.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

class ProfileModuleBuilder {
    func buildProfile() -> UIViewController {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        return viewController
    }
}
