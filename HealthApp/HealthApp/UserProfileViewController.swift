//
//  UserProfileController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserProfileViewController: UITableViewController {
   var workoutInfo = ["FTP: ", "Workouts Completed: "]
    
    var profileInfo = ["Name: ", "Email: "]
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
            return workoutInfo.count
        }
        else {
            return profileInfo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 1) {
            return "My Info"
        }
        return ""
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      var displayInfo = ""
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        if (indexPath.section == 0) {
         
         if (indexPath.row == 0) {
            displayInfo = String(describing: (currentUser?.ftp!)!)
         }
         else {
             displayInfo = String(describing: (currentUser?.workoutsCompleted!)!)
            
            cell.selectionStyle = .none
         }
         
            cell.textLabel?.text = workoutInfo[indexPath.row] + displayInfo
        }
        
        if (indexPath.section == 1) {
         cell.selectionStyle = .none

         if (indexPath.row == 0) {
            displayInfo = (currentUser?.firstName)! + " " + (currentUser?.lastName)!
         }
         else {
            displayInfo = (currentUser?.email)!
         }
         
            cell.textLabel?.text = profileInfo[indexPath.row] + displayInfo
            
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
