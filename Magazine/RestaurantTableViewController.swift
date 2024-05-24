//
//  RestaurantTableViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var list = RestaurantList().restaurantArray

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 146

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        
        let data = list[indexPath.row]
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
        list[sender.tag].isliked.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }

}
