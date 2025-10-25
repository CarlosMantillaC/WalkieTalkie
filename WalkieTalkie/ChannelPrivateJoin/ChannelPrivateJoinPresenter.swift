//
//  ChannelPrivateJoinPresenter.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPrivateJoinPresenter: ChannelPrivateJoinPresenterProtocol {
    weak var view: ChannelPrivateJoinViewProtocol?
    var interactor: ChannelPrivateJoinInteractorInputProtocol?
    var router: ChannelPrivateJoinRouterProtocol?
    
    func joinChannel(name: String, pin: String) {
        interactor?.joinChannel(name: name, pin: pin)
    }
}

extension ChannelPrivateJoinPresenter: ChannelPrivateJoinInteractorOutputProtocol {
    func didJoinChannel(response: ChannelPrivateJoinResponse) {
        view?.showSuccess(message: response.message)
    }
    
    func didFailToJoinChannel(with error: Error) {
        view?.showError(error: error.localizedDescription)
    }
}
