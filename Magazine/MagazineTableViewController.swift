//
//  MagazineTableViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {

    var list = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 507
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        
        let data = list[indexPath.row]
        
        let url = URL(string: data.photo_image)
        cell.photoImageView.kf.setImage(with: url)
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.photoImageView.layer.cornerRadius = 10
        
        cell.titleLabel.text = data.title
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.font = .boldSystemFont(ofSize: 24)
        cell.titleLabel.textColor = .gray
        
        cell.subtitleLabel.text = data.subtitle
        cell.subtitleLabel.font = .systemFont(ofSize: 16)
        cell.subtitleLabel.textColor = .lightGray
        
        let date = data.date.toDate()
        let dateString = date?.format()
        cell.dateLabel.text = dateString
        cell.dateLabel.font = .systemFont(ofSize: 14)
        cell.dateLabel.textColor = .lightGray
        
        return cell
    }
}