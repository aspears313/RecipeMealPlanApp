//
//  MealPlannerTableViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/11/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class MealPlannerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealTypeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
