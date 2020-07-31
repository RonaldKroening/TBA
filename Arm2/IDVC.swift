//
//  IDVC.swift
//  Arm2
//
//  Created by Bianca on 3/1/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import Foundation
import UIKit
import PDFKit


class IDVC: UIViewController{

    @IBAction func closed(_ sender: Any) {
        if sentVC == "SavedVC"{
            performSegue(withIdentifier: "backSa", sender: self)
        }else if sentVC == "SearchVC"{
            performSegue(withIdentifier: "backSe", sender: self)
        }
    }

    @IBOutlet weak var pdfTitle: UILabel!
    @IBOutlet weak var pdfView: PDFView!
    @IBAction func toSave(_ sender: Any) {
        
        let srcURL = Bundle.main.url(forResource: "Cases/"+send, withExtension: "pdf")!
        let destURL = URL(fileURLWithPath: "Saved/").appendingPathComponent(srcURL.lastPathComponent)
        
        do {
            try FileManager.default.copyItem(at: srcURL, to: destURL)
        } catch {
            print("copy failed:")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfTitle.text = send
        pdfView.document = PDFDocument(url: Bundle.main.url(forResource: "Cases/"+send, withExtension: "pdf")!)
        
    }
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
      }
}

