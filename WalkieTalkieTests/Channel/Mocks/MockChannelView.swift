//
//  MockChannelView.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelView: UIViewController, ChannelViewProtocol {
    var presenter: ChannelPresenterProtocol?
    var channelName: String?
    var usersShown: [String]?

    func setChannelName(_ name: String) {
        channelName = name
    }

    func displayUsers(_ emails: [String]) {
        usersShown = emails
    }
}
