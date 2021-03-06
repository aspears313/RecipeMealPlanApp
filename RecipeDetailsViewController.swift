//
//  RecipeDetailsViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 12/31/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
        
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addMealBtn: UIBarButtonItem!
    
    var recipe: Recipe?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
    }

    private func setNavigationBar() {
        
        let navigation = ReusableNavigation()
        
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigation.setNavigationBar()
        self.navigationController?.navigationBar.standardAppearance = navigation.setNavigationBar()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //self.navigationController?.navigationBar.topItem?.title = recipe?.name!
//        guard let title = recipe?.name, #available(iOS 11.0, *) else { return}
//
//        let maxWidth = UIScreen.main.bounds.size.width - 60
//        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
//        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
//
//        while width > maxWidth {
//            fontSize -= 1
//            width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
//        }
//
//        if var titleAttributes = navigationController?.navigationBar.largeTitleTextAttributes {
//            titleAttributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: fontSize)
//            titleAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
//
//            navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
//        }
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
        
        let font = UIFont.systemFont(ofSize: 20)
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.black]
        segmentedControl.setTitleTextAttributes(normalAttribute, for: .normal)
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.red]
        segmentedControl.setTitleTextAttributes(selectedAttribute, for: .selected)
        segmentedControl.selectedSegmentTintColor = .white
        
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
            containerView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 20),
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
