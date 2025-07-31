//
//  HomePresenter.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPresenter {
    weak var view: ChannelViewProtocol?
    var interactor: ChannelInteractorProtocol?
    var router: ChannelRouterProtocol?
    private let channel: Channel?
    
    init(channel: Channel?) {
        self.channel = channel
    }
}

extension ChannelPresenter: ChannelPresenterProtocol {
    func viewDidLoad() {
        guard let channel = channel else {
            view?.setChannelName("Desconectado")
            return
        }
        interactor?.connectToChannel(named: channel.name)
        view?.setChannelName(channel.name)
        interactor?.fetchUsersInChannel(named: channel.name)
    }
    
    func didTapLogout() {
        interactor?.logout()
    }
    
    func startTalking() {
        interactor?.startTalking()
    }
    
    func stopTalking() {
        interactor?.stopTalking()
    }
    
    func didTapExit() {
        interactor?.disconnectFromChannel()
        view?.setChannelName("Desconectado")
    }
    
    func refreshUsers() {
        guard let channel = channel else { return }
        interactor?.fetchUsersInChannel(named: channel.name)
    }
    
    func didTapDropdown() {
        if let view = view {
            router?.presentChannelsModally(from: view)
        }
    }
}

extension ChannelPresenter: ChannelInteractorOutputProtocol {
    func logoutSucceeded(message: String) {
        router?.navigateToLogin(with: message)
    }

    func didFetchUsers(_ emails: [String]) {
        print("Emails recibidos en presenter: \(emails)")
        view?.displayUsers(emails)
    }
}
