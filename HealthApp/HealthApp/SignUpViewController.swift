//
//  SignUpViewController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var password2Text: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstNameText.delegate = self
        lastNameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        password2Text.delegate = self
      
      passwordText.isSecureTextEntry = true
      password2Text.isSecureTextEntry = true
        
    }
   
   func passwordsMatch(pw1: String, pw2: String) -> Bool {
      if pw1 != pw2 {
         let alertController = UIAlertController(title: "Oops!", message: "Passwords don't match.", preferredStyle: UIAlertControllerStyle.alert)
         
         let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
         {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
         }
         alertController.addAction(okAction)
         self.present(alertController, animated: true, completion: nil)
         
         return false
      }
      else {
         return true
      }
   }
   
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == firstNameText) {
            firstNameText.text = textField.text
        }
        
        if (textField == lastNameText) {
            lastNameText.text = textField.text
        }
        
        if (textField == emailText) {
            emailText.text = textField.text
        }
        
        if (textField == passwordText) {
            passwordText.text = textField.text
        }
        
        if (textField == password2Text) {
            password2Text.text = textField.text
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneSigningUpPressed(_ sender: UIButton) {
        // TODO: Add functionality!
      FIRAuth.auth()?.createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
         
      //   print("creating user")
       //  print(user)
      }
      passwordsMatch(pw1: (passwordText?.text)!, pw2: (password2Text?.text)!)
      
        performSegue(withIdentifier: "doneSigningUpPressed", sender: sender)
    }
}
