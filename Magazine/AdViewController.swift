//
//  AdViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/29/24.
//

import UIKit

class AdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavi(title: "광고 화면")
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }

}
