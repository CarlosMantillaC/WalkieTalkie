//
//  ChannelRepository.swift
//  WalkieTalkie
//

//

import Foundation

protocol ChannelUsersRepositoryProtocol {
    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void)
}

final class ChannelUsersRepository: ChannelUsersRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "http://159.203.187.94/channel-users?canal=\(channelName)") else {
            completion(.failure(NSError(domain: "BadURL", code: -1)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.applyAuthHeaders()
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -3)))
                return
            }
            
            if let raw = String(data: data, encoding: .utf8) {
                print("🧾 Raw JSON response: \(raw)")
            }
            
            do {
                let userList = try JSONDecoder().decode([String].self, from: data)
                completion(.success(userList))
            } catch {
                completion(.failure(NSError(domain: "InvalidJSON", code: -2)))
            }
        }.resume()
    }
}
