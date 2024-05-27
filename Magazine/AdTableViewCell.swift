//
//  AdTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/27/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var adButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    func configureLayout() {
        self.contentView.layer.cornerRadius = 8
        self.contentView.backgroundColor = UIColor().random()
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        adButton.tintColor = .black
        adButton.layer.cornerRadius = 8
        adButton.backgroundColor = .white
    }
    
    func configure(data: Travel) {
        titleLabel.text = data.title
    }
}