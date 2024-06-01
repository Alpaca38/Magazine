//
//  ChatViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var data: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi(title: data!.chatroomName)
        addSeparatorCell()
        configureTableView()
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            tableView.scrollToRow(at: IndexPath(row: data!.chatList.count - 1, section: 0), at: .bottom, animated: false)
        }
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
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as! MyChatTableViewCell
                cell.configure(data: data)
                
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatTableViewCell.identifier, for: indexPath) as! OtherChatTableViewCell
            cell.configure(data: data)
            
            return cell
        }
    }
}
