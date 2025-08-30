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
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let jsonArray = try? JSONDecoder().decode([String].self, from: data) else {
                completion(.failure(NSError(domain: "InvalidJSON", code: -1)))
                return
            }
            
            let channels = jsonArray.map { Channel(name: $0) }
            completion(.success(channels))
        }.resume()
    }
}
