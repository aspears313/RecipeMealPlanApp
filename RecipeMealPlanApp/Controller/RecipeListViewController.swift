//
//  ViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 12/30/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import ChameleonFramework

class RecipeListViewController: UIViewController /*,UITableViewDataSource, UITableViewDelegate*/ {
    
    //@IBOutlet weak var recipeListTableView: UITableView!
    
    //@IBOutlet weak var recipeListCollectionViewLayout: CollectionViewSlantedLayout!
    //@IBOutlet weak var recipeListCollectionView: GeminiCollectionView!
    
    var recipeListCollectionView: UICollectionView!
//    let recipeListTableView: UITableView = {
//        let tv = UITableView()
//        tv.backgroundColor = UIColor.white
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        return tv
//    }()
//
    let placeholderView = UIView()
    
    let viewTitle = "Recipes"
    var cell: UICollectionViewCell?
    
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    var fetchedResultsController: NSFetchedResultsController<Recipe>!
        /*= NSFetchedResultsController()*/
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        view.backgroundColor = UIColor.white
        fetchedResultsController = fetchedResults()
        setupCollectionView()
//        recipeListCollectionView.dataSource = self
//        recipeListCollectionView.delegate = self
//        recipeListCollectionView.backgroundColor = .white
        //configure animation
        
        
        
        
        //recipeListCollectionView.dataSource = dataSource
        //updateSnapshot()
    }
    
//    func setupTableView() {
//        shoppingListTableView.delegate = self
//        shoppingListTableView.dataSource = self
//        shoppingListTableView.emptyDataSetDelegate = self
//        shoppingListTableView.emptyDataSetSource = self
//
//        shoppingListTableView.allowsMultipleSelection = true
//        shoppingListTableView.allowsMultipleSelectionDuringEditing = true
//
//        shoppingListTableView.backgroundView?.backgroundColor = .white
//        shoppingListTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//
//        shoppingListTableView.register(ShoppingListTableViewCellSection.self, forCellReuseIdentifier: "CellSection")
//        shoppingListTableView.register(ShoppingListTableViewCells.self, forCellReuseIdentifier: "Cell")
//
//        view.addSubview(shoppingListTableView)
//
//        NSLayoutConstraint.activate([
//            shoppingListTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
//            shoppingListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            shoppingListTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//            shoppingListTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
//            ])
//
//        shoppingListTableView.backgroundColor = .white
//    }
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width-60, height: 400)
        layout.minimumLineSpacing = 30
        
        
        recipeListCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        recipeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recipeListCollectionView.dataSource = self
        recipeListCollectionView.delegate = self
        recipeListCollectionView.backgroundColor = .white
        
        recipeListCollectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "RecipeCell")
        
        view.addSubview(recipeListCollectionView)
        
        NSLayoutConstraint.activate([
                                        recipeListCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                        recipeListCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                        recipeListCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                        recipeListCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }

    
    
    private func setNavigationBar() {

        let navigation = ReusableNavigation()
    
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigation.setNavigationBar()
        self.navigationController?.navigationBar.standardAppearance = navigation.setNavigationBar()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = viewTitle
    }
    
    @IBAction func toAddRecipeVC(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddRecipeFlow", sender: self)
    }

    @IBAction func signOutBtnClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        performSegue(withIdentifier: "toStartView", sender: self)
        
    }
    
    @IBAction func unwindToRecipeList(_ unwindSegue: UIStoryboardSegue) {
        
        let addDirectionsVC = unwindSegue.source as! AddDirectionsViewController
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Recipe", in: coreDataStack.mainContext)
        
        let newRecipe = Recipe(entity: entityDescription!, insertInto: coreDataStack.mainContext)

        newRecipe.name = addDirectionsVC.newRecipe?.name
        newRecipe.image = addDirectionsVC.newRecipe?.image
        newRecipe.mealType = addDirectionsVC.newRecipe?.mealType
        newRecipe.recipeDescription = addDirectionsVC.newRecipe?.recipeDescription
        newRecipe.directions = addDirectionsVC.directionsForRecipe
        
        let newIngredients = addDirectionsVC.newIngredients

        var newIngredientsSet = Set<Ingredients>()

        for newIngredient in newIngredients {

            let entityDescriptionTwo = NSEntityDescription.entity(forEntityName: "Ingredients", in: coreDataStack.mainContext)
            
            let ingredient = Ingredients(entity: entityDescriptionTwo!, insertInto: coreDataStack.mainContext)

            ingredient.ingredientName = newIngredient.ingredientName
            ingredient.measurement = newIngredient.measurement

            newIngredientsSet.insert(ingredient)
        }
        
        newRecipe.theseIngredients = newIngredientsSet as NSSet
        coreDataStack.saveContext()
        //updateSnapshot()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetailVC" {
            let recipeDetailsVC = segue.destination as! RecipeDetailsViewController
            if let indexPath = self.recipeListCollectionView.indexPath(for:cell! ) {
                recipeDetailsVC.recipe = fetchedResultsController.object(at: indexPath)
                recipeDetailsVC.addMealBtn.isEnabled = false
                recipeDetailsVC.navigationItem.title = fetchedResultsController.object(at: indexPath).name
            }
        }
    }
}

private extension RecipeListViewController {
    
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

// MARK: - Collection View Methods

extension RecipeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipeListCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
            let recipe = self.fetchedResultsController.object(at: indexPath)
            if let recipeImage = recipe.image {
                cell.recipeImage.image = UIImage(data: recipeImage)
            } else {
                cell.recipeImage.image = UIImage(named: "No photo")
            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        cell = recipeListCollectionView.cellForItem(at: indexPath)
        
        //Briefly fade the cell on selection
        UIView.animate(withDuration: 0.5,
                       animations: {
                        //Fade-out
                        self.cell?.alpha = 0.5
                       }) { (completed) in
            UIView.animate(withDuration: 0.5,
                           animations: {
                            //Fade-out
                            self.cell?.alpha = 1
                           })
        }
        
        self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
        recipeListCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension RecipeListViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        //updateSnapshot()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //updateSnapshot()
    }
}

