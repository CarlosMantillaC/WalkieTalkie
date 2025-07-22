//
//  HomeInteractor.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelInteractor: ChannelInteractorProtocol, WebSocketServiceDelegate {
    weak var presenter: ChannelInteractorOutputProtocol?
    private var socket: WebSocketServiceProtocol
    private let audioService: AudioServiceProtocol
    private let channel: Channel
    
    init(channel: Channel,
         socket: WebSocketServiceProtocol = WebSocketService(),
         audioService: AudioServiceProtocol = AudioService()) {
        self.channel = channel
        self.socket = socket
        self.audioService = audioService
        self.socket.delegate = self
    }
    
    func connectToChannel(named name: String) {
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
    
    func didReceive(message: String) {
        if let audioData = Data(base64Encoded: message) {
            print("🎧 Received audio data")
            audioService.playAudioData(audioData)
        } else {
            if let json = try? JSONSerialization.jsonObject(with: Data(message.utf8), options: []) as? [String: Any],
               let serverMessage = json["message"] as? String {
                print("ℹ️ Server message: \(serverMessage)")
            } else {
                print("⚠️ Received non-audio message: \(message)")
            }
        }
    }
    
    func didReceive(data: Data) {
        print("🎧 Received audio data (\(data.count) bytes)")
        audioService.playAudioData(data)
    }
}
