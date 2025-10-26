//
//  MockChannelPrivateCreateRepository.swift
//  WalkieTalkieTests
//

//

import Foundation
@testable import WalkieTalkie

class MockChannelPrivateCreateRepository: ChannelPrivateCreateRepositoryProtocol {
    var result: Result<ChannelPrivateCreateResponse, Error>!
    var createChannelCalled = false

    func createChannel(request: ChannelPrivateCreateRequest, completion: @escaping (Result<ChannelPrivateCreateResponse, Error>) -> Void) {
        createChannelCalled = true
        completion(result)
    }
}
