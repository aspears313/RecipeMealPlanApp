//
//  ViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 12/30/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit
import CoreData



class RecipeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeListTableView: UITableView!
    
    
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
//    var coreDataStack: CoreDataStack!
    var fetchedResultsController: NSFetchedResultsController<Recipe> = NSFetchedResultsController()
    
//    lazy var fetchedResultsController: NSFetchedResultsController<Recipe> = {
//
//
//            let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
//            let sort = NSSortDescriptor(key: #keyPath(Recipe.name), ascending: true)
//            fetchRequest.sortDescriptors = [sort]
//
//            let fetchedResultsController = NSFetchedResultsController(
//                fetchRequest: fetchRequest,
//                managedObjectContext: coreDataStack.mainContext, sectionNameKeyPath: nil,
//                cacheName: nil)
//
//            fetchedResultsController.delegate = self
//
//            return fetchedResultsController
//
//
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //loadSampleRecipes()
        
        fetchedResultsController = recipeListFetchedResultsController()
        
        self.recipeListTableView.delegate = self
        self.recipeListTableView.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        self.navigationItem.title = "Recipe List"
        
//        do {
//            try fetchedResultsController.performFetch()
//        } catch let error as NSError {
//            print("Fetching error: \(error), \(error.userInfo)")
//        }
        
    }
    
    func configure(cell: UITableViewCell, for indexPath: IndexPath) {

        guard let cell = cell as? RecipeListTableViewCell else {
          return
        }
        
       let currentRecipe = fetchedResultsController.object(at: indexPath)
        cell.nameOfRecipeCell.text = currentRecipe.name
        
        if let image = currentRecipe.image {
            cell.imageViewCell.image = UIImage(data: image)
        } else {
            cell.imageViewCell.image = UIImage(named: "No photo")
        }
      }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RecipeListTableViewCell else {
                    fatalError("The dequeued cell is not an instance of RecipeListTableViewCell.")
                }
        configure(cell: cell, for: indexPath)
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        var coreRecipes = fetchedResultsController.fetchedObjects!
        
        if editingStyle == .delete {
            let recipeToRemove = self.fetchedResultsController.object(at: indexPath)
            coreDataStack.mainContext.delete(recipeToRemove)
            coreDataStack.saveContext()
        }
    }
    
    @IBAction func toAddRecipeVC(_ sender: Any) {

        self.performSegue(withIdentifier: "toAddRecipeFlow", sender: self)
    }

    
    @IBAction func unwindToRecipeList(_ unwindSegue: UIStoryboardSegue) {
        
        let addDirectionsVC = unwindSegue.source as! AddDirectionsViewController
        
        let newRecipe = Recipe(context: coreDataStack.mainContext)
        
        newRecipe.name = addDirectionsVC.recipeTitle
        newRecipe.image = addDirectionsVC.recipePicture?.image?.pngData()
        newRecipe.ingredients = addDirectionsVC.listOfIngredients
        newRecipe.mealType = addDirectionsVC.selectedMealType
        
        coreDataStack.saveContext()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            
            if let indexPath = recipeListTableView.indexPathForSelectedRow{
                let recipeDetailsViewController = segue.destination as! RecipeDetailsViewController
                recipeDetailsViewController.recipe = self.fetchedResultsController.object(at: indexPath)
                recipeDetailsViewController.addMealBtn.isEnabled = false
            }
            }
        }
}

private extension RecipeListViewController {
    
    func recipeListFetchedResultsController() -> NSFetchedResultsController<Recipe> {
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest(),
            managedObjectContext: coreDataStack.mainContext,
            sectionNameKeyPath: nil,
            cacheName: nil)

        fetchedResultsController.delegate = self
        
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



extension RecipeListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.recipeListTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            recipeListTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            recipeListTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = recipeListTableView.cellForRow(at: indexPath!) as! RecipeListTableViewCell
            configure(cell: cell, for: indexPath!)
        case .move:
            recipeListTableView.deleteRows(at: [indexPath!], with: .automatic)
            recipeListTableView.insertRows(at: [newIndexPath!], with: .automatic)
        @unknown default:
            print("Unexpected NSFetchedResultsChangeType")
            }
        }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.recipeListTableView.endUpdates()
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


