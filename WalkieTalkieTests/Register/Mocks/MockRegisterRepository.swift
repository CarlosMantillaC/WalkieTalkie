//
//  MockRegisterRepository.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

class MockRegisterRepository: RegisterRepositoryProtocol {
    var capturedRequest: RegisterRequest?
    var resultToReturn: Result<RegisterResponse, Error>?

    func register(user: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        capturedRequest = user
        if let result = resultToReturn {
            completion(result)
        }
    }
}
