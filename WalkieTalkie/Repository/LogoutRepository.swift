//
//  LogoutRepository.swift
//  WalkieTalkie
//

//

import Foundation

protocol LogoutRepositoryProtocol {
    func logout(completion: @escaping (Result<String, Error>) -> Void)
}

final class LogoutRepository: LogoutRepositoryProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func logout(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: APIConstants.baseURL + APIConstants.Endpoint.logout) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.applyDefaultHeaders()
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
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            print("Raw response:", String(data: data, encoding: .utf8) ?? "No string")
            
            do {
                let decoded = try JSONDecoder().decode(LogoutResponse.self, from: data)
                completion(.success(decoded.message))
            } catch {
                completion(.success("Sesión cerrada correctamente."))
            }
        }.resume()
    }
}
