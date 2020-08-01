//
//  RecipeDetailsViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 12/31/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var recipe: Recipe?
        
    @IBOutlet weak var addMealBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = recipe?.name

        setupView()
    }

    private func setNavigationBar() {
        
        guard let title = recipe?.name, #available(iOS 11.0, *) else { return}
        
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
        }
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
        setNavigationBar()
    }
    
    private func updateView() {
        
        switch segmentedControl.selectedSegmentIndex {
                case 0:
                    let descriptionViewController: DescriptionAndPicutreViewController = {
                        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        
                        let viewController = storyboard.instantiateViewController(identifier: "descriptionViewController") as! DescriptionAndPicutreViewController
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
        
        let font = UIFont.systemFont(ofSize: 18)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        segmentedControl.addTarget(self, action: #selector(selectionDidChange), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
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
}
