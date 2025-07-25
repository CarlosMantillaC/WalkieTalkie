//
//  MockChannelsView.swift
//  WalkieTalkieTests
//

//

import UIKit
@testable import WalkieTalkie

final class MockChannelsView: ChannelsViewProtocol {
    var reloadDataCalled = false
    var shownErrorMessage: String?

    func reloadData() {
        reloadDataCalled = true
    }

    func showError(message: String) {
        shownErrorMessage = message
    }
}
