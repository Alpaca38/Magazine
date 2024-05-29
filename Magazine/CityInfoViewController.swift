//
//  CityInfoViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {
    
    var list = CityInfo.city
    var filteredList: [City] = []

    @IBOutlet var searchCityBar: UISearchBar!
    @IBOutlet var categorySegControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredList = list
        
        configureNavi(title: "인기 도시")

        configureTableView()
        
        configureSegment()
    }
    
    func configureSegment() {
        let categorys = ["모두","국내","해외"]
        
        for (index, category) in categorys.enumerated() {
            categorySegControl.setTitle(category, forSegmentAt: index)
        }
        
        categorySegControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filteredList = list
            tableView.reloadData()
        case 1:
            filteredList = list.filter({ $0.domestic_travel == true })
            tableView.reloadData()
        case 2:
            filteredList = list.filter({ $0.domestic_travel == false })
            tableView.reloadData()
        default:
            return
        }
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
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityInfoTableViewCell", for: indexPath) as! CityInfoTableViewCell
        cell.configure(data: filteredList[indexPath.row])
        
        return cell
    }
    
    
}

extension CityInfoViewController: UITableViewDelegate {
    
}
