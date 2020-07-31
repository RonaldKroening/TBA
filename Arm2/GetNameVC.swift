//
//  GetNameVC.swift
//  Arm2
//
//  Created by Bianca on 3/19/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import Foundation
import UIKit
class GetNameVC: UIViewController{
        
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var requiredLAB: UILabel!
    @IBOutlet weak var tf: UITextField!
    var userName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if(tf.text!.count > 0){
            nextButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
        }
    
    func folderCheck(){
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(mainPath)
        let documentDirecortPath = mainPath + "/UserInfo"
        var ojeCtBool : ObjCBool = true
        let isExit = FileManager.default.fileExists(atPath: documentDirecortPath, isDirectory: &ojeCtBool)
        print("isExit: ", isExit)
        if isExit == false {
            guard let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else { return }
            if let pathURL = URL.init(string: path) {
                let dataURL = pathURL.appendingPathComponent("UserInfo")
                do {
                    try FileManager.default.createDirectory(atPath: dataURL.absoluteString, withIntermediateDirectories: true, attributes: nil)
                } catch let error as NSError {
                    print(error.localizedDescription);
                }
            }
            else {
                print("Error in URL path");
            }
        }
    }
    
    func getUserName() -> String{
        return tf.text!
    }

    
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
    
    @IBAction func nextButton(_ sender: Any) {
        userName = getUserName()
        let defaults = UserDefaults.standard
        defaults.set(userName, forKey: "Name")
        performSegue(withIdentifier: "nametopic", sender: self)
        }
    }


