//
//  MyCalendarViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 5/7/20.
//  Copyright © 2020 Anthony. All rights reserved.
//
//
//import UIKit
//import FSCalendar
//
//protocol DateSelectionDelegate {
//    func didTapDateChoice(selectedDate: String)
//}
//
//
//class MyCalendarViewController: UIViewController {
//    
//    @IBOutlet var calendar: FSCalendar!
//    
//    var selectionDelegate: DateSelectionDelegate!
//    
//    fileprivate lazy var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        return formatter
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.setCalendarView()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    func setCalendarView() {
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
//    }
//    
//    
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension MyCalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
//    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
//        
//        return cell
//    }
//    
//    
//    
//    // Add animation to make transition look good.
//        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//            
//            print("did select date \(self.dateFormatter.string(from:date))")
//            
//            let selectedDate = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
//            
//            print("selected date is \(selectedDate)")
//            selectionDelegate.didTapDateChoice(selectedDate: selectedDate[0])
//            
//            if monthPosition == .next || monthPosition == .previous {
//                calendar.setCurrentPage(date, animated: true)
//            } else if self.calendar.scope == .month {
//                self.calendar.scope = .week
//            }
//        }
//}
