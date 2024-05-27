//
//  TouristSpotTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/27/24.
//

import UIKit
import Kingfisher

class TouristSpotTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        scoreLabel.font = .systemFont(ofSize: 12)
        scoreLabel.textColor = .lightGray
        mainImageView.layer.cornerRadius = 5
        mainImageView.contentMode = .scaleAspectFill
    }
    
    func configure(data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        scoreLabel.text = "평점 \(data.grade!) · 저장 \(data.save!.formatted())"
        let url = URL(string: data.travel_image!)
        mainImageView.kf.setImage(with: url)
        let imageName = data.like! ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likeButton.tintColor = .systemRed
    }
}
