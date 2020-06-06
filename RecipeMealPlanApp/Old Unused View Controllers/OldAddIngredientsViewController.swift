//
//  OldAddIngredientsViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 1/10/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

//import UIKit
// 
//protocol AddIngredientsViewControllerDelegate: NSObjectProtocol {
//    func doSomethingWithData(data: [String])
//}
//
//class OldAddIngredientsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate/*, MeasurePickerDataProtocol*/ {
//    
//    weak var delegate: AddIngredientsViewControllerDelegate?
//    @IBOutlet weak var doneBtn: UIBarButtonItem!
//    
//    
//       
//    @IBOutlet weak var measurementPickerView: UIPickerView!
//    @IBOutlet weak var LabelForIngredient: UILabel!
//    @IBOutlet weak var ingredientNameTextField: UITextField!
//    
//    //var ingredientList: IngredientListModel?
//    var pickerDataSource = PickerViewDataSource()
//    var userIngredient: String = ""
//    var thisMeasure: String = ""
//    var thisIngredientList: [String]? = []
//    //var ingredientList: [String] = []
//
//    let pickerData: [[String]] = [["","1","2","3","4","5","6","7","8","9","10"],
//                                  ["","1/8","1/4","1/3","1/2","2/3","3/4"],
//                                  ["","tsp","tbsp","cup","Oz","gram","lbs","fl Oz","Qt","Gal","L","pinch"]]
//    
//    //var pickerOfMeasurements: MeasurePickerData!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        ingredientNameTextField.delegate = self
//        measurementPickerView.dataSource = self
//        measurementPickerView.delegate = self
//        
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
//        view.addGestureRecognizer(tap)
//        
//        doneBtn.isEnabled = false
//    }
//    
//    
//    
//    //MARK: - PickerView Methods
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 3
//       }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        pickerData[component].count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 50
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        return pickerData[component][row]
//    }
//        
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        let selectedRowInComponent1 = measurementPickerView.selectedRow(inComponent: 0)
//        let stringForComponent1: String! = pickerData[0][selectedRowInComponent1]
//        
//        let selectedRowInComponent2 = measurementPickerView.selectedRow(inComponent: 1)
//        let stringForComponent2: String! = pickerData[1][selectedRowInComponent2]
//        
//        let selectedRowInComponent3 = measurementPickerView.selectedRow(inComponent: 2)
//        let stringForComponenet3: String! = pickerData[2][selectedRowInComponent3]
//        
//        if (stringForComponent1 == "" && stringForComponent2 == "" && stringForComponenet3 == "") {
//          
//            displayMessage(userMessage: "Must enter an amount")
//            
//        } else if stringForComponent1 == "" {
//            
//            thisMeasure = "\(stringForComponent2 ?? "") \(stringForComponenet3 ?? "")"
//            
//        } else if stringForComponent2 == "" {
//            
//            thisMeasure = "\(stringForComponent1 ?? "") \(stringForComponenet3 ?? "")"
//            
//        } else {
//            
//            thisMeasure = "\(stringForComponent1 ?? "") \(stringForComponent2 ?? "") \(stringForComponenet3 ?? "")"
//        }
//    }
//    
//    // MARK: - Actions
//    
//    @IBAction func addIngredientsBtn(_ sender: Any) {
//        
//        var thisIngredientName: String
//        // Check if required fields are empty or not.
//        if (ingredientNameTextField.text?.isEmpty)! {
//            displayMessage(userMessage: "Please type the name for your ingredient")
//            return
//        } else {
//            thisIngredientName = ingredientNameTextField.text!
//            
//        }
//        
//        userIngredient = "\(thisMeasure) \(thisIngredientName)"
//        
//        LabelForIngredient.text = userIngredient
//        
//        //To Reset the pickerView
//        measurementPickerView.selectRow(0, inComponent: 0, animated: false)
//        measurementPickerView.selectRow(0, inComponent: 1, animated: false)
//        measurementPickerView.selectRow(0, inComponent: 2, animated: false)
//        //To Reset UITextfield
//        ingredientNameTextField.text = ""
//
//        thisIngredientList?.append(userIngredient)
//        //print(userIngredientList!)
//        doneBtn.isEnabled = true
//        
//    }
//    
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        ingredientNameTextField.resignFirstResponder()
//        
//        return true
//    }
//    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        
//        return true
//    }
//
//    
//    
//    func displayMessage(userMessage:String) -> Void {
//        DispatchQueue.main.async {
//        let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
//        
//        let OKAction = UIAlertAction(title: "OK", style: .default) {
//            (action:UIAlertAction!) in
//            // Code in this block will trigger when OK button tapped.
//            print("Ok button tapped")
//            //DispatchQueue.main.async {
//              //  self.dismiss(animated: true, completion: nil)
//            //}
//        }
//        alertController.addAction(OKAction)
//        self.present(alertController, animated: true, completion: nil)
//        }
//        
//}
//    
//    
//
//    
//    // MARK: - Navigation
//    
//}
//
