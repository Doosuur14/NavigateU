//
//  MainscreenModuleBuilder.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

class MainscreenModuleBuilder {
    func buildMain() -> UIViewController {
        let viewModel = MainScreenViewModel()
        let viewController = MainScreenViewController(viewModel: viewModel)
        return viewController
    }
}
