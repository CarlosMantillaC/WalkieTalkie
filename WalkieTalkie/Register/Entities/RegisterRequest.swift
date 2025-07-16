//
//  RegisterRequest.swift
//  WalkieTalkie
//

//

struct RegisterRequest: Codable {
    let name: String
    let last_name: String
    let age: Int
    let email: String
    let password: String
    let confirm_password: String
}
