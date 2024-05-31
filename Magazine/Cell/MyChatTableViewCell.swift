//
//  OtherChatTableViewCell.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet var chatLabel: PaddingLabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        chatLabel.font = UILabel.contentsFont
        chatLabel.layer.borderWidth = 1
        chatLabel.layer.borderColor = UIColor.lightGray.cgColor
        chatLabel.layer.cornerRadius = 8
        chatLabel.numberOfLines = 0
        chatLabel.backgroundColor = .lightGray.withAlphaComponent(0.5)
        chatLabel.clipsToBounds = true
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
    }
    
    func configure(data: Chat) {
        chatLabel.text = data.message
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString = data.date
        guard let date = formatter.date(from: dateString) else { return }
        
        dateLabel.text = date.formatted(.dateTime.hour().minute().locale(Locale(identifier: "ko_KR")))
    }
    
}
