//
//  WorkoutDisplayViewController.swift
//  HealthApp
//
//  Created by Evan Joseph Hench on 3/20/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase
import UIKit


class WorkoutDisplayViewController: UIViewController {
    
    @IBOutlet weak var workoutContents: UITextView!
    @IBOutlet weak var workoutTitle: UILabel!
    
    var workoutId : Int = 0
    var ref : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()
        
        let _ = ref.observe(FIRDataEventType.value, with: { (snapshot) in
            let _ = snapshot.value as? [String : AnyObject] ?? [:]
            
            self.workoutId = (currentUser?.workoutsCompleted)! + 2
//            let urlString1 = "http://www.73summits.com/ergdb/api/workout/" + String(self.workoutId)
//            let urlString2 = "/" + String((currentUser?.ftp)!) + "/json"
//            let urlString3 = String(urlString1 + urlString2)!
//            print(urlString3)
//            print("http://www.73summits.com/ergdb/api/workout/3198/80/json")
            if let url = URL(string: "http://www.73summits.com/ergdb/api/workout/3198/80/json") {
                let session = URLSession.shared
                let download = session.dataTask(with: url) {
                    (data: Data?, response: URLResponse?, error: Error?) -> Void in
                    
                    if let data = data {
                        let json = JSON(data:data)
                        //print("JSON")
                        //print(json)
                        //print("---")
                        
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let this = self else { return }
                           // this.workoutTitle!.text = "Workout of the Day"
                            let arr = json.array!
                            
                            for index in 0...arr.count - 1 {
                                if (1 != index && index % 2 == 0) {
                                    let point1 = arr[index]
                                    let point2 = arr[index + 1]
                                    
                                    let interval = Int(point2[0].rawString()!)! - Int(point1[0].rawString()!)!
                                    let percent = Int(point1[1].rawString()!)!
                                    let ftp = Double((currentUser?.ftp)!) * 0.85 * Double(percent) / 100.0
                                    
                                    
                                    this.workoutContents!.text = this.workoutContents!.text + String(interval) + " minutes at " + String(Int(ftp)) + String("W\n")
                                }
                            }
                        }
                    }
                }
                
                download.resume()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
