//
//  MockChannelPresenter.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelPresenter: ChannelInteractorOutputProtocol {
    var fetchedEmails: [String]?
    
    func didReceivePermissionToSpeak() {}
    
    func didFetchUsers(_ emails: [String]) {
        fetchedEmails = emails
    }
}
