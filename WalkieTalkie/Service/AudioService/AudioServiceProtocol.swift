//
//  AudioService.swift
//  WalkieTalkie
//

//

import Foundation

protocol AudioServiceProtocol {
    func startStreaming(to socket: WebSocketServiceProtocol)
    func stopStreaming()
    func playAudioData(_ data: Data)
}
