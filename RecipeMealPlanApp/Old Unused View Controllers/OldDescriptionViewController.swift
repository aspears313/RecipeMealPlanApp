//
//  olddescriptionViewController.swift
//  RecipeListApp
//
//  Created by Anthony on 2/25/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

//import UIKit
//
//class OldDescriptionViewController: UIViewController {
//
//    var imagePicker: ImagePicker!
//    var picture: UIImageView?
//
//    @IBOutlet weak var RecipePic: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
//    @IBAction func showImagePicker(_ sender: UIButton) {
//
//        self.imagePicker.present(from: sender)
//
//    }
//
////    func sendDataToAddRecipeViewController(picture: UIImage) {
////    let addRecipeViewController = parent as! AddRecipeViewController
////        addRecipeViewController.dataFromContainer(containerPicture: picture)
//    //}
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension OldDescriptionViewController: ImagePickerDelegate {
//
//    func didSelect(image: UIImage?) {
//        self.RecipePic.image = image
//        picture?.image = image
//    }
//}
