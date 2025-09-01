//
//  MockChannelsInteractorOutput.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsInteractorOutput: ChannelsInteractorOutput {
    var loadedChannels: [Channel]?
    var receivedError: Error?
    var logoutMessage: String?

    func didLoadChannels(_ channels: [Channel]) {
        loadedChannels = channels
    }

    func didFailLoadingChannels(error: Error) {
        receivedError = error
    }

    func logoutSucceeded(message: String) {
        logoutMessage = message
    }
}
