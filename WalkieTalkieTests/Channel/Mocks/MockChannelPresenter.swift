//
//  MockChannelPresenter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelPresenter: ChannelInteractorOutputProtocol {
    var logoutMessage: String?
    var fetchedEmails: [String]?
    var didDisconnectCalled = false
    
    func logoutSucceeded(message: String) {
        logoutMessage = message
    }
    
    func didFetchUsers(_ emails: [String]) {
        fetchedEmails = emails
    }
    
    func didDisconnect() {
        didDisconnectCalled = true
    }
}
