//
//  MockChannelUsersRepository.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelUsersRepository: ChannelUsersRepositoryProtocol {
    var mockResult: Result<[String], Error>?

    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}
