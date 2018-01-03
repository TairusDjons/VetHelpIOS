//
//  TagCellClass.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 11.12.17.
//  Copyright © 2017 VetDev1. All rights reserved./Users/vetdev1/Desktop/VetHelpIOS/VetHelpIOS/API
//

import Foundation
import UIKit
class TagCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!
    @IBOutlet weak var maxWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.tagName.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.layer.cornerRadius = 4
        self.maxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2 }
}
