//
//  UITableView Extension.swift
//  HereWeGo
//
//  Created by Finesse on 10.02.2023.
//

import UIKit

extension UITableView {
     public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}
