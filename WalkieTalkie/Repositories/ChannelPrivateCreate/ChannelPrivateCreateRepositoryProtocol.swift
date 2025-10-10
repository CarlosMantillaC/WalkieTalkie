//
//  ChannelPrivateCreateRepositoryProtocol.swift
//  WalkieTalkie
//

//

import Foundation

protocol ChannelPrivateCreateRepositoryProtocol {
    func createChannel(request: ChannelPrivateCreateRequest, completion: @escaping (Result<ChannelPrivateCreateResponse, Error>) -> Void)
}