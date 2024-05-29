//
//  Extension_UIViewController.swift
//  Magazine
//
//  Created by 조규연 on 5/27/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let check = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(check)
        
        present(alert, animated: true)
    }
    
    func configureNavi(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .black
    }
}
