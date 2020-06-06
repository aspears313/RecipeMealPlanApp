//
//  AppDelegate.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/28/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    // MARK: -
    
//    private let coreDataManager = CoreDataManager(modelName: "RecipeMealPlanApp")
//    private let coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let recipeListViewController = RecipeListViewController()
//        recipeListViewController.coreDataStack = coreDataStack
//        _ = coreDataStack.managedContext
//
        
        
        let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
        if !previouslyLaunched {
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
            insertPredefinedObjects()
        }
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count - 1] as URL)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func insertPredefinedObjects() {
        
        let lasagnePic = UIImage(named: "Lasagne")
        let burgerPic = UIImage(named: "burger")
        let chickenPic = UIImage(named: "chicken marsala")
        
        let recipeOne = Recipe(context: coreDataStack.mainContext)
        recipeOne.name = "Lasagne"
        recipeOne.image = lasagnePic?.pngData()
        recipeOne.ingredients = ["15 Lasagne Noodles","1 cup(s) Ground veal","2/3 cup(s) Red sauce", "1 tsp(s) garlic powder"]
        recipeOne.mealType = "Dinner"
        
        let recipeTwo = Recipe(context: coreDataStack.mainContext)
        recipeTwo.name = "Burger"
        recipeTwo.image = burgerPic?.pngData()
        recipeTwo.ingredients = ["1 Burger Bun","1/2 lb(s) Ground Beef","1 Leaf Lettuce"]
        recipeTwo.mealType = "Lunch"
        
        let recipeThree = Recipe(context: coreDataStack.mainContext)
        recipeThree.name = "Chicken Marsala"
        recipeThree.image = chickenPic?.pngData()
        recipeThree.ingredients = ["1 lb(s) Chicken Breast","1 1/2 cup(s) Marsala Wine","1 cube of chicken builloion", "1 tsp(s) garlic powder"]
        recipeThree.mealType = "Dinner"
        
        let recipeFour = Recipe(context: coreDataStack.mainContext)
        recipeFour.name = "Scrambled Eggs"
        recipeFour.image = UIImage(named: "breakfastPic")?.pngData()
        recipeFour.ingredients = ["4 large eggs","3 slices of American Cheese","1 tbsp Milk"]
        recipeFour.mealType = "Breakfast"
        
        let recipeFive = Recipe(context: coreDataStack.mainContext)
        recipeFive.name = "Western Omelette"
        recipeFive.image = UIImage(named: "Western Omelette")?.pngData()
        recipeFive.ingredients = ["3 large eggs","1/4 cup(s) diced ham","2 slices of diced bacon"]
        recipeFive.mealType = "Breakfast"
        
        let recipeSix = Recipe(context: coreDataStack.mainContext)
        recipeSix.name = "Macaroni Salad"
        recipeSix.image = UIImage(named: "Macaroni Salad")?.pngData()
        recipeSix.ingredients = ["3 cup(s) elbow macaroni","2 tbsp diced Red Onion","1/2 cup(s) Mayo"]
        recipeSix.mealType = "Lunch"
        
        let recipeSeven = Recipe(context: coreDataStack.mainContext)
        recipeSeven.name = "Fried Bologna Sandwich"
        recipeSeven.image = UIImage(named: "Fried Bologna Sandwich")?.pngData()
        recipeSeven.ingredients = ["2 slices Bologna","2 slices Bread","1/2 tsp spicy brown mustard"]
        recipeSeven.mealType = "Lunch"
        
        let recipeEight = Recipe(context: coreDataStack.mainContext)
        recipeEight.name = "Mashed Potatoes"
        recipeEight.image = UIImage(named: "Mashed Potatoes")?.pngData()
        recipeEight.ingredients = ["6 yukon gold potaoes","1 tsp(s) garlic powder","1 tbsp butter"]
        recipeEight.mealType = "Side Dish"
        
        let recipeNine = Recipe(context: coreDataStack.mainContext)
        recipeNine.name = "Homemade Mac-N-Cheese"
        recipeNine.image = UIImage(named: "Mac - n - cheese")?.pngData()
        recipeNine.ingredients = ["2 cup(s) elbow macaroni","2 cup(s) shredded sharp cheddar","2 large eggs"]
        recipeNine.mealType = "Side Dish"
        
        let recipeTen = Recipe(context: coreDataStack.mainContext)
        recipeTen.name = "Pumpkin Pie"
        recipeTen.image = UIImage(named: "Pumpkin Pie")?.pngData()
        recipeTen.ingredients = ["1 can Libbys pumpin pie puree","1 9in pie shell","1 can evaportated milk"]
        recipeTen.mealType = "Dessert"
        
        let recipeEleven = Recipe(context: coreDataStack.mainContext)
        recipeEleven.name = "Celery Sticks"
        recipeEleven.image = UIImage(named: "Celery Sticks")?.pngData()
        recipeEleven.ingredients = ["2 celery stalks","1 tbsp(s) peanut butter","1/4 cup(s) golden raisins"]
        recipeEleven.mealType = "Snack"
        
        coreDataStack.saveContext()    }
   
}

