//
//  MockWebSocketService.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockWebSocketService: WebSocketServiceProtocol {
    var delegate: WebSocketServiceDelegate?
    var connectedChannel: String?
    var sentMessages: [String] = []
    var disconnectCalled = false
    
    func connect(to channel: String) {
        connectedChannel = channel
    }
    
    func disconnect() {
        disconnectCalled = true
    }
    
    func send(message: String) {
        sentMessages.append(message)
    }
    
    func send(data: Data) {}
}
