//
//  HomeViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation

protocol StartOutput: AnyObject {
    func goToLogin()
    func goToReg()
}

class HomeViewModel {
    weak var delegate: StartOutput?

    func goToLogin() {
        print("go to login")
        delegate?.goToLogin()
    }

    func goToRegister() {
        print("go to reg")
        delegate?.goToReg()
    }
}
