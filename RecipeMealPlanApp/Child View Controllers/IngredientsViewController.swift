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
        
    var recipe: Recipe?
    
    let ingredientListTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
    }
    
    func setTableView() {
        
        self.ingredientListTableView.dataSource = self
        self.ingredientListTableView.delegate = self
        
        ingredientListTableView.register(IngredientsListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(ingredientListTableView)
        
        NSLayoutConstraint.activate([
            ingredientListTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            ingredientListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ingredientListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            ingredientListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        ingredientListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        ingredientListTableView.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.theseIngredients!.count)!
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cellIdentifier = "Cell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! IngredientsListTableViewCell
            
            let recipeIngredients = recipe?.theseIngredients?.allObjects
            
            if let ingredient = recipeIngredients as? [Ingredients] {
                if let measure = ingredient[indexPath.row].measurement, let name = ingredient[indexPath.row].ingredientName {
                    cell.ingredientLabel.text = "\(measure) \(name)"
                    cell.ingredientLabel.textAlignment = .center
                }

            } else {
                cell.textLabel?.text = "No Ingredients"
                cell.textLabel?.textAlignment = .center
            }
            cell.backgroundColor = .white
            return cell
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
}
