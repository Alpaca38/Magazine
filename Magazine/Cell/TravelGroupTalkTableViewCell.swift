//
//  TravelGroupTalkTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit
import Kingfisher

class TravelGroupTalkTableViewCell: UITableViewCell {

    @IBOutlet var customView: UIView!
    @IBOutlet var firstProfileImageView: UIImageView!
    @IBOutlet var secondProfileImageView: UIImageView!
    @IBOutlet var thirdProfileImageView: UIImageView!
    @IBOutlet var fourthProfileImageView: UIImageView!
    @IBOutlet var chatRoomNameLabel: UILabel!
    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    lazy var imageViews = [firstProfileImageView, secondProfileImageView, thirdProfileImageView, fourthProfileImageView]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        imageViews.forEach {
            $0?.layer.cornerRadius = ($0?.frame.width)! / 2
            $0?.contentMode = .scaleAspectFill
            $0?.backgroundColor = .darkGray
        }
        
        chatRoomNameLabel.font = UILabel.boldFont
        
        chatLabel.font = UILabel.contentsFont
        chatLabel.textColor = .lightGray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
    }
    
    func configure(data: ChatRoom) {
        for (index, imageView) in imageViews.enumerated() {
            setImage(imageView: imageView!, url: data.chatroomImage[index])
        }
        
        chatRoomNameLabel.text = data.chatroomName
        
        chatLabel.text = data.chatList.last?.message
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let dateString = data.chatList.last?.date, let date = formatter.date(from: dateString) else { return }
        dateLabel.text = date.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko_KR")))
    }
    
    func setImage(imageView: UIImageView, url: String) {
        let url = URL(string: url)
        imageView.kf.setImage(with: url)
    }
}
