//
//  WebViewController.swift
//  HealthApp
//
//  Created by Emily K. Nguyen on 3/21/17.
//  Copyright © 2017 Emily K. Nguyen. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
   
   @IBOutlet weak var webView: UIWebView!
   
   
   var url: String? {
      didSet {
         if url != oldValue {
            loadWebpage()
         }
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      loadWebpage()
      // Do any additional setup after loading the view.
      
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func loadWebpage() {
      if let urlString = url {
         if let url = URL(string: urlString) {
            let req = URLRequest(url: url)
            webView?.loadRequest(req)
         }
      }
   }
   
   
   @IBAction func goBackToSignUp(_ sender: Any) {
      
      performSegue(withIdentifier: "unwindToSignUp", sender: sender)
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
