//
//  MockChannelPrivateCreateView.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateCreateView: ChannelPrivateCreateViewProtocol {
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
