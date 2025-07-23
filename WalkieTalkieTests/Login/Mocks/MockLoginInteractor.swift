//
//  MockLoginInteractor.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginInteractor: LoginInteractorProtocol {
    var lastRequest: LoginRequest?

    func login(request: LoginRequest) {
        lastRequest = request
    }
}
