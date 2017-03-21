//
//  User.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 3/15/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import Foundation

class User {
    
    var firstName: String?
    var lastName: String?
    var ftp: Int?
    var email: String?
    var workoutsCompleted: Int?
    
   init(firstName: String, lastName: String, ftp: Int, email: String, workoutsCompleted: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.ftp = ftp
        self.email = email
      self.workoutsCompleted = workoutsCompleted
    }
    
   convenience init(firstName: String, ftp: Int, email: String, workoutsCompleted: Int) {
      self.init(firstName: firstName, lastName: "", ftp: ftp, email: email, workoutsCompleted: workoutsCompleted)
    }
    
    func toAnyObject() -> Any {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "ftp": ftp,
            "email" : email,
            "workoutsCompleted": workoutsCompleted
        ]
    }
    
}
