//
//  AdViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/29/24.
//

import UIKit

class AdViewController: UIViewController {

    @IBOutlet var infoLabel: UILabel!
    
    var info: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavi(title: "광고 화면")
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
        
        infoLabel.text = info
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.font = .boldSystemFont(ofSize: 24)
        
    }
    
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }

}
