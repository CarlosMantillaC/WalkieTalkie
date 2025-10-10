
//
//  ChannelPrivateCreateResponse.swift
//  WalkieTalkie
//

//

import Foundation

struct ChannelPrivateCreateResponse: Codable {
    let id: Int
    let isPrivate: Bool
    let maxUsers: Int
    let message: String
    let name: String
}
