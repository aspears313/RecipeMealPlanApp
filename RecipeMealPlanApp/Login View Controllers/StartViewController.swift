//
//  StartViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 10/1/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "loggedIn", sender: nil)
        }
    }
    
    func setUp() {
        loginBtn.layer.cornerRadius = loginBtn.frame.height / 2.0
        signUpBtn.layer.cornerRadius = signUpBtn.frame.height / 2.0
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toLoginView", sender: self)
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUpView", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
    }
    

}
