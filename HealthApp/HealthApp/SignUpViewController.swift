//
//  SignUpViewController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit

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
        
        performSegue(withIdentifier: "doneSigningUpPressed", sender: sender)
    }
}

