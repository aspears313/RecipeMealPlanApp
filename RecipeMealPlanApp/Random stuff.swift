//
//  Random stuff.swift
//  RecipeAndMealPlanApp2
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
