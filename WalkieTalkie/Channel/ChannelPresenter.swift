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
    
    private let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }

    func viewDidLoad() {
        interactor?.connectToChannel(named: channel.name)
        view?.setChannelName(channel.name)
    }

    func startTalking() {
        interactor?.startTalking()
    }

    func stopTalking() {
        interactor?.stopTalking()
    }

    func didTapLogout() {
        interactor?.disconnectFromChannel()
        interactor?.logout()
    }
    
    func didTapExit() {
        interactor?.disconnectFromChannel()
        router?.navigateToChannels()
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
