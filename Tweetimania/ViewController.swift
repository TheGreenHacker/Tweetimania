//
//  ViewController.swift
//  Tweetimania
//
//  Created by Jack Li on 9/7/19.
//  Copyright © 2019 Jack Li. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let swifter = Swifter(consumerKey: "tHuzwg23jp6z3VnfGegv5ZxEn", consumerSecret: "J3RFRLopARFBtC9iRL1NyAdcVxIo2ETcP8FM31F6hPApcjo9NS")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func predict(_ sender: UIButton) {
        
    }
    
}

