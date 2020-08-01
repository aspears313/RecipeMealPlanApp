//
//  ViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 12/30/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit
import CoreData



class RecipeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //@IBOutlet weak var recipeListTableView: UITableView!
    let listTitle = "Recipe List"
    
    let recipeListTableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = UIColor.black
        tv.backgroundColor = UIColor.black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
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
        
        setupTableView()
        
        view.backgroundColor = UIColor.black
        recipeListTableView.backgroundColor = UIColor.black
        
        fetchedResultsController = recipeListFetchedResultsController()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        self.navigationItem.title = "Recipe List"
    }
    
   private func setNavigationBar() {
    
       let title = listTitle
    
       let maxWidth = UIScreen.main.bounds.size.width - 60
       var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
       var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
       
       while width > maxWidth {
           fontSize -= 1
           width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
       }
       if var titleAttributes = navigationController?.navigationBar.largeTitleTextAttributes {
           titleAttributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: fontSize)
           titleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
           
           navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
           navigationItem.title = title
       }
    }
    
    func setupTableView() {
        
        recipeListTableView.delegate = self
        recipeListTableView.dataSource = self
        
        recipeListTableView.register(RecipeListTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(recipeListTableView)
        
        NSLayoutConstraint.activate([
            recipeListTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 125),
            recipeListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            recipeListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            recipeListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)])
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let springTransform = CGAffineTransform(translationX: 0, y: recipeListTableView.bounds.size.height)
        cell.transform = springTransform
        
        UIView.animate(withDuration: 1.0, delay: 0.08, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options:
            .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recipeListTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        configure(cell: cell, for: indexPath)
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    func configure(cell: UITableViewCell, for indexPath: IndexPath) {

        guard let cell = cell as? RecipeListTableViewCell else { return }

        let currentRecipe = fetchedResultsController.object(at: indexPath)
        cell.recipeName.text = currentRecipe.name

        if let image = currentRecipe.image {
            cell.recipeImage.image = UIImage(data: image)
        } else {
            cell.recipeImage.image = UIImage(named: "No photo")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
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
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Recipe", in: coreDataStack.mainContext)
        
        let newRecipe = Recipe(entity: entityDescription!, insertInto: coreDataStack.mainContext)

        newRecipe.name = addDirectionsVC.newRecipe?.name
        newRecipe.image = addDirectionsVC.newRecipe?.image
        newRecipe.mealType = addDirectionsVC.newRecipe?.mealType
        newRecipe.recipeDescription = addDirectionsVC.newRecipe?.recipeDescription
        
        let newIngredients = addDirectionsVC.newIngredients

        var newIngredientsSet = Set<Ingredients>()

        for newIngredient in newIngredients {

            let entityDescriptionTwo = NSEntityDescription.entity(forEntityName: "Ingredients", in: coreDataStack.mainContext)
            
            let ingredient = Ingredients(entity: entityDescriptionTwo!, insertInto: coreDataStack.mainContext)

            ingredient.ingredientName = newIngredient.ingredientName
            ingredient.measurement = newIngredient.measurement

            newIngredientsSet.insert(ingredient)
        }
        
        //print(newIngredientsSet)
        newRecipe.theseIngredients = newIngredientsSet as NSSet

        coreDataStack.saveContext()
        setNavigationBar()
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
