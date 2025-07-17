//
//  WebSocketServiceDelegate.swift
//  WalkieTalkie
//

//

protocol WebSocketServiceDelegate: AnyObject {
    func didReceive(message: String)
}
