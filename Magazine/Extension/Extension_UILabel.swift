//
//  Extension_UILabel.swift
//  Magazine
//
//  Created by 조규연 on 5/30/24.
//

import UIKit

extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
    
    static var titleFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    static var boldFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    
    static var contentsFont: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
}
