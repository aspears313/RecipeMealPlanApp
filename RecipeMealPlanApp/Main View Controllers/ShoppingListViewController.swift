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
    
    //@IBOutlet weak var weekOfLabel: UILabel!
    
    fileprivate weak var thisCalendar: FSCalendar!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    let weekOfLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let shoppingListTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    //var coreDataStack: CoreDataStack!
    
    var ingredientsList = [Ingredients]()
    var selectedRecipes = [Recipe]()
    
    var todayDate = Date()
    var startOfWeekDate = Date()
    var endOfWeekDate = Date()
    let calendar = Calendar(identifier: .gregorian)


    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshView()
        
    }
    //MARK: - Setup my Views
    
    func setView() {
        self.view.backgroundColor = .black
        setNavigationBar()
        
        view.addSubview(weekOfLabel)
                
        NSLayoutConstraint.activate([
            weekOfLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            weekOfLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            weekOfLabel.heightAnchor.constraint(equalToConstant: 36),
            weekOfLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 139)
        ])
        
        setCalendarView()
        setupTableView()
        getStartAndEndDates(for: calendar)
    }
    
    func setNavigationBar() {
            
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .red
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.title = "Shopping List"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        }

    func setCalendarView() {
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 170, width: self.view.frame.width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        calendar.scope = .week
        calendar.backgroundColor = .white
        calendar.appearance.selectionColor = .red
        calendar.appearance.todaySelectionColor = .blue
        calendar.appearance.todayColor = .blue
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.titleWeekendColor = .blue
        calendar.appearance.headerTitleColor = .red
        calendar.appearance.weekdayTextColor = .red
        
        view.addSubview(calendar)
        self.thisCalendar = calendar
    }
    
    func setupTableView() {
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        shoppingListTableView.allowsMultipleSelection = true
        shoppingListTableView.allowsMultipleSelectionDuringEditing = true
        
        shoppingListTableView.backgroundView?.backgroundColor = .white
        shoppingListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        shoppingListTableView.register(ShoppingListTableViewCellSection.self, forCellReuseIdentifier: "CellSection")
        shoppingListTableView.register(ShoppingListTableViewCells.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(shoppingListTableView)
        
        NSLayoutConstraint.activate([
            shoppingListTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            shoppingListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            shoppingListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            shoppingListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
        
        shoppingListTableView.backgroundColor = .white
    }
    
    func refreshView() {
        
        ingredientsList.removeAll()
        
        selectedRecipes = fetchSelectedRecipes()
        getIngredientsForSelectedRecipes(selectedRecipes: selectedRecipes)
        
        shoppingListTableView.reloadData()
    }
        // MARK: - Function to set the initial start/end of week dates
        
    func getStartAndEndDates(for calendar: Calendar) {
        
        todayDate = calendar.startOfDay(for: todayDate)
        let weekday = calendar.component(.weekday, from: todayDate)
        
        switch weekday {
            
        case 1:
            startOfWeekDate = todayDate
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: todayDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: todayDate)!
            //print(self.dateFormatter.string(from: endOfWeekDate))
        case 2:
            startOfWeekDate = calendar.date(byAdding: .day, value: -1, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            //print(self.dateFormatter.string(from: endOfWeekDate))
        case 3:
            startOfWeekDate = calendar.date(byAdding: .day, value: -2, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            //print(self.dateFormatter.string(from: endOfWeekDate))
        case 4:
            startOfWeekDate = calendar.date(byAdding: .day, value: -3, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            //print(self.dateFormatter.string(from: endOfWeekDate))
        case 5:
            startOfWeekDate = calendar.date(byAdding: .day, value: -4, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            //print(self.dateFormatter.string(from: endOfWeekDate))
        case 6:
            startOfWeekDate = calendar.date(byAdding: .day, value: -5, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            //print(self.dateFormatter.string(from: endOfWeekDate))
        case 7:
            startOfWeekDate = calendar.date(byAdding: .day, value: -6, to: todayDate)!
            weekOfLabel.text = "Week of: \(self.dateFormatter.string(from: startOfWeekDate))"
            endOfWeekDate = calendar.date(byAdding: .day, value: 6, to: startOfWeekDate)!
            //print(self.dateFormatter.string(from: endOfWeekDate))
        default:
            weekOfLabel.text = "No Date"
        }
    }
//MARK: -  1st Fetch Selected Recipes
       
   func fetchSelectedRecipes() -> [Recipe] {
       
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Selections")
       
       let sort = NSSortDescriptor(key: "selectedDate", ascending: true)
       fetchRequest.sortDescriptors = [sort]
       
       var userSelectedRecipes = [Recipe]()
       var selectedRecipeString = [String]()
       //var recipeNamesAndDates: [String:[String]] = [:]
       
       //This works but needs some refining
       do {
           let results = try coreDataStack.mainContext.fetch(fetchRequest) as! [NSManagedObject]
           for result in results {
               
            let date = dateFormatter.date(from: result.value(forKey: "selectedDate") as! String)
            let recipe = result.value(forKey: "selectedRecipes") as! [String]
                   
               if startOfWeekDate <= date! && date! <= endOfWeekDate {
                selectedRecipeString.append(contentsOf: recipe)
               }
            }
           //Get the recipe array
        userSelectedRecipes = getRecipeObjects(selectedRecipeString: selectedRecipeString)
       } catch let error as NSError {
           print("ERROR: \(error.localizedDescription)")
       }
       return userSelectedRecipes
   }
// MARK: - 2nd
    // Convert the array for the name of recipes to an array of Recipe objects
   func getRecipeObjects(selectedRecipeString: [String]) -> [Recipe] {
        var userSelectedRecipes = [Recipe]()
        let allRecipes = fetchAllRecipes()

        for recipeName in selectedRecipeString {
            if let recipe = allRecipes.first(where: {$0.name == recipeName}) {
                userSelectedRecipes.append(recipe)
            }
        }
        return userSelectedRecipes
       }
    // MARK: - 3rd
    // Fetch all the recipes for comparison
       
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
    //MARK: - 4th
    //From the selected recipes create the list of ingredients
    
    func getIngredientsForSelectedRecipes(selectedRecipes: [Recipe]) {
        
        var haveSeen = Set<String>()
        
        for recipe in selectedRecipes {
            let ingredients = recipe.theseIngredients?.allObjects as! [Ingredients]
            //Leaving off right here
            for ingredient in ingredients {
                //The measure and ingredient name
                let fullIngredient = "\(ingredient.measurement!) \(ingredient.ingredientName!)"
                if let name = ingredient.ingredientName  {
                    if !haveSeen.contains(name) {
                        ingredient.ingredientList = [fullIngredient]
                        //ingredient.ingredientList?.append(fullIngredient)
                        ingredientsList.append(ingredient)
                        haveSeen.insert(name)
                    } else {
                        let index = find(value: name, in: ingredientsList)
                        ingredientsList[index!].ingredientList?.append(fullIngredient)
                        //print(coreIngredients[index!])
                    }
                }
            }
        }
        //print(ingredientsList)
    }
    
    func find(value searchValue: String, in ingredientsList: [Ingredients]) -> Int? {
        
        var currentIndex = 0
        
        for ingredient in ingredientsList {
            if ingredient.ingredientName == searchValue {
                return currentIndex
            } else {
                currentIndex += 1
            }
        }
        return nil
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
        //print(self.dateFormatter.string(from: endOfWeekDate))
        
        refreshView()
        

       //reloadWithAnimation()
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            let cell = shoppingListTableView.dequeueReusableCell(withIdentifier: "CellSection", for: indexPath) as! ShoppingListTableViewCellSection
            cell.backgroundColor = UIColor.white
            cell.ingredientNameLabel.text = "\(ingredientsList[indexPath.section].ingredientName!)"
            cell.checkMarkButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
            return cell
        } else {
            let cell = shoppingListTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShoppingListTableViewCells
            cell.backgroundColor = UIColor.white
            cell.ingredientLabel.font = UIFont.boldSystemFont(ofSize: 22)
            cell.ingredientLabel.text = "          \(ingredientsList[indexPath.section].ingredientList![dataIndex])"
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    @objc func checkMarkButtonClicked( sender: UIButton) {
        print("button pressed")
        
        if sender.isSelected {
            //Uncheck the button
            let image = UIImage(named: "unchecked-white") as UIImage?
            sender.setImage(image, for: .normal)
            sender.isSelected = false
        } else {
            //Check the button
            let image = UIImage(named: "checked-white") as UIImage?
            sender.setImage(image, for: .normal)
            sender.isSelected = true
        }
        shoppingListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = shoppingListTableView.cellForRow(at: indexPath) as! ShoppingListTableViewCellSection
        
        if indexPath.row == 0 {
            
            if ingredientsList[indexPath.section].isExpanded == true {
                ingredientsList[indexPath.section].isExpanded = false
                let sections = IndexSet.init(integer: indexPath.section)
                shoppingListTableView.reloadSections(sections, with: .none)
            } else {
                if cell.checkMarkButton.isSelected == true {
                    ingredientsList[indexPath.section].isExpanded = true
                    let sections = IndexSet.init(integer: indexPath.section)
                    shoppingListTableView.reloadSections(sections, with: .none)
                    let image = UIImage(named: "checked-white") as UIImage?
                    cell.checkMarkButton.setImage(image, for: .normal)
                    shoppingListTableView.reloadData()
                    //cell.checkMarkButton.isSelected = true
                    //(sender: cell.checkMarkButton)
                } else {
                    ingredientsList[indexPath.section].isExpanded = true
                    let sections = IndexSet.init(integer: indexPath.section)
                    shoppingListTableView.reloadSections(sections, with: .none)
                    //cell.checkMarkButton.isSelected = true
                    //cell.checkMarkButton.setImage(UIImage(named: "checked"), for: .normal)
                }
            }
            //checkMarkButtonClicked(sender: cell.checkMarkButton)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ingredientsList[section].isExpanded == true {
            return ingredientsList[section].ingredientList!.count + 1
        }
        else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Might be some changes to this
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // animation 1
        
        //reloadWithAnimation()
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//        cell.layer.transform = rotationTransform
//
//        UIView.animate(withDuration: 1.0, animations: {
//            cell.layer.transform = CATransform3DIdentity
//        })
        // animation 2
//        let springTransform = CGAffineTransform(translationX: 0, y: shoppingListTableView.bounds.size.height)
//        cell.transform = springTransform
//
//        UIView.animate(withDuration: 1.0, delay: 0.08, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options:
//            .curveEaseInOut, animations: {
//                cell.transform = CGAffineTransform.identity
//        }, completion: nil)
//
//        UIView.animate(withDuration: 1.6, animations: {
//            cell.transform = CGAffineTransform.identity
//        })

        // animation 3
//        cell.alpha = 0
//        UIView.animate(withDuration: 0.75, animations: {
//            cell.alpha = 1.0
//        })
//
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


