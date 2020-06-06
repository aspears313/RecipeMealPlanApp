//
//  AddRecipeViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 1/1/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

//import UIKit
//
//class OldAddRecipeViewController: UIViewController, UITextFieldDelegate{
//
//
//    @IBOutlet weak var customSegmentedControl: CustomSegmentedControl!
////    @IBOutlet weak var addDirectionsView: UIView!
////    @IBOutlet weak var addIngredientsView: UIView!
////    @IBOutlet weak var addDescriptionView: UIView!
//    @IBOutlet weak var nameOfRecipeTextField: UITextField!
//
////    private var descriptionViewController: descriptionViewController?
////    private var ingredientsChildViewController: ingredientsChildViewController?
//
//    //weak var currentViewController: UIViewController?
//    var newRecipe: Recipe?
//    var nameOfRecipe: String = ""
//    var pictureOfRecipe : UIImage?
//    var ingredients: [String] = []
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = "Your Recipe Name"
//        nameOfRecipeTextField.delegate = self
////        self.currentViewController = self.storyboard?.instantiateViewController(identifier: "toDescription")
////        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
////        self.addChild(self.currentViewController!)
////        self.addSubview(subView: self.currentViewController!.view, toView: self.addDirectionsView)
//    }
//
//    private func setupView() {
//
//        setupSegmentedControl()
//
//        updateView()
//    }
//
//    private func updateView() {
//
//        switch customSegmentedControl.selectedSegmentIndex {
//        case 0:
//            var descriptionViewController: DescriptionViewController = {
//                   let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//                   var viewController = storyboard.instantiateViewController(withIdentifier: "descriptionViewController") as! DescriptionViewController
//
//                   self.addViewControllerAsChildViewController(childViewController: viewController)
//
//                   return viewController
//               } ()
//            descriptionViewController.view.isHidden = false
////            ingredientsViewController.view.isHidden = true
////            directionsViewController.view.isHidden = true
//        case 1:
//            var ingredientsViewController: IngredientsViewController = {
//                   let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//                   var viewController = storyboard.instantiateViewController(withIdentifier: "ingredientsViewController") as! IngredientsViewController
//
//                   self.addViewControllerAsChildViewController(childViewController: viewController)
//
//                   return viewController
//               } ()
//           // descriptionViewController.view.isHidden = true
//            ingredientsViewController.view.isHidden = false
//           // directionsViewController.view.isHidden = true
//        default:
//            var directionsViewController: DirectionsViewController = {
//                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//
//                var viewController = storyboard.instantiateViewController(withIdentifier: "directionsViewController") as! DirectionsViewController
//
//                self.addViewControllerAsChildViewController(childViewController: viewController)
//
//                return viewController
//            } ()
//           // descriptionViewController.view.isHidden = true
//           // ingredientsViewController.view.isHidden = true
//            directionsViewController.view.isHidden = false
//        }
////        descriptionViewController.view.isHidden = !(customSegmentedControl.selectedSegmentIndex == 0)
////        ingredientsViewController.view.isHidden = (customSegmentedControl.selectedSegmentIndex == 1)
////        directionsViewController.view.isHidden = (customSegmentedControl.selectedSegmentIndex == 2)
////    }
//    }
//
//    private func setupSegmentedControl() {
//        customSegmentedControl.addTarget(self, action: #selector(selectionDidChange(sender: )), for: .valueChanged)
//
//
//        customSegmentedControl.selectedSegmentIndex = 0
//
//    }
//
////    @IBAction func selectionDidChange(_ sender: CustomSegmentedControl) {
////
////        updateView()
////    }
//    @objc func selectionDidChange(sender: CustomSegmentedControl) {
//
//       updateView()
//    }
//
//    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
//
//        // add container
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.isUserInteractionEnabled  = true
//        view.addSubview(containerView)
//        NSLayoutConstraint.activate([
//
//            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 280),
//            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -107)
//        ])
//
//        addChild(childViewController)
//        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(childViewController.view)
//        NSLayoutConstraint.activate([
//            childViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            childViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            childViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
//            childViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//        ])
//        childViewController.didMove(toParent: self)
//
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        super.touchesBegan(touches, with: event)
//        navigationItem.title = nameOfRecipeTextField.text
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        navigationItem.title = nameOfRecipeTextField.text
//
//        nameOfRecipe = nameOfRecipeTextField.text!
//        return false
//    }
//
////    func addSubview(subView: UIView, toView parentView: UIView) {
////        parentView.addSubview(subView)
////
////        var viewBindingsDict = [String: AnyObject]()
////        viewBindingsDict["subView"] = subView
////        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
////        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
////    }
//    func dataFromContainer(containerPicture: UIImage){
//        pictureOfRecipe = containerPicture
//    }
//
//
//    // MARK: - Button Actions
//
//
//
//    @IBAction func addRecipeToListBtnTapped(_ sender: Any) {
//        if nameOfRecipe.isEmpty {
//            displayMessage(userMessage:"You must have a name for your new recipe.")
//        } else if ingredients.isEmpty {
//            displayMessage(userMessage: "You must have at least one ingredient for your recipe")
//        }
//    }
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "addRecipe" {
//
//           // ingredients = ingredientsViewController.ingredients
//
//            nameOfRecipe = nameOfRecipeTextField.text!
//            //pictureOfRecipe = RecipePic.image
//
//            newRecipe = Recipe(nameOfRecipe: nameOfRecipe, ingredients: ingredients, imageOfRecipe: pictureOfRecipe)
//        }
//
//    }
//
//    func displayMessage(userMessage:String) -> Void {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
//
//            let OKAction = UIAlertAction(title: "OK", style: .default)
//            { (action:UIAlertAction!) in
//                // Code in this block will trigger when OK button tapped.
//                print("Ok button tapped")
//                //DispatchQueue.main.async {
//                  //  self.dismiss(animated: true, completion: nil)
//                //}
//            }
//            alertController.addAction(OKAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//
//    }
//
//}
//
//
//
