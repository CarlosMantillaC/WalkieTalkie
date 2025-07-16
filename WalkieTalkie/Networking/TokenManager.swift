//
//  TokenManager.swift
//  WalkieTalkie
//

//

import Foundation

final class TokenManager {
    private static let tokenKey = "accessToken"
    private static let userIdKey = "userId"
    
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
    
    static var userId: Int? {
        get {
            UserDefaults.standard.integer(forKey: userIdKey) == 0
            ? nil
            : UserDefaults.standard.integer(forKey: userIdKey)
        }
        set {
            if let id = newValue {
                UserDefaults.standard.set(id, forKey: userIdKey)
            } else {
                UserDefaults.standard.removeObject(forKey: userIdKey)
            }
        }
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userIdKey)
    }
}
