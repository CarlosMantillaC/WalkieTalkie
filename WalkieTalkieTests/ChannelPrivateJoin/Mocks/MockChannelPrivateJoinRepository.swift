//
//  MockChannelPrivateJoinRepository.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateJoinRepository: ChannelPrivateJoinRepositoryProtocol {
    var result: Result<ChannelPrivateJoinResponse, Error>!
    var joinChannelCalled = false

    func joinChannel(request: ChannelPrivateJoinRequest, completion: @escaping (Result<ChannelPrivateJoinResponse, Error>) -> Void) {
        joinChannelCalled = true
        completion(result)
    }
}
