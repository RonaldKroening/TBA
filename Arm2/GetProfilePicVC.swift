//
//  GetProfilePicVC.swift
//  Arm2
//
//  Created by Bianca on 3/19/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import Foundation
import UIKit
class GetProfilePicVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var canProgress = false
    
    @IBOutlet weak var nextToFin: UIButton!
    
    @IBOutlet weak var userwel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        while(canProgress == false){
            nextToFin.isUserInteractionEnabled = false
        }
           
    }
    //Adding photos Stuff
      func alertMake(){
          let alert = UIAlertController(title: "Choose an Option", message: "", preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { action in
              self.openPhotoLibrary()
              }))
          alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { action in
              self.openCamera()
          }))
          alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
          
          }))
              self.present(alert, animated: true)
          }
      let imagePicker = UIImagePickerController()
      func openCamera() {
          imagePicker.sourceType = .camera
          imagePicker.delegate = self

          present(imagePicker, animated: true)
      }
      func openPhotoLibrary() {
           guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                     print("can't open photo library")
                     return
                 }
                 imagePicker.sourceType = .photoLibrary
                 imagePicker.delegate = self
                 present(imagePicker, animated: true)
      }
    
    @IBAction func macPic(_ sender: Any) {
        alertMake()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        canProgress = true
        if let pickedImage = info[.originalImage] as? UIImage {
            let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            print(mainPath)
            let documentDirecortPath = URL(string: mainPath + "/UserInfo")
            if let data = pickedImage.pngData() {
                let filename = documentDirecortPath!.appendingPathComponent("profilepic.png")
                    try? data.write(to: filename)
                }
        }
        picker.dismiss(animated: true, completion: nil)
    }
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
    @IBAction func nextToFin(_ sender: Any) {
        UserDefaults.standard.set(1, forKey: "UseCount")
        UserDefaults.standard.synchronize()
        performSegue(withIdentifier: "pictofin", sender: self)
    }
    
    
}

