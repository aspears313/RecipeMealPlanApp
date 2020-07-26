//
//  MealTypeTableViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/26/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class MealTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
