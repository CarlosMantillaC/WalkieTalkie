//
//  RegisterRepository.swift
//  WalkieTalkie
//

//

import Foundation

protocol RegisterRepositoryProtocol {
    func register(user: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void)
}

final class RegisterRepository: RegisterRepositoryProtocol {
    private let session: URLSession
    
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
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            completion(.failure(error))
            return
        }
        
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                if let apiError = try? JSONDecoder().decode(RegisterAPIErrorResponse.self, from: data) {
                    let customError = NSError(
                        domain: "",
                        code: apiError.error.code,
                        userInfo: [NSLocalizedDescriptionKey: apiError.error.message]
                    )
                    completion(.failure(customError))
                } else {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
