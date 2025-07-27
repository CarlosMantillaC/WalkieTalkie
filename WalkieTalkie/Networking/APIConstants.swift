//
//  APIConstants.swift
//  WalkieTalkie
//

//

import Foundation

enum APIConstants {
    static let baseURL = "http://159.203.187.94"
    static let webSocketURL = "ws://159.203.187.94/ws"

    enum Endpoint {
        static let register = "/register"
        static let login = "/login"
        static let logout = "/logout"
        static let channels = "/channels"
        
        static func userChannel(channelName: String) -> String {
            return "/channel-users?canal=\(channelName)"
        }
    }
    
    struct Headers {
        static let contentType = "application/json"
    }
}
