//
//  TravelTalkViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit

class TravelTalkViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var list = ChatRoomList.mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavi(title: "Travel Talk")
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
        
        let nib2 = UINib(nibName: TravelGroupTalkTableViewCell.identifier, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: TravelGroupTalkTableViewCell.identifier)
    }
    
}

extension TravelTalkViewController: UITableViewDelegate {
    
}

extension TravelTalkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list[indexPath.row]
        
        if data.chatroomImage.count != 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelGroupTalkTableViewCell.identifier, for: indexPath) as! TravelGroupTalkTableViewCell
            cell.configure(data: data)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTalkTableViewCell.identifier, for: indexPath) as! TravelTalkTableViewCell
            cell.configure(data: data)
            
            return cell
        }
    }
    
    
}
