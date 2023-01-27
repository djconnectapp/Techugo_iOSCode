//
//  LeftMenuViewController.swift
//  DJConnect
//
//  Created by Techugo on 21/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import AlamofireObjectMapper
//import Stripe
import DropDown
import JMMaskTextField_Swift
import CryptoSwift
import Mixpanel

import AuthenticationServices


class LeftMenuViewController: UIViewController {

    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .dark)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.5)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            //dimmedView.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).withAlphaComponent(0.5)
            dimmedView.backgroundColor = .red.withAlphaComponent(0.15)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 43 / 255, green: 23 / 255, blue: 69 / 255, alpha: 1).cgColor,
            UIColor(red: 53 / 255, green: 32 / 255, blue: 82 / 255, alpha: 1).cgColor,
            UIColor(red: 43 / 255, green: 23 / 255, blue: 68 / 255, alpha: 1).cgColor
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
    @IBOutlet weak var userImgVw: UIImageView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var viewProfileBtn: UIButton!
    @IBOutlet weak var sideMenuTblVw: UITableView!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var bgVw: UIView!
    var sideMenuImgArr:[UIImage] = []
    
    var sideMenuItemArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingBtn.isHidden = true
        if UserModel.sharedInstance().userType == "DJ"{
//        sideMenuItemArr = ["Home","Financials","Transactions History","Reminder","Security","Support","Feedback","Social","Delete Account"]
            //            sideMenuImgArr = [
            //                    UIImage(named: "NewHome")!,
            //                    UIImage(named: "NewFinancials")!,
            //                    UIImage(named: "NewTransaction")!,
            //                    UIImage(named: "NewHome")!,
            //                    UIImage(named: "NewSecurity")!,
            //                    UIImage(named: "NewSupport")!,
            //                    UIImage(named: "NewFeedback")!,
            //                    UIImage(named: "NewSocial")!,
            //                    UIImage(named: "NewHome")!
            //                ]
            
            sideMenuItemArr = ["Home","Financials","My Account","Reminder","Support"]
            sideMenuImgArr = [
                    UIImage(named: "NewHome")!,
                    UIImage(named: "NewFinancials")!,
                    UIImage(named: "NewTransaction")!,
                    UIImage(named: "NewHome")!,
                    UIImage(named: "NewSupport")!,
                ]
            /*
            sideMenuItemArr = ["Home","Financials","Transactions History","Reminder","Security","Support","Delete Account"]
            sideMenuImgArr = [
                    UIImage(named: "NewHome")!,
                    UIImage(named: "NewFinancials")!,
                    UIImage(named: "NewTransaction")!,
                    UIImage(named: "NewHome")!,
                    UIImage(named: "NewSecurity")!,
                    UIImage(named: "NewSupport")!,
                    UIImage(named: "NewHome")!
                ]
             */
        }
        else
        {
             sideMenuItemArr = ["Home","Financials","My Account","Support"]
             sideMenuImgArr = [
                     UIImage(named: "NewHome")!,
                     UIImage(named: "NewFinancials")!,
                     UIImage(named: "NewTransaction")!,
                     UIImage(named: "NewSupport")!,
                 ]
//            sideMenuItemArr = ["Home","Financials","Transactions History","Security","Support","Delete Account"]
//            sideMenuImgArr = [
//                    UIImage(named: "NewHome")!,
//                    UIImage(named: "NewFinancials")!,
//                    UIImage(named: "NewTransaction")!,
//                    UIImage(named: "NewSecurity")!,
//                    UIImage(named: "NewSupport")!,
//                    UIImage(named: "NewHome")!
//                ]
        }
        
        userNameLbl.text = UserModel.sharedInstance().uniqueUserName
       
        createGradient(view: bgVw, bounds: .init(width: self.bgVw.frame.width, height: self.bgVw.frame.height))
        
        logoutBtn.addSubview(blurredView)
        logoutBtn.sendSubviewToBack(blurredView)
        
        sideMenuTblVw.tableFooterView = UIView()
        sideMenuTblVw.separatorStyle = .none
        
        logoutBtn.layer.cornerRadius = 5.0
        logoutBtn.layer.borderColor = UIColor.red.cgColor
        logoutBtn.layer.borderWidth = 1
        logoutBtn.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(homeApiUpdate), name:
                                                    Notification.Name("userNameNotify"), object: nil)
                                             

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        print("lgmenuWillCall")
    }
    
    @objc private func homeApiUpdate() {
        userNameLbl.text = UserModel.sharedInstance().uniqueUserName!
    }
    // add gradiant color
    func createGradient(view: UIView, bounds: CGSize) {
            let gradientLayer = CAGradientLayer()
            var updatedFrame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: bounds)
            updatedFrame.size.height += 100
            gradientLayer.frame = updatedFrame
        gradientLayer.colors = [UIColor.black.cgColor, UIColor(red: 53 / 255, green: 32 / 255, blue: 82 / 255, alpha: 1).cgColor] // start color and end color
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // vertical gradient start
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0) // vertical gradient end
            UIGraphicsBeginImageContext(gradientLayer.bounds.size)
            // gradientLayer.render(in: UIGraphicsGetCurrentContext() ?? UIGraphicsGetCurrentContext())
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor.init(patternImage: (image ?? UIImage()).resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch))
        }
    
//    override func viewDidLayoutSubviews() {
//        gradient.frame = bgVw.bounds
//        bgVw.layer.addSublayer(gradient)
//    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        // create the alert
               // let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)

        let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.callLogoutWebservice()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))

        present(refreshAlert, animated: true, completion: nil)
        
    }
    @IBAction func viewProfileBtnTapped(_ sender: Any) {
        
        if UserModel.sharedInstance().userType == "DJ"{
                    
            let sideMenuSB = UIStoryboard(name: "DJProfile", bundle: nil)
            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
            let navigationController = sideMenuController!.rootViewController as! UINavigationController
            navigationController.pushViewController(viewController, animated: true)
        sideMenuController?.hideLeftView()
            
        }else{
            
            let sideMenuSB = UIStoryboard(name: "ArtistProfile", bundle: nil)
            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as! ArtistViewProfileVC
            let navigationController = sideMenuController!.rootViewController as! UINavigationController
            navigationController.pushViewController(viewController, animated: true)
        sideMenuController?.hideLeftView()
            
            
//            let storyboard = UIStoryboard(name: "ArtistProfile", bundle: nil)
//            let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as? ArtistViewProfileVC
//            //next1?.isFromMenu = false
//            navigationController?.pushViewController(next1!, animated: true)
        }
    }
    @IBAction func settingBtnTapped(_ sender: Any) {
        
//        let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
//        let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//        viewController.sreenType = "Settings"
//        let navigationController = sideMenuController!.rootViewController as! UINavigationController
//        navigationController.pushViewController(viewController, animated: true)
//    sideMenuController?.hideLeftView()
        
    }
        
    //MARK: - WEBSERVICES
    func callGetProjectDetailWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.userAccountDeleteAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<UserDeleteModel>) in
                
                switch response.result {
                case .success(_):
                    //Loader.shared.hide()
                    let userDeleteD = response.result.value!
                    if userDeleteD.success == 1{
                        self.view.makeToast(userDeleteD.message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.logout()
                        })
                    }else{
                        Loader.shared.hide()
                        if(userDeleteD.message == "You are not authorised. Please login again."){
                            self.view.makeToast(userDeleteD.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                            })
                        }
                        else{
                            self.view.makeToast(userDeleteD.message)
                        }
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func deleteUserAlert(){
        let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure want to delete your account?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.callGetProjectDetailWebService()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    func callLogoutWebservice(){
        if getReachabilityStatus(){
            
           
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
            ]
            debugPrint(parameters)
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.logoutAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let logoutModel = response.result.value!
                    if logoutModel.success == 1{

                        Mixpanel.mainInstance().track(event: "Log out", properties: [:
                            
                        ])
                        
                        //Mixpanel.mainInstance().track(event: "App Launched")
                        print("logout success")
                        self.view.makeToast(logoutModel.message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.logout()
                                })
                        
                         
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(logoutModel.message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.logout()
                                })

                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func logout(){
        UserModel.sharedInstance().isSignup = true
        UserModel.sharedInstance().isSkip = false
        UserDefaults.standard.set(false, forKey: "isProfileComplete")
        UserDefaults.standard.set(false, forKey: "isPaymentComplete")
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logOut()
        let applanguage = UserModel.sharedInstance().appLanguage
        let latitude = UserModel.sharedInstance().currentLatitude
        let longitude = UserModel.sharedInstance().currentLongitude
        //let deviceToken = UserModel.sharedInstance().deviceToken
       // print("sideMenu_deviceToken",deviceToken)
        let username = UserModel.sharedInstance().userName
        let password = UserModel.sharedInstance().password
        let isRemember = UserModel.sharedInstance().isRemembered
        let rememberType = UserModel.sharedInstance().RememberUserType
        let arname = UserModel.sharedInstance().arname
        let arpassword = UserModel.sharedInstance().arpassword
        UserModel.sharedInstance().removeData()
        UserModel.sharedInstance().synchroniseData()
        UserModel.sharedInstance().appLanguage = applanguage
        UserModel.sharedInstance().currentLatitude = latitude
        UserModel.sharedInstance().currentLongitude = longitude
       // print("sideMenu_deviceToken1",deviceToken)
       // UserModel.sharedInstance().deviceToken = deviceToken
        UserModel.sharedInstance().synchroniseData()
        if isRemember == "1"{
            UserModel.sharedInstance().arname = arname
            UserModel.sharedInstance().arpassword = arpassword
            UserModel.sharedInstance().userName = username
            UserModel.sharedInstance().password = password
            UserModel.sharedInstance().isRemembered = isRemember
            UserModel.sharedInstance().RememberUserType = rememberType
            UserModel.sharedInstance().synchroniseData()
        }else{
            UserModel.sharedInstance().isRemembered = isRemember
        }
        
        UserModel.sharedInstance().token = ""
        UserModel.sharedInstance().userId = ""
        UserModel.sharedInstance().removeData()
        UserModel.sharedInstance().synchroniseData()
        self.ChangeRoot()
        
    }
    
    func ChangeRoot() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
        let navigationController = UINavigationController(rootViewController: nextViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController
        
    }
}

//MARK:- EXTENSIONS
extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sideMenuItemArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTableViewCell", for: indexPath) as! LeftMenuTableViewCell
        cell.selectionStyle = .none
        
        cell.iconLblVw.text = sideMenuItemArr[indexPath.row]
            cell.iconImgVw.image = sideMenuImgArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(UserModel.sharedInstance().userType == "AR"){
            if indexPath.row == 0{
                
                if UserModel.sharedInstance().userType == "AR"{
                    let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
                    let next1 = homeSB.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
                    sideMenuController()?.setContentViewController(next1!)
                    
                                    let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
                                    let viewController = storyBoard.instantiateViewController(withIdentifier: "NewArtistHomeVC") as! NewArtistHomeVC
                                    self.sideMenuController?.hideLeftView()
                                    self.sideMenuController?.rootViewController?.show(viewController, sender: self)
                                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                }else{
                                    let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
                                    let viewController = storyBoard.instantiateViewController(withIdentifier: "NewDJHomeVC") as! NewDJHomeVC
                                    self.sideMenuController?.hideLeftView()
                                    self.sideMenuController?.rootViewController?.show(viewController, sender: self)
                                    self.navigationController?.pushViewController(viewController, animated: true)
                }

            }
//            else if indexPath.row == 1{
//
//                let alert = UIAlertController(title: "Account", message: "Coming Soon", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                self.present(alert, animated: true)
//
//            }
            else if indexPath.row == 1{
                
                let getUserActiveStr = UserDefaults.standard.string(forKey: "userVerify")
                if(getUserActiveStr == "0"){
                    self.view.makeToast("Please make verify through Admin first.")
                }
                else{
                    let sideMenuSB = UIStoryboard(name: "DJHome", bundle: nil)
                    let viewController = sideMenuSB.instantiateViewController(withIdentifier: "FinancialViewController") as! FinancialViewController
                    let navigationController = sideMenuController!.rootViewController as! UINavigationController
                    navigationController.pushViewController(viewController, animated: true)
                sideMenuController?.hideLeftView()
                }
                
            }
            else if indexPath.row == 2{
                print("indexno",indexPath.row)
                let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
                let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//                viewController.sreenType = "Transac"
                viewController.sreenType = "myAccount"
                let navigationController = sideMenuController!.rootViewController as! UINavigationController

                navigationController.pushViewController(viewController, animated: true)
            sideMenuController?.hideLeftView()
            }
            else if indexPath.row == 3{
                let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
                let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
                viewController.sreenType = "Support"
                let navigationController = sideMenuController!.rootViewController as! UINavigationController
                navigationController.pushViewController(viewController, animated: true)
            sideMenuController?.hideLeftView()
                
            }
//            else if indexPath.row == 4{
//                let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
//                let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//                viewController.sreenType = "Feedback"
//                let navigationController = sideMenuController!.rootViewController as! UINavigationController
//                navigationController.pushViewController(viewController, animated: true)
//            sideMenuController?.hideLeftView()
//                
//            }
           // else if indexPath.row == 5{
//                let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
//                let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//                viewController.sreenType = "Feedback"
//                let navigationController = sideMenuController!.rootViewController as! UINavigationController
//                navigationController.pushViewController(viewController, animated: true)
//            sideMenuController?.hideLeftView()
                
                
                
//                let appID = "" // Your AppID
//                if let checkURL = NSURL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(appID)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8") {
//                    if UIApplication.shared.openURL(checkURL as URL) {
//                        print("url successfully opened")
//                    }
//                } else {
//                    print("invalid url")
//                }
                
          //  }
//            else if indexPath.row == 6{
//                let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
//                let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//                viewController.sreenType = "Social"
//                let navigationController = sideMenuController!.rootViewController as! UINavigationController
//                navigationController.pushViewController(viewController, animated: true)
//            sideMenuController?.hideLeftView()
//            }
            else
            {
                // delete account
                //self.deleteUserAlert()
            }
        
    }
    else{
        if indexPath.row == 0{
            
            if UserModel.sharedInstance().userType == "AR"{
                let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
                let next1 = homeSB.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
                sideMenuController()?.setContentViewController(next1!)
                
                                let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
                                let viewController = storyBoard.instantiateViewController(withIdentifier: "NewArtistHomeVC") as! NewArtistHomeVC
                                self.sideMenuController?.hideLeftView()
                                self.sideMenuController?.rootViewController?.show(viewController, sender: self)
                                self.navigationController?.pushViewController(viewController, animated: true)
                
            }else{
                                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
                                let viewController = storyBoard.instantiateViewController(withIdentifier: "NewDJHomeVC") as! NewDJHomeVC
                                self.sideMenuController?.hideLeftView()
                                self.sideMenuController?.rootViewController?.show(viewController, sender: self)
                                self.navigationController?.pushViewController(viewController, animated: true)
            }

        }
//        else if indexPath.row == 1{
//
//            let alert = UIAlertController(title: "Account", message: "Coming Soon", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default))
//            self.present(alert, animated: true)
//
//        }
        else if indexPath.row == 1{
            
            let getUserActiveStr = UserDefaults.standard.string(forKey: "userVerify")
            if(getUserActiveStr == "0"){
                self.view.makeToast("Please make verify through Admin first.")
            }
            else{
                let sideMenuSB = UIStoryboard(name: "DJHome", bundle: nil)
                let viewController = sideMenuSB.instantiateViewController(withIdentifier: "FinancialViewController") as! FinancialViewController
                let navigationController = sideMenuController!.rootViewController as! UINavigationController
                navigationController.pushViewController(viewController, animated: true)
            sideMenuController?.hideLeftView()
            }
            
            
        }
        else if indexPath.row == 2{
            let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//            viewController.sreenType = "Transac"
            viewController.sreenType = "myAccount"
            let navigationController = sideMenuController!.rootViewController as! UINavigationController

            navigationController.pushViewController(viewController, animated: true)
        sideMenuController?.hideLeftView()
        }
        else if indexPath.row == 3{
            let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
            viewController.sreenType = "Settings"
            let navigationController = sideMenuController!.rootViewController as! UINavigationController
            navigationController.pushViewController(viewController, animated: true)
        sideMenuController?.hideLeftView()
        }
        else if indexPath.row == 4{
            let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
            viewController.sreenType = "Support"
            let navigationController = sideMenuController!.rootViewController as! UINavigationController
            navigationController.pushViewController(viewController, animated: true)
        sideMenuController?.hideLeftView()
            
        }
        else if indexPath.row == 5{
//            let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
//            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//            viewController.sreenType = "Support"
//            let navigationController = sideMenuController!.rootViewController as! UINavigationController
//            navigationController.pushViewController(viewController, animated: true)
//        sideMenuController?.hideLeftView()
            
        }
       // else if indexPath.row == 6{
//            let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
//            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//            viewController.sreenType = "Feedback"
//            let navigationController = sideMenuController!.rootViewController as! UINavigationController
//            navigationController.pushViewController(viewController, animated: true)
//        sideMenuController?.hideLeftView()
            
            
//            let appID = "1601360647" // Your AppID
//            if let checkURL = NSURL(string: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(appID)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8") {
//                if UIApplication.shared.openURL(checkURL as URL) {
//                    print("url successfully opened")
//                }
//            } else {
//                print("invalid url")
//            }
            
       // }
//        else if indexPath.row == 7{
//            let sideMenuSB = UIStoryboard(name: "SideMenu", bundle: nil)
//            let viewController = sideMenuSB.instantiateViewController(withIdentifier: "SideMenuHomeVC") as! SideMenuHomeVC
//            viewController.sreenType = "Social"
//            let navigationController = sideMenuController!.rootViewController as! UINavigationController
//            navigationController.pushViewController(viewController, animated: true)
//        sideMenuController?.hideLeftView()
//        }
        else{
            // delete account
           // self.deleteUserAlert()
        }
    }
       
        }
    }
