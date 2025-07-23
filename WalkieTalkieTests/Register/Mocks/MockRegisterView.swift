//
//  MockRegisterView.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class MockRegisterView: RegisterViewProtocol {
    var successMessage: String?
    var errorMessage: String?
    
    func showSuccess(message: String) {
        successMessage = message
    }

    func showError(_ error: String) {
        errorMessage = error
    }
}
