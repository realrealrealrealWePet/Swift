//
//  ChatService.swift
//  Wepet
//
//  Created by jaegu park on 23/01/24.
//

import Foundation
import Alamofire

struct ChatRoomResponse: Decodable {
    let roomId: String
    let name: String
    let sessions: [String] // Assuming 'sessions' is an array of strings; adjust if needed
}

class LocalChatService {
    static let shared = LocalChatService()
    
    func createChatRoom(senderName: String, completion: @escaping (ChatRoomResponse?) -> Void) {
        let urlString = "http://43.203.0.31:8080/api/chat?name=\(senderName)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Changed to POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Specify JSON request body
        
        // If your API requires a body for the POST request, uncomment and modify the following line
        // let body: [String: Any] = ["name": senderName]
        // request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error creating chat room: \(String(describing: error))")
                completion(nil)
                return
            }
            
            do {
                // Use JSONDecoder to parse the response
                let decoder = JSONDecoder()
                let chatRoomResponse = try decoder.decode(ChatRoomResponse.self, from: data)
                completion(chatRoomResponse)
            } catch {
                print("Error decoding response: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
