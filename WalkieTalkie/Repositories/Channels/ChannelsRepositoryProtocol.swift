//
//  ChannelsRepositoryProtocol.swift
//  WalkieTalkie
//

//

protocol ChannelsRepositoryProtocol {
    func fetchPublicChannels(completion: @escaping (Result<[Channel], Error>) -> Void)
    func fetchPrivateChannels(completion: @escaping (Result<[Channel], Error>) -> Void)
}
