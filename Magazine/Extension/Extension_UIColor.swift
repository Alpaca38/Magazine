//
//  Extension_UIColor.swift
//  Magazine
//
//  Created by 조규연 on 5/27/24.
//

import UIKit

extension UIColor {
    func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
}
