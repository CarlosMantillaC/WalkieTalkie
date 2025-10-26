//
//  MockChannelPrivateJoinView.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateJoinView: ChannelPrivateJoinViewProtocol {
    var showErrorCalled = false
    var showSuccessCalled = false
    var errorMessage: String?
    var successMessage: String?

    func showError(error: String) {
        showErrorCalled = true
        errorMessage = error
    }

    func showSuccess(message: String) {
        showSuccessCalled = true
        successMessage = message
    }
}
