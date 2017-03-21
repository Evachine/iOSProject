//
//  UserProfileController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit


class UserProfileViewController: UITableViewController {
   // var workoutInfo = ["FTP: ", "Workouts Completed: "]
   
   // var profileInfo = ["Name: ", "Email: "]
   var logoutOk = true
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      tableView.reloadData()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   @IBAction func saveToProfileViewController (segue:UIStoryboardSegue) {
      tableView.reloadData()
      
   }
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return 2
   }
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if section == 0 {
         return 1
      }
      else {
         return 3
      }
   }
   
   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      if (section == 0) {
         return "FTP Preference"
      }
      return "My Info"
   }
   
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
      
      if (indexPath.section == 0) {
         
         cell.textLabel?.text = String(describing: (currentUser?.ftp!)!)
      }
      
      if (indexPath.section == 1) {
         cell.selectionStyle = .none

         if (indexPath.row == 0) {
            cell.textLabel?.text = (currentUser?.firstName)! + " " + (currentUser?.lastName)!
         }
         else if (indexPath.row == 1) {
            cell.textLabel?.text = (currentUser?.email)!
         }
         else {
            cell.textLabel?.text = "Workouts Completed : " + String(describing: (currentUser?.workoutsCompleted!)!)
         }
         
      }
      
      
      return cell
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      if (indexPath.section == 0 && indexPath.row == 0) {
         performSegue(withIdentifier: "editingFTP", sender: self)
      }
      
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if (segue.identifier == "editingFTP") {
         if let editingVC = segue.destination as? FTPEditTableViewController {
            editingVC.shownFTP = currentUser?.ftp
         }
      }
   }
   
   @IBAction func logoutUser(_ sender: UIBarButtonItem) {
      
      let firebaseAuth = FIRAuth.auth()
      do {
         try firebaseAuth?.signOut()
         
      } catch let signOutError as NSError {
         logoutOk = false
         print ("Error signing out: %@", signOutError)
      }
      
      if logoutOk {
         performSegue(withIdentifier: "unwindLogin", sender: sender)
      }
      
   }
   
}
