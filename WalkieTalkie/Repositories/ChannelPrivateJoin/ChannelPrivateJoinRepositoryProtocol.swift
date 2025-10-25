//
//  ChannelPrivateJoinRepositoryProtocol.swift
//  WalkieTalkie
//

//

import Foundation

protocol ChannelPrivateJoinRepositoryProtocol {
    func joinChannel(request: ChannelPrivateJoinRequest, completion: @escaping (Result<ChannelPrivateJoinResponse, Error>) -> Void)
}
