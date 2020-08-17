//
//  AppDelegate.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 4/28/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    // MARK: -
    
//    private let coreDataManager = CoreDataManager(modelName: "RecipeMealPlanApp")
//    private let coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
        if !previouslyLaunched {
            UserDefaults.standard.set(true, forKey: "previouslyLaunched")
            insertPredefinedObjects()
        }
        
//        let attrOne = NSDictionary(object: UIFont(name: "Helvetica", size: 16.0)!, forKey: NSAttributedString.Key.font as NSCopying)
//        
//        UISegmentedControl.appearance().setTitleTextAttributes(attrOne as! [NSAttributedString.Key : Any], for: .normal)
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = UINavigationController(rootViewController: StartingTabBarViewController())
//        window?.makeKeyAndVisible()
        
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
        
        let entity = NSEntityDescription.entity(forEntityName: "Ingredients", in: coreDataStack.mainContext)
                
        let recipeOne = Recipe(context: coreDataStack.mainContext)
        recipeOne.name = "Lasagne"
        recipeOne.image = UIImage(named: "Lasagne")?.pngData()
        recipeOne.mealType = "Dinner"
        var ingredsForRecipeOne = Set<Ingredients>()
        
        
        let recipeOneInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeOneInOne.ingredientName = "Lasagne Noodles"
        recipeOneInOne.measurement = "15"
        ingredsForRecipeOne.insert(recipeOneInOne)
    
        let recipeOneInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeOneInTwo.ingredientName = "Ground Veal"
        recipeOneInTwo.measurement = "1 cup(s)"
        ingredsForRecipeOne.insert(recipeOneInTwo)


        let recipeOneInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeOneInThree.ingredientName = "Red Sauce"
        recipeOneInThree.measurement = "2/3 cup(s)"
        ingredsForRecipeOne.insert(recipeOneInThree)


        let recipeOneInFour = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeOneInFour.ingredientName = "Garlic Powder"
        recipeOneInFour.measurement = "1 tsp(s)"
        ingredsForRecipeOne.insert(recipeOneInFour)

        recipeOne.theseIngredients = ingredsForRecipeOne as NSSet
        
        //////////////////////

        let recipeTwo = Recipe(context: coreDataStack.mainContext)
        recipeTwo.name = "Burger"
        recipeTwo.image = UIImage(named: "burger")?.pngData()
        recipeTwo.mealType = "Lunch"
        var ingredsForRecipeTwo = Set<Ingredients>()

         let recipeTwoInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
         recipeTwoInOne.ingredientName = "Burger Bun"
         recipeTwoInOne.measurement = "1"
         ingredsForRecipeTwo.insert(recipeTwoInOne)

         let recipeTwoInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
         recipeTwoInTwo.ingredientName = "Ground Beef"
         recipeTwoInTwo.measurement = "1/2 lb(s)"
         ingredsForRecipeTwo.insert(recipeTwoInTwo)


         let recipeTwoInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
         recipeTwoInThree.ingredientName = "Leaf Lettuce"
         recipeTwoInThree.measurement = "1"
         ingredsForRecipeTwo.insert(recipeTwoInThree)

        recipeTwo.theseIngredients = ingredsForRecipeTwo as NSSet

        /////////////////////////

        let recipeThree = Recipe(context: coreDataStack.mainContext)
        recipeThree.name = "Chicken Marsala"
        recipeThree.image = UIImage(named: "chicken marsala")?.pngData()
        recipeThree.mealType = "Dinner"
        var ingredsForRecipeThree = Set<Ingredients>()

        let recipeThreeInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeThreeInOne.ingredientName = "Chicken Breast"
        recipeThreeInOne.measurement = "1 lb(s)"
        ingredsForRecipeThree.insert(recipeThreeInOne)

        let recipeThreeInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeThreeInTwo.ingredientName = "Marsala Wine"
        recipeThreeInTwo.measurement = "1 1/2 cup(s)"
        ingredsForRecipeThree.insert(recipeThreeInTwo)


        let recipeThreeInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeThreeInThree.ingredientName = "Chicken Builloion"
        recipeThreeInThree.measurement = "1 cube"
        ingredsForRecipeThree.insert(recipeThreeInThree)

        let recipeThreeInFour = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeThreeInFour.ingredientName = "Garlic Powder"
        recipeThreeInFour.measurement = "1 tsp(s)"
        ingredsForRecipeThree.insert(recipeThreeInFour)

        recipeThree.theseIngredients = ingredsForRecipeThree as NSSet

        /////////////////////

        let recipeFour = Recipe(context: coreDataStack.mainContext)
        recipeFour.name = "Scrambled Eggs"
        recipeFour.image = UIImage(named: "breakfastPic")?.pngData()
        recipeFour.mealType = "Breakfast"
        var ingredsForRecipeFour = Set<Ingredients>()

        let recipeFourInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeFourInOne.ingredientName = "Large Eggs"
        recipeFourInOne.measurement = "4"
        ingredsForRecipeFour.insert(recipeFourInOne)

        let recipeFourInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeFourInTwo.ingredientName = "American Cheese"
        recipeFourInTwo.measurement = "3 Slices"
        ingredsForRecipeFour.insert(recipeFourInTwo)


        let recipeFourInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeFourInThree.ingredientName = "Milk"
        recipeFourInThree.measurement = "1 tbsp(s)"
        ingredsForRecipeFour.insert(recipeFourInThree)

        recipeFour.theseIngredients = ingredsForRecipeFour as NSSet

        //////////////////////////////////////////

        let recipeFive = Recipe(context: coreDataStack.mainContext)
        recipeFive.name = "Western Omelette"
        recipeFive.image = UIImage(named: "Western Omelette")?.pngData()
        recipeFive.mealType = "Breakfast"
        var ingredsForRecipeFive = Set<Ingredients>()

        let recipeFiveInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeFiveInOne.ingredientName = "Large Eggs"
        recipeFiveInOne.measurement = "3"
        ingredsForRecipeFive.insert(recipeFiveInOne)

        let recipeFiveInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeFiveInTwo.ingredientName = "Diced Ham"
        recipeFiveInTwo.measurement = "1/4 cup(s)"
        ingredsForRecipeFive.insert(recipeFiveInTwo)


        let recipeFiveInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeFiveInThree.ingredientName = "Diced Bacon"
        recipeFiveInThree.measurement = "2 Slices"
        ingredsForRecipeFive.insert(recipeFiveInThree)

        recipeFive.theseIngredients = ingredsForRecipeFive as NSSet

        ////////////////////

        let recipeSix = Recipe(context: coreDataStack.mainContext)
        recipeSix.name = "Macaroni Salad"
        recipeSix.image = UIImage(named: "Macaroni Salad")?.pngData()
        recipeSix.mealType = "Lunch"
        var ingredsForRecipeSix = Set<Ingredients>()

        let recipeSixInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeSixInOne.ingredientName = "Elbow Macaroni"
        recipeSixInOne.measurement = "3 cup(s)"
        ingredsForRecipeSix.insert(recipeSixInOne)

        let recipeSixInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeSixInTwo.ingredientName = "Diced Red Onion"
        recipeSixInTwo.measurement = "2 tbsp"
        ingredsForRecipeSix.insert(recipeSixInTwo)


        let recipeSixInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeSixInThree.ingredientName = "Mayonnaise"
        recipeSixInThree.measurement = "1/2 cup(s)"
        ingredsForRecipeSix.insert(recipeSixInThree)

        recipeSix.theseIngredients = ingredsForRecipeSix as NSSet

        /////////////////////

        let recipeSeven = Recipe(context: coreDataStack.mainContext)
        recipeSeven.name = "Fried Bologna Sandwich"
        recipeSeven.image = UIImage(named: "Fried Bologna Sandwich")?.pngData()
        recipeSeven.mealType = "Lunch"
        var ingredsForRecipeSeven = Set<Ingredients>()

        let recipeSevenInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeSevenInOne.ingredientName = "Bologna"
        recipeSevenInOne.measurement = "2 Slices"
        ingredsForRecipeSeven.insert(recipeSevenInOne)

        let recipeSevenInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeSevenInTwo.ingredientName = "Bread"
        recipeSevenInTwo.measurement = "2 Slices"
        ingredsForRecipeSeven.insert(recipeSevenInTwo)


        let recipeSevenInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeSevenInThree.ingredientName = "Spicy Brown Mustard"
        recipeSevenInThree.measurement = "1/2 tsp(s)"
        ingredsForRecipeSeven.insert(recipeSevenInThree)

        recipeSeven.theseIngredients = ingredsForRecipeSeven as NSSet

        ///////////////////

        let recipeEight = Recipe(context: coreDataStack.mainContext)
        recipeEight.name = "Mashed Potatoes"
        recipeEight.image = UIImage(named: "Mashed Potatoes")?.pngData()
        recipeEight.mealType = "Side Dish"
        var ingredsForRecipeEight = Set<Ingredients>()

        let recipeEightInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeEightInOne.ingredientName = "Yukon Gold Potatoes"
        recipeEightInOne.measurement = "6"
        ingredsForRecipeEight.insert(recipeEightInOne)

        let recipeEightInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeEightInTwo.ingredientName = "Garlic Powder"
        recipeEightInTwo.measurement = "1 tsp(s)"
        ingredsForRecipeEight.insert(recipeEightInTwo)


        let recipeEightInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeEightInThree.ingredientName = "Butter"
        recipeEightInThree.measurement = "1"
        ingredsForRecipeEight.insert(recipeEightInThree)

        recipeEight.theseIngredients = ingredsForRecipeEight as NSSet

        /////////////////////////////

        let recipeNine = Recipe(context: coreDataStack.mainContext)
        recipeNine.name = "Homemade Mac-N-Cheese"
        recipeNine.image = UIImage(named: "Mac - n - cheese")?.pngData()
        recipeNine.mealType = "Side Dish"
        var ingredsForRecipeNine = Set<Ingredients>()

        let recipeNineInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeNineInOne.ingredientName = "Elbow Macaroni"
        recipeNineInOne.measurement = "2 cup(s)"
        ingredsForRecipeNine.insert(recipeNineInOne)

        let recipeNineInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeNineInTwo.ingredientName = "Shredded Sharp Cheddar Cheese"
        recipeNineInTwo.measurement = "2 cup(s)"
        ingredsForRecipeNine.insert(recipeNineInTwo)


        let recipeNineInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeNineInThree.ingredientName = "Large Eggs"
        recipeNineInThree.measurement = "2"
        ingredsForRecipeNine.insert(recipeNineInThree)

        recipeNine.theseIngredients = ingredsForRecipeNine as NSSet

        /////////////////////////////////

        let recipeTen = Recipe(context: coreDataStack.mainContext)
        recipeTen.name = "Pumpkin Pie"
        recipeTen.image = UIImage(named: "Pumpkin Pie")?.pngData()
        recipeTen.mealType = "Dessert"
        var ingredsForRecipeTen = Set<Ingredients>()

        let recipeTenInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeTenInOne.ingredientName = "Frozen Pie Shell"
        recipeTenInOne.measurement = "1"
        ingredsForRecipeTen.insert(recipeTenInOne)

        let recipeTenInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeTenInTwo.ingredientName = "Pumpkin Puree"
        recipeTenInTwo.measurement = "1 can(s)"
        ingredsForRecipeTen.insert(recipeTenInTwo)


        let recipeTenInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeTenInThree.ingredientName = "Evaporated Milk"
        recipeTenInThree.measurement = "1 can(s)"
        ingredsForRecipeTen.insert(recipeTenInThree)

        recipeTen.theseIngredients = ingredsForRecipeTen as NSSet

        ////////////////////

        let recipeEleven = Recipe(context: coreDataStack.mainContext)
        recipeEleven.name = "Celery Sticks"
        recipeEleven.image = UIImage(named: "Celery Sticks")?.pngData()
        recipeEleven.mealType = "Snack"
        var ingredsForRecipeEleven = Set<Ingredients>()

        let recipeElevenInOne = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeElevenInOne.ingredientName = "Celery Stalks"
        recipeElevenInOne.measurement = "1"
        ingredsForRecipeEleven.insert(recipeElevenInOne)

        let recipeElevenInTwo = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeElevenInTwo.ingredientName = "Peanut Butter"
        recipeElevenInTwo.measurement = "2 tbsp(s)"
        ingredsForRecipeEleven.insert(recipeElevenInTwo)


        let recipeElevenInThree = Ingredients(entity: entity!, insertInto: coreDataStack.mainContext)
        recipeElevenInThree.ingredientName = "Raisens"
        recipeElevenInThree.measurement = "3 tbsp(s)"
        ingredsForRecipeEleven.insert(recipeElevenInThree)

        recipeEleven.theseIngredients = ingredsForRecipeEleven as NSSet
        
        coreDataStack.saveContext()
        
    }
   
}

