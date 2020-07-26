//
//  Random stuff.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/9/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

//import Foundation

//@IBOutlet weak var calendar: FSCalendar!
//fileprivate weak var calendar: FSCalendar!

 //Navigation Bar Setup
//        self.navigationController?.navigationBar.barTintColor = .black
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = "Meal Planner"
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        let navItem = UINavigationItem(title: "Month")
//        self.navigationController?.navigationBar
        //self.navigationItem.leftBarButtonItem.
        //self.navigationItem.leftBarButtonItem?.isEnabled = true

        // Setting up Calendar in the view
//        let calendar = FSCalendar(frame: CGRect(x: 20, y: 273, width: 374, height: 350))
//        calendar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(calendar)
//        calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        calendar.heightAnchor.constraint(equalToConstant: 350).isActive = true
//        calendar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
//        self.calendar = calendar
//
//        calendar.dataSource = self
//        calendar.delegate = self
//
//        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
//
//        //Setting up what calendar will look like
//        self.calendar.backgroundColor = .black
//        self.calendar.appearance.selectionColor = .red
//        self.calendar.appearance.todaySelectionColor = .blue
//        self.calendar.appearance.todayColor = .blue
//        self.calendar.appearance.titleDefaultColor = .white
//        self.calendar.appearance.titleWeekendColor = .red
        
        //calendar.scope = .month

        
//        calendar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(calendar)
//
//        calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        calendar.heightAnchor.constraint(equalToConstant: 275).isActive = true
//        calendar.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
//
//        self.calendar = calendar

        // Do any additional setup after loading the view.

//273
//        let calendar = FSCalendar(frame: CGRect(x: 20, y: 273, width: 374, height: 350))
//        calendar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(calendar)
//        NSLayoutConstraint.activate([
//            calendar.])
//        calendar.heightAnchor.constraint(equalToConstant: 350).isActive = true
//        calendar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
//        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        calendar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100)
//        calendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:  0)
  
        //calendar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //self.calendar = calendar
        
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 45, width: view.frame.size.width, height: 100))
//        self.view.addSubview(navBar)
//        navBar.prefersLargeTitles = true

        //let toggleBtn = UIBarButtonItem(title: "Toggle", style: .plain, target: nil, action: #selector(toggleCalendarView))
//        navItem.rightBarButtonItem = toggleBtn
//        navBar.setItems([navItem], animated: false)
        //navBar.backgroundColor = .black
        //navBar.barTintColor = .white
        
        //self.view.addSubview(navBar)
        
//        self.navigationController?.navigationBar.barTintColor = .black
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = "Meal Planner"
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//
//        self.navigationController?.navigationBar
        //self.navigationItem.leftBarButtonItem.
        //self.navigationItem.leftBarButtonItem?.isEnabled = true




//lazy var fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult> = {
//    let expressionDescription = NSExpressionDescription()
//    expressionDescription.name = "mealCount"
//
//    let arguments = [NSExpression(forKeyPath: "mealType")]
//    expressionDescription.expression = NSExpression(forFunction: "count:", arguments: arguments)
//
//    let fetchRequest: NSFetchRequest<NSDictionary> = Recipes.fetchRequest()
//    fetchRequest.propertiesToFetch = ["mealType", expressionDescription]
//    fetchRequest.propertiesToGroupBy = ["mealType"]
//    fetchRequest.resultType = .dictionaryResultType
//    
//    let sort = NSSortDescriptor(keyPath: #keyPath(Recipes.mealType), ascending: true)
//    fetchRequest.sortDescriptors = [sort]
//    
//    let fetchedResultsController = NSFetchedResultsController(
//    fetchRequest: fetchRequest,
//    managedObjectContext: coreDataStack.managedContext,
//    sectionNameKeyPath: nil, cacheName: nil)
//    
//    fetchedResultsController.delegate = self
//    return fetchedResultsController
//
//}()


 //let mealsForTheDay = NSManagedObject(entity: entity!, insertInto: coreDataStack.managedContext)
        //let mealsForTheDay = NSManagedObject(entity: entity!, insertInto: coreDataStack.managedContext)
        //mealsForTheDay.setValue([theSelectedDate:[selectedMeals]], forKey: "selectedRecipes")
        //mealsForTheDay.setValue(selectedMeals, forKey: theSelectedDate)
        
        //        let mealsForTheDay = Selections(context: coreDataStack.managedContext)
        //selectedRecipes?.updateValue(selectedMeals,forKey: theSelectedDate)
//        let mealsForTheDay = SelectedRecipes(context: coreDataStack.managedContext)
//        mealsForTheDay.selectedRecipes?.updateValue(selectedMeals, forKey: theSelectedDate)
//        coreDataStack.saveContext()
        //mealsForTheDay[theSelectedDate] = selectedMeals
        //self.calendar.scope = .month



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

//    private func setView() {
//
//        mealTypeTableView.delegate = self
//        mealTypeTableView.dataSource = self
//        mealTypeTableView.allowsMultipleSelection = true
//
//        nameOfRecipeTextField.delegate = self
//
//        nextToAddPhotoViewBtn.isHidden = true
//
//        self.view.addSubview(nameYourRecipe)
//        self.view.addSubview(nameOfRecipeTextField)
//        self.view.addSubview(mealTypeTableView)
//        self.view.addSubview(nextToAddPhotoViewBtn)
//
//
//        nameYourRecipe.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        nameYourRecipe.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 37).isActive = true
//        nameYourRecipe.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -37).isActive = true
//        nameYourRecipe.heightAnchor.constraint(equalToConstant: 73).isActive = true
//        nameYourRecipe.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160).isActive = true
//
//        nameOfRecipeTextField.topAnchor.constraint(equalTo: nameYourRecipe.topAnchor, constant: 81).isActive = true
//        nameOfRecipeTextField.heightAnchor.constraint(equalToConstant: 34).isActive = true
//        nameOfRecipeTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 28).isActive = true
//        nameOfRecipeTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -28).isActive = true
//
//        mealTypeTableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        mealTypeTableView.topAnchor.constraint(equalTo: nameOfRecipeTextField.bottomAnchor, constant: 15).isActive = true
//        mealTypeTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
//        mealTypeTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
//        mealTypeTableView.heightAnchor.constraint(equalToConstant: 345).isActive = true
//
//        nextToAddPhotoViewBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        nextToAddPhotoViewBtn.topAnchor.constraint(equalTo: mealTypeTableView.bottomAnchor, constant: 20).isActive = true
//        nextToAddPhotoViewBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 80).isActive = true
//        nextToAddPhotoViewBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -80).isActive = true
//
//        mealTypeTableView.register(MealTypeTableViewCell.self, forCellReuseIdentifier: "Cell")
//        mealTypeTableView.isScrollEnabled = false
//    }

//    let nameYourRecipe: UILabel = {
//        let label = UILabel()
//        label.text = "What is the name of your recipe?"
//        label.numberOfLines = 2
//        label.textAlignment = .center
//        label.textColor = UIColor.red
//        label.font = UIFont.init(name: "Helvetica Neue", size: 28)
//        label.font = label.font.with([.traitBold, .traitItalic])
//        label.backgroundColor = UIColor.black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    let nameOfRecipeTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "What is the name of your recipe?"
//        textField.borderStyle = .roundedRect
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    let mealTypeTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.separatorColor = UIColor.black
//        tableView.backgroundColor = UIColor.white
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//    let nextToAddPhotoViewBtn: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor.red
//        button.setTitle("Next", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
//        button.isHidden = true
//        button.addTarget(self, action: #selector(nextBtnClicked(_:)), for: .touchUpInside)
//
//        return button
//    }()


 // MARK: - TableView Methods
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if let selectedRows = mealTypeTableView.indexPathsForSelectedRows {
//            if selectedRows.count == limit {//could use variable named
//            displayMessage(userMessage: "You are limited to \(limit) selections")
//            return nil
//            }
//        }
//        return indexPath
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected \(mealType[indexPath.row])")
//
//        selectedMealType = mealType[indexPath.row]
//        if let cell = mealTypeTableView.cellForRow(at: indexPath){
//            if cell.isSelected {
//                cell.accessoryType = .checkmark
//            }
//        }
//
//        if let selectedRows = tableView.indexPathsForSelectedRows {
//            print("didDeselectRowAtIndexPath selected rows:\(selectedRows)")
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("deselected \(mealType[indexPath.row])")
//        //mealType.remove(at: indexPath.row)
//
//        //selectedMealType.remove(at: indexPath.row)
//        if let cell = mealTypeTableView.cellForRow(at: indexPath) {
//            cell.accessoryType = .none
//            selectedMealType = ""
//        }
//
//        if let selectedRows = mealTypeTableView.indexPathsForSelectedRows {
//            print("did DeselectRowAtIndexPath selected rows: \(selectedRows)")
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mealType.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//        cell.textLabel?.text = mealType[indexPath.row]
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 53
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "What kind of meal is this?"
//    }
    
//    @objc func nextBtnClicked(_ sender: Any) {
//        performSegue(withIdentifier: "toAddPhotoVC", sender: self)
//
//    }

//        let title = recipeTitle
//
//        let maxWidth = UIScreen.main.bounds.size.width - 60
//        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
//        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
//
//        while width > maxWidth {
//            fontSize -= 1
//            width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
//        }
//        if var titleAttributes = navigationController?.navigationBar.largeTitleTextAttributes {
//            titleAttributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: fontSize)
//            titleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
//
//            navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
//            navigationItem.title = title
//        }
