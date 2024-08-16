//
//  Coordinator.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

protocol Coordinator {

    var navigationController: UINavigationController { get set }

    func start()
}
