//
//  RecipeCollectionViewCell.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 12/8/20.
//  Copyright © 2020 Anthony. All rights reserved.
//
import Foundation
import UIKit
import CollectionViewSlantedLayout

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0

class RecipeCollectionViewCell: CollectionViewSlantedCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    private var gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let backgroundView = backgroundView {
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.frame = backgroundView.bounds
            backgroundView.layer.addSublayer(gradient)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let backgroundView = backgroundView {
            gradient.frame = backgroundView.bounds
        }
    }
    
    var image: UIImage = UIImage() {
        didSet {
            recipeImage.image = image
        }
    }
    
    var imageHeight: CGFloat {
        return (recipeImage.image?.size.height) ?? 0.0
    }

    var imageWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    func offset(_ offset: CGPoint) {
        recipeImage.frame = recipeImage.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
    
//    let cellView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
//    let recipeImage: UIImageView = {
//        let image = UIImageView()
//        image.clipsToBounds = true
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//
//    let recipeName: UILabel = {
//        let label = UILabel()
//        label.text = "Recipes"
//        label.textColor = .black
//        label.adjustsFontSizeToFitWidth = true
//        label.font = UIFont.boldSystemFont(ofSize: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    

