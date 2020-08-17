//
//  AddDirectionsViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 2/29/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddDirectionsViewController: UIViewController {

    @IBOutlet weak var doneBtn: UIButton!
    
    var newRecipe: Recipe?
    var newIngredients: [Ingredients] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = newRecipe!.name!
        
        doneBtn.layer.cornerRadius = doneBtn.frame.height / 2.0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
