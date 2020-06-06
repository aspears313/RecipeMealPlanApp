//
//  CoreDataManager.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 5/27/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
    
    //MARK: - Properties
    
    private let modelName: String
    
    //MARK: - Initialization
    
    public init(modelName: String) {
        //Set model Name
        self.modelName = modelName
        
    }
    
    //MARK: - Core Data Stack
    private lazy var managedObjectModel: NSManagedObjectModel = {
        // Fetch model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else{
        fatalError("Unable to Find Data Model")
        }
    
    
        // Initialize Managed Object Model
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        //Initialize Persistent Store Coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        // Helpers
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        // URL Documents Directory
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // URL Persistent Store
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption : true
            ]
            
            // Add Persistent Store
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)
        } catch {
            fatalError("Unable to Add Persistent Store")
        }
        return persistentStoreCoordinator
    }()
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managd Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Configure Managaged Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    } ()
    
    public private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.parent = self.privateManagedObjectContext
        
        return managedObjectContext
    }()
    
    public func saveChanges() {
        mainManagedObjectContext.performAndWait {
            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                print("Unable to save changes of main managed object context")
                print("\(error), \(error.localizedDescription)")
            }
        }
        
        privateManagedObjectContext.perform {
            do {
                if self.privateManagedObjectContext.hasChanges {
                    try self.privateManagedObjectContext.save()
                }
            } catch {
                print("Unable to save changes of private managed object context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
    
    public func privateChildManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        managedObjectContext.parent = mainManagedObjectContext
        
        return managedObjectContext
    }
}
