//
//  HomeModuleBuilder.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

class HomeModuleBuilder {

    func buildHomepage(output: StartOutput) -> UIViewController {
        let viewModel = HomeViewModel()
        viewModel.delegate = output
        let viewController = HomeScreenViewController(viewModel: viewModel)
        return viewController
    }

}
