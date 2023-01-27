//
//  homePageVC.swift
//  DJConnect
//
//  Created by mac on 09/12/19.
//  Copyright © 2019 mac. All rights reserved.
//
import UIKit

class HomePageVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblLaunguage: UILabel!
    @IBOutlet weak var btnLaunguage: UIButton!
    @IBOutlet weak var btnLaunguageClear: UIButton!
    @IBOutlet weak var lblmainsplash: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var cnsLeadingsidemenu: NSLayoutConstraint!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var btnartist: UIButton!
    @IBOutlet weak var btndj: UIButton!
    @IBOutlet weak var lblSelectLanguage: UILabel!
    @IBOutlet weak var sliderUserSelect: UISlider!
    
    //MARK: - GLOBAL VARIABLES
    var selectedIndex = 1
    var arrLaunguage = ["Arabic".localize,"English".localize]
    //MARK: - UI VIEW CONTROLLER LIFE CYCLE.
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSelectLanguage.text = "Select Language".localize
        btnLaunguage.setTitle("Language".localize, for: .normal)
        vwBlur .isHidden = true
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        
        cnsLeadingsidemenu.constant = -(self.view.frame.size.width)
        tableview.tableFooterView = UIView()
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        
        lblLaunguage.text = arrLaunguage[selectedIndex]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let sliderValue = (self.view.frame.width - 175)/2
        sliderUserSelect.setThumbImage(UIImage(named: "arrr2"), for: .normal)
        if UserModel.sharedInstance().appLanguage == "0"{
            sliderUserSelect.value = 0.496
            imgBack.setImage(UIImage(named: "white_right_arror_new_ar")!)
        }else{
            sliderUserSelect.value = 0.496
            imgBack.setImage(UIImage(named: "white_right_arror_new_en")!)
        }
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            
            let statusbarView = UIView(frame: app.statusBarFrame)
            statusbarView.backgroundColor = UIColor(red: 75/255, green: 20/255, blue: 52/255, alpha: 1.0)
            app.statusBarUIView?.addSubview(statusbarView)
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(red: 75/255, green: 20/255, blue: 52/255, alpha: 1.0)
        }
        
    }
    //MARK: - OTHER METHODS
    func arabic(){
        UserModel.sharedInstance().appLanguage = "0"
        UserModel.sharedInstance().synchroniseData()
        
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        let arabic = Locale().initWithLanguageCode(languageCode: "ar", countryCode: "ar", name: "Arabic")
        DGLocalization.sharedInstance.setLanguage(withCode:arabic)
        self.reloadViewFromNib()
        
    }
    
    func english(){
        UserModel.sharedInstance().appLanguage = "1"
        UserModel.sharedInstance().synchroniseData()
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
        let English = Locale().initWithLanguageCode(languageCode: "en", countryCode: "en", name: "English")
        DGLocalization.sharedInstance.setLanguage(withCode:English)
        self.reloadViewFromNib()
    }
    
    func reloadViewFromNib() {
        ChangeRoot()
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
    
    //MARK: - ACTIONS
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
    
    @IBAction func sliderAction(_ sender: UISlider) {
        if sliderUserSelect.value == 0{
            UserModel.sharedInstance().userType = "AR"
            performSegue(withIdentifier: "segueHomeFordj", sender: nil)
        }
        if sliderUserSelect.value == 1{
            UserModel.sharedInstance().userType = "DJ"
            performSegue(withIdentifier: "segueHomeFordj", sender: nil)
        }
    }
}
//MARK: - EXTENSIONS
extension HomePageVC : UITableViewDelegate, UITableViewDataSource{
    
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
