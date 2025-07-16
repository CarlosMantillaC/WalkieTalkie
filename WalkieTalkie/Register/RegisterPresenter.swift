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
        name: String,
        last_name: String,
        age: String,
        email: String,
        password: String,
        confirm_password: String) {
            
            guard !name.isEmpty, !last_name.isEmpty, !age.isEmpty, !email.isEmpty, !password.isEmpty, !confirm_password.isEmpty else {
                view?.showError("Todos los campos son obligatorios.")
                return
            }
            
            let nameRegex = "^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$"
            if !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name) {
                view?.showError("El nombre solo debe contener letras.")
                return
            }
            
            if !NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: last_name) {
                view?.showError("El apellido solo debe contener letras.")
                return
            }
            
            guard let ageInt = Int(age), ageInt > 12 && ageInt <= 100 else {
                view?.showError("Edad inválida.")
                return
            }
            
            guard password.count >= 6 else {
                view?.showError("La contraseña debe tener al menos 6 caracteres.")
                return
            }
            
            guard password == confirm_password else {
                view?.showError("Las contraseñas no coinciden.")
                return
            }
            
            guard email.contains("@"), email.contains(".") else {
                view?.showError("Correo electrónico inválido.")
                return
            }
            
            let request = RegisterRequest(
                name: name,
                last_name: last_name,
                age: ageInt,
                email: email,
                password: password,
                confirm_password: confirm_password
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
