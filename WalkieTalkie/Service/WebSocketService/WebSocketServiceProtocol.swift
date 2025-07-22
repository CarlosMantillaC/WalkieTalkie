//
//  WebSocketServiceProtocol.swift
//  WalkieTalkie
//

//

import Foundation

protocol WebSocketServiceProtocol {
    var delegate: WebSocketServiceDelegate? { get set }
    func connect(to channel: String)
    func send(message: String)
    func send(data: Data)
    func disconnect()
}
