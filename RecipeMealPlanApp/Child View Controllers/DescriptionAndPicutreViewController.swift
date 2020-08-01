//
//  DescriptionViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class DescriptionAndPicutreViewController: UIViewController {
    
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
        
        if let description = recipe?.recipeDescription {
            recipeDescription.text = description
        } else {
            recipeDescription.text = "No description available."
        }
        
        //recipePic.layer.cornerRadius = recipePic.frame.size.width / 2
        recipePic.clipsToBounds = true

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
