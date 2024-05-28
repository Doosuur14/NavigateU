//
//  AlertManager.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 05.05.2024.
//

import Foundation
import UIKit

 final class AlertManager {

     static let shared = AlertManager()

        private init() {}

    // MARK: I am going to make the methods in this class static because  they belong to itself and there's no point of making  so many instances of alert manager class.
     private  func showAlert(viewController: UIViewController, title: String, message: String?) {
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}

extension AlertManager {

    // MARK: Invalid email and password alert
    func showInvalidAlert(viewCon: UIViewController) {
        self.showAlert(viewController: viewCon, title: "INVALID EMAIL AND PASSWORD",
                       message: "Please enter a valid email and password")
    }
    // MARK: Registration failed
    func showRegistrationFailedAlert(viewCon: UIViewController) {
        self.showAlert(viewController: viewCon, title: "REGISTRATION WAS NOT SUCCESSFUL",
                       message: "Please review the details for the form")
    }
    func showRegistrationSuccessful(viewCon: UIViewController) {
        self.showAlert(viewController: viewCon, title: "REGISTRATION WAS SUCCESSFUL!",
                       message: "Welcome.")
    }
    func showLoginErrorAlert(viewCon: UIViewController) {
        self.showAlert(viewController: viewCon, title: "LOGIN FAILED",
                       message: "Please review the login details and try again")
    }
}
