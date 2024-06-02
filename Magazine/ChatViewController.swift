//
//  ChatViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextView: UITextView!
    @IBOutlet var sendButton: UIButton!
    
    var data: ChatRoom?
    
    let placeholder = "메세지를 입력하세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi(title: data!.chatroomName)
        addSeparatorCell()
        configureTableView()
        configureTextView()
        configureButton()
        showTableViewBottom()
        
    }
    
    func showTableViewBottom() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            tableView.scrollToRow(at: IndexPath(row: data!.chatList.count - 1, section: 0), at: .bottom, animated: false)
        }
    }
    
    func configureButton() {
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.tintColor = .lightGray
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc func sendButtonTapped() {
        if messageTextView.textColor == .black {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: Date())
            data!.chatList.append(Chat(user: User.user, date: dateString, message: messageTextView.text))
            messageTextView.text = nil
            tableView.reloadData()
            showTableViewBottom()
        }
    }
    
    func configureTextView() {
        messageTextView.delegate = self
        messageTextView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        messageTextView.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 38)
        messageTextView.clipsToBounds = true
        messageTextView.layer.cornerRadius = 5
        messageTextView.text = placeholder
        messageTextView.textColor = .lightGray
    }
    
    func addSeparatorCell() {
        for i in 1...data!.chatList.count - 1 {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            let dateString = data!.chatList[i].date
            let previousDateString = data!.chatList[i - 1].date
            guard let date = formatter.date(from: dateString), let previousDate = formatter.date(from: previousDateString) else { return }
            
            let calendar = Calendar.current
            if !calendar.isDate(date, inSameDayAs: previousDate) {
                let separatorMessage = date.formatted(.dateTime.year(.extended()).month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko_KR")))
                data!.chatList.insert(Chat(user: User.user, date: "dayChange", message: separatorMessage), at: i)
            }
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: OtherChatTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: OtherChatTableViewCell.identifier)
        
        let nib2 = UINib(nibName: MyChatTableViewCell.identifier, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        
        let nib3 = UINib(nibName: SeparatorTableViewCell.identifier, bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: SeparatorTableViewCell.identifier)
        
        tableView.separatorStyle = .none
    }
    
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        showTableViewBottom()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let minHeight: CGFloat = 48
        let maxHeight: CGFloat = 88
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach {
            if estimatedSize.height <= minHeight {
                $0.constant = minHeight
            } else if estimatedSize.height <= maxHeight {
                $0.constant = estimatedSize.height
            } else {
                $0.constant = maxHeight
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data!.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = self.data!.chatList[indexPath.row]
        
        if data.user == .user {
            if data.date == "dayChange" {
                let cell = tableView.dequeueReusableCell(withIdentifier: SeparatorTableViewCell.identifier, for: indexPath) as! SeparatorTableViewCell
                cell.configure(data: data)
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as! MyChatTableViewCell
                cell.configure(data: data)
                cell.selectionStyle = .none
                
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatTableViewCell.identifier, for: indexPath) as! OtherChatTableViewCell
            cell.configure(data: data)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
}
