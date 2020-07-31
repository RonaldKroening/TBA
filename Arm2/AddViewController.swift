//
//  AddViewController.swift
//  Arm2
//
//  Created by Bianca on 3/17/20.
//  Copyright © 2020 Rift Labs. All rights reserved.
//

import Foundation
import UIKit
class AddViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var color = UIColor(red: 175/255, green: 29/255, blue: 88/255, alpha: 1)
    //)
    var selectedCellsCount = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    var toSave: [String] = []
    var tagsT: [String] = []
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var titleChg: UITextField!
    @IBOutlet weak var notesView: UITextField!
    var tagAr = ["Party","Dinner","Birthday","Concert","Formal","Fun","Date","Chill","Prom","Beach","Movies","School","Lowkey"]
    var tagsTS : String = ""
    var selectedTags: [String] = []
    override func viewDidLoad() {

        super.viewDidLoad()
        addImage.image = UIImage(named: "mann2.png")


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Handling Text
    
   
     func notesIsEmpty() -> Bool{
         if(notesView.text!.isEmpty == false){
             toSave.append(notesView.text!)
            return true
         }else{
            return false
        }
     }
    
    //Handling Files
    
    func updateFileTitle(path: String){
        do {
            try toSave[0].write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
            }
        
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            }
    }
    func updateFileNotes(path: String){
        do {
            try toSave[1].write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
            }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            }
    }
    
    func updateFileTags(path: String){
        do {
            for a in tagsT{
                tagsTS = tagsTS + " " + a
            }
                try tagsTS.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
        }catch let error as NSError {
                print("Ooops! Something went wrong: \(error)")
                }
        }
    
   //Collection View Stuff
    
    
    //Amount of columns
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagAr.count
    }
    //Making the cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1!", for: indexPath) as! TVC
        cell.sizeToFit()
        cell.tagLAB.text = tagAr[indexPath.item]
        
        return cell
    }
    
    
       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1!", for: indexPath) as! TVC
        //cell.tagBTN.backgroundColor = UIColor(red: 175/255, green: 29/255, blue: 88/255, alpha: 1)
        //
    //Button Pressed
    
    func tagAdder(){
        for e in selectedCellsCount{
            if(e % 2 == 1){
                tagsTS.append(tagAr[e])
            }
        }
    }
    
    //Sending to files
    @IBAction func allDoneBtn(_ sender: Any) {
        toSave.append(titleChg.text!)
        if(notesIsEmpty() == true && titleChg.text!.isEmpty == false){
            tagAdder()
            updateFileTitle(path: "titles")
            updateFileTags(path: "tags")
            updateFileNotes(path: "notes")
            performSegue(withIdentifier: "seg1e", sender: self)
        }else{
            print("no")
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hii")
        var count = selectedCellsCount[indexPath.item]
        count = count + 1
        let cell = collectionView.cellForItem(at: indexPath)
        let oldcolor = UIColor(red: 225/255, green: 79/255, blue: 138/255, alpha: 1)
        let newcolor = UIColor(red: 150/255, green: 4/255, blue: 53/255, alpha: 1)
        if(cell!.backgroundColor == newcolor){
        print("hi")
        count = count  + 1
        cell!.backgroundColor = oldcolor
        }
        if(count % 2 == 1){
            cell!.backgroundColor = newcolor
        }
        
        }
        
    
    
}
