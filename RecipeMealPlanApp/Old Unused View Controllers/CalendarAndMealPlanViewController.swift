//
//  CalendarAndMealPlanViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 5/7/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

//import UIKit
//
//
//
//class CalendarAndMealPlanViewController: UIViewController {
//    
//    @IBOutlet weak var navigationBar: UINavigationBar!
//    @IBOutlet weak var calendarViewBtn: UIBarButtonItem!
//    @IBOutlet weak var mealPlannerView: UIView!
//    @IBOutlet weak var calendarView: UIView!
//    
//    
//    
//    var theSelectedDate = String()
//    var theSelectedMeals: [Recipe] = []
//    var mealsForTheDay: [String:[Recipe]] = [:]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //mealPlannerView.isHidden = true
//        setSelectedDate()
//        //setMealPlannerView()
//
//        //calendarController.delegate = self
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        //setSelectedDate()
//    }
//    
//    func setNavigationBar() {
//        
//        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        navigationBar.backgroundColor = .black
//    }
//    
//    func setMealPlannerView() {
//        
//        //view.addSubview(mealPlannerView)
//        mealPlannerView.isHidden = false
//        let mealPlannerVC = storyboard?.instantiateViewController(withIdentifier: "MyMealPlannerViewController") as! MyMealPlannerViewController
//        mealPlannerVC.selectionDelegate = self
//        addChild(mealPlannerVC)
//        mealPlannerVC.view.translatesAutoresizingMaskIntoConstraints = false
//        
//        mealPlannerView.addSubview(mealPlannerVC.view)
//        //self.view.addSubview(mealPlannerView)
//        
//        NSLayoutConstraint.activate([
//            mealPlannerVC.view.leadingAnchor.constraint(equalTo: mealPlannerView.leadingAnchor),
//            mealPlannerVC.view.trailingAnchor.constraint(equalTo: mealPlannerView.trailingAnchor),
//            mealPlannerVC.view.topAnchor.constraint(equalTo: mealPlannerView.topAnchor),
//            mealPlannerVC.view.bottomAnchor.constraint(equalTo: mealPlannerView.bottomAnchor)
//        ])
//        
//        mealPlannerVC.didMove(toParent: self)
//        
//    }
//    
//    func setSelectedDate() {
//        
//        
//        let calendarVC = storyboard?.instantiateViewController(withIdentifier: "MyCalendarViewController") as! MyCalendarViewController
//        calendarVC.selectionDelegate = self
//        addChild(calendarVC)
//        calendarVC.view.translatesAutoresizingMaskIntoConstraints = false
//        calendarView.addSubview(calendarVC.view)
//        
//        NSLayoutConstraint.activate([
//            calendarVC.view.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
//            calendarVC.view.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor),
//            calendarVC.view.topAnchor.constraint(equalTo: calendarView.topAnchor),
//            calendarVC.view.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor)
//        ])
//        
//        calendarVC.didMove(toParent: self)
//        mealPlannerView.isHidden = true
//        //mealPlannerView.removeFromSuperview()
//        //present(calendarVC, animated: true, completion: nil)
//    }
//    
//    func plannedMeals(selectedMeals: [Recipe]) {
//        mealsForTheDay[theSelectedDate] = selectedMeals
//        //mealPlannerView.removeFromSuperview()
//        //mealPlannerView.isHidden = true
//        
//        //mealPlannerView.removeFromSuperview()
//        //mealPlannerView.removeFromSuperview()
//        //setMealPlannerView()
//        
//    }
//}
//    
//extension CalendarAndMealPlanViewController: DateSelectionDelegate {
//    func didTapDateChoice(selectedDate: String) {
//        theSelectedDate = selectedDate
//        setMealPlannerView()
//        
//    }
//}
//
//extension CalendarAndMealPlanViewController: MealSelectionDelegate {
//    func didSelectMeals(selectedMeals: [Recipe]) {
//        theSelectedMeals = selectedMeals
//        print(theSelectedMeals)
//        plannedMeals(selectedMeals: theSelectedMeals)
//        theSelectedMeals.removeAll()
//    }
//}
//
//
