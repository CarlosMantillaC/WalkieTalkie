//
//  SettingsProtocols.swift
//  WalkieTalkie
//

//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    var presenter: SettingsPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showAlert(title: String, message: String)
}

protocol SettingsPresenterProtocol: AnyObject {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var router: SettingsRouterProtocol? { get set }
    
    func viewDidLoad()
    func didTapLogout()
}

protocol SettingsInteractorInputProtocol: AnyObject {
    var presenter: SettingsInteractorOutputProtocol? { get set }
    
    func performLogout()
}

protocol SettingsInteractorOutputProtocol: AnyObject {
    func didLogoutSuccessfully()
}

protocol SettingsRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    
    func navigateToLogin(from view: SettingsViewProtocol?)
}
