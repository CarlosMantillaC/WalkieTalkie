//
//  APIConstants.swift
//  WalkieTalkie
//

//

import Foundation

enum APIConstants {
    static let baseURL = "http://159.223.150.185:81"
    static let webSocketURL = "ws://159.223.150.185:81/ws"

    enum Endpoint {
        static let register = "/register"
        static let login = "/login"
        static let logout = "/logout"
        static let channels = "/channels/public"
        static let channelsPrivate = "/channels/private"
        static let createChannelPrivate = "/channels/private/create"
        static let joinChannelPrivate = "/channels/private/join"
        
        static func userChannel(channelName: String) -> String {
            return "/channel-users?channel=\(channelName)"
        }
    }
    
    struct Headers {
        static let contentType = "application/json"
    }
}
