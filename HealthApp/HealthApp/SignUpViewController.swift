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
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {
   
   @IBOutlet weak var firstNameText: UITextField!
   @IBOutlet weak var lastNameText: UITextField!
   @IBOutlet weak var emailText: UITextField!
   @IBOutlet weak var passwordText: UITextField!
   @IBOutlet weak var password2Text: UITextField!
   @IBOutlet weak var ftpPrefText: UITextField!
   
   @IBOutlet weak var doneButton: UIButton!
   
   let failed: String = "Authentication Failed"
   
   var firstName: String = ""
   var lastName: String = ""
   var ftp: Int?
   var email: String = ""
   var password: String = ""
   
   
   var ref : FIRDatabaseReference!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      self.ref = FIRDatabase.database().reference()
      
      firstNameText.delegate = self
      lastNameText.delegate = self
      emailText.delegate = self
      passwordText.delegate = self
      password2Text.delegate = self
      ftpPrefText.delegate = self
      
      passwordText.isSecureTextEntry = true
      password2Text.isSecureTextEntry = true
      
   }
   
   func passwordsMatch(pw1: String, pw2: String) -> Bool {
      if pw1 != pw2 {
         let alertController = UIAlertController(title: self.failed, message: "Passwords don't match.", preferredStyle: UIAlertControllerStyle.alert)
         
         let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
         {
            (result : UIAlertAction) -> Void in
            //print("You pressed OK")
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
      
      textField.resignFirstResponder()
      
      return true
   }
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func isValidEmail(testStr:String) -> Bool {
      // print("validate calendar: \(testStr)")
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
      
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: testStr)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if (segue.identifier == "doneSigningUpPressed") {
         currentUser = User(firstName: self.firstName, lastName: self.lastName, ftp: self.ftp!, email: self.email, workoutsCompleted: 0)
      }
      
      if (segue.identifier == "showFTPWebInfo") {
         
         if let ftpWebNav = segue.destination as? UINavigationController {
            if let webInfoVC = ftpWebNav.topViewController as? WebViewController {
               
               webInfoVC.url = "https://decaironman-training.com/2013/12/09/powerlevels-ftp-pros-vs-humans/comment-page-1/" 
            }
         }
         
         
      }
      

   }
   
   @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
      
   }
   
   @IBAction func doneSigningUpPressed(_ sender: UIButton) {
      // TODO: Add functionality!
      
      if (firstNameText.text != nil && firstNameText.text != "") {
         firstName = firstNameText.text!
         
         if (lastNameText.text != nil && lastNameText.text != "") {
            lastName = lastNameText.text!
            
            
            if (ftpPrefText.text != nil && (Int(ftpPrefText.text!) != nil)) {
               ftp = Int(ftpPrefText.text!)
            }
            
            if (emailText.text != nil && emailText.text != "") {
               if isValidEmail(testStr: emailText.text!) {
                  email = emailText.text!
                  
                  if ((passwordText.text != nil && passwordText.text != "") || (password2Text.text == nil && password2Text.text != "")) {
                     password = passwordText.text!
                     
                     if passwordsMatch(pw1: (passwordText?.text)!, pw2: (password2Text?.text)!) {
                        
                        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                           if error != nil {
                              let alertController = UIAlertController(title: self.failed, message: "User already exists.", preferredStyle: UIAlertControllerStyle.alert)
                              
                              let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                 (result : UIAlertAction) -> Void in
                                 //print("You pressed OK")
                              }
                              alertController.addAction(okAction)
                              self.present(alertController, animated: true, completion: nil)
                           }
                           else {
                              self.ref.child("users").child(user!.uid).setValue(["email": self.email,"firstName": self.firstName,"lastName": self.lastName, "workoutsCompleted": 0, "ftp": self.ftp!])
         
                              
                              self.performSegue(withIdentifier: "doneSigningUpPressed", sender: sender)
                              
                           }
                        }
                        
                        // TODO: Try to check if user already exists
                        
                     }
                     else {
                        let alertController = UIAlertController(title: self.failed, message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                           (result : UIAlertAction) -> Void in
                           //print("You pressed OK")
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                     }
                  }
                  else {
                     // create alert that they must provide both password fields
                     let alertController = UIAlertController(title: "Authentication Failed", message: "Must provide both password fields.", preferredStyle: UIAlertControllerStyle.alert)
                     
                     let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                        (result : UIAlertAction) -> Void in
                        //print("You pressed OK")
                     }
                     alertController.addAction(okAction)
                     self.present(alertController, animated: true, completion: nil)
                  }
               }
               else {
                  // tell user the email must be valid
                  let alertController = UIAlertController(title: self.failed, message: "Must provide a valid email address.", preferredStyle: UIAlertControllerStyle.alert)
                  
                  let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                     (result : UIAlertAction) -> Void in
                     //print("You pressed OK")
                  }
                  alertController.addAction(okAction)
                  self.present(alertController, animated: true, completion: nil)
               }
            }
            else {
               // create alert that there is no email
               let alertController = UIAlertController(title: self.failed, message: "Must provide an email address.", preferredStyle: UIAlertControllerStyle.alert)
               
               let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                  (result : UIAlertAction) -> Void in
                  //print("You pressed OK")
               }
               alertController.addAction(okAction)
               self.present(alertController, animated: true, completion: nil)
            }
         }
         else {
            // create alert that there is no last name
            let alertController = UIAlertController(title: self.failed, message: "Must provide a last name.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
               (result : UIAlertAction) -> Void in
               //print("You pressed OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
         }
      }
      else {
         let alertController = UIAlertController(title: self.failed, message: "Must provide a first name.", preferredStyle: UIAlertControllerStyle.alert)
         
         let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            //print("You pressed OK")
         }
         alertController.addAction(okAction)
         self.present(alertController, animated: true, completion: nil)
      }
   }
   
}
