//
//  MainCell.swift
//  HereWeGo
//
//  Created by Finesse on 07.02.2023.
//

import UIKit
import SwiftyGif


class MainCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private var cellLabel: UILabel!
    @IBOutlet private var cellImage: UIImageView!
    
    func configure(with text: String, indexPath: Int) {
        cellLabel.text = text
        setImage(with: indexPath)
    }
    
    private func setImage(with indexPath: Int) {
        guard cellImage.isHidden else {return}
        do {
            let gif = try UIImage(gifName: "\(indexPath).gif")
            let imageview = UIImageView(gifImage: gif)
            imageview.frame = cellImage.bounds
            cellImage.addSubview(imageview)
        } catch {
            print(error)
        }
        
        cellImage.isHidden = false
    }
}
