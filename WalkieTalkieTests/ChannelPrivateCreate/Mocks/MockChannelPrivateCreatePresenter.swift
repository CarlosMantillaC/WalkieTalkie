//
//  MockChannelPrivateCreatePresenter.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateCreatePresenter: ChannelPrivateCreateInteractorOutputProtocol {
    var didCreateChannelCalled = false
    var didFailToCreateChannelCalled = false
    var error: Error?

    func didCreateChannel() {
        didCreateChannelCalled = true
    }

    func didFailToCreateChannel(with error: Error) {
        didFailToCreateChannelCalled = true
        self.error = error
    }
}
