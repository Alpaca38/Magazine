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
        configureSearchBar()
    }
    
    func configureSearchBar() {
        searchCityBar.delegate = self
    }
    
    func configureSegment() {
        let categorys = ["모두","국내","해외"]
        
        for (index, category) in categorys.enumerated() {
            categorySegControl.setTitle(category, forSegmentAt: index)
        }
        
        categorySegControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        guard let text = searchCityBar.text else {
            return
        }
        if text.isEmpty {
            switch sender.selectedSegmentIndex {
            case 0:
                filteredList = list
            case 1:
                filteredList = list.filter({$0.domestic_travel == true})
            case 2:
                filteredList = list.filter({$0.domestic_travel == false})
            default:
                return
            }
        } else {
            switch sender.selectedSegmentIndex {
            case 0:
                filteredList = list.filter({ $0.city_name.compare(text) || $0.city_english_name.compare(text) || $0.city_explain.compare(text)})
            case 1:
                filteredList = list.filter({ ($0.city_name.compare(text) || $0.city_english_name.compare(text) || $0.city_explain.compare(text)) && $0.domestic_travel == true})
            case 2:
                filteredList = list.filter({ ($0.city_name.compare(text) || $0.city_english_name.compare(text) || $0.city_explain.compare(text)) && $0.domestic_travel == false})
            default:
                return
            }
        }
        
        tableView.reloadData()
    }
    
    func configureTableView() {
        let nib = UINib(nibName: "CityInfoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CityInfoTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = view.frame.height / 6
        
    }
    
}

extension CityInfoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchCityBar.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        if text == "" {
            filteredList = list
        } else {
            switch categorySegControl.selectedSegmentIndex {
            case 0:
                filteredList = list.filter({ $0.city_name.compare(text) || $0.city_english_name.compare(text) || $0.city_explain.compare(text)})
            case 1:
                filteredList = list.filter({ ($0.city_name.compare(text) || $0.city_english_name.compare(text) || $0.city_explain.compare(text)) && $0.domestic_travel == true})
            case 2:
                filteredList = list.filter({ ($0.city_name.compare(text) || $0.city_english_name.compare(text) || $0.city_explain.compare(text)) && $0.domestic_travel == false})
            default:
                return
            }
        }
        tableView.reloadData()
    }
    
}

extension CityInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityInfoTableViewCell", for: indexPath) as! CityInfoTableViewCell
        let data = filteredList[indexPath.row]
        cell.configure(data: data)
        
        cell.cityTitleLabel.asColor(targetString: searchCityBar.text!, color: .yellow)
        cell.cityExplainLabel.asColor(targetString: searchCityBar.text!, color: .red)
        
        return cell
    }
    
    
}

extension CityInfoViewController: UITableViewDelegate {
    
}
