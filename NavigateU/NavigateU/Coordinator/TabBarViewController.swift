//
//  TabBarViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.04.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        self.tabBar.barTintColor = .systemRed
        self.tabBar.tintColor = UIColor(named: "CustomColor")

    }
    private func setupTabBar() {

        let main = self.createNav(with: "Explore", image: UIImage(systemName: "magnifyingglass"), vc: MainScreenViewController())
        let profile = self.createNav(with: "Profile", image: UIImage(systemName: "person.circle.fill"), vc: ProfileViewController())
        self.setViewControllers([main, profile], animated: true)
        navigationItem.hidesBackButton = true
    }
    private func createNav(with title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
