//
//  DescriptionViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddDescriptionViewController: UIViewController {
    
    var recipeTitle: String = ""
    var recipePicture: UIImageView?
    var selectedMealType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = recipeTitle
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddIngredientsVC", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAddIngredientsVC" {
            let addIngredientsVC = segue.destination as! AddIngredientsViewController
            addIngredientsVC.recipeTitle = self.recipeTitle
            addIngredientsVC.recipePicture = self.recipePicture
            addIngredientsVC.selectedMealType = self.selectedMealType
        }
    }
    

}
