//
//  MockLoginInteractorOutput.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginInteractorOutput: LoginInteractorOutputProtocol {
    var lastSuccessResponse: LoginResponse?
    var receivedError: Error?
    var onSuccess: (() -> Void)?
    var onFailure: (() -> Void)?

    func loginSucceeded(with response: LoginResponse) {
        lastSuccessResponse = response
        onSuccess?()
    }

    func loginFailed(with error: Error) {
        receivedError = error
        onFailure?()
    }
}
