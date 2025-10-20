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
    
    func didTapLogout() {
        view?.showLogoutConfirmation()
    }
    
    func confirmLogoutTapped() {
        view?.showLoading()
        interactor?.performLogout()
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
