//
//  WebSocketServiceProtocol.swift
//  WalkieTalkie
//

//

protocol WebSocketServiceProtocol {
    var delegate: WebSocketServiceDelegate? { get set }
    func connect(to channel: String)
    func send(message: String)
    func disconnect()
}
