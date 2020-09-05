//
//  CalendarViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/2/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import FSCalendar
import CoreData

class MealPlannerViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var mealChoiceView: UIView!
    @IBOutlet weak var calendarViewBtn: UIBarButtonItem!
    
    let coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    var theSelectedDate: String = ""
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setNavigationBar()
        self.setCalendarView()
        
        mealChoiceView.isHidden = true
        
        calendarViewBtn.tintColor = .white
        calendarViewBtn.title = "Week"
       
    }
    //MARK: - Set Views()
    func setMealPlannerView() {
            
            mealChoiceView.isHidden = false
            let mealPlannerVC = storyboard?.instantiateViewController(withIdentifier: "MealPlannerViewController") as! MealTypeAndCountViewController
            mealPlannerVC.selectionDelegate = self
            addChild(mealPlannerVC)
            mealPlannerVC.view.translatesAutoresizingMaskIntoConstraints = false
            
            mealChoiceView.addSubview(mealPlannerVC.view)
            
            NSLayoutConstraint.activate([
                mealPlannerVC.view.leadingAnchor.constraint(equalTo: mealChoiceView.leadingAnchor),
                mealPlannerVC.view.trailingAnchor.constraint(equalTo: mealChoiceView.trailingAnchor),
                mealPlannerVC.view.topAnchor.constraint(equalTo: mealChoiceView.topAnchor),
                mealPlannerVC.view.bottomAnchor.constraint(equalTo: mealChoiceView.bottomAnchor)
            ])
            mealPlannerVC.didMove(toParent: self)
    }
    
    func setCalendarView() {
        
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        
        //Setting up what calendar will look like
        self.calendar.backgroundColor = .white
        self.calendar.appearance.selectionColor = .red
        self.calendar.appearance.todaySelectionColor = .blue
        self.calendar.appearance.todayColor = .blue
        self.calendar.appearance.titleDefaultColor = .black
        self.calendar.appearance.titleWeekendColor = .blue
        self.calendar.appearance.headerTitleColor = .red
        self.calendar.appearance.weekdayTextColor = .red
    }
    
    func setNavigationBar() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .red
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationBar.backgroundColor = .red
    }
    
    @IBAction func toggleCalendarView() {
        print("toggle calendar view")
        if self.calendar.scope == .month {
            self.calendar.scope = .week
            self.mealChoiceView.isHidden = false
            self.calendarViewBtn.title = "Month"
        } else {
            self.calendar.scope = .month
            self.mealChoiceView.isHidden = true
            self.calendarViewBtn.title = "Week"
        }
    }
    
    func plannedMeal(selectedMeals: [String]) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Selections", in: coreDataStack.mainContext)
        let selection = Selections(entity: entity!, insertInto: coreDataStack.mainContext)
        
        selection.selectedDate = theSelectedDate
        selection.selectedRecipes = selectedMeals

        coreDataStack.saveContext()
    }
}



//MARK: - Calendar DataSource and Delegate Methods

extension MealPlannerViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return calendar.currentPage
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        
        return cell
    }
    // Add animation to make transition look good.
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from:date))")
        
        let selectedDate = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        theSelectedDate = selectedDate[0]
        print("selected date is \(selectedDate)")
        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        } else if self.calendar.scope == .month {
            self.calendar.scope = .week
            setMealPlannerView()
            self.calendarViewBtn.title = "Month" 
        }
    }
}

//MARK: - Conforming to Delegate method for meals
extension MealPlannerViewController: MealSelectDelegate {
    func didSelectMeals(selectedMeals: [String]) {
        let theSelectedMeals = selectedMeals
        plannedMeal(selectedMeals: theSelectedMeals)
    }
}
