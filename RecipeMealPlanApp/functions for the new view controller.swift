//
//  functions for the new view controller.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 7/4/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import Foundation


//    func getIngredientsFromRecipes(selectedRecipes: [Recipe]) -> [Ingredients] {
//
//        var tempIngredients = [Ingredients]()
//        var tempCoreIngredients = [Ingredients]()
//
//        for recipe in selectedRecipes {
//            let ingredients = recipe.theseIngredients?.allObjects as! [Ingredients]
//
//            if tempCoreIngredients.isEmpty {
//                for ingredient in ingredients {
//                    tempCoreIngredients.append(ingredient)
//                }
//            } else {
//                for ingredient in ingredients {
//                    for tempCoreIngredient in tempCoreIngredients {
//                        if let name = ingredient.ingredientName, let coreName = tempCoreIngredient.ingredientName {
//                            if name != coreName {
//                                if !tempIngredients.contains(ingredient) {
//                                    tempIngredients.append(ingredient)
//                                } else {
//                                    break
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        for temp in tempIngredients {
//            if !tempCoreIngredients.contains(temp) {
//                tempCoreIngredients.append(temp)
//            }
//        }
//        return tempCoreIngredients
//    }


// MARK: - Will move these Functions
    
    // Will Probably move almost all these functions out of this view controller
    
    //Not using for this view controller
    
   
//
//    func fetchDatesAndRecipesThenConvertToObjects2() -> [String: [Recipe]] {
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Selections")
//
//        let sort = NSSortDescriptor(key: "selectedDate", ascending: true)
//        fetchRequest.sortDescriptors = [sort]
//
//        var myDictionary: [String: [String]] = [:]
//
//        do {
//            let results = try coreDataStack.mainContext.fetch(fetchRequest) as! [NSManagedObject]
//            for result in results {
//
//                let currentDay = result.value(forKey: "selectedDate") as! String
//                print(currentDay)
//                let reverseDateFormatter = DateFormatter()
//                reverseDateFormatter.dateFormat = "MM/dd/yyyy"
//                let date = reverseDateFormatter.date(from: currentDay)
//
//                if let date = date {
//                    if startOfWeekDate <= date && date <= endOfWeekDate {
//                        print("date is between startOfWeekDate and endOfWeekDate")
//                        myDictionary.updateValue(result.value(forKey: "selectedRecipes") as! [String], forKey: result.value(forKey: "selectedDate") as! String)
//                    } else
//                    {
//                        print("date is outside of the startOfWeekDate and endOfWeekDate")
//                    }
//                }
//            }
//        } catch let error as NSError {
//            print("ERROR: \(error.localizedDescription)")
//        }
//        //return myDictionary
//        let theConvertedDictionary = getTheRecipeObject(theDatesWithMealsDictionary: myDictionary)
//        return theConvertedDictionary
//    }
//
//    func fetchDatesAndRecipesConvertToObjects() -> [String:[Recipe]] {
//
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Selections")
//
//            let sort = NSSortDescriptor(key: "selectedDate", ascending: true)
//            fetchRequest.sortDescriptors = [sort]
//
//            var myDictionary: [String:[String]] = [:]
//
//            do {
//                let results = try coreDataStack.mainContext.fetch(fetchRequest) as! [NSManagedObject]
//                for result in results {
//                    myDictionary.updateValue(result.value(forKey: "selectedRecipes") as! [String], forKey: result.value(forKey: "selectedDate") as! String)
//                }
//            } catch let error as NSError {
//                print("ERROR: \(error.localizedDescription)")
//                //return [String:[String]]()
//            }
//        // This is where I can return my dictionary: [String:[String]]
//            let theReturnedDictionary = getTheRecipeObject(theDatesWithMealsDictionary: myDictionary)
//            getTheObjectsDictionary(recipeObjects: getTheRecipeObject(theDatesWithMealsDictionary: myDictionary))
//
//            return theReturnedDictionary
//        }
//    // This function converts the array of recipe names as String to an array of Recipe
//
////    func getTheIngredients(theDatesWithMealsDictionary: [String:[String]]) {
////
////        //This is not very efficient find a better way. If I have 100s of Recipes will completely slow down or crash
////
////        var selectedRecipe: [Recipe] = []
////        let fetchedRecipes = theFetchedRecipes()
////        var updatedDictonary: [String:[Recipe]] = [:]
////        var selectedIngredients: [String] = []
////
////        for (date,recipeNames) in theDatesWithMealsDictionary {
////            //print(date)
////            for selectedRecipeName in recipeNames {
////                //print(selectedRecipeName)
////                for recipe in fetchedRecipes {
////
////                    if let recipeName = recipe.name {
////
////                        //print(recipeName)
////                        if selectedRecipeName == recipeName {
////
////                            selectedRecipe.append(recipe)
////                            if let ingredients = recipe.ingredients {
////
////                                for ingredient in ingredients {
////
////                                    selectedIngredients.append(ingredient)
////                                }
////                            }
////                        }
////                    }
////                }
////            }
////            updatedDictonary.updateValue(selectedRecipe, forKey: date)
////            selectedRecipe.removeAll()
////        }
////        //return selectedIngredients
////    }
//
//    func getTheRecipeObject(theDatesWithMealsDictionary: [String:[String]]) -> [String:[Recipe]] {
//
//        //This is not very efficient find a better way. If I have 100s of Recipes will completely slow down or crash
//
//        var selectedRecipe: [Recipe] = []
//        let fetchedRecipes = theFetchedRecipes()
//        var updatedDictonary: [String:[Recipe]] = [:]
//
//        for (date,recipeNames) in theDatesWithMealsDictionary {
//            //print(date)
//            for selectedRecipeName in recipeNames {
//                //print(selectedRecipeName)
//                for recipe in fetchedRecipes {
//
//                    if let recipeName = recipe.name {
//
//                        //print(recipeName)
//                        if selectedRecipeName == recipeName {
//                            //MARK: Check this out later
//                            selectedRecipe.append(recipe)
//                            if let ingredients = recipe.theseIngredients {
//
//                                for ingredient in ingredients {
//
//
//                                    selectedIngredients.append(ingredient as! String)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            updatedDictonary.updateValue(selectedRecipe, forKey: date)
//            selectedRecipe.removeAll()
//        }
//        return updatedDictonary
//    }
//
    
//
//    func getTheObjectsDictionary(recipeObjects: [String:[Recipe]]){
//
//        for (key, value) in recipeObjects {
//            selectedRecipesWithDatesObjects.append(plannedMeals(sectionName: key, sectionObjects: value))
//        }
//    }
//}
