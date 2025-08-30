//
//  RegisterRepository.swift
//  WalkieTalkie
//

//

import Foundation

final class RegisterRepository: RegisterRepositoryProtocol {
    private let session: URLSession
    private let encoder = NetworkService.shared.encoder
    private let decoder = NetworkService.shared.decoder
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func register(user: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.register) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.applyDefaultHeaders()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch {
            completion(.failure(error))
            return
        }
        
        session.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }

            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let decoded = try self.decoder.decode(RegisterResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                if let apiError = try? self.decoder.decode(RegisterAPIErrorResponse.self, from: data) {
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
