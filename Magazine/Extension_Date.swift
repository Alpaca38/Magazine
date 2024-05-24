//
//  Extension_Date.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        
        return formatter.string(from: self)
    }
}
