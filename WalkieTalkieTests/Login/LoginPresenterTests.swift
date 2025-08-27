//
//  LoginPresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class LoginPresenterTests: XCTestCase {
    var presenter: LoginPresenter!
    var mockView: MockLoginView!
    var mockInteractor: MockLoginInteractor!
    var mockRouter: MockLoginRouter!

    override func setUp() {
        super.setUp()
        presenter = LoginPresenter()
        mockView = MockLoginView()
        mockInteractor = MockLoginInteractor()
        mockRouter = MockLoginRouter()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func testLoginWithEmptyFieldsShowsError() {
        presenter.didTapLogin(email: "", password: "")
        
        XCTAssertEqual(mockView.lastErrorMessage, "Todos los campos son obligatorios.")
    }

    func testLoginWithInvalidEmailShowsError() {
        presenter.didTapLogin(email: "correo_invalido", password: "123456")
        
        XCTAssertEqual(mockView.lastErrorMessage, "Correo electrónico inválido.")
    }

    func testLoginWithValidDataCallsInteractor() {
        presenter.didTapLogin(email: "correo@valido.com", password: "123456")
        
        XCTAssertEqual(mockInteractor.lastRequest?.email, "correo@valido.com")
    }

    func testDidTapRegisterCallsRouter() {
        presenter.didTapRegister()
        
        XCTAssertTrue(mockRouter.didNavigateToRegister)
    }

    func testLoginSuccessNavigatesToHome() {
        presenter.loginSucceeded(with: LoginResponse(token: "abc123"))
        
        XCTAssertEqual(TokenManager.accessToken, "abc123")
        XCTAssertTrue(mockRouter.didNavigateToHome)
    }

    func testLoginFailedShowsError() {
        let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Credenciales incorrectas"])
        
        presenter.loginFailed(with: error)
        
        XCTAssertEqual(mockView.lastErrorMessage, "Credenciales incorrectas")
    }
}
