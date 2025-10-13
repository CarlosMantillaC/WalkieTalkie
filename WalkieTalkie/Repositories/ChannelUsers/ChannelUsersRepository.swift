//
//  ChannelRepository.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelUsersRepository: ChannelUsersRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.userChannel(channelName: channelName)) else {
            completion(.failure(NSError(domain: "BadURL", code: -1)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.applyAuthHeaders()
        
        session.dataTask(with: request) { data, response, error in
            if TokenExpirationHandler.handleIfNeeded(response) {
                return
            }

            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -3)))
                return
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
