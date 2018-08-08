    //
    //  LoginViewController.swift
    //  CubeMe
    //
    //  Created by William Fernandes on 05/08/18.
    //  Copyright © 2018 William Fernandes. All rights reserved.
    //
    
    import UIKit
    import Firebase
    import SVProgressHUD
    
    class LoginViewController: UIViewController {
        
        @IBOutlet weak var emailTextfield: UITextField!
        @IBOutlet weak var passwordTextfield: UITextField!
        @IBOutlet weak var loginButton: UIButton!
        @IBOutlet weak var registerButton: UIButton!
        
        let defaults = UserDefaults.standard
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if UserDefaults.standard.string(forKey: Constants.UserDefaults.currentUser) != nil {
                self.performSegue(withIdentifier: Constants.Segue.goToProfile, sender: self)
            }
            
            self.hideKeyboardWhenTappedAround()
            loginButton.setRoundConers()
            registerButton.setRoundConers()
            
        }
        
        @IBAction func logInPressed(_ sender: UIButton) {
            
            SVProgressHUD.show()
            Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                
                if error != nil {
                    
                    print(error!)
                    SVProgressHUD.dismiss()
                    //let image = UIImage(named: "error-sign")
                    //SVProgressHUD.setErrorImage(image!)
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                    
                } else {
                    print("Log in success!")
                    
                    SVProgressHUD.dismiss()
                    
                    self.defaults.set(Auth.auth().currentUser?.email, forKey: Constants.UserDefaults.currentUser)
                    
                    self.performSegue(withIdentifier: Constants.Segue.goToProfile, sender: self)
                    
                }
            }
        }
        
        
        @IBAction func registerPressed(_ sender: UIButton) {
            
            SVProgressHUD.show()
            
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) {
                (user, error) in
                
                if error != nil {
                    
                    print(error!)
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                    
                } else {
                    print("Registration Successful!")
                    
                    SVProgressHUD.dismiss()
                    
                    self.defaults.set(Auth.auth().currentUser?.email, forKey: Constants.UserDefaults.currentUser)
                    self.performSegue(withIdentifier: Constants.Segue.goToProfile, sender: self)
                }
            }
        }
    }
