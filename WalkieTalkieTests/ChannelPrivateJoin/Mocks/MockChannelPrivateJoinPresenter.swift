//
//  MockChannelPrivateJoinPresenter.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateJoinPresenter: ChannelPrivateJoinInteractorOutputProtocol {
    var didJoinChannelCalled = false
    var didFailToJoinChannelCalled = false
    var response: ChannelPrivateJoinResponse?
    var error: Error?

    func didJoinChannel(response: ChannelPrivateJoinResponse) {
        didJoinChannelCalled = true
        self.response = response
    }

    func didFailToJoinChannel(with error: Error) {
        didFailToJoinChannelCalled = true
        self.error = error
    }
}
