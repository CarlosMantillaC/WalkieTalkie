//
//  MockChannlesInteractor.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsInteractor: ChannelsInteractorProtocol {
    var loadChannelsCalled = false
    var logoutCalled = false

    func loadChannels() {
        loadChannelsCalled = true
    }

    func logout() {
        logoutCalled = true
    }
}
