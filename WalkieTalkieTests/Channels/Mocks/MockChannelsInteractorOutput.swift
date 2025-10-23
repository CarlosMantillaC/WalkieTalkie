//
//  MockChannelsInteractorOutput.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsInteractorOutput: ChannelsInteractorOutput {
    var publicChannels: [Channel]?
    var privateChannels: [Channel]?
    var receivedError: Error?

    func didLoadChannels(publicChannels: [Channel], privateChannels: [Channel]) {
        self.publicChannels = publicChannels
        self.privateChannels = privateChannels
    }

    func didFailLoadingChannels(error: Error) {
        receivedError = error
    }
}
