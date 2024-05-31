//
//  RestaurantTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configure(data: Restaurant) {
        let url = URL(string: data.image)
        restaurantImageView.kf.setImage(with: url)
        
        titleLabel.text = data.name
        
        addressLabel.text = data.address
        
        phoneNumberLabel.text = data.phoneNumber
        
        priceLabel.text = data.price.formatted(.currency(code: "krw"))
        
        categoryLabel.text = data.category
        
        let imageName = data.isliked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func configureLayout() {
        restaurantImageView.contentMode = .scaleAspectFill
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        addressLabel.numberOfLines = 0
        addressLabel.font = .systemFont(ofSize: 14)
        phoneNumberLabel.font = .systemFont(ofSize: 16)
        priceLabel.font = .systemFont(ofSize: 16)
        categoryLabel.font = .systemFont(ofSize: 16)
    }
}
