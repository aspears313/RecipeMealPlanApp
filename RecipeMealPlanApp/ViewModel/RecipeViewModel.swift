//
//  RecipeViewModel.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 2/28/21.
//  Copyright © 2021 Anthony. All rights reserved.
//
import UIKit

struct RecipeViewModel {
    
    let name: String
    let image: UIImage
    
    //Dependency Injection
    init(recipe: Recipe) {
        self.name = recipe.name!
        self.image = UIImage(data: recipe.image!) ?? UIImage(named: "No photo")!
    }
}
