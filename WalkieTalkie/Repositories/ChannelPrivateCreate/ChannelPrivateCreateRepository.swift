//
//  ChannelPrivateCreateRepository.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPrivateCreateRepository: ChannelPrivateCreateRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func createChannel(request: ChannelPrivateCreateRequest, completion: @escaping (Result<ChannelPrivateCreateResponse, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.createChannelPrivate) else {
            completion(.failure(NSError(domain: "BadURL", code: -1)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.applyDefaultHeaders()
        urlRequest.applyAuthHeaders()
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch {
            completion(.failure(error))
            return
        }
        
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: -3)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(ChannelPrivateCreateResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                if let apiError = try?  JSONDecoder().decode(ChannelPrivateCreateAPIErrorResponse.self, from: data) {
                    let customError = NSError(
                        domain: "API",
                        code: 400,
                        userInfo: [NSLocalizedDescriptionKey: apiError.error]
                    )
                    completion(.failure(customError))
                } else {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
