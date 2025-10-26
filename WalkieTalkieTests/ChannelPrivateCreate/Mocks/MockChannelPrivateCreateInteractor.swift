//
//  MockChannelPrivateCreateInteractor.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateCreateInteractor: ChannelPrivateCreateInteractorInputProtocol {
    var presenter: ChannelPrivateCreateInteractorOutputProtocol?
    var createChannelCalled = false
    var channelName: String?
    var pin: String?

    func createChannel(name: String, pin: String) {
        createChannelCalled = true
        self.channelName = name
        self.pin = pin
    }
}
