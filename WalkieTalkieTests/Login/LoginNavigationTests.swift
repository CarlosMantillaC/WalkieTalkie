//
//  LoginNavigationTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class LoginNavigationTests: XCTestCase {
    var loginVC: LoginViewController!
    var presenter: LoginPresenter!
    var router: LoginRouter!
    var mockInteractor: MockLoginInteractor!

    override func setUp() {
        super.setUp()

        loginVC = LoginRouter.createModule() as? LoginViewController
        presenter = loginVC.presenter as? LoginPresenter
        router = presenter.router as? LoginRouter

        mockInteractor = MockLoginInteractor()
        presenter.interactor = mockInteractor

        loginVC.loadViewIfNeeded()
    }

    func testDidTapRegisterOpensRegister() {
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: loginVC)
        window.makeKeyAndVisible()

        presenter.didTapRegister()

        XCTAssertNotNil(loginVC.presentedViewController)
        XCTAssertTrue(loginVC.presentedViewController is RegisterViewController)
    }

    func testLoginSuccessNavigatesToChannel() {
        let window = UIWindow()
        let nav = UINavigationController(rootViewController: loginVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()

        let response = LoginResponse(token: "fake_token")
        presenter.loginSucceeded(with: response)

        RunLoop.current.run(until: Date())

        let first = nav.viewControllers.first
        XCTAssertNotNil(first)
        XCTAssertTrue(first is ChannelViewController)
    }
}
