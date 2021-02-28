//
//  RecipeCollectionViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 12/8/20.
//  Copyright © 2020 Anthony. All rights reserved.
//
import UIKit

class RecipeCell: UICollectionViewCell/*CollectionViewSlantedCell*/ {
    
//    @IBOutlet weak var recipeImage: UIImageView!
//    @IBOutlet weak var recipeName: UILabel!
    let containerView = UIView()
    var recipeImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        addSubview(containerView)
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        recipeImage.image = UIImage(named: "No photo")
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.clipsToBounds = true
        containerView.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        recipeImage.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        recipeImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        recipeImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}
