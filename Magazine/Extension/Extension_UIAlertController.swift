//
//  Extension_UIAlertController.swift
//  Magazine
//
//  Created by 조규연 on 5/30/24.
//

import UIKit

extension UIAlertController {
    func addActions(actions: [UIAlertAction]) {
        actions.forEach {
            self.addAction($0)
        }
    }
}
