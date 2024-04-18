//
//  ConnectChat.swift
//  Wepet
//
//  Created by jaegu park on 28/01/24.
//

import Foundation

struct ServerResponse: Codable {
    let type: String
    let roomId: String
    let message: String
}

class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    
    func connectToChat(with roomId: String, sender: String) {
        let urlString = "ws://43.203.0.31:8080/ws/chat"
        guard let url = URL(string: urlString) else { return }
        
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        
        sendInitialMessage(roomId: roomId, sender: sender)
    }
    
    private func sendInitialMessage(roomId: String, sender: String) {
        let messageDict = [
            "type": "ENTER",
            "roomId": roomId,
            "sender": sender,
            "message": "Hello!"
        ]
        
        do {
            let messageData = try JSONSerialization.data(withJSONObject: messageDict, options: [])
            let messageString = String(data: messageData, encoding: .utf8)!
            webSocketTask?.send(.string(messageString)) { error in
                if let error = error {
                    print("Error sending message: \(error)")
                }
            }
        } catch {
            print("Error serializing message: \(error)")
        }
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}

extension WebSocketManager {
    func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.processMessage(text)
                case .data(let data):
                    print("Received data: \(data), not processing.")
                @unknown default:
                    break
                }
                
                self?.receiveMessage() // Listen for the next message
            }
        }
    }
    
    func processMessage(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        do {
            let response = try JSONDecoder().decode(ServerResponse.self, from: data)
            print("Received message: \(response.message)")
            // Handle the decoded response here
        } catch {
            print("Error decoding message: \(error)")
        }
    }
}
