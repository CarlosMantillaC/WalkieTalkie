//
//  MockPresenter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class MockPresenter: RegisterPresenterProtocol {
    var sentRequest: (first_name: String, last_name: String, email: String, password: String, confirm_password: String)?
    var errorShown: String?

    func didTapSend(first_name: String, last_name: String, email: String, password: String, confirm_password: String) {

        if first_name.isEmpty || last_name.isEmpty || email.isEmpty || password.isEmpty || confirm_password.isEmpty {
            errorShown = "Todos los campos son obligatorios."
            return
        }

        guard password == confirm_password else {
            errorShown = "Las contraseñas no coinciden."
            return
        }

        guard email.contains("@"), email.contains(".") else {
            errorShown = "Correo electrónico inválido."
            return
        }

        sentRequest = (first_name, last_name, email, password, confirm_password)
    }
}
