//
//  ListUsersRepositoryProtocol.swift
//  WalkieTalkie
//

//

import Foundation

protocol ListUsersRepositoryProtocol {
    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void)
}
