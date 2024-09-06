//
//  NavigateUUITests.swift
//  NavigateUUITests
//
//  Created by Faki Doosuur Doris on 18.08.2024.
//

import XCTest
@testable import NavigateU

final class NavigateUUITests: XCTestCase {
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let label = app.staticTexts["NavigateU"]
        XCTAssert(label.exists)
    }

    func test_if_button_exsist() {
        let app = XCUIApplication()
        app.launch()

        let button = app.buttons["Get Started"]
        XCTAssert(button.exists)
    }
}
