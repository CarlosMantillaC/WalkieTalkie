//
//  HomePresenter.swift
//  WalkieTalkie
//

//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?

    func didTapLogout() {
        interactor?.logout()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func logoutSucceeded(message: String) {
        router?.navigateToLogin(with: message)
    }

    func logoutFailed(with error: Error) {
        view?.showLogoutError(error.localizedDescription)
    }
}
