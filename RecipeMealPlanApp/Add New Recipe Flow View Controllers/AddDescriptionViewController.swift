//
//  DescriptionViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddDescriptionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var descriptionView: UITextView!
    
    var newRecipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setController()

//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = newRecipe!.name!
//
//        descriptionView.text = newRecipe?.recipeDescription
//
//        nextBtn.layer.cornerRadius = nextBtn.frame.height / 2.0
        // Do any additional setup after loading the view.
    }
    
    func setController() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = newRecipe!.name!
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        descriptionView.backgroundColor = .white
        descriptionView.text = "Your description here."
        descriptionView.textColor = UIColor.lightGray
        descriptionView.delegate = self
        descriptionView.textAlignment = .center
        descriptionView.layer.cornerRadius = 25.0
        descriptionView.layer.borderWidth = 2.0
        descriptionView.layer.borderColor = UIColor.red.cgColor
        descriptionView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        nextBtn.layer.cornerRadius = nextBtn.frame.height / 2.0
        
    }
    
    @objc func tapDone(sender: Any) {
        descriptionView.resignFirstResponder()
        self.view.endEditing(true)
        hideKeyboard()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
        hideKeyboard()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.text = "Your description here."
            textView.textColor = UIColor.lightGray
        } else {
            descriptionView.resignFirstResponder()
            self.view.endEditing(true)
            hideKeyboard()
        }
        return true
    }
    
    func hideKeyboard() {
        newRecipe?.recipeDescription = descriptionView.text
        //print(newRecipe!)
        descriptionView.resignFirstResponder()
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
