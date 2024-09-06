//
//  MainFlowCoordinator.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

protocol MainFlowCoordinatorProtocol: AnyObject {
    func mainFlowSignOutUser()
}

class MainFlowCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var mainFlowCoordinatorProtocol: MainFlowCoordinatorProtocol?

    init(navigationController: UINavigationController, mainFlowCoordinatorProtocol: MainFlowCoordinatorProtocol) {
        self.navigationController = navigationController
        self.mainFlowCoordinatorProtocol = mainFlowCoordinatorProtocol
    }

    func start() {
        let mainviewController = MainscreenModuleBuilder().buildMain()
        mainviewController.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "house"), tag: 0)
        let profileviewController = ProfileModuleBuilder().buildProfile()
        profileviewController.tabBarItem = UITabBarItem(title: "Profile",
                                                        image: UIImage(systemName: "person.circle.fill"), tag: 1)
        let likedArticleController = LikedArticleModuleBuilder().buildLikedArticlePage()
        likedArticleController.tabBarItem = UITabBarItem(title: "Favourites",
                                                         image: UIImage(systemName: "heart"), tag: 2)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainviewController,likedArticleController, profileviewController]
        tabBarController.tabBar.tintColor = UIColor(named: "CustomColor")
        tabBarController.tabBar.backgroundColor = .systemGray6
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
