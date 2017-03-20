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
        
        let html = "<a id=1 href='?foo=bar&mid&lt=true'>One</a> <a id=2 href='?foo=bar&lt;qux&lg=1'>Two</a>"
        
        if let doc = HTML(html: html, encoding: .utf8) {
            print(doc.title!)
            
            // Search for nodes by CSS
            for link in doc.css("a, link") {
                print(link.text!)
                print(link["href"]!)
            }
            
            // Search for nodes by XPath
            for link in doc.xpath("//a | //link") {
                print(link.text!)
                print(link["href"]!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
