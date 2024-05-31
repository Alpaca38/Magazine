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
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: OtherChatTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: OtherChatTableViewCell.identifier)
        
        let nib2 = UINib(nibName: MyChatTableViewCell.identifier, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: MyChatTableViewCell.identifier)
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as! MyChatTableViewCell
            cell.configure(data: data)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatTableViewCell.identifier, for: indexPath) as! OtherChatTableViewCell
            cell.configure(data: data)
            
            return cell
        }
    }
}
