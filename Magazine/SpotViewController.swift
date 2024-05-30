//
//  SpotViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/29/24.
//

import UIKit
import Cosmos
import Kingfisher

class SpotViewController: UIViewController {
    
    var data: Travel?

    @IBOutlet var detailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var ratingView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavi(title: "관광지 화면")
        configureView()
    }
    
    func configureView() {
        guard let data else { return }
        
        let url = URL(string: data.travel_image!)
        detailImageView.kf.setImage(with: url)
        detailImageView.contentMode = .scaleAspectFill
        
        titleLabel.text = data.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        descriptionLabel.text = data.description
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.numberOfLines = 0
        
        ratingView.settings.starSize = 15
        ratingView.rating = data.grade!
        ratingView.text = data.saveText
    }

}
