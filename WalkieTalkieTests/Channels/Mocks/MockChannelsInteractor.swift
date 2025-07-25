//
//  MockChannlesInteractor.swift
//  WalkieTalkieTests
//

//

import UIKit
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
