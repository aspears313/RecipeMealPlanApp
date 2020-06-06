//
//  CoreDataStack.swift
//  RecipeAndMealPlanApp2
//
//  Created by Anthony on 4/25/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  
  private let modelName: String
  
  lazy var mainContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  init(modelName: String) {
    self.modelName = modelName
  }
  
  private lazy var storeContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: self.modelName)
    
    container.loadPersistentStores {
      (storeDescription, error) in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  func saveContext() {
    guard mainContext.hasChanges else { return}
    
    do {
        try mainContext.save()
        print("Successful")
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    } 
  }
}

