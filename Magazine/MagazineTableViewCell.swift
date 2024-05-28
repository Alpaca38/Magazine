//
//  MagazineTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = 10
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .gray
        
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = .lightGray
        
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .lightGray
    }
    
    func configure(_ data: Magazine) {
        let url = URL(string: data.photo_image)
        photoImageView.kf.setImage(with: url)
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        let date = data.date.toDate()
        let dateString = date?.format()
        dateLabel.text = dateString
    }
}
