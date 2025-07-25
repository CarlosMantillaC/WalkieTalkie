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
    private let channel: Channel
    
    init(channel: Channel) {
        self.channel = channel
    }
}

extension ChannelPresenter: ChannelPresenterProtocol {
    func viewDidLoad() {
        interactor?.connectToChannel(named: channel.name)
        view?.setChannelName(channel.name)
        interactor?.fetchUsersInChannel(named: channel.name)
    }

    func startTalking() {
        interactor?.startTalking()
    }

    func stopTalking() {
        interactor?.stopTalking()
    }
    
    func didTapExit() {
        interactor?.disconnectFromChannel()
        if let view = view {
            router?.navigateToChannels(from: view)
        }
    }
    
    func refreshUsers() {
        interactor?.fetchUsersInChannel(named: channel.name)
    }
}

extension ChannelPresenter: ChannelInteractorOutputProtocol {
    func didReceivePermissionToSpeak() {
        print("Tienes permiso para hablar")
    }
    
    func didFetchUsers(_ emails: [String]) {
        print("Emails recibidos en presenter: \(emails)")
        view?.displayUsers(emails)
    }
}
