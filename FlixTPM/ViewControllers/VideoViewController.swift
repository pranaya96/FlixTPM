//
//  VideoViewController.swift
//  FlixTPM
//
//  Created by Pranaya Adhikari on 7/31/18.
//  Copyright © 2018 Pranaya Adhikari. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController, WKUIDelegate{
    
    var webView:WKWebView!
    var trailerKeyForVideo:String!
    
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let myURL = URL(string:"https://www.youtube.com/watch?v=\(trailerKeyForVideo!)")
        let myRequest = URLRequest(url: myURL!)
         webView.load(myRequest)
        // Do any additional setup after loading the view.
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
