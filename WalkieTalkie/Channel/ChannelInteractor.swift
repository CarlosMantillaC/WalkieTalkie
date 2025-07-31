//
//  HomeInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelInteractor {
    weak var presenter: ChannelInteractorOutputProtocol?
    private var socket: WebSocketServiceProtocol
    private let audioService: AudioServiceProtocol
    private let channel: Channel?
    private let usersRepository: ChannelUsersRepositoryProtocol
    
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
    }
    
    func fetchUsersInChannel(named channelName: String) {
        usersRepository.fetchUsers(for: channelName) { [weak self] result in
            switch result {
            case .success(let emails):
                print("Users in channel: \(emails)")
                self?.presenter?.didFetchUsers(emails)
            case .failure(let error):
                print("Failed to fetch users: \(error.localizedDescription)")
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
            print("Received audio data")
            audioService.playAudioData(audioData)
        } else {
            if let json = try? JSONSerialization.jsonObject(with: Data(message.utf8), options: []) as? [String: Any],
               let serverMessage = json["message"] as? String {
                print("Server message: \(serverMessage)")
            } else {
                print("Received non-audio message: \(message)")
            }
        }
    }
    
    func didReceive(data: Data) {
        print("Received audio data (\(data.count) bytes)")
        audioService.playAudioData(data)
    }
}
