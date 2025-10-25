
//
//  ChannelPrivateJoinRepository.swift
//  WalkieTalkie
//

//

import Foundation

final class ChannelPrivateJoinRepository: ChannelPrivateJoinRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func joinChannel(request: ChannelPrivateJoinRequest, completion: @escaping (Result<ChannelPrivateJoinResponse, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.joinChannelPrivate) else {
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
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401, let data = data {
                if let apiError = try? JSONDecoder().decode(ChannelPrivateJoinAPIErrorResponse.self, from: data) {
                    let customError = NSError(
                        domain: "API",
                        code: httpResponse.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: apiError.error]
                    )
                    completion(.failure(customError))
                    return
                }
            }

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
                let decoded = try JSONDecoder().decode(ChannelPrivateJoinResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                if let apiError = try?  JSONDecoder().decode(ChannelPrivateJoinAPIErrorResponse.self, from: data) {
                    let customError = NSError(
                        domain: "API",
                        code: (response as? HTTPURLResponse)?.statusCode ?? 400,
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
