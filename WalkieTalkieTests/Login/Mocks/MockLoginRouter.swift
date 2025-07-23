//
//  MockLoginRouter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginRouter: LoginRouterProtocol {
    var didNavigateToHome = false
    var didNavigateToRegister = false

    static func createModule() -> UIViewController {
        return UIViewController()
    }

    func navigateToHome(from view: LoginViewProtocol) {
        didNavigateToHome = true
    }

    func navigateToRegister(from view: LoginViewProtocol) {
        didNavigateToRegister = true
    }
}
