//
//  StopWatchViewController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 3/9/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import Firebase
import FirebaseAuthUI
import FirebaseAuth
import FirebaseDatabase
import UIKit

class StopWatchViewController: UIViewController {
    
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var millSecs: Int = 0
    var startPauseWatch: Bool = true
    var stopwatchString = ""
    
    var ref : FIRDatabaseReference!
    
    // Links to potentially fix our timer issues:
    //
    // http://stackoverflow.com/questions/35496203/nstimer-too-slow
    // https://developer.apple.com/reference/foundation/timer
    // https://developer.apple.com/reference/corefoundation/1543542-cfabsolutetimegetcurrent
    // https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFDatesAndTimes/CFDatesAndTimes.html#//apple_ref/doc/uid/10000125i
    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    
    @IBAction func workoutIsCompleted(_ sender: UIButton) {
        currentUser?.workoutsCompleted = (currentUser?.workoutsCompleted)! + 1
        self.ref.child("users/" + ((FIRAuth.auth()?.currentUser?.uid)!) + "/workoutsCompleted").setValue((currentUser?.workoutsCompleted)!)
    }
    
    
    @IBAction func startPause(_ sender: Any) {
        
        if startPauseWatch == true {
            timer = Timer.scheduledTimer(timeInterval: 0.01
                , target: self, selector: Selector("updateStopwatch"), userInfo: nil, repeats: true)
            
            startPauseWatch = false
            
            DispatchQueue.main.async {
                self.startPauseButton.setTitle("Pause", for: .normal)
            }
        }
        else {
            timer.invalidate()
            startPauseWatch = true
            
            DispatchQueue.main.async {
                self.startPauseButton.setTitle("Start", for: .normal)
            }
            
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        millSecs = 0
        seconds = 0
        minutes = 0
        stopwatchString = "00:00:00"
        stopwatchLabel.text = stopwatchString
    }
    
    func updateStopwatch() {
        
        millSecs += 1
        
        if millSecs == 100 {
            seconds += 1
            millSecs = 0
        }
        
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let millSecsString = millSecs > 9 ? "\(millSecs)" : "0\(millSecs)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString):\(secondsString):\(millSecsString)"
        stopwatchLabel.text = stopwatchString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference()
        
        // Do any additional setup after loading the view.
        
        stopwatchLabel.text = "00:00:00"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
