//
//  TouristSpotTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/27/24.
//

import UIKit
import Kingfisher
import Cosmos

class TouristSpotTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        mainImageView.layer.cornerRadius = 5
        mainImageView.contentMode = .scaleAspectFill
        ratingView.settings.fillMode = .precise
        ratingView.settings.starSize = 15
        
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func configure(data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        ratingView.rating = data.grade!
        ratingView.text = "· 저장 \(data.save!.formatted())"
        let url = URL(string: data.travel_image!)
        mainImageView.kf.setImage(with: url)
        let imageName = data.like! ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likeButton.tintColor = .systemRed
    }
}
