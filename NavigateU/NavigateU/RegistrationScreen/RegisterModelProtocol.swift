//
//  RegisterModelProtocol.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 06.05.2024.
//

import Foundation
import Combine
import UIKit

protocol RegistrationProtocol: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Intent

    var state: State { get }

    func register(_ intent: Intent, firstName: String, lastName: String, email: String, password: String, countryOfOrigin: String, cityOfResidence: String)
}

protocol RegViewModel: RegistrationProtocol {
    var stateDidChangeForReg: ObservableObjectPublisher { get }
}
