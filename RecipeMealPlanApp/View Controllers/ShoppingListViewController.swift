//
//  ShoppingListViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/11/20.
//  Copyright © 2020 Anthony. All rights reserved.


import UIKit
import CoreData
import FSCalendar

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var weekOfLabel: UILabel!
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    fileprivate weak var thisCalendar: FSCalendar!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    struct plannedMeals {
        var sectionName: String!
        var sectionObjects: [Recipe]!
    }
    
    let todayDate = Date()
    let calendar = Calendar(identifier: .gregorian)
    
    var startOfWeekDate = Date()
    var endOfWeekDate = Date()
    
    var testDictionary: [String: [Recipe]] = [:]
    
    var selectedRecipesWithDates: [String:[Recipe]] = [:]
    var selectedRecipesWithDatesObjects = [plannedMeals]()
    var selectedIngredients = [String]()
    
    var ingredients = [String]()
    
    let shoppingListTableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .black
        tv.backgroundColor = .black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        shoppingListTableView.backgroundColor = UIColor.black
        
        setCalendarView()
        setNavigationBar()
        setupTableView()
        
        getStartAndEndDates(for: calendar)
        
        testDictionary = fetchDatesAndRecipesThenConvertToObjects2()
        
        ingredients = getJustIngredientName(toUpdateIngredList: selectedIngredients)
 //       selectedRecipesWithDates = fetchDatesAndRecipesConvertToObjects()
 
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shoppingListTableView.reloadData()
    }
    
    //MARK: - Setup my Views
    
    func setCalendarView() {
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 180, width: self.view.frame.width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        calendar.scope = .week
        calendar.backgroundColor = .black
        calendar.appearance.selectionColor = .red
        calendar.appearance.todaySelectionColor = .blue
        calendar.appearance.todayColor = .blue
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.titleWeekendColor = .red
        
        
        view.addSubview(calendar)
        self.thisCalendar = calendar
    }
    
    func setNavigationBar() {
        
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        self.navigationBar.backgroundColor = .black
    }
    
    func setupTableView() {
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        shoppingListTableView.allowsMultipleSelection = true
        shoppingListTableView.allowsMultipleSelectionDuringEditing = true
        
        shoppingListTableView.backgroundView?.backgroundColor = .black
        
        shoppingListTableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(shoppingListTableView)
        
        NSLayoutConstraint.activate([
            shoppingListTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            shoppingListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            shoppingListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            shoppingListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
    }
    
    func getJustIngredientName(toUpdateIngredList: [String]) -> [String] {
        
        var delimiter = " "
        
        var ingredients = [String]()
        
        for ingredient in toUpdateIngredList {
            let token = ingredient.components(separatedBy: delimiter)
//            print(token[0])
//            print(token[1])
//            print(token[2])
        }
        
        return ingredients
        
    }
    
    // MARK: - Functions for getting dates
    
    func getStartAndEndDates(for calendar: Calendar) {
        
        let weekday = calendar.component(.weekday, from: todayDate)
        
        switch weekday {
            
        case 1:
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: todayDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: todayDate)!
            print(self.dateFormatter.string(from: endOfWeekDate))
        case 2:
            startOfWeekDate = calendar.date(byAdding: .day, value: -1, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            print(self.dateFormatter.string(from: endOfWeekDate))
        case 3:
            startOfWeekDate = calendar.date(byAdding: .day, value: -2, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            print(self.dateFormatter.string(from: endOfWeekDate))
        case 4:
            startOfWeekDate = calendar.date(byAdding: .day, value: -3, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            print(self.dateFormatter.string(from: endOfWeekDate))
        case 5:
            startOfWeekDate = calendar.date(byAdding: .day, value: -4, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            print(self.dateFormatter.string(from: endOfWeekDate))
        case 6:
            startOfWeekDate = calendar.date(byAdding: .day, value: -5, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            print(self.dateFormatter.string(from: endOfWeekDate))
        case 7:
            startOfWeekDate = calendar.date(byAdding: .day, value: -6, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            print(self.dateFormatter.string(from: endOfWeekDate))
        default:
            weekOfLabel.text = "No Date"
        }
    }
    
    // MARK: - Will move these Functions
    
    // Will Probably move almost all these functions out of this view controller
    
    func fetchDatesAndRecipesThenConvertToObjects2() -> [String: [Recipe]] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Selections")
        
        let sort = NSSortDescriptor(key: "selectedDate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        var myDictionary: [String: [String]] = [:]
        
        do {
            let results = try coreDataStack.mainContext.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                
                let currentDay = result.value(forKey: "selectedDate") as! String
                print(currentDay)
                let reverseDateFormatter = DateFormatter()
                reverseDateFormatter.dateFormat = "MM/dd/yyyy"
                let date = reverseDateFormatter.date(from: currentDay)
                
                if let date = date {
                    if startOfWeekDate <= date && date <= endOfWeekDate {
                        print("date is between startOfWeekDate and endOfWeekDate")
                        myDictionary.updateValue(result.value(forKey: "selectedRecipes") as! [String], forKey: result.value(forKey: "selectedDate") as! String)
                    } else
                    {
                        print("date is outside of the startOfWeekDate and endOfWeekDate")
                    }
                }
            }
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
        }
        //return myDictionary
        let theConvertedDictionary = getTheRecipeObject(theDatesWithMealsDictionary: myDictionary)
        return theConvertedDictionary
    }
    
    func fetchDatesAndRecipesConvertToObjects() -> [String:[Recipe]] {
            
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
        // This is where I can return my dictionary: [String:[String]]
            let theReturnedDictionary = getTheRecipeObject(theDatesWithMealsDictionary: myDictionary)
            getTheObjectsDictionary(recipeObjects: getTheRecipeObject(theDatesWithMealsDictionary: myDictionary))
        
            return theReturnedDictionary
        }
    // This function converts the array of recipe names as String to an array of Recipe
    
    func getTheIngredients(theDatesWithMealsDictionary: [String:[String]]) {
        
        //This is not very efficient find a better way. If I have 100s of Recipes will completely slow down or crash
        
        var selectedRecipe: [Recipe] = []
        let fetchedRecipes = theFetchedRecipes()
        var updatedDictonary: [String:[Recipe]] = [:]
        var selectedIngredients: [String] = []
        
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
        //return selectedIngredients
    }
    
    func getTheRecipeObject(theDatesWithMealsDictionary: [String:[String]]) -> [String:[Recipe]] {
        
        //This is not very efficient find a better way. If I have 100s of Recipes will completely slow down or crash
        
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

//MARK: - FSCalendar DataSource and Delegate Methods

extension ShoppingListViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        
        return cell
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        
        return startOfWeekDate
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        startOfWeekDate = calendar.currentPage
        weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
        endOfWeekDate = self.calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
        print(self.dateFormatter.string(from: endOfWeekDate))
        
        selectedIngredients.removeAll()
        testDictionary = fetchDatesAndRecipesThenConvertToObjects2()
        
        reloadWithAnimation()
        
        //UIView.transition(with: shoppingListTableView, duration: 1.0, options: .transitionFlipFromRight, animations: {self.shoppingListTableView.reloadData()}, completion: nil)
//        let range = NSMakeRange(0, self.shoppingListTableView.numberOfSections)
//        let sections = NSIndexSet(indexesIn: range)
//        self.shoppingListTableView.reloadSections(sections as IndexSet, with: .automatic)
        
        
//        shoppingListTableView.reloadSections(, with: .left)
//        shoppingListTableView.reloadData()
    }
}


// MARK: - TableView Methods

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let ingredientToMove = selectedIngredients[indexPath.row]
        
        selectedIngredients.remove(at: indexPath.row)
        selectedIngredients.insert(ingredientToMove, at: 0)
        let desitnationIndexPath = NSIndexPath(row: 1, section: indexPath.section)
        shoppingListTableView.moveRow(at: indexPath, to: desitnationIndexPath as IndexPath)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ingredientToMove = selectedIngredients[indexPath.row]
        
        selectedIngredients.remove(at: indexPath.row)
        selectedIngredients.append(ingredientToMove)
        let destinationIndexPath = NSIndexPath(row: selectedIngredients.count - 1, section: indexPath.section)
        shoppingListTableView.moveRow(at: indexPath, to: destinationIndexPath as IndexPath)
        
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
        cell.ingredientLabel.textAlignment = .left
        cell.ingredientLabel.text = selectedIngredients[indexPath.row]
        cell.checkMarkImageView.image = UIImage(named: "unchecked")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // animation 1
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//        cell.layer.transform = rotationTransform
//
//        UIView.animate(withDuration: 1.0, animations: {
//            cell.layer.transform = CATransform3DIdentity
//        })
//
        let springTransform = CGAffineTransform(translationX: 0, y: shoppingListTableView.bounds.size.height)
        cell.transform = springTransform
        
        UIView.animate(withDuration: 1.0, delay: 0.08, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options:
            .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
        }, completion: nil)

//        UIView.animate(withDuration: 1.6, animations: {
//            cell.transform = CGAffineTransform.identity
//        })

        // animation 2
//        cell.alpha = 0
//        UIView.animate(withDuration: 0.75, animations: {
//            cell.alpha = 1.0
//        })
        
    }
    
    
    func reloadWithAnimation() {
        shoppingListTableView.reloadData()
        let tableViewHeight = shoppingListTableView.bounds.size.height
        let cells = shoppingListTableView.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.0, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
