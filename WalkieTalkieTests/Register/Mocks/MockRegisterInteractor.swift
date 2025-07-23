//
//  MockRegisterInteractor.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class MockRegisterInteractor: RegisterInteractorProtocol {
    var lastRegisterRequest: RegisterRequest?

    func register(user: RegisterRequest) {
        lastRegisterRequest = user
    }
}
