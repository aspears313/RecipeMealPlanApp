//
//  DataManager.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 2/28/21.
//  Copyright © 2021 Anthony. All rights reserved.


import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    func fetchedResults() -> NSFetchedResultsController<Recipe> {
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest(),
            managedObjectContext: coreDataStack.mainContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }

        return fetchedResultsController
    }
    
    func fetchRequest() -> NSFetchRequest<Recipe> {
        
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(Recipe.name), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        return fetchRequest
    }
}
