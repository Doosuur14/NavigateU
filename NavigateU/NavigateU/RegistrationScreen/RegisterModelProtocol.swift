//
//  RegisterModelProtocol.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 06.05.2024.
//

import Foundation
import Combine

protocol RegistrationProtocol: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    var state: State { get }

    func register(firstName: String, lastName: String, email: String, password: String, countryOfOrigin: String, cityOfResidence: String)
}

protocol RegViewModel: RegistrationProtocol {
    var stateDidChangeForReg: ObservableObjectPublisher { get }
}
