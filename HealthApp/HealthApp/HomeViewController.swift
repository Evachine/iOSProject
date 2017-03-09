//
//  HomeController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var currentDayLabel: UILabel!
    
    var currentDayOfTheWeek : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDayOfWeek()
        currentDayLabel.text = currentDayOfTheWeek
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDayOfWeek() {
        /* let todayDate = NSDate()
         let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier(rawValue: NSGregorianCalendar))
         let myComponents = myCalendar?.components(.CalendarUnitW, fromDate: todayDate)
         let weekDay = myComponents?.weekday
         */
        
        let todaysDate = Date()
        let calendar = Calendar.current
        
        print("Today's date: \(todaysDate)")
        var todayDateComponents = DateComponents()
        todayDateComponents.day = calendar.component(.day, from: todaysDate)
        todayDateComponents.month = calendar.component(.month, from: todaysDate)
        todayDateComponents.year = calendar.component(.year, from: todaysDate)
        
        if let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian),
            let date = gregorianCalendar.date(from: todayDateComponents as DateComponents) {
            let weekday = gregorianCalendar.component(.weekday, from: date)
            let weekdayString = getDayOfWeekString(i: weekday)
            currentDayOfTheWeek = weekdayString
            print(weekdayString) // 5, which corresponds to Thursday in the Gregorian Calendar
        }
        
        //  return weekDay
    }
    
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
}
