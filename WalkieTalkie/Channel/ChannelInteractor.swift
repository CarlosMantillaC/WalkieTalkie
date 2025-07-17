//
//  HomeInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelInteractor: ChannelInteractorProtocol, WebSocketServiceDelegate {
    weak var presenter: ChannelInteractorOutputProtocol?
    private let repository: LogoutRepositoryProtocol
    private var socket: WebSocketServiceProtocol
    private let audioService: AudioServiceProtocol
    private let channel: Channel

    init(channel: Channel,
         repository: LogoutRepositoryProtocol = LogoutRepository(),
         socket: WebSocketServiceProtocol = WebSocketService(),
         audioService: AudioServiceProtocol = AudioService()) {
        self.channel = channel
        self.repository = repository
        self.socket = socket
        self.audioService = audioService
        self.socket.delegate = self
    }

    func connectToChannel(named name: String) {
        socket.connect(to: name)
    }

    func startTalking() {
        socket.send(message: "START")
        audioService.startStreaming(to: socket)
    }

    func stopTalking() {
        socket.send(message: "STOP")
        audioService.stopStreaming()
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
    
    func didReceive(message: String) {
        if message == "🗣️ Puedes hablar" {
            presenter?.didReceivePermissionToSpeak()
            return
        }

        guard let data = Data(base64Encoded: message) else {
            print("❌ Could not decode base64 audio")
            return
        }

        audioService.playAudioData(data)
    }
}
