//
//  MockLoginRepository.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockLoginRepository: LoginRepositoryProtocol {
    var lastRequest: LoginRequest?
    var resultToReturn: Result<LoginResponse, Error>?

    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        lastRequest = request
        if let result = resultToReturn {
            completion(result)
        }
    }
}
