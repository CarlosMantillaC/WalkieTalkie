//
//  MockChannlesInteractor.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsInteractor: ChannelsInteractorProtocol {
    var loadChannelsCalled = false

    func loadChannels() {
        loadChannelsCalled = true
    }
}
