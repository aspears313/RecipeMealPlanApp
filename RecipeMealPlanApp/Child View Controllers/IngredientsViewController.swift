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
    //var ingredients: [String] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ingredientListTableView.dataSource = self
        self.ingredientListTableView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredients!.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cellIdentifier = "ingredientCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            if let ingredients = recipe?.ingredients {
                cell.textLabel?.text = ingredients[indexPath.row]
                cell.textLabel?.textAlignment = .center
            } else {
                cell.textLabel?.text = "Wrong"
                cell.textLabel?.textAlignment = .center
            }
            
            //let ingredient = recipe?.ingredients?.allObjects
            
//            cell.textLabel?.text = ingredients[indexPath.row] as? String
//            cell.textLabel?.textAlignment = .center
            
            return cell
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    //}
    

}
