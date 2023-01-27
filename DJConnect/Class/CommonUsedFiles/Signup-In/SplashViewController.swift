//
//  SplashViewController.swift
//  DJConnect
//
//  Created by My Mac on 11/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import GhostTypewriter

class SplashViewController: UIViewController {
    //MARK:- OUTLETS
    @IBOutlet weak var lblanimate: TypewriterLabel!
    @IBOutlet weak var logoview: UIView!
    @IBOutlet weak var view_button: UIView!
    @IBOutlet weak var view_blank: UIView!
    @IBOutlet weak var viewLogo: UIImageView!
    @IBOutlet weak var lblLaunguage: UILabel!
    @IBOutlet weak var btnLaunguage: UIButton!
    @IBOutlet weak var btnLaunguageClear: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var cnsLeadingsidemenu: NSLayoutConstraint!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var btnartist: UIButton!
    @IBOutlet weak var btndj: UIButton!
    @IBOutlet weak var lblSelectLanguage: UILabel!
    @IBOutlet weak var sliderUserSelect: UISlider!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var vwOverlay: UIView!
    
    //MARK:- GLOBAL VARIABLE
    var avPlayer: AVPlayer!
    var arrLaunguage = [String]()
    var selectedIndex = 1
    var ghostwrite = "0"
    var notification1 = "0"
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLE.
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeVariables()
        
        vwBlur .isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(disconnectPaxiSocket(_:)), name: Notification.Name(rawValue: "ChangeVC"), object: nil)
        
        cnsLeadingsidemenu.constant = -(self.view.frame.size.width)
        tableview.tableFooterView = UIView()
        self.vwOverlay.isHidden = true
        UserModel.sharedInstance().isHomePress = false
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        lblLaunguage.text = arrLaunguage[selectedIndex]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let sliderValue = (self.view.frame.width - 175)/2
        
        if UserModel.sharedInstance().appLanguage == "0"{
            sliderUserSelect.value = 0.496
            imgBack.setImage(UIImage(named: "white_right_arror_new_ar")!)
        }else{
            sliderUserSelect.value = 0.496
            imgBack.setImage(UIImage(named: "white_right_arror_new_en")!)
        }
        
        if UserModel.sharedInstance().userId != nil{
            UserModel.sharedInstance().isSignup = false
            UserModel.sharedInstance().isPin = true
            UserModel.sharedInstance().synchroniseData()
            (UIApplication.shared.delegate as! AppDelegate).ChangeRoottoHome()
        }
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            
            let statusbarView = UIView(frame: app.statusBarFrame)
            statusbarView.backgroundColor = UIColor(red: 58/255, green: 18/255, blue: 52/255, alpha: 1.0)
            app.statusBarUIView?.addSubview(statusbarView)
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(red: 75/255, green: 20/255, blue: 52/255, alpha: 1.0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sliderUserSelect.setThumbImage(UIImage(named: "arrr2"), for: .normal)
        
        if UserModel.sharedInstance().isHomePress == nil || UserModel.sharedInstance().isHomePress == false {
            btnLaunguageClear .isUserInteractionEnabled = false
            globalObjects.shared.isSplash = true
            playVideo(from: "onlyVideoSplash.mov")
        }
        if  globalObjects.shared.isSplash == true {
            self.perform(#selector(SplashViewController.showbutton), with: nil, afterDelay: 6.0)
            self.perform(#selector(SplashViewController.pushToLogin), with: nil, afterDelay: 7.0)
        }else{
            self.perform(#selector(SplashViewController.pushToLogin), with: nil, afterDelay: 7.0)
            vwBottom.isHidden = false
        }
    }
    
    //MARK: - ACTIONS
    private func playVideo(from file:String) {
        let file = file.components(separatedBy: ".")
        
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none;
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        playerLayer.frame = self.logoview.frame//CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        print(playerLayer.frame)
        
        self.logoview.layer.insertSublayer(playerLayer, at: 0)
        player.seek(to: CMTime.zero)
        
        player.play()
        
    }
    
    @IBAction func btnOverlayCloseAction(_ sender: UIButton) {
        self.vwOverlay.isHidden = true
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "isWalkthrough")
        defaults.synchronize()
    }
    
    @IBAction func btnBlurCloseAction(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsLeadingsidemenu.constant = -(self.view.frame.width)
            self.view.layoutIfNeeded()
        }) { (completion) in
            self.vwBlur .isHidden = true
            
        }
    }
    
    @IBAction func btnlaunguageClear_action(_ sender: UIButton) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsLeadingsidemenu.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in
            self.vwBlur .isHidden = false
        }
    }
    
    @IBAction func btnCloseSidemenu(_ sender: UIButton) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsLeadingsidemenu.constant = -(self.view.frame.width)
            self.view.layoutIfNeeded()
        }) { (completion) in
            self.vwBlur .isHidden = true
        }
    }
    
    @IBAction func btnSliderAction(_ sender: UISlider) {
        if sliderUserSelect.value == 0{
            globalObjects.shared.isSplash = false
            UserModel.sharedInstance().userType = "AR"
            performSegue(withIdentifier: "segueHomeFordj", sender: nil)
        }
        if sliderUserSelect.value == 1{
            globalObjects.shared.isSplash = false
            UserModel.sharedInstance().userType = "DJ"
            performSegue(withIdentifier: "segueHomeFordj", sender: nil)
        }
    }
    
    // MARK:- OTHER METHODS
    
    func arabic(){
        UserModel.sharedInstance().appLanguage = "0"
        UserModel.sharedInstance().synchroniseData()
        
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        let arabic = Locale().initWithLanguageCode(languageCode: "ar", countryCode: "ar", name: "Arabic")
        DGLocalization.sharedInstance.setLanguage(withCode:arabic)
        self.notification1 = "1"
        
        ChangeRoot()
        self.reloadViewFromNib()
        
    }
    
    func english(){
        UserModel.sharedInstance().appLanguage = "1"
        UserModel.sharedInstance().synchroniseData()
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
        let English = Locale().initWithLanguageCode(languageCode: "en", countryCode: "en", name: "English")
        DGLocalization.sharedInstance.setLanguage(withCode:English)
        self.notification1 = "1"
        
        ChangeRoot()
        self.reloadViewFromNib()
    }
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        lblLaunguage.text = arrLaunguage[selectedIndex]
        tableview .reloadData()
    }
    
    func ChangeRoot() {
        let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "aftersplash") as! UINavigationController
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
        desiredViewController.view.addSubview(snapshot);
        appdel.window?.rootViewController = desiredViewController;
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview();
        });
    }
    
    func localizeVariables(){
        arrLaunguage = ["Arabic".localize,"English"]
        lblSelectLanguage.text = "Select Language".localize
        btnLaunguage.setTitle("Language".localize, for: .normal)
    }
    
    //MARK: - SELECTOR METHODS
    @objc func showbutton(){
        vwBottom.isHidden = false
        vwBottom.alpha = 0.0
        
        UIView.animate(withDuration: 1.0, animations: {
            self.vwBottom.alpha = 1.0
        }) { (finished) in
            if finished {
                self.sliderAnimationStep1()
            }
        }
    }
    
    @objc func sliderAnimationStep1() {
        UIView.animate(withDuration: 0.3, animations: {
            self.sliderUserSelect.setValue(0, animated: true)
        }) { (finished) in
            if finished {
                self.perform(#selector(SplashViewController.sliderAnimationStep2), with: nil, afterDelay: 0.3)
            }
        }
    }
    
    @objc func sliderAnimationStep2() {
        UIView.animate(withDuration: 0.3, animations: {
            self.sliderUserSelect.setValue(1, animated: true)
        }) { (completed) in
            if completed {
                self.perform(#selector(SplashViewController.sliderAnimationStep3), with: nil, afterDelay: 0.3)
            }
        }
    }
    
    @objc func sliderAnimationStep3() {
        UIView.animate(withDuration: 0.3, animations: {
            self.sliderUserSelect.setValue(0.496, animated: true)
        }) { (completed) in
            if completed {
                
            }
        }
    }
    @objc func moveSilder(){
        sliderUserSelect.value = 0
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                        self.sliderUserSelect.setValue(1, animated: true) },
                       completion: nil)
        
    }
    @objc func pushToLogin(){
        btnLaunguageClear .isUserInteractionEnabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            let defaults = UserDefaults.standard
            self.vwOverlay.isHidden = defaults.bool(forKey: "isWalkthrough")
        })
    }
    
    @objc func disconnectPaxiSocket(_ notification: Notification) {
        if notification1 == "0"{
            self.notification1 = "1"
            performSegue(withIdentifier: "splashToLoginSegue", sender: nil)
        }
    }
}

//MARK:- EXTENSIONS

extension SplashViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLaunguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = arrLaunguage[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor .lightGray
        if indexPath.row == selectedIndex{
            cell.textLabel?.textColor = UIColor .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.arabic()
        }else if indexPath.row == 1{
            self.english()
        }
    }
}
