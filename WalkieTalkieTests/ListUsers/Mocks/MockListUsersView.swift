//
//  MockListUsersView.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockListUsersView: ListUsersViewProtocol {
    var reloadDataCalled = false
    var showErrorCalled = false
    var errorMessage: String?

    func reloadData() {
        reloadDataCalled = true
    }

    func showError(message: String) {
        showErrorCalled = true
        errorMessage = message
    }
}
