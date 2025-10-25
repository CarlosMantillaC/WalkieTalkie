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
            view?.showDisconnectedState()
            return
        }

        view?.setChannelName(channel.name)
        interactor?.fetchUsersInChannel(named: channel.name)

        if channel.isPrivate {
            view?.promptForPIN { [weak self] pin in
                guard let pin = pin, !pin.isEmpty else {
                    self?.view?.showDisconnectedState()
                    return
                }
                self?.interactor?.connectToChannel(named: channel.name, pin: pin)
            }
        } else {
            interactor?.connectToChannel(named: channel.name, pin: nil)
        }
    }
    
    func startTalking() {
        interactor?.startTalking()
    }
    
    func stopTalking() {
        interactor?.stopTalking()
    }
    
    func didTapExit() {
        interactor?.disconnectFromChannel()
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

    func didTapDropdownCountUser() {
        if let view = view, let channel = channel {
            router?.navigateToListUsers(from: view, with: channel.name)
        }
    }
    
    func didTapSettings() {
        guard let view = view else { return }
        router?.navigateToSettings(from: view)
    }
}

extension ChannelPresenter: ChannelInteractorOutputProtocol {
    func didFetchUsers(_ emails: [String]) {
        let count = emails.count
        let text = "\(count) conectados"
        view?.displayUsers(text)
    }
    
    func didDisconnect() {
        view?.showDisconnectedState()
    }
}
