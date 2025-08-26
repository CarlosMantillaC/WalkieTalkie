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
            first_name: "",
            last_name: "",
            email: "",
            password: "",
            confirm_password: "")
        
        XCTAssertEqual(mockView.errorMessage, "Todos los campos son obligatorios.")
    }

    func testMismatchedPasswordsShouldShowError() {
        presenter.didTapSend(
            first_name: "Test",
            last_name: "User",
            email: "test@mail.com",
            password: "123456",
            confirm_password: "654321")
        
        XCTAssertEqual(mockView.errorMessage, "Las contraseñas no coinciden.")
    }

    func testInvalidEmailShouldShowError() {
        presenter.didTapSend(
            first_name: "Test",
            last_name: "User",
            email: "testmail",
            password: "123456",
            confirm_password: "123456")
        
        XCTAssertEqual(mockView.errorMessage, "Correo electrónico inválido.")
    }

    func testValidInputShouldCallInteractorRegister() {
        presenter.didTapSend(
            first_name: "Test",
            last_name: "User",
            email: "test@mail.com",
            password: "123456",
            confirm_password: "123456")
        
        XCTAssertNotNil(mockInteractor.lastRegisterRequest)
        XCTAssertEqual(mockInteractor.lastRegisterRequest?.first_name, "Test")
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
