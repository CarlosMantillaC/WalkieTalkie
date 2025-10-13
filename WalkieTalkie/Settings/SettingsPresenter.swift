
//
//  SettingsPresenter.swift
//  WalkieTalkie
//

//

import UIKit

class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    var router: SettingsRouterProtocol?
    
    func viewDidLoad() {
        // Future logic for viewDidLoad if needed
    }
    
    func didTapLogout() {
        // Ask for confirmation before logging out
        let alert = UIAlertController(title: "Cerrar Sesión", message: "¿Estás seguro de que quieres cerrar la sesión?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Cerrar Sesión", style: .destructive, handler: { [weak self] _ in
            self?.view?.showLoading()
            self?.interactor?.performLogout()
        }))
        
        // The view controller will be responsible for presenting the alert
        if let view = view as? UIViewController {
            view.present(alert, animated: true)
        }
    }
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    func didLogoutSuccessfully() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.hideLoading()
            self?.router?.navigateToLogin(from: self?.view)
        }
    }
}
