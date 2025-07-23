//
//  MockLoginPresenter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginPresenter: LoginPresenterProtocol {
    var lastLogin: (email: String, password: String)?
    var lastErrorShown: String?
    var didTapRegisterCalled = false

    func didTapLogin(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            lastErrorShown = "Todos los campos son obligatorios."
            return
        }

        if !email.contains("@") || !email.contains(".") {
            lastErrorShown = "Correo electrónico inválido."
            return
        }

        lastLogin = (email, password)
    }

    func didTapRegister() {
        didTapRegisterCalled = true
    }
}
