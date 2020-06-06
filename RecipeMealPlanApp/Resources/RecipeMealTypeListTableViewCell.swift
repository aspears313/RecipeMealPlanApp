//
//  RecipeMealTypeListTableViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 5/1/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class RecipeMealTypeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var nameOfRecipeCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
