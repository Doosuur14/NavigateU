//
//  UICustomTextField.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.05.2024.
//

import Foundation
import UIKit

extension UITextField {
    @discardableResult
    func isEmptyTextField() -> Bool {
        if self.text?.isEmpty ?? true {
            self.layer.borderColor = UIColor(named: "subtitlecolor")?.cgColor
        }
        return self.text?.isEmpty ?? true
    }
}
