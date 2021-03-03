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
    var recipeViewModel: RecipeViewModel! {
        didSet {
            recipeLabel.text = recipeViewModel.name
            recipeImage.image = recipeViewModel.image
        }
    }
    
    let containerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "No photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Name"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "HelveticaNeue-bold", size: 26)
//        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    var recipe: Recipe? {
//        didSet {
//            if let image = recipe?.image {
//                recipeImage.image = UIImage(data: image)
//            }
//            recipeLabel.text = recipe?.name
//        }
//    }
    
//    var recipeViewModel: RecipeViewModel? {
//        didSet {
//            recipeLabel.text = recipeViewModel?.name
//            recipeImage.image = recipeViewModel?.image
//            
//        }
//    }
    
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
        containerView.addSubview(recipeImage)
        containerView.addSubview(labelView)
        labelView.addSubview(recipeLabel)
        
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        recipeImage.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        recipeImage.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        recipeImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        recipeImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        labelView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        labelView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        recipeLabel.leftAnchor.constraint(equalTo: labelView.leftAnchor).isActive = true
        recipeLabel.rightAnchor.constraint(equalTo: labelView.rightAnchor).isActive = true
        recipeLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor).isActive = true
        recipeLabel.topAnchor.constraint(equalTo: labelView.topAnchor).isActive = true
        
//        recipeLabel.leftAnchor.constraint(equalTo:
//                                            containerView.leftAnchor).isActive = true
//        r.rightAnchor.constraint(equalTo:
//                                            containerView.rightAnchor).isActive = true
//        recipeName.bottomAnchor.constraint(equalTo:
//                                            containerView.bottomAnchor).isActive = true
//        recipeName.heightAnchor.constraint(equalToConstant: (containerView.heightAnchor / 4.0)).isActive = true
        
        
    }
}
