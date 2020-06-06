//
//  RecipeDetailsViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 12/31/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
    
    var recipe: Recipe?
        
    @IBOutlet weak var addMealBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = recipe?.name
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
        
    }
    
    private func updateView() {
        
        switch customSegmentedControl.selectedSegmentIndex {
                case 0:
                    let descriptionViewController: DescriptionViewController = {
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        
                        let viewController = storyboard.instantiateViewController(identifier: "descriptionViewController") as! DescriptionViewController
                        viewController.recipe = recipe
                        
                        self.addViewControllerAsChildViewController(childViewController: viewController)
                        
                        return viewController
                    } ()
                    descriptionViewController.view.isHidden = false
                case 1:
                    let ingredientsViewController: IngredientsViewController = {
                           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

                        let viewController = storyboard.instantiateViewController(withIdentifier: "ingredientsViewController") as! IngredientsViewController
                        //Setup View Controller
                        viewController.recipe = recipe
                    
//                        if let ingredients = recipe?.ingredients {
//                            viewController.ingredients =
//                        }
//                        viewController.ingredients = recipe?.ingredients as? [String]
                                              
                           self.addViewControllerAsChildViewController(childViewController: viewController)

                           return viewController
                       } ()
                    ingredientsViewController.view.isHidden = false
                default:
                
                    let directionsViewController: DirectionsViewController = {
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

                        let viewController = storyboard.instantiateViewController(withIdentifier: "directionsViewController") as! DirectionsViewController
                        //Setup View Controller
                        viewController.recipe = recipe

                        self.addViewControllerAsChildViewController(childViewController: viewController)

                        return viewController
                    } ()
                    directionsViewController.view.isHidden = false
                }
        
            }

    private func setupSegmentedControl() {
        customSegmentedControl.addTarget(self, action: #selector(selectionDidChange), for: .valueChanged)
        
        customSegmentedControl.selectedSegmentIndex = 0
    }
    
    @objc private func selectionDidChange() {
        updateView()
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        
        // add container
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.isUserInteractionEnabled  = true
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])

        addChild(childViewController)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childViewController.view)
        NSLayoutConstraint.activate([
            childViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        childViewController.didMove(toParent: self)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
