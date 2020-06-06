//
//  PickerViewDataSource.swift
//  RecipeListApp
//
//  Created by Anthony on 1/18/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

protocol myPickerViewProtocol {
    func myPickerDidSelectRow(selectedRowValue: Int?)
}

class PickerViewDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pickerData: [[String]] = [["","1","2","3","4","5","6","7","8","9","10"],
                                  ["","1/8","1/4","1/3","1/2","2/3","3/4"],
                                  ["","tsp(s)","tbsp(s)","cup(s)","Oz","gram(s)","whole","lbs","fl Oz(s)","Qt","Gal(s)","L","pinch"]]
    //let addIngredView: AddIngredientsViewController = AddIngredientsViewController()

    //var delegate: pickerViewModelDelegate?

//    let wholeNumbersComponent1: [String] = ["","1","2","3","4","5","6","7","8","9","10"]
//    let fractionNumbersComponent2: [String] = ["","1/8","1/4","1/3","1/2","2/3","3/4"]
//    let unitOfMeasureComponent3: [String] = ["tsp","tbsp","cup","Oz","gram","lbs","fl Oz","Qt","Gal","L","pinch"]

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

        let addIngredView: AddIngredientsViewController = AddIngredientsViewController()


        let selectedRowInComponent1 = pickerView.selectedRow(inComponent: 0)

        let selectedRowInComponent2 = pickerView.selectedRow(inComponent: 1)

        let selectedRowInComponent3 = pickerView.selectedRow(inComponent: 2)

        //addIngredView.LabelForIngredient?.text = "\(selectedRowInComponent1) \(selectedRowInComponent2) \(selectedRowInComponent3)"
    }
    
    

    
    
}
