//
//  URLRequest+Extensions.swift
//  WalkieTalkie
//

//

import Foundation

extension URLRequest {
    mutating func applyDefaultHeaders() {
        self.setValue(APIConstants.Headers.contentType, forHTTPHeaderField: "Content-Type")
    }
    
    mutating func applyAuthHeaders() {
        if let token = TokenManager.accessToken {
            self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
