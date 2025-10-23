//
//  MockChannelsRepository.swift
//  WalkieTalkieTests
//

//

import XCTest
@testable import WalkieTalkie

final class MockChannelsRepository: ChannelsRepositoryProtocol {
    var publicChannelsResult: Result<[Channel], Error>?
    var privateChannelsResult: Result<[Channel], Error>?

    func fetchPublicChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        if let result = publicChannelsResult {
            completion(result)
        }
    }

    func fetchPrivateChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        if let result = privateChannelsResult {
            completion(result)
        }
    }
}
