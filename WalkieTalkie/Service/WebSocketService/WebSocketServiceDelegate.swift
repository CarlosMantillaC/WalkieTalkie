//
//  WebSocketServiceDelegate.swift
//  WalkieTalkie
//

//

import Foundation

protocol WebSocketServiceDelegate: AnyObject {
    func didReceive(message: String)
    func didReceive(data: Data)
}
