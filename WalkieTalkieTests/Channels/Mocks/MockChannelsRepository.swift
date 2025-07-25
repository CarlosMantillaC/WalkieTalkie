//
//  MockChannelsRepository.swift
//  WalkieTalkieTests
//

//

import UIKit
@testable import WalkieTalkie

final class MockChannelsRepository: ChannelsRepositoryProtocol {
    var stubbedResult: Result<[Channel], Error>?

    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        if let result = stubbedResult {
            completion(result)
        }
    }
}
