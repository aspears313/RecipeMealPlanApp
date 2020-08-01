//
//  IngredientsChildViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 2/23/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import Foundation
import UIKit

class IngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var ingredientListTableView: UITableView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ingredientListTableView.dataSource = self
        self.ingredientListTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.theseIngredients!.count)!
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cellIdentifier = "ingredientCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            let recipeIngredients = recipe?.theseIngredients?.allObjects
            
            if let ingredients = recipeIngredients as? [Ingredients] {
                cell.textLabel?.text = "\(ingredients[indexPath.row].measurement!) \(ingredients[indexPath.row].ingredientName!)"
                cell.textLabel?.textAlignment = .center
            } else {
                cell.textLabel?.text = "Wrong"
                cell.textLabel?.textAlignment = .center
            }
            return cell
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
}
