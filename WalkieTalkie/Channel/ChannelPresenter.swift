//
//  HomePresenter.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPresenter: ChannelPresenterProtocol {
    weak var view: ChannelViewProtocol?
    var interactor: ChannelInteractorProtocol?
    var router: ChannelRouterProtocol?

    func didTapLogout() {
        interactor?.logout()
    }
}

extension ChannelPresenter: ChannelInteractorOutputProtocol {
    func logoutSucceeded(message: String) {
        router?.navigateToLogin(with: message)
    }

    func logoutFailed(with error: Error) {
        view?.showLogoutError(error.localizedDescription)
    }
}
