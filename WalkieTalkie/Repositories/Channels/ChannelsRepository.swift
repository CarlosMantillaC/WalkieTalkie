//
//  ChannelsRepository.swift
//  WalkieTalkie
//

//

import Foundation

class ChannelsRepository: ChannelsRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.channels) else {
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
                completion(.failure(NSError(domain: "NoData", code: -1)))
                return
            }
            
            do {
                let channels = try JSONDecoder().decode([Channel].self, from: data)
                completion(.success(channels))
            } catch {
                completion(.failure(NSError(domain: "InvalidJSON", code: -1, userInfo: [NSUnderlyingErrorKey: error])))
            }
        }.resume()
    }
}
