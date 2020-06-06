//
//  DescriptionViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    @IBOutlet weak var recipePic: UIImageView!
    @IBOutlet weak var recipeDescription: UITextView!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = recipe?.image {
            recipePic.image = UIImage(data: image)
               } else {
            recipePic.image = UIImage(named: "No photo")
               }

        //recipePic.image = recipe?.image
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
