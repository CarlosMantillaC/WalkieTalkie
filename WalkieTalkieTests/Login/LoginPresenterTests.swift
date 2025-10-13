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
        let response = LoginResponse(accessToken: "abc123", accessTokenExpiresIn: 3600, email: "", first_name: "", last_name: "", refreshToken: "", refreshTokenExpiresAt: "", user_id: 1)
        presenter.loginSucceeded(with: response)
        
        XCTAssertTrue(mockRouter.didNavigateToHome)
    }

    func testLoginFailedShowsError() {
        let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Credenciales incorrectas"])
        
        presenter.loginFailed(with: error)
        
        XCTAssertEqual(mockView.lastErrorMessage, "Credenciales incorrectas")
    }
}
