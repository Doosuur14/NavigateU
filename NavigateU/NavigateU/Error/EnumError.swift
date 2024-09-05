//
//  File.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 19.04.2024.
//

import Foundation

enum EnumError {
    case loginFailed(LoginError)

    func handleError() {
        switch self {
        case .loginFailed(_):
            print("invalid email and password entered")
        }
    }
}
