//
//  MockLoginInteractorOutput.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginInteractorOutput: LoginInteractorOutputProtocol {
    var lastSuccessToken: LoginResponse?
    var lastError: Error?
    var onSuccess: (() -> Void)?
    var onFailure: (() -> Void)?

    func loginSucceeded(with token: LoginResponse) {
        lastSuccessToken = token
        onSuccess?()
    }

    func loginFailed(with error: Error) {
        lastError = error
        onFailure?()
    }
}
