//
//  LoginViewController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

   @IBOutlet weak var emailText: UITextField!
   @IBOutlet weak var passwordText: UITextField!
   
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
      if (textField == emailText) {
         print("Email: \(textField.text)")
         
         emailText.text = textField.text
      }
      
      if (textField == passwordText) {
         print("PW: \(textField.text)")
         
         passwordText.text = textField.text
      }
      
      textField.resignFirstResponder()
      
      return true
   }

   
   @IBAction func loginButtonPressed(_ sender: UIButton) {
      
      print(emailText.text!)
      print(passwordText.text!)

      
   }
   
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

   
   /* Firebase crap:
    
    To create a new user with the passed in info: 
    
    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
    // ...
    }
    
    
    To sign in:
    FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
    // ...
    }
    
    To sign out:
    
    let firebaseAuth = FIRAuth.auth()
    do {
    try firebaseAuth?.signOut()
    } catch let signOutError as NSError {
    print ("Error signing out: %@", signOutError)
    }
    
    
    */
}
