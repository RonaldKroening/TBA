//
//  ClosetViewController.swift
//  Arm2
//
//  Created by Bianca on 1/31/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//
import Foundation
import UIKit
import PDFKit
import Foundation

public var sentVC: String = String()
public var send: String = String()
class SearchVC: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    var itemAr: [UIImage] = []
    var titleAr: [String] = []
    var tagsAr: [[String]] = []
    var tags: NSMutableDictionary = [:]
    var f = "None1"
//    func loadingData(file:String){
//
//        let stream = InputStream(fileAtPath: "db.csv")!
//        let csv = try! CSVReader(stream: stream)
//        while let row = csv.next() {
//            print("\(row)")
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let c =  UserDefaults.standard.integer(forKey: "UseCount")
        if(c > 1){
            let d = c+1
            UserDefaults.standard.set(d, forKey: "UseCount")
        }
        //folderCheck()
        titleAr = getAllCases()
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getAllCases() -> [String]{
        var im : [String] = []
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        print(mainPath)
        let documentDirecortPath = mainPath + "/Cases"
        let d = URL(string: documentDirecortPath)!
        var fileURLs : [URL] = []
        let fileManager = FileManager.default
        let p = Bundle.main.resourcePath! + "/Cases"

        let items = try! fileManager.contentsOfDirectory(atPath: p)

        for e in items{
            im.append(e)
        }
        return im
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleAr.count / 3
    }
    func loadFile(fN: String)-> [String]{
        let fileURLProject = Bundle.main.path(forResource: fN, ofType: "txt")
               // Read from the file
        var readStringProject = ""
        var contents = [String]()
        do {
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
            let r2 = readStringProject.components(separatedBy: " ")
            contents = r2
        } catch let error as NSError {
            print("Failed reading from URL")
        }
        return contents
    }
    func tagSearchAlg(a: String, t: Array<Any>) -> [Int]{
        var i: [Int] = []
        var c = 0
        for e in t{
            let d = (e as AnyObject).components(separatedBy: .whitespaces)
            for f in d{
              if f == "a"{
                i.append(c)
              }
            }
            c+=1
        }
        return i //array of indexes for tags
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let s = titleAr.count / 3
        return s
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell

        let ar1 = getAllCases()
        
            //for presenting pdf
//            cell.cV.autoScales = true
//            cell.cV.displayMode = .singlePageContinuous
//            cell.cV.displayDirection = .vertical
//            cell.cV.document = pdfDocument
        
        var s1 = titleAr[indexPath.item]
        for x in 1...4{
            s1 = String(s1.dropLast())
        }
        let path = Bundle.main.path(forResource: "/Cases/"+s1, ofType: "pdf") // read resource name: pdf.pdf
        let url = URL(fileURLWithPath: path!)
        let pdfDocument = PDFDocument(url:url)
        cell.title.text = s1
        cell.pV.image = makeThumbnail(pdfDocument: pdfDocument, page: 1)
//        cell.iV.image = makeThumbnail(pdfDocument:
//        PDFDocument(url: ), page: 1)
        return cell
    }
    func makeThumbnail(pdfDocument: PDFDocument?, page: Int) -> UIImage? {
        return pdfDocument?.page(at: page)?.thumbnail(of: CGSize(width: 40, height: 40), for: .artBox)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 150, height: collectionView.frame.size.height - 150)
    }
    func sendValue() -> String{
        return f
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var s1 = titleAr[indexPath.item]
        for x in 1...4{
            s1 = String(s1.dropLast())
        }
        send = s1
        sentVC = "SearchVC"
        performSegue(withIdentifier: "seggy", sender: self)

//        IDVC().pdfView.document = PDFDocument(url: Bundle.main.url(forResource: "People v Martin", withExtension: "pdf")!)
        
    }
 
}

