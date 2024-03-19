//
//  ViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.03.2024.
//

import UIKit

class LoginViewController: UIViewController {
    var loginDesignview: LoginView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    private func setUpView() {
        loginDesignview = LoginView(frame: view.bounds)
        view = loginDesignview
        view.backgroundColor = .white
    }

}
