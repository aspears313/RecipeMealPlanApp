//
//  NewViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 8/5/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import CoreData

class PlannedMealsViewController: UIViewController, UINavigationBarDelegate {
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    var currentDate = Date()
    var selectedRecipes = [Recipe]()
    var newRecipesToAdd = [Recipe]()
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var calendarView: UIView!
    
//    let navBar: UINavigationBar = {
//        let bar = UINavigationBar()
//        bar.backgroundColor = .white
//        bar.translatesAutoresizingMaskIntoConstraints = false
//        return bar
//    }()
    
    let mealForTheDayTableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = UIColor.white
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    fileprivate lazy var monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter
    }()
    
    fileprivate lazy var dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    fileprivate lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshView()
    }
    
    //MARK: - Initial Set up of View Controller
    
    func setUpView() {
        setSegmentControl()
        setNavigationBar()
        setLabels()
        setTableView()
    }
    
    func setTableView() {
        
        mealForTheDayTableView.delegate = self
        mealForTheDayTableView.dataSource = self
        
        mealForTheDayTableView.register(ListedRecipesTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(mealForTheDayTableView)
        
        NSLayoutConstraint.activate([
            mealForTheDayTableView.topAnchor.constraint(equalTo: self.calendarView.bottomAnchor),
            mealForTheDayTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            mealForTheDayTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            mealForTheDayTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        mealForTheDayTableView.backgroundColor = .white
        mealForTheDayTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func setLabels() {
        dayLabel.text = self.dayFormatter.string(from: currentDate)
        dayOfWeekLabel.text = self.dayOfWeekFormatter.string(from: currentDate)
    }
    
    func setNavigationBar() {
        
//        navigationBar.barTintColor = .white
//        navigationBar.backgroundColor = .white
//        navigationBar.isTranslucent = false
//        navigationBar.prefersLargeTitles = true
//        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        navigationBar.topItem?.title = self.monthFormatter.string(from: currentDate)
        //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .red
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.topItem?.title = self.monthFormatter.string(from: currentDate)
        
//        self.navigationController?.navigationBar.barTintColor = .white
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        self.navigationController?.navigationBar.backgroundColor = .white
//        self.navigationController?.navigationBar.topItem?.title = self.monthFormatter.string(from: currentDate)
    }
    
    func setSegmentControl() {
        let font = UIFont.boldSystemFont(ofSize: 20)
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.black]
        segmentControl.setTitleTextAttributes(normalAttribute, for: .normal)
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.red]
        segmentControl.setTitleTextAttributes(selectedAttribute, for: .selected)
        segmentControl.selectedSegmentTintColor = .white
    }
    
    //MARK: - Button Actions
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)
        
        if let newDate = previousDay {
            currentDate = newDate
            self.navigationController?.navigationBar.topItem?.title = self.monthFormatter.string(from: newDate)
            dayLabel.text = self.dayFormatter.string(from: newDate)
            dayOfWeekLabel.text = self.dayOfWeekFormatter.string(from: newDate)
        }
        refreshView()
    }
    
    @IBAction func forwardBtnClicked(_ sender: Any) {
        
        let futureDay = Calendar.current.date(byAdding: .day, value:  1, to: currentDate)
        
        if let newDate = futureDay {
            self.navigationController?.navigationBar.topItem?.title = self.monthFormatter.string(from: newDate)
            currentDate = newDate
            dayLabel.text = self.dayFormatter.string(from: newDate)
            dayOfWeekLabel.text = self.dayOfWeekFormatter.string(from: newDate)
        }
        refreshView()
    }
    
    func refreshView() {
        
        selectedRecipes.removeAll()
        selectedRecipes.append(contentsOf: fetchSelectedRecipesForCurrentDate())
        
        mealForTheDayTableView.reloadData()
    }

    //MARK: - Fetches for the day.
    
    func fetchSelectedRecipesForCurrentDate() -> [Recipe] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Selections")
        
        let sort = NSSortDescriptor(key: "selectedDate", ascending: true)
        
        fetchRequest.sortDescriptors = [sort]
        
        var selectedRecipesForCurrentDate = [Recipe]()
        var selectedRecipeString = [String]()
        let currentDate = self.dateFormatter.string(from: self.currentDate)
        
        do {
            let results = try coreDataStack.mainContext.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                let date = result.value(forKey: "selectedDate") as! String
                let recipe = result.value(forKey: "selectedRecipes") as! [String]
//                print("Date: \(date)")
//                print("Recipe: \(recipe)")
               
                if date == currentDate {
                    //print("Dates match")
                    selectedRecipeString.append(contentsOf: recipe)
                    
                }
                else {
                    print("The dates don't match")
                }
            }
            // Get the recipe array
            selectedRecipesForCurrentDate = getRecipes(selectedRecipeString: selectedRecipeString)
            
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
        }
        return selectedRecipesForCurrentDate
    }
    
    func getRecipes(selectedRecipeString:[String]) -> [Recipe] {
        var selectedRecipesFromString = [Recipe]()
        let allRecipes = fetchAllRecipes()
        
        //First convert the [String] to [Recipe]\
        for recipeName in selectedRecipeString {
            if let recipe = allRecipes.first(where: {$0.name == recipeName}) {
                selectedRecipesFromString.append(recipe)
            }
        }
        return selectedRecipesFromString
    }
    
    func fetchAllRecipes() -> [Recipe] {
        
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            if let indexPath = mealForTheDayTableView.indexPathForSelectedRow {
                let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
                recipeDetailsViewController.recipe = self.selectedRecipes[indexPath.row]
                recipeDetailsViewController.addMealBtn.isEnabled = false
            }
        }
    }
    

}

//MARK: - TableView DataSource & Delegate Methods
extension PlannedMealsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealForTheDayTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListedRecipesTableViewCell
        
        let currentRecipe = selectedRecipes[indexPath.row]
            
        cell.recipeName.text = currentRecipe.name
        
        if let image = currentRecipe.image {
            cell.recipeImage.image = UIImage(data: image)
        } else {
            cell.recipeImage.image = UIImage(named: "No photo")
        }
        
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // Might change to sections of the mealType
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
        mealForTheDayTableView.deselectRow(at: indexPath, animated: true)
    }
}
