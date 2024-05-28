//
//  MagazineTableViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {

    var list = MagazineInfo.magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 507
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.identifier, for: indexPath) as! MagazineTableViewCell

        cell.configure(list[indexPath.row])

        return cell
    }
}
