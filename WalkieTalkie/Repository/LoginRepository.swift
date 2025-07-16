//
//  LoginRepository.swift
//  WalkieTalkie
//

//

import Foundation

protocol LoginRepositoryProtocol {
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void)
}

final class LoginRepository: LoginRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.login) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.applyDefaultHeaders()
        
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
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
                        
            do {
                let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                if let apiError = try? JSONDecoder().decode(LoginAPIErrorResponse.self, from: data) {
                    let customError = NSError(
                        domain: "API",
                        code: 400,
                        userInfo: [NSLocalizedDescriptionKey: apiError.error]
                    )
                    completion(.failure(customError))
                }
            }
        }.resume()
    }
}
