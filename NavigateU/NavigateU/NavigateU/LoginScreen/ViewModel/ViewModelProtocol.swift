//
//  ViewModelProtocol.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 19.04.2024.
//

import Foundation
import Combine

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Intent

    var state: State { get }

    func trigger(_ intent: Intent, email: String, password: String)
}

protocol UIKitViewModel: ViewModel {
    var stateDidChangeForLog: ObservableObjectPublisher { get }
}

