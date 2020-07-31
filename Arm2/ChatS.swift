//
//  ViewController.swift
//  Arm2
//
//  Created by Bianca on 1/31/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import UIKit
import Foundation

class ChatS: UIViewController{
    
    @IBOutlet weak var questionsA: UITextField!
    
    @IBAction func finishedQ(_ sender: Any) {
        var send = questionsA.text
        questionsA.text = "Feature Unavailable due to circumstances."
        //do api call
        responseL.text = send
        //responseL.text = api response
    }
    @IBOutlet weak var responseL: UILabel!
    override func viewDidLoad() {
            super.viewDidLoad()


        }

          override func didReceiveMemoryWarning() {
              super.didReceiveMemoryWarning()
          }
}
    





