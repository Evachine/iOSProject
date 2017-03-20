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
    var workoutInfo = ["Favorites", "Current plan"]
    
    var profileInfo = ["Name: ", "Email: ", "Password: "]
    var logoutOk = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return profileInfo.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 1) {
            return "My Profile"
        }
        return ""
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as UITableViewCell
        
        if (indexPath.section == 0) {
            cell.textLabel?.text = workoutInfo[indexPath.row]
        }
        
        if (indexPath.section == 1) {
            cell.textLabel?.text = profileInfo[indexPath.row]
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            performSegue(withIdentifier: "SegueToFavorites", sender: self)
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
