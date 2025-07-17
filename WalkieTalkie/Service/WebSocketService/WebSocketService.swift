//
//  WebSocketService.swift
//  WalkieTalkie
//

//

import Foundation

final class WebSocketService: WebSocketServiceProtocol {
    weak var delegate: WebSocketServiceDelegate?
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: "ws://159.203.187.94/ws")!
    private let session: URLSession
    private var isConnected = false

    init() {
        let config = URLSessionConfiguration.default
        if let token = TokenManager.accessToken {
            config.httpAdditionalHeaders = [
                "Authorization": "Bearer \(token)"
            ]
        }
        session = URLSession(configuration: config)
    }

    func connect(to channel: String) {
        guard !isConnected else { return }

        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        isConnected = true
        print("🔗 WebSocket connected")

        let json: [String: String] = ["canal": channel]
        if let data = try? JSONSerialization.data(withJSONObject: json),
           let message = String(data: data, encoding: .utf8) {
            send(message: message)
        }

        listen()
    }

    func send(message: String) {
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print("❌ Error sending message: \(error)")
            } else {
                print("✅ Sent message: \(message)")
            }
        }
    }

    private func listen() {
        guard isConnected else {
            print("🔕 Not listening: socket not connected")
            return
        }

        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }
            guard self.isConnected else {
                print("🔌 Stopped listening: connection closed")
                return
            }

            switch result {
            case .failure(let error):
                print("❌ Error receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("📩 Received string message: \(text)")
                    delegate?.didReceive(message: text)
                case .data(let data):
                    print("📩 Received binary message: \(data)")
                @unknown default:
                    print("📩 Received unknown message")
                }
            }

            self.listen()
        }
    }

    func disconnect() {
        isConnected = false
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
        print("🔌 WebSocket disconnected")
    }
}
