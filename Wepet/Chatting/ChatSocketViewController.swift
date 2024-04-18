//
//  ChatSocketViewController.swift
//  Wepet
//
//  Created by jaegu park on 18/01/24.
//

import UIKit
import SocketIO

class ChatSocketViewController: UIViewController {
    
    @IBOutlet var ChatTableView: UITableView!
    @IBOutlet var ChatTextField: UITextField!
    @IBOutlet var ChatLayout: NSLayoutConstraint!
    
    var myChat: [chatType] = []
    var socket: SocketIOClient!
    
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.socket = SocketIOManager.shared.socket
        bindMsg()
        
        self.ChatTableView.delegate = self
        self.ChatTableView.dataSource = self
        
        initGestureRecognizer()
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        SocketIOManager.shared.closeConnection()
        unregisterForKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func bindMsg() {
        self.socket.on("test") { (dataArray, socketAck) in
            
            var chat = chatType()
            print("***************************************")
            print(type(of: dataArray))
            let data = dataArray[0] as! NSDictionary
            
            chat.type = data["type"] as! String
            chat.message = data["message"] as! String
            self.myChat.append(chat)
            print(chat)
            
            self.updateChat(count: self.myChat.count) {
                print("Get Message")
            }
        }
    }
    
    func updateChat( count: Int, completion: @escaping ()->Void ) {
        let indexPath = IndexPath( row: count-1, section: 0 )
        
        self.ChatTableView.beginUpdates()
        self.ChatTableView.insertRows(at: [indexPath], with: .none)
        self.ChatTableView.endUpdates()
        
        self.ChatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        
        // 필요한경우 escaping closure를 이용한 데이터 전달
        completion()
    }
    
    @IBAction func SendButton(_ sender: Any) {
        let text = self.ChatTextField.text!
        self.socket.emit("test", text)
                
        self.myChat.append(chatType(type: "TALK", message: text))
                
        self.updateChat(count: self.myChat.count) {
            print("Send Message")
        }
    }
}

struct chatType {
    var type = "TALK"
    var message = ""
}

extension ChatSocketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chat = myChat[indexPath.row]
        
        //좌우마진 122, 40이 최대값이므로 최댓값 가로길이는 아래와같음
        let widthOfText = view.frame.width - 122 - 40
        let size = CGSize(width: widthOfText, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let estimatedFrame = NSString(string: chat.message).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        // 위아래마진 14,14 + 여유공간 4
        return estimatedFrame.height + 14 + 14 + 4
    }
}
 

extension ChatSocketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellId = self.myChat[indexPath.row].type == "" ? "MyCell" : "YourCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChattingTableViewCell
        cell.chatLabel.text = self.myChat[indexPath.row].message
        return cell
    }
}

extension ChatSocketViewController {

    //GestureRecognizer 생성
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

    // observer생성
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //observer해제
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        //키보드의 동작시간 얻기
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        //키보드의 애니메이션종류 얻기
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        //키보드의 크기 얻기
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        //iOS11이상부터는 노치가 존재하기때문에 safeArea값을 고려
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        self.ChatLayout.constant = -self.keyboardHeight
        //키보드 높이만큼 inset조정
        self.ChatTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        if myChat.count > 0 {
            self.ChatTableView.scrollToRow(at: IndexPath(row: myChat.count-1, section: 0), at: .bottom, animated: false)
        }
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            //animation처럼 보이게하기
            self.view.layoutIfNeeded()
        })
        
        
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        // 원래대로 돌아가도록
        self.ChatLayout.constant = 0
        self.ChatTableView.contentInset = .zero
        self.view.setNeedsLayout()
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        })
        
    }
}
