//
//  CityInfoTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/29/24.
//

import UIKit
import Kingfisher
import SwiftUI

class CityInfoTableViewCell: UITableViewCell {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityTitleLabel: UILabel!
    @IBOutlet var cityExplainLabel: BasePaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
    }
    
    func configureLayout() {
        cityImageView.layer.cornerRadius = 20
        cityImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        cityImageView.contentMode = .scaleAspectFill
        
        cityTitleLabel.font = .boldSystemFont(ofSize: 21)
        cityTitleLabel.textColor = .white
        
        cityExplainLabel.font = .systemFont(ofSize: 16)
        cityExplainLabel.textColor = .white
        cityExplainLabel.clipsToBounds = true
        cityExplainLabel.backgroundColor = .black.withAlphaComponent(0.5)
        cityExplainLabel.layer.maskedCorners = [.layerMaxXMaxYCorner]
        cityExplainLabel.layer.cornerRadius = 10
        
    }
    
    func configure(data: City) {
        let url = URL(string: data.city_image)
        cityImageView.kf.setImage(with: url)
        
        cityTitleLabel.text = data.cityTitle
        
        cityExplainLabel.text = data.city_explain
    }
    
}
