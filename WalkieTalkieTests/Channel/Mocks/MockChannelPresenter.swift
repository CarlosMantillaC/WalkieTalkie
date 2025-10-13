//
//  MockChannelPresenter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelPresenter: ChannelInteractorOutputProtocol {
    var fetchedEmails: [String]?
    var didDisconnectCalled = false
    
    func didFetchUsers(_ emails: [String]) {
        fetchedEmails = emails
    }
    
    func didDisconnect() {
        didDisconnectCalled = true
    }
}
