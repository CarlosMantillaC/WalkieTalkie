//
//  MockListUsersRepository.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockListUsersRepository: ListUsersRepositoryProtocol {
    var result: Result<[String], Error>!
    var fetchUsersCalled = false

    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void) {
        fetchUsersCalled = true
        completion(result)
    }
}
