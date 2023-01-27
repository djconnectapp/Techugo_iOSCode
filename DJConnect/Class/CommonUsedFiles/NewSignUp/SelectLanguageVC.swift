//
//  SelectLanguageVC.swift
//  DJConnect
//
//  Created by Techugo on 15/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SelectLanguageVC: UIViewController {
    
    
    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var arabicVw: UIView!
    @IBOutlet weak var arabicFlagImgVw: UIImageView!
    @IBOutlet weak var arabicLbl: UILabel!
    
    @IBOutlet weak var englishVw: UIView!
    @IBOutlet weak var englishFlagImgVw: UIImageView!
    @IBOutlet weak var englshLbl: UILabel!
    
    @IBOutlet weak var selectLngLbl: UILabel!
    
    @IBOutlet weak var langDescLbl: UILabel!
    
    @IBOutlet weak var getStartBtn: UIButton!
    
   // var lanselected : String?
    var notification1 = "0"
    var arrLaunguage = [String]()
    var selectedIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        
        setUpVw()
    }
    
    func setUpVw(){
        
        arabicVw.backgroundColor = UIColor(red: 12 / 255, green: 45 / 255, blue: 55 / 255, alpha: 1)
        englishVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        
        //arabicVw.backgroundColor = hexStringToUIColor(hex: "#d3d3d3")
        
        arabicVw.layer.cornerRadius = 20.0
        arabicVw.clipsToBounds = true
        
        englishVw.layer.cornerRadius = 20.0
        englishVw.clipsToBounds = true

        getStartBtn.layer.cornerRadius = getStartBtn.frame.size.height/2
        getStartBtn.clipsToBounds = true
        
        let buttonHeight = getStartBtn.frame.height
            let buttonWidth = getStartBtn.frame.width

            //let shadowSize: CGFloat = 15
            let contactRect = CGRect(x: 0, y: buttonHeight - 10, width: buttonWidth, height: buttonHeight)
        getStartBtn.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        getStartBtn.layer.shadowRadius = 5
        getStartBtn.layer.shadowOpacity = 0.6
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(arabictapGesture(_:)))
        arabicVw.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(englishtapGesture(_:)))
        englishVw.addGestureRecognizer(tap1)
    }
    
    @objc func arabictapGesture(_ sender: UITapGestureRecognizer){
        arabic()
    }
    
    @objc func englishtapGesture(_ sender: UITapGestureRecognizer){
        english()
    }
    
    func arabic(){
        UserModel.sharedInstance().appLanguage = "0"
        UserModel.sharedInstance().synchroniseData()
        
        englishVw.backgroundColor = UIColor(red: 12 / 255, green: 45 / 255, blue: 55 / 255, alpha: 1)
        arabicVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        let arabic = Locale().initWithLanguageCode(languageCode: "ar", countryCode: "ar", name: "Arabic")
        DGLocalization.sharedInstance.setLanguage(withCode:arabic)
        self.notification1 = "1"
        
//        ChangeRoot()
//        self.reloadViewFromNib()
        
    }
    
    func english(){
        UserModel.sharedInstance().appLanguage = "1"
        UserModel.sharedInstance().synchroniseData()
        arabicVw.backgroundColor = UIColor(red: 12 / 255, green: 45 / 255, blue: 55 / 255, alpha: 1)
        englishVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
        let English = Locale().initWithLanguageCode(languageCode: "en", countryCode: "en", name: "English")
        DGLocalization.sharedInstance.setLanguage(withCode:English)
        self.notification1 = "1"
        
    }
    
    
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        
    }

    @IBAction func getStartBtnTapped(_ sender: Any) {
        if(UserModel.sharedInstance().appLanguage == "" || UserModel.sharedInstance().appLanguage == nil){
            english()
        }
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "OnBoardViewController") as? OnBoardViewController
        navigationController?.pushViewController(next1!, animated: true)
        
//        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
//        let next1 = storyBoard.instantiateViewController(withIdentifier: "SetPinVC") as? SetPinVC
//        navigationController?.pushViewController(next1!, animated: true)
        

    }
    
    @objc func disconnectPaxiSocket(_ notification: Notification) {
        if notification1 == "0"{
            self.notification1 = "1"
            performSegue(withIdentifier: "splashToLoginSegue", sender: nil)
        }
    }
    
    
}
