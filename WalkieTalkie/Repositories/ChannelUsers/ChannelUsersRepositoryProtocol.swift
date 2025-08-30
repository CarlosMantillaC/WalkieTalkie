//
//  ChannelUsersRepositoryProtocol.swift
//  WalkieTalkie
//

//

protocol ChannelUsersRepositoryProtocol {
    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void)
}
