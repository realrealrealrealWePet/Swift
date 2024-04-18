//
//  ChattingSocket.swift
//  Wepet
//
//  Created by jaegu park on 15/01/24.
//

import Foundation
import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "ws://43.203.0.31:8080/ws/chat")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    override init() {
        super.init()
        socket = self.manager.socket(forNamespace: "/test")
        
        socket.on("test") { dataArray, ack in
            print(dataArray)
        }
    }

    func establishConnection(roomId: String, completion: @escaping ()->Void){
        socket = self.manager.socket(forNamespace: "/"+roomId)
        socket.connect()
        completion()
    }
    
    func closeConnection(){
        socket.emit("disconnect")
        socket.disconnect()
    }
   
    func sendMessage(message: String, nickname: String) {
//        socket.emit("event",  ["message" : "This is a test message"])
//        socket.emit("event1", [["name" : "ns"], ["email" : "@naver.com"]])
//        socket.emit("event2", ["name" : "ns", "email" : "@naver.com"])
//        socket.emit("msg", ["nick": nickname, "msg" : message])
        
        socket.emit("test", ["message":"Hi Server"])
                
        socket.emit("chat-msg", [
            "name": nickname,
            "message": message
        ])
    }
}
