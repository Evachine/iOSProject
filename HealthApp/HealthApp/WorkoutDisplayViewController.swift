//
//  WorkoutDisplayViewController.swift
//  HealthApp
//
//  Created by Evan Joseph Hench on 3/20/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import Foundation
import UIKit


class WorkoutDisplayViewController: UIViewController {
    
    @IBOutlet weak var workoutContents: UITextView!
    @IBOutlet weak var workoutTitle: UILabel!
    
    var workoutId : Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Instead of 3198, should get workout_id and add to user's worksoutsCompleted
        if let url = URL(string: "http://www.73summits.com/ergdb/api/workout/3198/80/json") {
            let session = URLSession.shared
            let download = session.dataTask(with: url) {
                (data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                if let data = data {
                    let json = JSON(data:data)
                    
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let this = self else { return }
                        this.workoutTitle!.text = "Workout of the Day"
                        let arr = json.array!
                        
                        for index in 0...arr.count - 1 {
                            if (1 != index && index % 2 == 0) {
                                let point1 = arr[index]
                                let point2 = arr[index + 1]
                                
                                let interval = Int(point2[0].rawString()!)! - Int(point1[0].rawString()!)!
                                let percent = Int(point1[1].rawString()!)!
                                
                                this.workoutContents!.text = this.workoutContents!.text + String(interval) + "\tminutes at " + String(percent) + String("%\tof your FTP\n")
                            }
                        }
                    }
                }
            }
            
            download.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
