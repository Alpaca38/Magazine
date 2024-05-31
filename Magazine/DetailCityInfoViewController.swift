//
//  DetailCityInfoViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/27/24.
//

import UIKit

class DetailCityInfoViewController: UIViewController {

    @IBOutlet var detailTableView: UITableView!
    
    var list = TravelInfo.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
    }
    
    func configureTableView() {
        let nib = UINib(nibName: TouristSpotTableViewCell.identifier, bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: TouristSpotTableViewCell.identifier)
        let nib2 = UINib(nibName: AdTableViewCell.identifier, bundle: nil)
        detailTableView.register(nib2, forCellReuseIdentifier: AdTableViewCell.identifier)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    @objc func likeButtonTapped(sender: UIButton) {
        list[sender.tag].like?.toggle()
        detailTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }

}

extension DetailCityInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        if data.ad {
            let vc = storyboard?.instantiateViewController(identifier: AdViewController.identifier) as! AdViewController
            vc.info = data.title
            let navi = UINavigationController(rootViewController: vc)
            navi.modalPresentationStyle = .fullScreen
            present(navi, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(identifier: SpotViewController.identifier) as! SpotViewController
            vc.data = data
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension DetailCityInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let touristSpotCell = tableView.dequeueReusableCell(withIdentifier: TouristSpotTableViewCell.identifier, for: indexPath) as! TouristSpotTableViewCell
        let adCell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
        
        let data = list[indexPath.row]
        
        if data.ad {
            adCell.configure(data: data)
            
            return adCell
        } else {
            touristSpotCell.configure(data: data)
            touristSpotCell.likeButton.tag = indexPath.row
            touristSpotCell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return touristSpotCell
        }
    }
}
