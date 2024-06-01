//
//  MyChatTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit
//import Kingfisher

class OtherChatTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var chatLabel: PaddingLabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.backgroundColor = .darkGray
        
        userLabel.font = UILabel.contentsFont
        
        chatLabel.font = UILabel.contentsFont
        chatLabel.layer.borderWidth = 1
        chatLabel.layer.borderColor = UIColor.lightGray.cgColor
        chatLabel.layer.cornerRadius = 8
        chatLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
    }
    
    func configure(data: Chat) {
//        let url = URL(string: data.user.profileImage)
//        profileImageView.kf.setImage(with: url)
        profileImageView.image = UIImage(named: data.user.profileImage)
        
        userLabel.text = data.user.rawValue
        
        chatLabel.text = data.message
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString = data.date
        guard let date = formatter.date(from: dateString) else { return }
        
        dateLabel.text = date.formatted(.dateTime.hour().minute().locale(Locale(identifier: "ko_KR")))
    }
    
}
