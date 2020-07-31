//
//  TakePhotoViewController.swift
//  Arm2
//
//  Created by Bianca on 1/31/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import Foundation
import UIKit

class TakePhotoViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {


    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            imagePicker.dismiss(animated: true, completion: nil)
            imageView.image = info[.originalImage] as? UIImage
        }
    }
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        present(imagePicker, animated: true, completion: nil)
        let vc = ViewController() //your view controller
        self.present(vc, animated: true, completion: nil)
    }
    

}
