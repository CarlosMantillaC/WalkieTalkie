//
//  LoginFunctionalTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class LoginFunctionalTests: XCTestCase {
    var viewController: LoginViewController!
    var mockPresenter: MockLoginPresenter!

    override func setUp() {
        super.setUp()
        viewController = LoginViewController(nibName: "LoginViewController", bundle: Bundle(for: LoginViewController.self))
        mockPresenter = MockLoginPresenter()
        viewController.presenter = mockPresenter
        _ = viewController.view
    }

    override func tearDown() {
        viewController = nil
        mockPresenter = nil
        super.tearDown()
    }

    func testEmptyFieldsShouldTriggerError() {
        simulateForm(email: "", password: "")
        viewController.didTapLogin(self)

        XCTAssertEqual(mockPresenter.lastErrorShown, "Todos los campos son obligatorios.")
    }

    func testInvalidEmailShouldTriggerError() {
        simulateForm(email: "correo_invalido", password: "123456")
        viewController.didTapLogin(self)

        XCTAssertEqual(mockPresenter.lastErrorShown, "Correo electrónico inválido.")
    }

    func testValidLoginShouldCallInteractor() {
        simulateForm(email: "correo@valido.com", password: "123456")
        viewController.didTapLogin(self)

        XCTAssertEqual(mockPresenter.lastLogin?.email, "correo@valido.com")
        XCTAssertEqual(mockPresenter.lastLogin?.password, "123456")
    }

    func testDidTapRegisterShouldTriggerNavigation() {
        viewController.didTapRegister(self)
        XCTAssertTrue(mockPresenter.didTapRegisterCalled)
    }

    func simulateForm(email: String, password: String) {
        viewController.emailTextField.text = email
        viewController.passwordTextField.text = password
    }
}
