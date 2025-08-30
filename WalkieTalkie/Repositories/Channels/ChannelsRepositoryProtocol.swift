//
//  ChannelsRepositoryProtocol.swift
//  WalkieTalkie
//

//

protocol ChannelsRepositoryProtocol {
    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void)
}
