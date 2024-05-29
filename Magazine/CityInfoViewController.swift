//
//  CityInfoViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    
    let list = CityInfo.city

    @IBOutlet var searchCityBar: UISearchBar!
    @IBOutlet var categorySegControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavi(title: "인기 도시")

        configureTableView()
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "CityInfoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityInfoTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = view.frame.height / 6
        
    }
    
}

extension CityInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityInfoTableViewCell", for: indexPath) as! CityInfoTableViewCell
        cell.configure(data: list[indexPath.row])
        
        return cell
    }
    
    
}

extension CityInfoViewController: UITableViewDelegate {
    
}
