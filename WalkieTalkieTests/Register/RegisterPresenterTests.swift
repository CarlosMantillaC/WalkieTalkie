//
//  RegisterPresenterTests.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class RegisterPresenterTests: XCTestCase {
    var presenter: RegisterPresenter!
    var mockView: MockRegisterView!
    var mockInteractor: MockRegisterInteractor!

    override func setUp() {
        super.setUp()
        
        presenter = RegisterPresenter()
        mockView = MockRegisterView()
        mockInteractor = MockRegisterInteractor()
        
        presenter.view = mockView
        presenter.interactor = mockInteractor
    }

    func testEmptyFieldsShouldShowError() {
        presenter.didTapSend(
            firstName: "",
            lastName: "",
            email: "",
            password: "",
            confirmPassword: ""
        )
        
        XCTAssertEqual(mockView.errorMessage, "Todos los campos son obligatorios.")
    }

    func testMismatchedPasswordsShouldShowError() {
        presenter.didTapSend(
            firstName: "Test",
            lastName: "User",
            email: "test@mail.com",
            password: "123456",
            confirmPassword: "654321"
        )
        
        XCTAssertEqual(mockView.errorMessage, "Las contraseñas no coinciden.")
    }

    func testInvalidEmailShouldShowError() {
        presenter.didTapSend(
            firstName: "Test",
            lastName: "User",
            email: "testmail",
            password: "123456",
            confirmPassword: "123456"
        )
        
        XCTAssertEqual(mockView.errorMessage, "Correo electrónico inválido.")
    }

    func testValidInputShouldCallInteractorRegister() {
        presenter.didTapSend(
            firstName: "Test",
            lastName: "User",
            email: "test@mail.com",
            password: "123456",
            confirmPassword: "123456"
        )
        
        XCTAssertNotNil(mockInteractor.lastRegisterRequest)
        XCTAssertEqual(mockInteractor.lastRegisterRequest?.firstName, "Test")
    }

    func testRegisterSuccessShouldCallViewShowSuccess() {
        presenter.registerSuccess(message: "Registro exitoso")
        
        XCTAssertEqual(mockView.successMessage, "Registro exitoso")
    }

    func testRegisterFailedShouldCallViewShowError() {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error de red"])
        
        presenter.registerFailed(with: error)
        
        XCTAssertEqual(mockView.errorMessage, "Error de red")
    }
}
