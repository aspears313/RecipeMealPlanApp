//
//  IngredientsListTableViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 8/14/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class IngredientsListTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 25.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredient 1"
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(ingredientLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        ingredientLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        ingredientLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        ingredientLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        ingredientLabel.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }

}
