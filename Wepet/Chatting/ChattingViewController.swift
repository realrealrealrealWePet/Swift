//
//  ChattingViewController.swift
//  Wepet
//
//  Created by jaegu park on 1/10/23.
//

import UIKit
import SocketIO
import StompClientLib

class ChattingViewController: UIViewController {
    
    @IBOutlet var MessageTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    let chatService = LocalChatService()
    let connectChat = WebSocketManager()
    var socketClient = StompClientLib()
    
    private let url = URL(string: "")
    
    var myChat: [chatType] = []
    var socket: SocketIOClient!
    
    let id = "1"
    var roomList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.socket = SocketIOManager.shared.socket
//        SocketIOManager.shared.establishConnection(roomId: "") {
//            print("set socket")
//        }
//        bindMsg()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SocketIOManager.shared.closeConnection()
    }
    
//    func registerSockect() {
//        socketClient.openSocketWithURLRequest(
//            request: NSURLRequest(url: url),
//            delegate: self,
//            connectionHeaders: [ "X-AUTH-TOKEN" : accessToken ]
//        )
//    }
    
    func subscribe() {
        socketClient.subscribe(destination: "[subscribe prefix]/[Destination]")
    }
    
//    func sendMessage() {
//        var payloadObject : [String : Any] = [ Key 1 : Value 1 , ... , Key N, Value N ]
//        
//        socketClient.sendJSONForDict(
//            dict: payloadObject as AnyObject,
//            toDestination: "[publish prefix]/[publish url]")
//    }
    
    func disconnect() {
        socketClient.disconnect()
    }
    
    func bindMsg() {
        self.socket.on("chat-msg") { (dataArray, socketAck) in
         print("***************************************")
         print(dataArray)
         print(type(of: dataArray))
         let data = dataArray[0] as! NSDictionary
         let name = data["name"] as! String
         let msg = data["message"] as! String
         
         print("name: \(name), msg: \(msg) 통신!")
        }
    }
    
    @IBAction func connectSocket(_ sender: Any) {
        chatService.createChatRoom(senderName: "Sender") { chatRoomResponse in
                guard let chatRoomResponse = chatRoomResponse else {
                    print("Failed to create chat room or parse response")
                    return
                }
                
                print("Chat Room ID: \(chatRoomResponse.roomId)")
                // Now you have the roomId and other details, you can proceed with further actions
            }

    }
    
    @IBAction func disconnectSocket(_ sender: Any) {
        connectChat.connectToChat(with: "742e2bd5-9489-4001-8c48-c9969ad22242", sender: "Sender")
    }
    
    @IBAction func Send_Tapped(_ sender: Any) {
        connectChat.receiveMessage()
    }
}

extension ChattingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "room", for: indexPath)
//        cell.textLabel?.text = roomList[indexPath.row]
        return cell
    }
}

extension ChattingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let roomText = roomList[indexPath.row]
        
//        SocketIOManager.shared.establishConnection(room: roomText) {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatSocketVC") as? ChatSocketViewController else { return }

            self.navigationController?.pushViewController(nextVC, animated: true)
//        }
    }
}
