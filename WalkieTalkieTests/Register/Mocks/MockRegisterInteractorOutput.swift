//
//  MockRegisterInteractorOutput.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class MockRegisterInteractorOutput: RegisterInteractorOutputProtocol {
    var successMessage: String?
    var receivedError: Error?
    var onSuccess: (() -> Void)?
    var onFailure: (() -> Void)?

    func registerSuccess(message: String) {
        successMessage = message
        onSuccess?()
    }

    func registerFailed(with error: Error) {
        receivedError = error
        onFailure?()
    }
}
