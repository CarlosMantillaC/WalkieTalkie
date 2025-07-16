//
//  RegisterProtocols.swift
//  WalkieTalkie
//

//

import Foundation
import UIKit

protocol RegisterViewProtocol: AnyObject {
    func showSuccess(message: String)
    func showError(_ error: String)
}

protocol RegisterPresenterProtocol: AnyObject {
    func didTapSend(name: String, last_name: String, age: String, email: String, password: String, confirm_password: String)
}

protocol RegisterInteractorProtocol: AnyObject {
    func register(user: RegisterRequest)
}

protocol RegisterInteractorOutputProtocol: AnyObject {
    func registerSuccess(message: String)
    func registerFailed(with error: Error)
}

protocol RegisterRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}
