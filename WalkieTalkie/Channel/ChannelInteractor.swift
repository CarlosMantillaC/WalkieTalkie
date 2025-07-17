//
//  HomeInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelInteractor: ChannelInteractorProtocol {
    weak var presenter: ChannelInteractorOutputProtocol?
    private let repository: LogoutRepositoryProtocol
    private let socket: WebSocketServiceProtocol
    private let channel: Channel

    init(channel: Channel, repository: LogoutRepositoryProtocol = LogoutRepository(),
         socket: WebSocketServiceProtocol = WebSocketService()) {
        self.channel = channel
        self.repository = repository
        self.socket = socket
        
    }

    func connectToChannel(named name: String) {
        socket.connect(to: name)
    }

    func startTalking() {
        socket.send(message: "START")
    }

    func stopTalking() {
        socket.send(message: "STOP")
    }
    
    func disconnectFromChannel() {
        socket.disconnect()
    }
    
    func logout() {
        repository.logout { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    TokenManager.clear()
                    self?.presenter?.logoutSucceeded(message: message)
                case .failure(let error):
                    self?.presenter?.logoutFailed(with: error)
                }
            }
        }
    }
}
