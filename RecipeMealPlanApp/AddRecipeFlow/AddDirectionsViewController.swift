//
//  AddDirectionsViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 2/29/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddDirectionsViewController: UIViewController {

    var recipeTitle: String = ""
    var recipePicture: UIImageView?
    var listOfIngredients: [String] = []
    var selectedMealType: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = recipeTitle
        // Do any additional setup after loading the view.
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
