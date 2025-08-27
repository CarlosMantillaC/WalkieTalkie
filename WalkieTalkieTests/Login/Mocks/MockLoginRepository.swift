//
//  MockLoginRepository.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginRepository: LoginRepositoryProtocol {
    var capturedRequest: LoginRequest?
    var resultToReturn: Result<LoginResponse, Error>?

    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        capturedRequest = request
        if let result = resultToReturn {
            completion(result)
        }
    }
}
