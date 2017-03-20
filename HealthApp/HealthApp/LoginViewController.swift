//
//  LoginViewController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var email: String? = ""
    var password: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailText.delegate = self
        passwordText.delegate = self
        
        passwordText.isSecureTextEntry = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /*  if (textField == emailText) {
         //print("Email: \(textField.text)")
         
         email = textField.text!
         }
         
         if (textField == passwordText) {
         //  print("PW: \(textField.text)")
         
         password = textField.text!
         }
         */
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if (emailText.text != nil) {
            email = emailText.text
        }
        
        if passwordText.text != nil {
            password = passwordText.text
        }
        
        print("Email: \(email!)")
        print("Password: \(password!)")
        
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!) { (user, error) in
            
            if let user = user {
                let uid = user.uid  // Unique ID, which you can use to identify the user on the client side
                let email = user.email
                let photoURL = user.photoURL
                user.getTokenWithCompletion({ (token, error) in
                    // let idToken? = token  // ID token, which you can safely send to a backend
                })
                
                self.performSegue(withIdentifier: "loginIsPressed", sender: sender)
                
            }
            else {
                let alertController = UIAlertController(title: "Oops!", message: "Invalid email/password combination", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    print("You pressed OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        // TODO: Add functionality!
        
        
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "signupIsPressed", sender: sender)
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // Firebase stuff:
    
    //To create a new user with the passed in info:
    
    /*FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
     // ...
     }
     
     
     // To sign in:
     FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
     // ...
     }
     
     // To sign out:
     
     let firebaseAuth = FIRAuth.auth()
     do {
     try firebaseAuth?.signOut()
     } catch let signOutError as NSError {
     print ("Error signing out: %@", signOutError)
     }*/
}
