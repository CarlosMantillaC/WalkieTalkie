//
//  RegisterRequest.swift
//  WalkieTalkie
//

//

struct RegisterRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let confirmPassword: String
}
