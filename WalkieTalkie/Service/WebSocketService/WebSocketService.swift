//
//  WebSocketService.swift
//  WalkieTalkie
//

//

import Foundation
import os

final class WebSocketService: WebSocketServiceProtocol {
    weak var delegate: WebSocketServiceDelegate?
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: APIConstants.webSocketURL)!
    private let session: URLSession
    private var isConnected = false
    
    private let logger = Logger(subsystem: "com..WalkieTalkie", category: "WebSocket")
    
    init() {
        let config = URLSessionConfiguration.default
        if let token = TokenManager.accessToken {
            config.httpAdditionalHeaders = [
                "Authorization": "Bearer \(token)"
            ]
        }
        session = URLSession(configuration: config)
    }
    
    func connect(to channel: String, pin: String? = nil) {
        guard !isConnected else {
            logger.debug("Already connected, ignoring connect request.")
            return
        }
        
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        isConnected = true
        
        logger.info("Connected to WebSocket at \(self.url.absoluteString, privacy: .public)")
        
        var json: [String: String] = ["channel": channel]
        if let pin = pin {
            json["pin"] = pin
        }
        
        if let data = try? JSONSerialization.data(withJSONObject: json),
           let message = String(data: data, encoding: .utf8) {
            send(message: message)
        }
        
        listen()
    }
    
    func send(message: String) {
        webSocketTask?.send(.string(message)) { [weak self] error in
            if let error = error {
                self?.logger.error("Error sending string: \(error.localizedDescription, privacy: .public)")
            } else {
                self?.logger.debug("Sent string message: \(message, privacy: .public)")
            }
        }
    }
    
    func send(data: Data) {
        webSocketTask?.send(.data(data)) { [weak self] error in
            if let error = error {
                self?.logger.error("Error sending data: \(error.localizedDescription, privacy: .public)")
            } else {
                self?.logger.debug("Sent binary data of size: \(data.count, privacy: .public)")
            }
        }
    }
    
    private func listen() {
        guard isConnected else {
            logger.warning("Not listening: socket not connected")
            return
        }
        
        webSocketTask?.receive { [weak self] result in
            guard let self = self, self.isConnected else { return }
            
            switch result {
            case .failure(let error):
                self.logger.error("Error receiving message: \(error.localizedDescription, privacy: .public)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self.logger.debug("Received text message: \(text, privacy: .public)")
                    delegate?.didReceive(message: text)
                case .data(let data):
                    self.logger.debug("Received binary data of size: \(data.count, privacy: .public)")
                    delegate?.didReceive(data: data)
                @unknown default:
                    self.logger.warning("Received unknown message type")
                }
            }
            
            self.listen()
        }
    }
    
    func disconnect() {
        isConnected = false
        logger.info("Disconnected from WebSocket.")
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
    }
}
