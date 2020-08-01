//
//  NameOfRecipeViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 3/5/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import CoreData

class AddNameOfRecipeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var selectMealTypeBtn: UIButton!
    @IBOutlet var mealTypeChoices: [UIButton]!
    
    @IBOutlet weak var nameOfRecipeTextField: UITextField!
    @IBOutlet weak var nextToAddPhotoViewBtn: UIButton!
    
    let mealType = ["Breakfast","Lunch","Dinner","Snack","Dessert","Side Dish"]
    var recipeTitle = "Your Recipe Name"
    let context = CoreDataStack.init(modelName: "RecipeMealPlanApp").mainContext
 
    var selectedMealType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setView()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)

        nextToAddPhotoViewBtn.isHidden = true
        nextToAddPhotoViewBtn.layer.cornerRadius = nextToAddPhotoViewBtn.frame.height / 2.0
        selectMealTypeBtn.layer.cornerRadius = selectMealTypeBtn.frame.height / 2.0
        selectMealTypeBtn.titleLabel?.textAlignment = .center
        
        mealTypeChoices.forEach { (mealTypeBtn) in
            mealTypeBtn.layer.cornerRadius = mealTypeBtn.frame.height / 2.0
            mealTypeBtn.isHidden = true
        }
        //self.navigationItem.title = recipeTitle
        //setNavigationBar()

        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = recipeTitle
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
        nameOfRecipeTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    private func setNavigationBar() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = recipeTitle
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
        hideKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        hideKeyboard()
        return true
    }
     
    func hideKeyboard() {
        if let text = nameOfRecipeTextField.text, text.isEmpty {
            nextToAddPhotoViewBtn.isHidden = true
        } else {
//            nextToAddPhotoViewBtn.isHidden = false
            recipeTitle = nameOfRecipeTextField.text!.capitalized
            setNavigationBar()
            nameOfRecipeTextField.resignFirstResponder()
        }
    }
    
    @IBAction func selectMealTypeBtnClicked(_ sender: Any) {
        mealTypeChoices.forEach{ (mealTypeBtn) in
            UIView.animate(withDuration: 0.4, animations: {
                mealTypeBtn.isHidden = !mealTypeBtn.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func mealTypeBtnClicked(_ sender: UIButton) {
        if let btnlabel = sender.titleLabel?.text {
            selectedMealType = btnlabel
            selectMealTypeBtn.titleLabel?.text = selectedMealType
            nextToAddPhotoViewBtn.isHidden = false
        
            mealTypeChoices.forEach{ (mealTypeBtn) in
                UIView.animate(withDuration: 0.4, animations: {
                    mealTypeBtn.isHidden = !mealTypeBtn.isHidden
                })
            }
        }
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
            performSegue(withIdentifier: "toAddPhotoVC", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddPhotoVC" {
            let newRecipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: context) as! Recipe
            newRecipe.name = recipeTitle
            newRecipe.mealType = selectedMealType
            
            let addPhotoVC = segue.destination as! AddPhotoViewController
            addPhotoVC.newRecipe = newRecipe
        }
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action:UIAlertAction!) in
                print("Ok button tapped")
            }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIFont {
    var bold: UIFont {
        return with(.traitBold)
    }
    
    var italic: UIFont {
        return with(.traitItalic)
    }
    
    var boldItalic: UIFont {
        return with([.traitBold, .traitItalic])
    }
    
    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(self.fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits))) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
}
