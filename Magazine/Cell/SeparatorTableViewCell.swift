//
//  SeparatorTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 6/1/24.
//

import UIKit

class SeparatorTableViewCell: UITableViewCell {

    @IBOutlet var separatorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorLabel.textAlignment = .center
        separatorLabel.textColor = .white
        separatorLabel.font = .systemFont(ofSize: 14)
        separatorLabel.clipsToBounds = true
        separatorLabel.layer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        separatorLabel.layer.cornerRadius = 8
        
        
    }
    
    func configure(data: Chat) {
        separatorLabel.text = data.message
    }
    
}
