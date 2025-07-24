//
//  LoginPresenter.swift
//  WalkieTalkie
//

//

import Foundation

final class LoginPresenter {
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
}

extension LoginPresenter: LoginPresenterProtocol {
    func didTapLogin(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            view?.showError("Todos los campos son obligatorios.")
            return
        }
        
        guard email.contains("@"), email.contains(".") else {
            view?.showError("Correo electrónico inválido.")
            return
        }
        
        let request = LoginRequest(email: email, password: password)
        interactor?.login(request: request)
    }
    
    func didTapRegister() {
        if let view = view {
            router?.navigateToRegister(from: view)
        }
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func loginSucceeded(with token: LoginResponse) {
        TokenManager.accessToken = token.token
        if let view = view {
            router?.navigateToHome(from: view)
        }
    }
    
    func loginFailed(with error: Error) {
        view?.showError(error.localizedDescription)
    }
}
