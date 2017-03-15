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
   var workoutPlan: WorkoutPlan?
   var email: String?
   var password: String?
   
   init(firstName: String, lastName: String, workoutPlan: WorkoutPlan, email: String, password: String) {
      self.firstName = firstName
      self.lastName = lastName
      self.workoutPlan = workoutPlan
      self.email = email
      self.password = password
   }
   
   convenience init(firstName: String, workoutPlan: WorkoutPlan, email: String, password: String) {
       self.init(firstName: firstName, lastName: "", workoutPlan: workoutPlan, email: email, password: password)
   }
   
}
