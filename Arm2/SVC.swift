//
//  SVC.swift
//  Arm2
//
//  Created by Bianca on 7/28/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

class SVC: UIViewController{


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "/Cases/State v Allen", ofType: "pdf") // read resource name: pdf.pdf
        let url = URL(fileURLWithPath: path!)
        let pdfDocument = PDFDocument(url:url)
//        pdfView.displayMode = .singlePageContinuous
//        pdfView.displayDirection = .vertical
//        pdfView.document = pdfDocument
                
//        imV.image = makeThumbnail(pdfDocument: pdfDocument, page: 1)
            
        
    }
    func makeThumbnail(pdfDocument: PDFDocument?, page: Int) -> UIImage? {
        return pdfDocument?.page(at: page)?.thumbnail(of: CGSize(width: 40, height: 40), for: .artBox)
    }
        
//        let pdfD = PDFDocument(url: fileURLs[0])
//        view1.document = pdfD
        //let nvc = ChatS()
        //navigationController?.pushViewController(nvc, animated: true)
    }
    

