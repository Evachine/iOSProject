//
//  WorkoutDisplayViewController.swift
//  HealthApp
//
//  Created by Evan Joseph Hench on 3/20/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Kanna


class WorkoutDisplayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://www.73summits.com/ergdb/api/workout/3198/292/json") {
            let session = URLSession.shared
            let download = session.dataTask(with: url) {
                (data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                if let data = data {
                    print("DATA:")
                    print(data)
                    print("----")
                    let json = JSON(data:data)
                    print("JSON:")
                    print(json)
                    print("----")
                    
//                    DispatchQueue.main.async {
//                        [weak self] in
//                        guard let this = self else { return }
//                        this.posLabel.text = json["features"][0]["properties"]["place"].stringValue
//                        this.tableButton.isEnabled = true
//                        this.features = json["features"]
//                    }
                }
            }
            
            download.resume()
        }
        
        
//        let myURLString = "http://rpmtraining.com/blog/"
//        var html = ""
//        guard let myURL = URL(string: myURLString) else {
//            print("Error: \(myURLString) doesn't seem to be a valid URL")
//            return
//        }
//        
//        do {
//            html = try String(contentsOf: myURL, encoding: .ascii)
//            print("HTML : \(html)")
//            
//            // Titles are in an <h2 class="entry-title"...
//            //
//            // Content is in a <p><strong>CROSSFIT...
//            // CSPORT content is same but it's <p class="p1"><strong>CSPORT......
//        }
//        catch let error {
//            print("Error: \(error)")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
