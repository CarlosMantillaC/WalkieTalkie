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

    func logoutSucceeded(message: String) {
        logoutMessage = message
    }

    func didReceivePermissionToSpeak() {}

    func didFetchUsers(_ emails: [String]) {
        fetchedEmails = emails
    }
}
