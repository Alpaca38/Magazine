//
//  RestaurantTableViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    var list = RestaurantList.restaurantArray
    var filteredList: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 146
        
        let map = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
        navigationItem.rightBarButtonItem = map
        
        searchTextField.placeholder = "검색어를 입력해주세요. (ex. 한식, 분식, 만원 이하)"
        searchTextField.addTarget(self, action: #selector(searchButtonTapped), for: .editingDidEndOnExit)
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        filteredList = list

    }
    
    @objc func mapButtonTapped() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchButtonTapped() {
        if searchTextField.text == "만원 이하" {
            filteredList = list.filter({ $0.price <= 10000 })
        } else if searchTextField.text == "" {
            filteredList = list
            showAlert(title: "검색어를 입력하지 않았습니다.", message: "검색어를 입력해주세요.", style: .alert)
        } else {
            filteredList = list.filter({ $0.name.contains(searchTextField.text!) || $0.category.contains(searchTextField.text!) })
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath) as! RestaurantTableViewCell
        
        let data = filteredList[indexPath.row]
        
        cell.configure(data: data)
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        filteredList[sender.tag].isliked.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }

}
