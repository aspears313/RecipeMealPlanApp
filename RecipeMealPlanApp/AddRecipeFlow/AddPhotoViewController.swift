//
//  AddPhotoViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
    
    @IBOutlet weak var recipePic: UIImageView!
    @IBOutlet weak var SelectAPictureBtn: UIButton!
    
    var selectedMealType: String = ""
    var picture: UIImageView?
    var imagePicker: ImagePicker!
    var recipeTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipePic.layer.cornerRadius = 25.0
        recipePic.clipsToBounds = true

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = recipeTitle
                
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(recognizer:)))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func selectAPicBtnPressed(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)

    }
    
    @IBAction func tapGesture(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            print("tap")
            self.imagePicker.present(from: view)
        }
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddDescriptionVC", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAddDescriptionVC" {
            let addDescriptionVC = segue.destination as! AddDescriptionViewController
            addDescriptionVC.recipeTitle = self.recipeTitle
            addDescriptionVC.recipePicture = self.recipePic
            addDescriptionVC.selectedMealType = self.selectedMealType
        }
    }
    

}

extension AddPhotoViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.recipePic.image = image
    }
}
