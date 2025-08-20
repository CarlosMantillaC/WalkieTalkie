//
//  MockAudioService.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockAudioService: AudioServiceProtocol {
    var startStreamingCalled = false
    var stopStreamingCalled = false
    var playedAudioData = false
    
    func startStreaming(to socket: WebSocketServiceProtocol) {
        startStreamingCalled = true
    }
    
    func stopStreaming() {
        stopStreamingCalled = true
    }
    
    func playAudioData(_ data: Data) {
        playedAudioData = true
    }
}
