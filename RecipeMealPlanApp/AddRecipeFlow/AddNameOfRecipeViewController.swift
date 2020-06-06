//
//  NameOfRecipeViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 3/5/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddNameOfRecipeViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameOfRecipeTextField: UITextField!
    @IBOutlet weak var nextToAddPhotoViewBtn: UIButton!
    @IBOutlet weak var mealTypeTableView: UITableView!
    
    let mealType = ["Breakfast","Lunch","Dinner","Snack","Dessert","Side Dish"]
    var nameOfNewRecipe: String = ""
    var selectedMealType: String = ""
    var limit = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextToAddPhotoViewBtn.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Your Recipe Name"
        nameOfRecipeTextField.delegate = self
        mealTypeTableView.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
        //tabBarController?.tabBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        super.touchesBegan(touches, with: event)
        hideKeyboard()
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        hideKeyboard()
        return true
    }
     
    func hideKeyboard () {
        if let text = nameOfRecipeTextField.text, text.isEmpty {
            nextToAddPhotoViewBtn.isHidden = true
        } else {
            nextToAddPhotoViewBtn.isHidden = false
            navigationItem.title = nameOfRecipeTextField.text!
            nameOfNewRecipe = nameOfRecipeTextField.text!
            nameOfRecipeTextField.resignFirstResponder()
        }
    }
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedRows = mealTypeTableView.indexPathsForSelectedRows {
            if selectedRows.count == limit {//could use variable named
            displayMessage(userMessage: "You are limited to \(limit) selections")
            return nil
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(mealType[indexPath.row])")
        
        selectedMealType = mealType[indexPath.row]
        if let cell = mealTypeTableView.cellForRow(at: indexPath){
            if cell.isSelected {
                cell.accessoryType = .checkmark
            }
        }
//        selectedMealType.append(mealType[indexPath.row])
//        if let cell = mealTypeTableView.cellForRow(at: indexPath) {
//            if cell.isSelected {
//                cell.accessoryType = .checkmark
//            }
        
        
        if let selectedRows = tableView.indexPathsForSelectedRows {
            print("didDeselectRowAtIndexPath selected rows:\(selectedRows)")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselected \(mealType[indexPath.row])")
        //mealType.remove(at: indexPath.row)
        
        //selectedMealType.remove(at: indexPath.row)
        if let cell = mealTypeTableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            selectedMealType = ""
        }
        
        if let selectedRows = mealTypeTableView.indexPathsForSelectedRows {
            print("did DeselectRowAtIndexPath selected rows: \(selectedRows)")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = mealType[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "What kind of meal is this?"
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
            performSegue(withIdentifier: "toAddPhotoVC", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAddPhotoVC" {
            let addPhotoVC = segue.destination as! AddPhotoViewController
            addPhotoVC.recipeTitle = self.nameOfNewRecipe
            addPhotoVC.selectedMealType = self.selectedMealType
            print(selectedMealType)
            
        }
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped")
            //DispatchQueue.main.async {
              //  self.dismiss(animated: true, completion: nil)
            //}
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        }
    }
    

}
