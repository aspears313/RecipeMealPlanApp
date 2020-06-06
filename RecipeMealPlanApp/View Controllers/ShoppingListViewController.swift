//
//  ShoppingListViewController.swift
//  RecipeAndMealPlanApp2
//
//  Created by Anthony on 4/11/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import CoreData


class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
   // @IBOutlet weak var shoppingListTableView: UITableView!
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    struct plannedMeals {
        var sectionName: String!
        var sectionObjects: [Recipe]!
    }
    
    var selectedRecipesWithDatesObjects = [plannedMeals]()
    var selectedIngredients = [String]()
    
    let shoppingListTableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = UIColor.white
        tv.backgroundColor = UIColor.black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setupTableView()

//        shoppingListTableView.delegate = self
//        shoppingListTableView.dataSource = self
        
        fetchDatesAndRecipesConvertToObjects()
 
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - TableView Methods
    
//    func configure(cell: UITableViewCell, for indexPath: IndexPath) {
//
//        guard let cell = cell as? ShoppingListTableViewCell else {
//            return
//        }
//
//        let currentIngredient = selectedIngredients[indexPath.row]
//
////        cell.recipeName.textAlignment = .center
//        cell.backgroundColor = UIColor.white
//        cell.ingredientName.text = currentIngredient
//
////        let currentRecipe = selectedRecipesWithDatesObjects[indexPath.section].sectionObjects[indexPath.row]
////
////        //cell.recipeName.text = currentRecipe.name
////        if let name = currentRecipe.name {
////            if let image = currentRecipe.image{
////                cell.recipeName.text = name
////                cell.recipeImage.image = UIImage(data: image)
////            }
////            else {
////                cell.recipeName.text = name
////                cell.recipeImage.image = UIImage(named: "No photo")
////            }
////        }
//    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return selectedRecipesWithDatesObjects[section].sectionName
//
//    }
    func setNavigationBar() {
        
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        self.navigationBar.backgroundColor = .black
    }
    
    func setupTableView() {
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        shoppingListTableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(shoppingListTableView)
        
        NSLayoutConstraint.activate([
            shoppingListTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            shoppingListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            shoppingListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            shoppingListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return selectedRecipesWithDatesObjects[section].sectionObjects.count
        return selectedIngredients.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return selectedRecipesWithDatesObjects.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = shoppingListTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShoppingListTableViewCell
        
        cell.backgroundColor = UIColor.black
        cell.ingredientLabel.textAlignment = .center
        cell.ingredientLabel.text = selectedIngredients[indexPath.row]
        //configure(cell: cell, for: indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // MARK: - Functions
    
    // MARK: - Will move these Functions
    
    // Will Probably move almost all these functions out of this view controller
    
    func fetchDatesAndRecipesConvertToObjects() {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Selections")
            
            let sort = NSSortDescriptor(key: "selectedDate", ascending: true)
            fetchRequest.sortDescriptors = [sort]
            
            var myDictionary: [String:[String]] = [:]

            do {
                let results = try coreDataStack.mainContext.fetch(fetchRequest) as! [NSManagedObject]
                for result in results {
                    myDictionary.updateValue(result.value(forKey: "selectedRecipes") as! [String], forKey: result.value(forKey: "selectedDate") as! String)
                }
            } catch let error as NSError {
                print("ERROR: \(error.localizedDescription)")
                //return [String:[String]]()
            }
            getTheObjectsDictionary(recipeObjects: getTheRecipeObject(theDatesWithMealsDictionary: myDictionary))
        }
    
    func getTheRecipeObject(theDatesWithMealsDictionary: [String:[String]]) -> [String:[Recipe]] {
        
        //This is not very efficient find a better way. If I have 100s will completely slow down or crash
        
        var selectedRecipe: [Recipe] = []
        let fetchedRecipes = theFetchedRecipes()
        var updatedDictonary: [String:[Recipe]] = [:]
        
        for (date,recipeNames) in theDatesWithMealsDictionary {
            //print(date)
            for selectedRecipeName in recipeNames {
                //print(selectedRecipeName)
                for recipe in fetchedRecipes {
                    if let recipeName = recipe.name {
                        //print(recipeName)
                        if selectedRecipeName == recipeName {
                            selectedRecipe.append(recipe)
                            if let ingredients = recipe.ingredients {
                                for ingredient in ingredients {
                                    selectedIngredients.append(ingredient)
                                }
                            }
                        }
                    }
                }
            }
            updatedDictonary.updateValue(selectedRecipe, forKey: date)
            selectedRecipe.removeAll()
        }
        return updatedDictonary
    }
    
    func theFetchedRecipes() -> [Recipe] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        var recipes: [Recipe] = []
        
        do {
            let results = try coreDataStack.mainContext.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                recipes.append(result as! Recipe)
            }
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
            return [Recipe]()
        }
        return recipes
    }
    
    func getTheObjectsDictionary(recipeObjects: [String:[Recipe]]){
        
        for (key, value) in recipeObjects {
            selectedRecipesWithDatesObjects.append(plannedMeals(sectionName: key, sectionObjects: value))
        }
    }
}
    



