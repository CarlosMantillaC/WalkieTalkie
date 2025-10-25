//
//  ListUsersRepository.swift
//  WalkieTalkie
//

//

import Foundation

final class ListUsersRepository: ListUsersRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchUsers(for channelName: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.userChannel(channelName: channelName)) else {
            completion(.failure(NSError(domain: "BadURL", code: -1)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.applyDefaultHeaders()
        
        session.dataTask(with: urlRequest) { data, response, error in
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
                let decoded = try JSONDecoder().decode([String].self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
