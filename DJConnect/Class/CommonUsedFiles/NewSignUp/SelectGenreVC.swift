//
//  SelectGenreVC.swift
//  DJConnect
//
//  Created by Techugo on 17/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class SelectGenreVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var selectGenreLbl: UILabel!
    @IBOutlet weak var popBtn: UIButton!
    @IBOutlet weak var rockBtn: UIButton!
    @IBOutlet weak var electroBtn: UIButton!
    @IBOutlet weak var rapBtn: UIButton!
    @IBOutlet weak var hiphopBtn: UIButton!
    @IBOutlet weak var ragaeBtn: UIButton!
    @IBOutlet weak var gospelBtn: UIButton!
    @IBOutlet weak var technoBtn: UIButton!
    @IBOutlet weak var rBBtn: UIButton!
    @IBOutlet weak var bluesBtn: UIButton!
    @IBOutlet weak var selectAllBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var genreArr = [String]()
    
    var isPopSelected : Bool?
    var isRockSelected : Bool?
    var isElectroSelected : Bool?
    var isRapSelected : Bool?
    var isHiphopSelected : Bool?
    var isRagaeSelected : Bool?
    var isGospelSelected : Bool?
    var isTechnoSelected : Bool?
    var isRbSelected : Bool?
    var isBluesSelected : Bool?
    
    var isSelectedAll : Bool?
    
    
    var arrGenrelist = [GenreData]()
    var arrSelectedIndex = [Int]()
    var arrSelectedGerneName = [String]()
    var oldSelectedIds = ""
    var notificationName = ""
    
    
    var callbackGenreData : ((_ data: [GenreData], _ selectAll: String) -> Void)?
    var btnCol = [UIButton]()
        //= [popBtn, rockBtn, electroBtn, rapBtn, hiphopBtn, ragaeBtn, gospelBtn, technoBtn, rBBtn,  bluesBtn]
        
    var genreIndexId = ""
    var selectedgerneDataObj = [GenreData]()
    var selectaLStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
         isPopSelected = false
         isRockSelected = false
         isElectroSelected = false
         isRapSelected = false
         isHiphopSelected = false
         isRagaeSelected = false
         isGospelSelected = false
         isTechnoSelected = false
         isRbSelected = false
         isBluesSelected = false
         isSelectedAll = false

        setUpVw()
        self.buttonSetup()
        self.setUpGerne()

        btnCol.append(popBtn)
        btnCol.append(rockBtn)
        btnCol.append(electroBtn)
        btnCol.append(rapBtn)
        btnCol.append(hiphopBtn)
        btnCol.append(ragaeBtn)
        btnCol.append(gospelBtn)
        btnCol.append(technoBtn)
        btnCol.append(rBBtn)
        btnCol.append(bluesBtn)
        
        
        if(selectaLStr == "selectedAll"){
            selectAllBtn.setTitle("Clear All", for: .normal)
            isSelectedAll = true
        }
        else{
            selectAllBtn.setTitle("Select All", for: .normal)
            isSelectedAll = false
        }
        
//        if(genreIndexId != ""){
//                for i in 0...arrGenrelist.count {
//                        if selectedgerneDataObj[i].title == arrGenrelist[i].title{
//                        print("helo5")
//                       // btnCol.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
//                        for (i, data) in btnCol.enumerated(){
//                            self.gerneSelectTap(index: i, btn: data,isFirst: true)
//                        }
//                    }
//                    else{
//                        //btnCol.backgroundColor = .clear
//                    }
//                }
//        }
               
    }
    override func viewWillAppear(_ animated: Bool) {
        preSelectedBtn(btns: self.btnCol)
    }
    func buttonSetup(){
        if(arrGenrelist.count > 0){
        self.popBtn.setTitle(self.arrGenrelist[0].title, for: .normal)
        self.rockBtn.setTitle(self.arrGenrelist[1].title, for: .normal)
        self.electroBtn.setTitle(self.arrGenrelist[2].title, for: .normal)
        self.rapBtn.setTitle(self.arrGenrelist[3].title, for: .normal)
        self.hiphopBtn.setTitle(self.arrGenrelist[4].title, for: .normal)
        self.ragaeBtn.setTitle(self.arrGenrelist[5].title, for: .normal)
        self.gospelBtn.setTitle(self.arrGenrelist[6].title, for: .normal)
        self.technoBtn.setTitle(self.arrGenrelist[7].title, for: .normal)
        self.rBBtn.setTitle(self.arrGenrelist[8].title, for: .normal)
        self.bluesBtn.setTitle(self.arrGenrelist[9].title, for: .normal)
        }
    }
    
    
    func setUpGerne(){
        for (index, data) in btnCol.enumerated(){
            self.gerneSelectTap(index: index, btn: data,isFirst: true)
        }
    }
    
    func setUpVw(){
         
        popBtn.layer.cornerRadius = popBtn.frame.size.height/2
        popBtn.layer.borderColor = UIColor.white.cgColor
        popBtn.layer.borderWidth = 1
        popBtn.clipsToBounds = true
        popBtn.backgroundColor = .clear
        
        rockBtn.layer.cornerRadius = rockBtn.frame.size.height/2
        rockBtn.layer.borderColor = UIColor.white.cgColor
        rockBtn.layer.borderWidth = 1
        rockBtn.clipsToBounds = true
        rockBtn.backgroundColor = .clear
        
        electroBtn.layer.cornerRadius = electroBtn.frame.size.height/2
        electroBtn.layer.borderColor = UIColor.white.cgColor
        electroBtn.layer.borderWidth = 1
        electroBtn.clipsToBounds = true
        electroBtn.backgroundColor = .clear
        
        rapBtn.layer.cornerRadius = rapBtn.frame.size.height/2
        rapBtn.layer.borderColor = UIColor.white.cgColor
        rapBtn.layer.borderWidth = 1
        rapBtn.clipsToBounds = true
        rapBtn.backgroundColor = .clear
        
        hiphopBtn.layer.cornerRadius = hiphopBtn.frame.size.height/2
        hiphopBtn.layer.borderColor = UIColor.white.cgColor
        hiphopBtn.layer.borderWidth = 1
        hiphopBtn.clipsToBounds = true
        hiphopBtn.backgroundColor = .clear
        
        ragaeBtn.layer.cornerRadius = ragaeBtn.frame.size.height/2
        ragaeBtn.layer.borderColor = UIColor.white.cgColor
        ragaeBtn.layer.borderWidth = 1
        ragaeBtn.clipsToBounds = true
        ragaeBtn.backgroundColor = .clear
        
        gospelBtn.layer.cornerRadius = gospelBtn.frame.size.height/2
        gospelBtn.layer.borderColor = UIColor.white.cgColor
        gospelBtn.layer.borderWidth = 1
        gospelBtn.clipsToBounds = true
        gospelBtn.backgroundColor = .clear
        
        technoBtn.layer.cornerRadius = technoBtn.frame.size.height/2
        technoBtn.layer.borderColor = UIColor.white.cgColor
        technoBtn.layer.borderWidth = 1
        technoBtn.clipsToBounds = true
        technoBtn.backgroundColor = .clear
        
        rBBtn.layer.cornerRadius = rBBtn.frame.size.height/2
        rBBtn.layer.borderColor = UIColor.white.cgColor
        rBBtn.layer.borderWidth = 1
        rBBtn.clipsToBounds = true
        rBBtn.backgroundColor = .clear
        
        bluesBtn.layer.cornerRadius = bluesBtn.frame.size.height/2
        bluesBtn.layer.borderColor = UIColor.white.cgColor
        bluesBtn.layer.borderWidth = 1
        bluesBtn.clipsToBounds = true
        bluesBtn.backgroundColor = .clear
        
    }
    
    @IBAction func popBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 0, btn: popBtn,isFirst: false)
    }
    
    @IBAction func rockBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 1, btn: rockBtn,isFirst: false)
       
        
    }
    
    func gerneSelectTap(index: Int, btn: UIButton, isFirst: Bool){
        //if(arrGenrelist.count > 0){
        if !isFirst{
            self.arrGenrelist[index].isSelected = !self.arrGenrelist[index].isSelected
        }
        if self.arrGenrelist[index].isSelected {//Selected
            btn.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        }else{ //Not selected
            btn.backgroundColor = .clear
        }

            //}
    }
    
    func preSelectedBtn(btns: [UIButton]){
        for (index, inneritem) in self.arrGenrelist.enumerated() {
            if inneritem.isSelected {//Selected
                btns[index].backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
            }else{ //Not selected
                btns[index].backgroundColor = .clear
            }
        }
    }
    
    
    @IBAction func electroBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 2, btn: electroBtn,isFirst: false)
    }
    
    @IBAction func rapBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 3, btn: rapBtn, isFirst: false)
    }
    
    @IBAction func hiphopBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 4, btn: hiphopBtn,isFirst: false)
    }
    
    @IBAction func ragaeBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 5, btn: ragaeBtn,isFirst: false)
    }

    @IBAction func gospelBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 6, btn: gospelBtn,isFirst: false)
    }
    
    @IBAction func technoBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 7, btn: technoBtn,isFirst: false)
    }
    
    @IBAction func rbBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 8, btn: rBBtn,isFirst: false)
    }
    
    @IBAction func bluesBtntaped(_ sender: Any) {

        self.gerneSelectTap(index: 9, btn: bluesBtn,isFirst: false)
    }
    
    @IBAction func selectAllBtntaped(_ sender: Any) {
        
        for (index, _) in self.arrGenrelist.enumerated() {
            if isSelectedAll == false {
                
                selectAllBtn.setTitle("Clear All", for: .normal)
                self.btnCol[index].backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
                self.arrGenrelist[index].isSelected = true
                selectaLStr = "selectedAll"
            } else {
                selectAllBtn.setTitle("Select All", for: .normal)
                self.btnCol[index].backgroundColor = .clear
                self.arrGenrelist[index].isSelected = false
                selectaLStr = ""
            }
           
        }
        self.isSelectedAll?.toggle()
        
    }
    
    @IBAction func nextBtntaped(_ sender: Any) {
        
        if let call = callbackGenreData{
            call(arrGenrelist, selectaLStr)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func backBtntaped(_ sender: Any) {
        //selectaLStr = ""
        for (index, _) in self.arrGenrelist.enumerated() {

                self.btnCol[index].backgroundColor = .clear
                self.arrGenrelist[index].isSelected = false

        }
        self.navigationController?.popViewController(animated: false)
    }

}
