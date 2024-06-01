//
//  TravelTalkTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit
//import Kingfisher

class TravelTalkTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var chatRoomNameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.backgroundColor = .darkGray
        profileImageView.contentMode = .scaleAspectFill
        
        chatRoomNameLabel.font = UILabel.boldFont
        
        chatLabel.font = UILabel.contentsFont
        chatLabel.textColor = .lightGray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
    }
    
    func configure(data: ChatRoom) {
//        let url = URL(string: data.chatroomImage[0])
//        profileImageView.kf.setImage(with: url)
        profileImageView.image = UIImage(named: data.chatroomImage[0])
        
        chatRoomNameLabel.text = data.chatroomName
        
        chatLabel.text = data.chatList.last?.message
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let dateString = data.chatList.last?.date, let date = formatter.date(from: dateString) else { return }
        dateLabel.text = date.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko_KR")))
        
    }
}
