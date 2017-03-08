//
//  SevenDaysController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 2/14/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    private var timer = Timer()
    private var millisecond_counter = 0
    private var second_counter = 0
    private var minute_counter = 0
    private var hour_counter = 0
    @IBOutlet var timerLabel: UILabel!
    
    @IBAction func startAction(_ sender: Any) {
        // TODO: Don't allow timer to be "started" again once already started. Currently just speeds up the time
        //   -> probably just need to disable start button
        
        // We want there to only be two buttons: A Start button and a Pause/Reset button.
        //   When Start is pressed, Pause/Reset button should be "Pause" and Start should become disabled
        //   When Pause is pressed, Pause/Reset button should be "Reset"
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(TimerViewController.updateCounter), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func resetAction(_ sender: Any) {
        timer.invalidate()
        millisecond_counter = 0
        second_counter = 0
        minute_counter = 0
        hour_counter = 0
        timerLabel.text = String(format: "%02d", hour_counter) + ":" + String(format: "%02d", minute_counter) + ":" + String(format: "%02d", second_counter)
    }
    
    func updateCounter() {
        timerLabel.text = String(format: "%02d", hour_counter) + ":" + String(format: "%02d", minute_counter) + ":" + String(format: "%02d", second_counter)
        millisecond_counter += 1
        
        if (millisecond_counter == 1000) {
            millisecond_counter = 0
            second_counter += 1
        }
        
        if (second_counter == 60) {
            second_counter = 0
            minute_counter += 1
        }
        
        if (minute_counter == 60) {
            minute_counter = 0
            hour_counter += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timerLabel.text = String(format: "%02d", hour_counter) + ":" + String(format: "%02d", minute_counter) + ":" + String(format: "%02d", second_counter)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

