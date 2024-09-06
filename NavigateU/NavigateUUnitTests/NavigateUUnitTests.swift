//
//  NavigateUUnitTests.swift
//  NavigateUUnitTests
//
//  Created by Faki Doosuur Doris on 18.08.2024.
//

import XCTest
import Combine
@testable import NavigateU

final class NavigateUUnitTests: XCTestCase {

    lazy var  viewModel = LoginViewModel()
    lazy var  userService  = UserService()
    private var cancellables: Set<AnyCancellable> = []

    func test_user_login_success() {
        let email = "jj12@gmail.com"
        let password = "140503"

        let expectation = self.expectation(description: "Login successful")

        userService.login(email: email, password: password) { result in
            switch result {

            case .success(let authDataResult):
                let user = authDataResult.user
                XCTAssertEqual(user.email, email)
            case .failure(let error):
                XCTFail("Login should not fail. Error: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }


    func test_Login_Failed_EmptyEmailAndPassword() {
        let emptyEmail = ""
        let emptyPassword = ""

        let expectation = self.expectation(description: "User login failure")

        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .loginFailed = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.trigger(.didTapLoginButton, email: emptyEmail, password: emptyPassword)

        waitForExpectations(timeout: 5, handler: nil)
    }

}
