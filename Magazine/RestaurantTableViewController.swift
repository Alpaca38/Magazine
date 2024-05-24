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
    
    var list = RestaurantList().restaurantArray
    var filteredList: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 146
        
        searchTextField.placeholder = "검색어를 입력해주세요. (ex. 한식, 분식, 만원 이하)"
        searchTextField.addTarget(self, action: #selector(searchButtonTapped), for: .editingDidEndOnExit)
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        filteredList = list

    }
    
    @objc func searchButtonTapped() {
        if list.contains(where: { $0.category == searchTextField.text }) {
            filteredList = list.filter({ $0.category == searchTextField.text })
        } else if searchTextField.text == "만원 이하"{
            filteredList = list.filter({ $0.price <= 10000 })
        } else if searchTextField.text == "" {
            filteredList = list
            showAlert(title: "검색어를 입력하지 않았습니다.", message: "검색어를 입력해주세요.")
        } else {
            filteredList = list
            showAlert(title: "존재하지 않는 카테고리 입니다.", message: "다시 입력해주세요.")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let data = filteredList[indexPath.row]
        let url = URL(string: data.image)
        cell.restaurantImageView.kf.setImage(with: url)
        cell.restaurantImageView.contentMode = .scaleAspectFill
        
        cell.titleLabel.text = data.name
        cell.titleLabel.font = .boldSystemFont(ofSize: 16)
        cell.titleLabel.numberOfLines = 0
        
        cell.addressLabel.text = data.address
        cell.addressLabel.numberOfLines = 0
        cell.addressLabel.font = .systemFont(ofSize: 14)
        
        cell.phoneNumberLabel.text = data.phoneNumber
        cell.phoneNumberLabel.font = .systemFont(ofSize: 16)

        cell.priceLabel.text = data.price.formatted(.currency(code: "krw"))
        cell.priceLabel.font = .systemFont(ofSize: 16)

        cell.categoryLabel.text = data.category
        cell.categoryLabel.font = .systemFont(ofSize: 16)

        
        let imageName = data.isliked ? "heart.fill" : "heart"
        cell.likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        filteredList[sender.tag].isliked.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let check = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(check)
        
        present(alert, animated: true)
    }

}
