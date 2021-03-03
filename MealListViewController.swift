//
//  MealListViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/16/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import CoreData

class MealListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let mealsForTypeTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var coreDataStack: CoreDataStack!
    
    var mealType: String = ""
    var mealTypeRecipes = [Recipe]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        
        mealTypeRecipes = mealsForType()

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        mealsForTypeTableView.delegate = self
        mealsForTypeTableView.dataSource = self
        
        mealsForTypeTableView.register(ListedRecipesTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(mealsForTypeTableView)
        
        NSLayoutConstraint.activate([
            mealsForTypeTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mealsForTypeTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mealsForTypeTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mealsForTypeTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        mealsForTypeTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        mealsForTypeTableView.backgroundColor = .white
    }
    
    func setupNavBar() {
        let navigation = ReusableNavigation()
        
        let extractedExpr = self.navigationController?.navigationBar.scrollEdgeAppearance = navigation.setNavigationBar()
        extractedExpr
        self.navigationController?.navigationBar.standardAppearance = navigation.setNavigationBar()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //self.navigationController?.navigationBar.topItem?.title = mealType
        
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = mealType
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
    func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        
        guard let cell = cell as? ListedRecipesTableViewCell else {
            return
        }
        let currentMeal = mealTypeRecipes[indexPath.row]
        cell.recipeName.text = currentMeal.name

        if let image = currentMeal.image {
            cell.recipeImage.image = UIImage(data: image)
        } else {
            cell.recipeImage.image = UIImage(named: "No photo")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealTypeRecipes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListedRecipesTableViewCell else {
            fatalError("The dequeed cell is not an instance of ListedRecipesTableViewCell.")
        }

        configure(cell: cell, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func mealsForType() -> [Recipe] {

        let predicate = NSPredicate(format: "mealType == %@", mealType)
        let fetchRequest: NSFetchRequest<Recipe> = NSFetchRequest(entityName: "Recipe")
        fetchRequest.predicate = predicate

        var fetchResults: [Recipe] = []
        do {
            fetchResults = try coreDataStack.mainContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
            return [Recipe]()
        }
        return fetchResults
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            
            if let indexPath = mealsForTypeTableView.indexPathForSelectedRow{
                let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
                recipeDetailsViewController.recipe = mealTypeRecipes[indexPath.row]
                recipeDetailsViewController.addMealBtn.isEnabled = true
                recipeDetailsViewController.navigationItem.title = mealTypeRecipes[indexPath.row].name
            }
        }
    }
}
