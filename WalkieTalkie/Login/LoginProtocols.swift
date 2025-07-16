//
//  LoginProtocols.swift
//  WalkieTalkie
//

//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func showError(_ message: String)
}

protocol LoginPresenterProtocol: AnyObject {
    func didTapLogin(email: String, password: String)
    func didTapRegister()
}

protocol LoginInteractorProtocol: AnyObject {
    func login(request: LoginRequest)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func loginSucceeded(with token: LoginResponse)
    func loginFailed(with error: Error)
}

protocol LoginRouterProtocol {
    static func createModule() -> UIViewController
    func navigateToHome(from view: LoginViewProtocol)
    func navigateToRegister(from view: LoginViewProtocol)
}
