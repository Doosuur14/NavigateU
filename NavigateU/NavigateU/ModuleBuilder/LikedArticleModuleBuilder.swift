//
//  LikedArticleModuleBuilder.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 30.07.2024.
//

import Foundation
import UIKit

class LikedArticleModuleBuilder {
    func buildLikedArticlePage() -> UIViewController {
        let localDatasource = DocumentLocalDataSource()
        let viewModel = LikedArticlesViewModel(documentLocalDataSource: localDatasource)
        let viewController = LikedArticleViewController(viewModel: viewModel)
        return viewController
    }
}
