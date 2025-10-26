//
//  MockChannelPrivateJoinInteractor.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateJoinInteractor: ChannelPrivateJoinInteractorInputProtocol {
    var presenter: ChannelPrivateJoinInteractorOutputProtocol?
    var joinChannelCalled = false
    var channelName: String?
    var pin: String?

    func joinChannel(name: String, pin: String) {
        joinChannelCalled = true
        self.channelName = name
        self.pin = pin
    }
}
