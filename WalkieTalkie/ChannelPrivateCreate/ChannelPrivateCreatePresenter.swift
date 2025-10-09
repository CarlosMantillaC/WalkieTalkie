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
    
    func createChannel() {
        view?.showLoading()
        interactor?.createChannel()
    }
}

extension ChannelPrivateCreatePresenter: ChannelPrivateCreateInteractorOutputProtocol {
    func didCreateChannel() {
        view?.hideLoading()
        view?.showSuccess(message: "Se ha creado el canal correctamente")
    }
    
    func didFailToCreateChannel(with error: Error) {
        view?.hideLoading()
        view?.show(error: error.localizedDescription)
    }
}
