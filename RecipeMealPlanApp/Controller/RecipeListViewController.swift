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

class RecipeListViewController: UIViewController {
    
    var recipeListCollectionView: UICollectionView!

    let placeholderView = UIView()
    var cell: UICollectionViewCell!
    let viewTitle = "Recipes"
    var recipeViewModels = [RecipeViewModel]()
    var fetchedResultsController: NSFetchedResultsController<Recipe>!
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setupCollectionView()
        fetchData()
        view.backgroundColor = UIColor.white
    }
    
    //MARK: - Initial Setup
    
    fileprivate func fetchData() {
        fetchedResultsController = DataManager.shared.fetchedResults()
        
        recipeViewModels = fetchedResultsController.fetchedObjects?.map({return RecipeViewModel(recipe: $0)}) ?? []
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
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
    
    //MARK: - IBAction functions
    
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
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Recipe", in: coreDataStack.mainContext)!
        
        let newRecipe = Recipe(entity: entityDescription, insertInto: coreDataStack.mainContext)

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
        recipeListCollectionView.reloadData()
    }
    
    //MARK: - Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            let recipeDetailsVC = segue.destination as! RecipeDetailsViewController
            if let indexPath = self.recipeListCollectionView.indexPath(for:cell ) {
                recipeDetailsVC.recipe = fetchedResultsController.object(at: indexPath)
                recipeDetailsVC.addMealBtn.isEnabled = false
                recipeDetailsVC.navigationItem.title = fetchedResultsController.object(at: indexPath).name
            }
        }
    }
}
// MARK: - CollectionView Delegate

extension RecipeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //fetchedResultsController.fetchedObjects?.count ?? 0
        return recipeViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        cell = recipeListCollectionView.cellForItem(at: indexPath)
        
        self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
        recipeListCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - CollectionView DataSource

extension RecipeListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recipeListCollectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
                
        let recipe = self.recipeViewModels[indexPath.row]
        cell.recipeViewModel = recipe
            
        return cell
    }
}
