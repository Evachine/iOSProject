//
//  WeeksTableViewController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 3/9/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit

class WeeksTableViewController: UITableViewController {
    
    var workouts: [String : String] = [:]
    var workoutId : Int? = 0
    
    func getDayOfWeekString(i: Int) -> String {
        
        var dayOfTheWeek: String = ""
        
        if(i == 2){
            dayOfTheWeek = "MONDAY";
        } else if (i==3){
            dayOfTheWeek = "TUESDAY";
        } else if (i==4){
            dayOfTheWeek = "WEDNESDAY";
        } else if (i==5){
            dayOfTheWeek = "THURSDAY";
        } else if (i==6){
            dayOfTheWeek = "FRIDAY";
        } else if (i==7){
            dayOfTheWeek = "SATURDAY";
        } else if (i==1){
            dayOfTheWeek = "SUNDAY";
        }
        
        return dayOfTheWeek
    }
    
    func getDayOfWeek() -> Int {
        let todaysDate = Date()
        let calendar = Calendar.current
        var weekday = 0
        
        print("Today's date: \(todaysDate)")
        var todayDateComponents = DateComponents()
        todayDateComponents.day = calendar.component(.day, from: todaysDate)
        todayDateComponents.month = calendar.component(.month, from: todaysDate)
        todayDateComponents.year = calendar.component(.year, from: todaysDate)
        
        if let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian),
            let date = gregorianCalendar.date(from: todayDateComponents as DateComponents) {
            weekday = gregorianCalendar.component(.weekday, from: date)
        }
        
        return weekday
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      if (currentUser != nil) {
         print("We have a user")
      }
      else {
         print("no user")
      }
      
        for day in 0...6 {
            // get user daysCompleted
            if let url = URL(string: "http://www.73summits.com/ergdb/api/workout/3198/80/json") {
                let session = URLSession.shared
                let download = session.dataTask(with: url) {
                    (data: Data?, response: URLResponse?, error: Error?) -> Void in
                    
                    if let data = data {
                        let json = JSON(data:data)
                        print("JSON")
                        print(json)
                        print("----")
                        
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let this = self else { return }
                            let arr = json.array!
                            var inputString = ""
                            
                            // keep in mind that the first workout is id == 2 on ErgDB
                            for index in 0...arr.count - 1 {
                                if (1 != index && index % 2 == 0) {
                                    let point1 = arr[index]
                                    let point2 = arr[index + 1]
                                    
                                    let interval = Int(point2[0].rawString()!)! - Int(point1[0].rawString()!)!
                                    let percent = Int(point1[1].rawString()!)!
                                    
                                    inputString = inputString + String(interval) + "\tminutes at " + String(percent) + String("%\tof your FTP\n")
                                }
                            }
                            
                            let key = this.getDayOfWeekString(i: this.getDayOfWeek() + day)
                            this.workouts[key] = inputString
                        }
                    }
                }
                
                download.resume()
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        
        let key = self.getDayOfWeekString(i: self.getDayOfWeek() + indexPath.row)
        cell.textLabel?.text = self.workouts[key]
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // workoutId = firebase.user.workoutsCompleted + 2 + IndexPath.row
        // set workoutId in WorkoutDisplayViewController to workoutId from here
        
        performSegue(withIdentifier: "displayWorkout", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let workoutVC = segue.destination as? WorkoutDisplayViewController {
            workoutVC.workoutId = self.workoutId
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
