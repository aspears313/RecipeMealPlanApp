//
//  DescriptionViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddDescriptionViewController: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var newRecipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = newRecipe!.name!
        
        nextBtn.layer.cornerRadius = nextBtn.frame.height / 2.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddIngredientsVC", sender: self)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddIngredientsVC" {
            let addIngredientsVC = segue.destination as! AddIngredientsViewController
            addIngredientsVC.newRecipe = self.newRecipe!
        }
    }
    

}
