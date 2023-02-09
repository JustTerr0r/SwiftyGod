//
//  MainCell.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//

import UIKit

class MainCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private var cellLabel: UILabel!
    @IBOutlet private var cellImage: UIImageView!
    
    func configure(with text: String) {
        cellLabel.text = text
    }
    
    func setImage(with image: UIImage){
        cellImage.isHidden = false
        cellImage.image = image
    }
}
