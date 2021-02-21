//
//  StartViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 10/1/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class StartViewController: UIViewController {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        email.delegate = self
        password.delegate = self
        email.textColor = .white
        password.textColor = .white
        signInBtn.layer.cornerRadius = signInBtn.frame.height / 2.0
        //signInBtn.backgroundColor = .clear
        //signInBtn.layer.borderWidth = 2.0
        signInBtn.layer.borderColor = FlatRed().cgColor
        
        
        signUpBtn.layer.cornerRadius = signUpBtn.frame.height / 2.0
        signUpBtn.backgroundColor = .clear
        signUpBtn.layer.borderWidth = 2.0
        signUpBtn.layer.borderColor = FlatRedDark().cgColor
        
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!)
        { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loggedIn", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUpView", sender: self)
    }
    
    @IBAction func forgotPasswordBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toForgotPassword", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
    }
    

}

extension StartViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
        hideKeyboard()
    }
    
    func hideKeyboard() {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        hideKeyboard()
        return false
    }
    
}
