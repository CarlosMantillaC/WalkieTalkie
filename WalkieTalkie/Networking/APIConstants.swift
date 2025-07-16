//
//  APIConstants.swift
//  WalkieTalkie
//

//

import Foundation

enum APIConstants {
    static let baseURL = "http://159.203.187.94"
    
    enum Endpoint {
        static let register = "/api/register"
        static let login = "/api/login"
        static let logout = "/api/logout"
        static let user = "/api/user"
        static let users = "/api/users"
    }
    
    struct Headers {
        static let contentType = "application/json"
    }
}
