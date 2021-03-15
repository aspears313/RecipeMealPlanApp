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

    //@IBOutlet weak var bottomNavBar: UINavigationBar!
    @IBOutlet weak var addRecipe: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var recipeListCollectionView: UICollectionView!
    let placeholderView = UIView()
    var cell: UICollectionViewCell!
    let viewTitle = "Recipes"
    var recipeViewModels = [RecipeViewModel]()
    var fetchedResultsController: NSFetchedResultsController<Recipe>!
    lazy var coreDataStack = CoreDataStack(modelName: "RecipeMealPlanApp")
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, RecipeViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, RecipeViewModel>

    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setupCollectionView()
        fetchData()
        view.backgroundColor = UIColor.white
        applySnapshot(animatingDifferences: false)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addRecipe.isEnabled = !editing
        recipeListCollectionView.allowsMultipleSelection = editing
        recipeListCollectionView.indexPathsForSelectedItems?.forEach({ (indexPath) in
            recipeListCollectionView.deselectItem(at: indexPath, animated: false)
        })
        recipeListCollectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell = recipeListCollectionView.cellForItem(at: indexPath) as! RecipeCell
            cell.isEditing = editing
        }
    }
    
    //MARK: - Initial Setup
    
    fileprivate func fetchData() {
        fetchedResultsController = FetchManager.shared.fetchedResults()
        
        recipeViewModels = fetchedResultsController.fetchedObjects?.map({return RecipeViewModel(recipe: $0)}) ?? []
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        layout.itemSize = CGSize(width: view.frame.width-60, height: 400)
        layout.minimumLineSpacing = 30
        
        recipeListCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        recipeListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //recipeListCollectionView.dataSource = self
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
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    //MARK: - Button functions
    
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
        fetchData()
        applySnapshot(animatingDifferences: true)
    }
    
    //MARK: - Prepare for Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            let recipeDetailsVC = segue.destination as! RecipeDetailsViewController
            if let indexPath = self.recipeListCollectionView.indexPath(for:cell ) {
                recipeDetailsVC.recipe = fetchedResultsController.object(at: indexPath)
                recipeDetailsVC.addMealBtn.isEnabled = false
                recipeDetailsVC.addMealBtn.tintColor = UIColor.clear
                recipeDetailsVC.navigationItem.title = fetchedResultsController.object(at: indexPath).name
            }
        }
    }
}

// MARK: - CollectionView Delegate

extension RecipeListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            //let selectedRecipe = recipeViewModels[indexPath.item]
            //self.performSegue(withIdentifier: "toDetailVC", sender: selectedRecipe)
            cell = recipeListCollectionView.cellForItem(at: indexPath) as! RecipeCell
            self.performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
            recipeListCollectionView.deselectItem(at: indexPath, animated: true)
        }
        cell = recipeListCollectionView.cellForItem(at: indexPath) as! RecipeCell
    }
}

//MARK: - CollectionView DataSource

extension RecipeListViewController {
    
    func makeDataSource() -> DataSource {
      // 1
      let dataSource = DataSource(
        collectionView: recipeListCollectionView,
        cellProvider: { (recipeListCollectionView, indexPath, recipeViewModel) ->
          UICollectionViewCell? in
          // 2
          
          let cell = recipeListCollectionView.dequeueReusableCell(
            withReuseIdentifier: "RecipeCell",
            for: indexPath) as? RecipeCell
          
            let recipe = self.recipeViewModels[indexPath.row]
            cell?.recipeViewModel = recipe
            cell?.isEditing = self.isEditing
          return cell
      })
      return dataSource
    }
    
    // 1
    func applySnapshot(animatingDifferences: Bool = true) {
      // 2
      var snapshot = Snapshot()
      // 3
      snapshot.appendSections([0])
      // 4
      snapshot.appendItems(recipeViewModels)
      // 5
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
