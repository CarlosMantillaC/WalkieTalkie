//
//  SettingsInteractor.swift
//  WalkieTalkie
//

//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol {
    weak var presenter: SettingsInteractorOutputProtocol?

    func performLogout() {
        TokenManager.clear()
        presenter?.didLogoutSuccessfully()
    }
}
