//
//  RecipeListTableViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 1/1/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class ListedRecipesTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 25.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let recipeImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25.0
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "No photo")
        return image
    }()
    
    let recipeName: UILabel = {
        let label = UILabel()
        label.text = "Recipe 1"
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        addSubview(cellView)
        cellView.addSubview(recipeName)
        cellView.addSubview(recipeImage)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        recipeImage.widthAnchor.constraint(equalToConstant: 66).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 66).isActive = true
        recipeImage.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10).isActive = true
        recipeImage.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        
        recipeName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 90).isActive = true
        recipeName.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        recipeName.heightAnchor.constraint(equalToConstant: 56).isActive = true
        recipeName.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        
    }
}


