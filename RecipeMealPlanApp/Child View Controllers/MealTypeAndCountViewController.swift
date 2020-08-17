//
//  MealPlannerViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/11/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import CoreData

protocol MealSelectDelegate: class {
    //func didSelectMeals(selectedMeals: [Recipe])
    
    func didSelectMeals(selectedMeals: [String])
}

class MealTypeAndCountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mealTypeTableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    weak var selectionDelegate: MealSelectDelegate?
    
    //var selectedMeals: [Recipe] = []
    var selectedMeals: [String] = []
    var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    var mealTypeAndCount: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mealTypeTableView.dataSource = self
        self.mealTypeTableView.delegate = self
        self.mealTypeTableView.backgroundColor = .white
        
        self.view.backgroundColor = .white
        self.doneBtn.layer.cornerRadius = doneBtn.frame.height / 2.0
        mealTypeAndCount = totalMealsPerType()
   
    }
    
    //MARK: TableView Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toMealTypeListVC", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealTypeAndCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mealTypeDictionary: [String: String] = mealTypeAndCount[indexPath.row]
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = mealTypeDictionary["mealType"]
        cell.detailTextLabel?.text = mealTypeDictionary["mealCount"]
   
        return cell
    }
    
    func totalMealsPerType() -> [[String: String]] {
        
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "mealCount"
        
        let arguments = [NSExpression(forKeyPath: "mealType")]
        expressionDescription.expression = NSExpression(forFunction: "count:", arguments: arguments)
        
        let fetchRequest: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: "Recipe")
        fetchRequest.propertiesToFetch = ["mealType", expressionDescription]
        fetchRequest.propertiesToGroupBy = ["mealType"]
        fetchRequest.resultType = .dictionaryResultType
        
        var fetchResults: [NSDictionary] = []
        do {
            fetchResults = try coreDataStack.mainContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
            return [[String:String]]()
        }
        return fetchResults as! [[String:String]]
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMealTypeListVC" {
            if let indexPath = mealTypeTableView.indexPathForSelectedRow{
                let navigationController = segue.destination as! UINavigationController
                let mealListVC = navigationController.topViewController as! MealListViewController 
                let mealtypeDictionary = mealTypeAndCount[indexPath.row]
                let mealType = mealtypeDictionary["mealType"]
                
                mealListVC.coreDataStack = coreDataStack
                mealListVC.mealType = mealType!
                }
            }
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {


        print(selectedMeals.count)
        selectionDelegate?.didSelectMeals(selectedMeals: selectedMeals)
        selectedMeals.removeAll()
       
    }
    
    @IBAction func addMealBtn(_ unwindSegue: UIStoryboardSegue) {
        let recipeDetailsVC = unwindSegue.source as! RecipeDetailsViewController
        
        if let recipeName = recipeDetailsVC.recipe?.name {
            selectedMeals.append(recipeName)

        }
      
    }
    
}
    




