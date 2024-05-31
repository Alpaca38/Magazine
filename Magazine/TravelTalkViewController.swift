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
    var filteredList: [ChatRoom] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredList = list
        
        configureNavi(title: "Travel Talk")
        configureTableView()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: TravelTalkTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TravelTalkTableViewCell.identifier)
        
        let nib2 = UINib(nibName: TravelGroupTalkTableViewCell.identifier, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: TravelGroupTalkTableViewCell.identifier)
        
        tableView.separatorStyle = .none
    }
    
}

extension TravelTalkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = filteredList[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: ChatViewController.identifier) as! ChatViewController
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TravelTalkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = filteredList[indexPath.row]
        
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

extension TravelTalkViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        if text == "" {
            filteredList = list
        } else {
            filteredList = list.filter({ $0.chatroomName.compare(text) })
        }
    }
}
