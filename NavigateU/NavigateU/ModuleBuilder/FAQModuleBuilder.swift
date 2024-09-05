//
//  FAQModuleBuilder.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 30.07.2024.
//

import Foundation
import UIKit

class FAQModuleBuilder {
    func buildFAQ() -> UIViewController {
        let viewModel = FAQViewModel()
        let viewController = FAQViewController(viewModel: viewModel)
        return viewController
    }
}
