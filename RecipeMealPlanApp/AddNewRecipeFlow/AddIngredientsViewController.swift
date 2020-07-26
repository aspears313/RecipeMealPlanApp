//
//  AddIngredientsViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import CoreData

class AddIngredientsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var measurementPickerView: UIPickerView!
    @IBOutlet weak var labelForIngredient: UILabel!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var addIngredientBtn: UIButton!
    
    var newRecipe: Recipe?
    var ingredientsForNewRecipe: [Ingredients] = []
    var thisMeasure: String = ""
    //var pickerDataSource = PickerViewDataSource()
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    let pickerData: [[String]] = [["","1","2","3","4","5","6","7","8","9","10"],
                                  ["","1/8","1/4","1/3","1/2","2/3","3/4"],
                                  ["","tsp(s)","tbsp(s)","cup(s)","Oz","gram(s)","whole","lbs","fl Oz(s)","Qt","Gal(s)","L","pinch","can(s)"]]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = newRecipe?.name!
        
        nextBtn.isHidden = true
        nextBtn.layer.cornerRadius = nextBtn.frame.height / 2.0
        addIngredientBtn.layer.cornerRadius = addIngredientBtn.frame.height / 2.0
        ingredientNameTextField.delegate = self
        measurementPickerView.dataSource = self
        measurementPickerView.delegate = self
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        //Stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    //MARK: - PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
       }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData[component].count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return pickerData[component][row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        let selectedRowInComponent1 = measurementPickerView.selectedRow(inComponent: 0)
        let stringForComponent1: String! = pickerData[0][selectedRowInComponent1]
        
        let selectedRowInComponent2 = measurementPickerView.selectedRow(inComponent: 1)
        let stringForComponent2: String! = pickerData[1][selectedRowInComponent2]
        
        let selectedRowInComponent3 = measurementPickerView.selectedRow(inComponent: 2)
        let stringForComponenet3: String! = pickerData[2][selectedRowInComponent3]
        
        if (stringForComponent1 == "" && stringForComponent2 == "" && stringForComponenet3 == "") {
                      
        } else if stringForComponent1 == "" {
            
            thisMeasure = "\(stringForComponent2 ?? "") \(stringForComponenet3 ?? "")"
            
        } else if stringForComponent2 == "" {
            
            thisMeasure = "\(stringForComponent1 ?? "") \(stringForComponenet3 ?? "")"
            
        } else {
            
            thisMeasure = "\(stringForComponent1 ?? "") \(stringForComponent2 ?? "") \(stringForComponenet3 ?? "")"
        }
    }

    @IBAction func addIngredientsBtn(_ sender: Any) {
        
        hideKeyboard()
        if let ingredientName = ingredientNameTextField.text {
            if thisMeasure == "" {
                displayMessage(userMessage: "Please enter an amount before adding an ingredient")
            } else if ingredientName.isEmpty {
                displayMessage(userMessage: "Please enter the ingredients name to add the ingredient")
            } else {
                
                let newIngredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredients", into: coreDataStack.mainContext) as! Ingredients
                
                newIngredient.measurement = thisMeasure
                newIngredient.ingredientName = ingredientName.capitalized
                
                ingredientsForNewRecipe.append(newIngredient)
                
                labelForIngredient.text = "\(newIngredient.measurement!) \(newIngredient.ingredientName!)"
                
                //To Reset the pickerView
                measurementPickerView.selectRow(0, inComponent: 0, animated: true)
                measurementPickerView.selectRow(0, inComponent: 1, animated: true)
                measurementPickerView.selectRow(0, inComponent: 2, animated: true)
                //To Reset UITextfield
                ingredientNameTextField.text = ""
                thisMeasure = ""
                
                nextBtn.isHidden = false
            }
        }
    }
    
    func hideKeyboard () {
        ingredientNameTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
        hideKeyboard()
        return true
    }
        
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
            
        return true
    }

    func addIngredientsToRecipe() {
        
        var ingredientsForNewRecipeSet = Set<Ingredients>()
        
        for ingredient in ingredientsForNewRecipe {
            
            let entity = NSEntityDescription.entity(forEntityName: "Ingredients", in: coreDataStack.mainContext)
            
            let currentIngredient = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
            
            currentIngredient.measurement = ingredient.measurement
            currentIngredient.ingredientName = ingredient.ingredientName
            
            ingredientsForNewRecipeSet.insert(currentIngredient)
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
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        if thisMeasure.isEmpty && ingredientNameTextField.text!.isEmpty {
            addIngredientsToRecipe()
            performSegue(withIdentifier: "toAddDirectionsVC", sender: self)
        } else if !thisMeasure.isEmpty && ingredientNameTextField.text!.isEmpty {
            displayMessage(userMessage: "Please enter the name of your ingredient before continuing.")
        } else if thisMeasure.isEmpty && !ingredientNameTextField.text!.isEmpty {
            displayMessage(userMessage: "Please enter a measurement for your ingredient before continuing")
        } else {
            addIngredientsBtn(self)
            addIngredientsToRecipe()
            performSegue(withIdentifier: "toAddDirectionsVC", sender: self)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toAddDirectionsVC" {
            let addDirectionsVC = segue.destination as! AddDirectionsViewController
            addDirectionsVC.newRecipe = self.newRecipe!
            addDirectionsVC.newIngredients = self.ingredientsForNewRecipe
        }
    }
}
