//
//  MockChannelsRepository.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsRepository: ChannelsRepositoryProtocol {
    var resultToReturn: Result<[Channel], Error>?

    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        if let result = resultToReturn {
            completion(result)
        }
    }
}
