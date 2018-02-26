//
//  PetTableCell.swift
//  VetHelpIOS
//
//  Created by VetDev1 on 21.11.17.
//  Copyright © 2017 VetDev1. All rights reserved.
//

import UIKit

class PetTableCell: UITableViewCell {

    @IBOutlet weak var petnameTextView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
