//
//  RecipeViewModel.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 2/28/21.
//  Copyright © 2021 Anthony. All rights reserved.
//
import UIKit

struct RecipeViewModel: Hashable {
    
    let name: String
    let image: UIImage
    
    //Dependency Injection
    init(recipe: Recipe) {
        self.name = recipe.name!
        if recipe.image == nil {
            self.image = UIImage(named: "No photo")!
        } else {
            self.image = UIImage(data: recipe.image!)!
        }
        //self.image = UIImage(data: recipe.image!) ?? UIImage(named: "No photo")!
    }

}
