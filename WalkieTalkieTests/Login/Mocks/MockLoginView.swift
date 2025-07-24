//
//  MockLoginView.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginView: LoginViewProtocol {
    var lastErrorMessage: String?

    func showError(_ message: String) {
        lastErrorMessage = message
    }
}
