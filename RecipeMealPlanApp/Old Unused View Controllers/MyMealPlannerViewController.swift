//
//  MyMealPlannerViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 5/8/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

//import UIKit
//import CoreData
//
//protocol MealSelectionDelegate {
//    func didSelectMeals(selectedMeals: [Recipe])
//}
//
//class MyMealPlannerViewController: UIViewController {
//    
//    @IBOutlet weak var mealPlanTableView: UITableView!
//    
//    
//    var selectedMeals: [Recipe] = []
//    var mealTypeAndCount: [[String: String]] = []
//    
//    var selectionDelegate: MealSelectionDelegate!
//    
//    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        mealPlanTableView.dataSource = self
//        mealPlanTableView.delegate = self
//
//        mealTypeAndCount = totalMealsPerType()
//        // Do any additional setup after loading the view.
//    }
//    
//    func totalMealsPerType() -> [[String: String]] {
//        
//        let expressionDescription = NSExpressionDescription()
//        expressionDescription.name = "mealCount"
//        
//        let arguments = [NSExpression(forKeyPath: "mealType")]
//        expressionDescription.expression = NSExpression(forFunction: "count:", arguments: arguments)
//        
//        let fetchRequest: NSFetchRequest<NSDictionary> = NSFetchRequest(entityName: "Recipe")
//        fetchRequest.propertiesToFetch = ["mealType", expressionDescription]
//        fetchRequest.propertiesToGroupBy = ["mealType"]
//        
//        fetchRequest.resultType = .dictionaryResultType
//        
//        var fetchResults: [NSDictionary] = []
//        do {
//            fetchResults = try coreDataStack.managedContext.fetch(fetchRequest)
//        } catch let error as NSError {
//            print("ERROR: \(error.localizedDescription)")
//            return [[String:String]]()
//        }
//        return fetchResults as! [[String:String]]
//    }
//
//    
//    // MARK: - Navigation
//
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//       
//       if segue.identifier == "toMealTypeListVC" {
//           if let indexPath = mealPlanTableView.indexPathForSelectedRow{
//               let navigationController = segue.destination as! UINavigationController
//               let mealListVC = navigationController.topViewController as! MealListViewController
//               let mealtypeDictionary = mealTypeAndCount[indexPath.row]
//               let mealType = mealtypeDictionary["mealType"]
//               
//               mealListVC.coreDataStack = coreDataStack
//               mealListVC.mealType = mealType!
//               }
//           }
//   }
//    
//    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
//        
//    }
//    
//    @IBAction func doneBtnTapped(_ sender: Any) {
//
//        //var selectedMeals = toBeCopiedSelectedMeals
//        print(selectedMeals.count)
//        selectionDelegate.didSelectMeals(selectedMeals: selectedMeals)
//        selectedMeals.removeAll()
//    }
//    
//    @IBAction func addMealBtn(_ unwindSegue: UIStoryboardSegue) {
//        let recipeDetailsVC = unwindSegue.source as! RecipeDetailsViewController
// 
//        if let recipe = recipeDetailsVC.recipe {
//            //selectedMeals.append(recipe)
//            selectedMeals.append(recipe)
//        }
//    }
//    
//}
//
//extension MyMealPlannerViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mealTypeAndCount.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let mealTypeDictionary: [String: String] = mealTypeAndCount[indexPath.row]
//        
//        let cell = mealPlanTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        
//        
//        cell.textLabel?.text = mealTypeDictionary["mealType"]
//        cell.detailTextLabel?.text = mealTypeDictionary["mealCount"]
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//}
//extension MyMealPlannerViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "toMealTypeListVC", sender: indexPath.row)
//        mealPlanTableView.deselectRow(at: indexPath, animated: true)
//    }
//}
