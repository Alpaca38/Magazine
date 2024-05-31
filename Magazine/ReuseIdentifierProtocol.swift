//
//  ReuseIdentifierProtocol.swift
//  Magazine
//
//  Created by 조규연 on 5/31/24.
//

import UIKit
// 프로토콜을 이용하면 수십명이 협업할 때 큰 도움이 된다
protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
