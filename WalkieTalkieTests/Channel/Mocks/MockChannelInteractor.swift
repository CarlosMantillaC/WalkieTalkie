//
//  MockChannelInteractor.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelInteractor: ChannelInteractorProtocol {
    var connectCalled = false
    var startTalkingCalled = false
    var stopTalkingCalled = false
    var disconnectCalled = false
    var fetchUsersCalled = false

    func connectToChannel(named name: String) {
        connectCalled = true
    }

    func startTalking() {
        startTalkingCalled = true
    }

    func stopTalking() {
        stopTalkingCalled = true
    }

    func disconnectFromChannel() {
        disconnectCalled = true
    }

    func fetchUsersInChannel(named channelName: String) {
        fetchUsersCalled = true
    }
}
