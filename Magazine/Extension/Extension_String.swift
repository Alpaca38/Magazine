//
//  Extension_String.swift
//  Magazine
//
//  Created by 조규연 on 5/24/24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let format = DateFormatter()
        format.dateFormat = "yyMMdd"
        
        if let date = format.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
    func compare(_ compare: String) -> Bool {
        
        return self.range(of: compare, options: .caseInsensitive) != nil
    }
}
