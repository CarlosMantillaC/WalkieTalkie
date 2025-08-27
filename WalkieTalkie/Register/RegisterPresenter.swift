//
//  RegisterPresenter.swift
//  WalkieTalkie
//

//

import Foundation

final class RegisterPresenter {
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorProtocol?
    var router: RegisterRouterProtocol?
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func didTapSend(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        confirmPassword: String
    ) {
            
            guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
                view?.showError("Todos los campos son obligatorios.")
                return
            }
            
            let nameRegex = "^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$"
            if !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: firstName) {
                view?.showError("El nombre solo debe contener letras.")
                return
            }
            
            if !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: lastName) {
                view?.showError("El apellido solo debe contener letras.")
                return
            }
            
            guard password.count >= 6 else {
                view?.showError("La contraseña debe tener al menos 6 caracteres.")
                return
            }
            
            guard password == confirmPassword else {
                view?.showError("Las contraseñas no coinciden.")
                return
            }
            
            guard email.contains("@"), email.contains(".") else {
                view?.showError("Correo electrónico inválido.")
                return
            }
            
            let request = RegisterRequest(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                confirmPassword: confirmPassword
            )
            interactor?.register(user: request)
        }
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    func registerSuccess(message: String) {
        view?.showSuccess(message: message)
    }
    
    func registerFailed(with error: Error) {
        view?.showError(error.localizedDescription)
    }
}
