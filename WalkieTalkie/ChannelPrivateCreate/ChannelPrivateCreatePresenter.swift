//
//  ChannelPrivateCreatePresenter.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPrivateCreatePresenter: ChannelPrivateCreatePresenterProtocol {
    weak var view: ChannelPrivateCreateViewProtocol?
    var interactor: ChannelPrivateCreateInteractorInputProtocol?
    var router: ChannelPrivateCreateRouterProtocol?
    
    func createChannel(name: String, pin: String) {
        interactor?.createChannel(name: name, pin: pin)
    }
}

extension ChannelPrivateCreatePresenter: ChannelPrivateCreateInteractorOutputProtocol {
    func didCreateChannel() {
        view?.showSuccess(message: "Se ha creado el canal correctamente")
    }
    
    func didFailToCreateChannel(with error: Error) {
        view?.showError(error: error.localizedDescription)
    }
}
