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
import FirebaseDatabase

import LocalAuthentication // touchID stuff

var currentUserId: Int?
var currentUser: User?

class LoginViewController: UIViewController, UITextFieldDelegate {
   
   @IBOutlet weak var emailText: UITextField!
   @IBOutlet weak var passwordText: UITextField!
   
   var email: String? = ""
   var password: String? = ""
   var firstName: String? = ""
   var lastName: String? = ""
   var ftp: Int? = 0
   var workoutsCompleted: Int? = 0
   
   var ref : FIRDatabaseReference!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      emailText.delegate = self
      passwordText.delegate = self
      
      passwordText.isSecureTextEntry = true
      
      self.ref = FIRDatabase.database().reference()
      
      
      // Do any additional setup after loading the view.
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   @IBAction func loginWithTouch(_ sender: Any) {
      
      // create Authentication Context
      let authenticationContext = LAContext()
      
      var error:NSError?
      
      // check for fingerprint sensor
      // If not, show the user an alert view and bail out!
      guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
         showAlertViewIfNoSensor()
         return
      }
      
      // 3. Check the fingerprint
      authenticationContext.evaluatePolicy(
         .deviceOwnerAuthenticationWithBiometrics,
         localizedReason: "For my eyes only!",
         reply: { [unowned self] (success, error) -> Void in
            
            if( success ) {
               
               // Fingerprint recognized
               // TODO: Go to view controller
               //print("yay fingerprint worked!")
                
                self.email = "test_user@email.com"
                self.password = "password"
               
               self.tryToSignInWithInfo()
               
               
            }else {
               
              
                  self.showAlertViewIfFingerprintIsWrong()
               
            }
            
      })
      
   
   }
   
   func showAlertViewIfFingerprintIsWrong(){
      
      showAlertWithTitle(title: "Error", message: "Unable to identify fingerprint.")
      
   }
   
   func showAlertViewIfNoSensor(){
      
      showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
      
   }
   
   func showAlertWithTitle( title:String, message:String ) {
      
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alertVC.addAction(okAction)
      
      DispatchQueue.main.async {
         self.present(alertVC, animated: true, completion: nil)

      }

   }
   
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      return true
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      
      return true
   }
   
   
   @IBAction func loginButtonPressed(_ sender: UIButton) {
      
      if (emailText.text != nil) {
         email = emailText.text
      }
      
      if (passwordText.text != nil) {
         password = passwordText.text
      }
      
      tryToSignInWithInfo()
      
     /* FIRAuth.auth()?.signIn(withEmail: email!, password: password!) { (user, error) in
         
         if let user = user {
           
            user.getTokenWithCompletion({ (token, error) in
               // let idToken? = token  // ID token, which you can safely send to a backend
            })
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
               // Get user value
               
               currentUserId = Int(userID!) // set the current user ID, a global
               
               let value = snapshot.value as? NSDictionary
               //print(value)
               
               self.firstName = value?["firstName"] as! String
               self.lastName = value?["lastName"] as! String
               
               var ftpString = value?["ftp"] as! Int32
               self.ftp = Int(ftpString)
               
               
               var workoutsCompletedString = value?["workoutsCompleted"] as! Int32
               self.workoutsCompleted = Int(workoutsCompletedString)
               
               
               currentUser = User(firstName: self.firstName!, lastName: self.lastName!, ftp: self.ftp!, email: self.email!, workoutsCompleted: self.workoutsCompleted!)
               
               
               self.performSegue(withIdentifier: "loginIsPressed", sender: sender)
               
               // ...
            }) { (error) in
               print(error.localizedDescription)
            }
            
      
            
         }
         else {
            let alertController = UIAlertController(title: "Oops!", message: "Invalid email/password combination", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
               (result : UIAlertAction) -> Void in
               //print("You pressed OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
         }
      }*/
      
   }
   
   func tryToSignInWithInfo () {
      FIRAuth.auth()?.signIn(withEmail: email!, password: password!) { (user, error) in
         
         if let user = user {
            
            user.getTokenWithCompletion({ (token, error) in
               // let idToken? = token  // ID token, which you can safely send to a backend
            })
            
            let userID = FIRAuth.auth()?.currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
               // Get user value
               
               currentUserId = Int(userID!) // set the current user ID, a global
               
               let value = snapshot.value as? NSDictionary
               //print(value)
               
               self.firstName = value?["firstName"] as! String
               self.lastName = value?["lastName"] as! String
               
               var ftpString = value?["ftp"] as! Int32
               self.ftp = Int(ftpString)
               
               
               var workoutsCompletedString = value?["workoutsCompleted"] as! Int32
               self.workoutsCompleted = Int(workoutsCompletedString)
               
               
               currentUser = User(firstName: self.firstName!, lastName: self.lastName!, ftp: self.ftp!, email: self.email!, workoutsCompleted: self.workoutsCompleted!)
               
               
               self.performSegue(withIdentifier: "loginIsPressed", sender: self)
               
               // ...
            }) { (error) in
               print(error.localizedDescription)
            }
            
            
            
         }
         else {
            let alertController = UIAlertController(title: "Oops!", message: "Invalid email/password combination", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
            {
               (result : UIAlertAction) -> Void in
               //print("You pressed OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
         }
      }

   }
   
   
   @IBAction func signUpButtonPressed(_ sender: UIButton) {
      performSegue(withIdentifier: "signupIsPressed", sender: sender)
   }
   
   @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
      
   }
   
   
   
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
   
   
   
   }
