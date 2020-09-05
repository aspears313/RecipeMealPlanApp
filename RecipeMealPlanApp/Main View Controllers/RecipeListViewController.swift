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
    
    let recipeListTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var viewTitle = "Recipes"
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    var fetchedResultsController: NSFetchedResultsController<Recipe> = NSFetchedResultsController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setNavigationBar()
        //Was black
        view.backgroundColor = UIColor.white
        
        fetchedResultsController = recipeListFetchedResultsController()
        
    }
    
   private func setNavigationBar() {

    let navigation = ReusableNavigation()
    
    self.navigationController?.navigationBar.scrollEdgeAppearance = navigation.setNavigationBar()
    self.navigationController?.navigationBar.standardAppearance = navigation.setNavigationBar()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationBar.topItem?.title = viewTitle

    //This is will be used to some degree
    
//    let maxWidth = UIScreen.main.bounds.size.width - 60
//    var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
//    var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
//
//    while width > maxWidth {
//        fontSize -= 1
//        width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
//    }
//    if var titleAttributes = navigationController?.navigationBar.largeTitleTextAttributes {
//        titleAttributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: fontSize)
//        titleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
//
//        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
//        navigationItem.title = title
//       }
//    navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    func setupTableView() {
        
        recipeListTableView.delegate = self
        recipeListTableView.dataSource = self
        
        recipeListTableView.register(ListedRecipesTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(recipeListTableView)
        
        NSLayoutConstraint.activate([
            recipeListTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 140),
            recipeListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            recipeListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            recipeListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        recipeListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        recipeListTableView.backgroundColor = .white
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
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func configure(cell: UITableViewCell, for indexPath: IndexPath) {

        guard let cell = cell as? ListedRecipesTableViewCell else { return }

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
                recipeDetailsViewController.navigationItem.title = self.fetchedResultsController.object(at: indexPath).name
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
            let cell = recipeListTableView.cellForRow(at: indexPath!) as! ListedRecipesTableViewCell
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
