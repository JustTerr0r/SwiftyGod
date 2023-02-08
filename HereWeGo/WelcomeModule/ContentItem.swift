//
//  ContentItem.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//

import UIKit

struct MenuItem {
    let type: MenuItemType
    let text: String
    let image: UIImage?
}

enum MenuItemType {
    case casual
    case withEmoji
}
