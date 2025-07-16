//
//  RegisterAPIError.swift
//  WalkieTalkie
//

//

struct RegisterAPIError: Codable {
    let code: Int
    let type: String
    let message: String
}
