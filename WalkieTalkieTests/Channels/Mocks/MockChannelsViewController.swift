//
//  MockChannelsViewController.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsViewController: UIViewController, ChannelsViewProtocol {
    var reloadDataCalled = false
    var showErrorMessage: String?

    func reloadData() {
        reloadDataCalled = true
    }

    func showError(message: String) {
        showErrorMessage = message
    }
}
