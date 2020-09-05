//
//  AddPhotoViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony on 3/6/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
    
    @IBOutlet weak var addPhotoVCTitleLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var SelectAPictureBtn: UIButton!
    @IBOutlet weak var pictureBtn: UIButton!
    
    var imagePicker: ImagePicker!
    var newRecipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change how it is displayed
//        recipePic.layer.cornerRadius = recipePic.frame.height / 2.0
//        recipePic.clipsToBounds = true

       // self.navigationItem.title = newRecipe!.name!
                nextBtn.layer.cornerRadius = nextBtn.frame.height / 2.0
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        if let name = newRecipe?.name {
            addPhotoVCTitleLabel.text = "Do you have a picture for '\(name)'?"
        }
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(recognizer:)))
//        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func pictureBtnPressed(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddDescriptionVC" {
            let addDescriptionVC = segue.destination as! AddDescriptionViewController
            addDescriptionVC.newRecipe = self.newRecipe!
            addDescriptionVC.navigationItem.title = self.newRecipe?.name
        }
    }
}

extension AddPhotoViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        //self.recipePic.image = image
        self.pictureBtn.setBackgroundImage(image, for: .normal)
        self.newRecipe!.image = image?.pngData()
        //self.newRecipe!.image = image?.pngData()
    }
}
