//
//  TokenManager.swift
//  WalkieTalkie
//

//

import Foundation

final class TokenManager {
    private static let tokenKey = "accessToken"
    
    static var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: tokenKey)
        }
        set {
            if let token = newValue {
                UserDefaults.standard.set(token, forKey: tokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: tokenKey)
            }
        }
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
