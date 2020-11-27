//
//  LoginViewController.swift
//  RecipeMealPlanApp
//
//  Created by Anthony Spears on 10/1/20.
//  Copyright © 2020 Anthony. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()

        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        loginBtn.layer.cornerRadius = loginBtn.frame.height / 2.0
        
        self.view.backgroundColor = .white
        
        email.delegate = self
        password.delegate = self
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    
    
    @IBAction func forgotPasswordBtnClicked(_ sender: Any) {
        
    }
    @IBAction func loginBtnClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!)
        { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "toHomeView", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
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

extension LoginViewController: UITextFieldDelegate {
    
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
