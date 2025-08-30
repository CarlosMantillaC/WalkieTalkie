//
//  HomeInteractor.swift
//  WalkieTalkie
//

//

import Foundation
import os

final class ChannelInteractor {
    weak var presenter: ChannelInteractorOutputProtocol?
    private var socket: WebSocketServiceProtocol
    private let audioService: AudioServiceProtocol
    private let channel: Channel?
    private let usersRepository: ChannelUsersRepositoryProtocol
    
    private let logger = Logger(subsystem: "com..WalkieTalkie", category: "ChannelInteractor")
    
    init(channel: Channel?,
         socket: WebSocketServiceProtocol = WebSocketService(),
         audioService: AudioServiceProtocol = AudioService(),
         usersRepository: ChannelUsersRepositoryProtocol = ChannelUsersRepository()) {
        self.channel = channel
        self.socket = socket
        self.audioService = audioService
        self.usersRepository = usersRepository
        self.socket.delegate = self
    }
}

extension ChannelInteractor: ChannelInteractorProtocol {
    func connectToChannel(named name: String) {
        guard let _ = channel else { return }
        socket.connect(to: name)
        audioService.startStreaming(to: socket)
        audioService.stopStreaming()
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
        presenter?.didDisconnect()
    }
    
    func fetchUsersInChannel(named channelName: String) {
        usersRepository.fetchUsers(for: channelName) { [weak self] result in
            switch result {
            case .success(let emails):
                self?.presenter?.didFetchUsers(emails)
            case .failure(let error):
                self?.logger.error("Failed to fetch users: \(error.localizedDescription, privacy: .public)")
            }
        }
    }
    
    func logout() {
        TokenManager.clear()
        self.presenter?.logoutSucceeded(message: "Sesión cerrada exitosamente")
    }
}

extension ChannelInteractor: WebSocketServiceDelegate {
    func didReceive(message: String) {
        if let audioData = Data(base64Encoded: message) {
            audioService.playAudioData(audioData)
        }
    }
    
    func didReceive(data: Data) {
        audioService.playAudioData(data)
    }
}
