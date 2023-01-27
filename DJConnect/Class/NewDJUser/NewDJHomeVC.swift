//
//  NewDJHomeVC.swift
//  DJConnect
//
//  Created by Techugo on 17/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
//import AKSideMenu
import LGSideMenuController
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import StoreKit

class NewDJHomeVC: UIViewController {
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var welcomeBackLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postConnectVw: UIView!
    @IBOutlet weak var myServiceVw: UIView!
    
    @IBOutlet weak var learnDjVw: UIView!
    @IBOutlet weak var learnDjBtn: UIButton!
    
    @IBOutlet weak var postConnctBtn: UIButton!
    @IBOutlet weak var myServiceBtn: UIButton!
    
   // @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var notificationNoLbl: UILabel!
    
    var typeofUser = String()
    var window: UIWindow?
    
    var viewerId = String()
    var projectId = String()
    var userVerifyStr = String()
    var nav = UINavigationController()
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .dark)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.3)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            //dimmedView.backgroundColor = .white.withAlphaComponent(0.4)
        dimmedView.backgroundColor = UIColor.white
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let imageName = "DJCwatermark"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        
//        imageView.frame = CGRect(x: self.view.frame.width/2 - 140, y: self.view.frame.size.height/2 - 140, width:280, height:280)
//        self.view.addSubview(imageView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(openProjectDetailScreen), name:
                                                                            Notification.Name("projectIdLink"), object: nil)

        
        notificationNoLbl.isHidden = true
        notificationNoLbl.layer.cornerRadius = notificationNoLbl.frame.size.height/2
        notificationNoLbl.clipsToBounds = true
        
        if UserModel.sharedInstance().userType == "DJ" {
            typeofUser = "AR"
            
        }else {
            typeofUser = "DJ"
        }
        
        print("projectId",projectId)
        if viewerId.isEmpty{
            viewerId = UserModel.sharedInstance().userId ?? ""
        }
        setupData()
        setUpVw()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // api is not running
        if UserModel.sharedInstance().userId != nil || UserModel.sharedInstance().userId != ""{
            setupData()
        }else{
            ChangeRoot()
        }
        
        callcheckUserVerifyAPI(getIndex: 0)
        
        // MARK: - app alert
//        if #available(iOS 10.3, *) {
//                SKStoreReviewController.requestReview()
//
//            } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1601360647") {
//                if #available(iOS 10, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//
//                } else {
//                    UIApplication.shared.openURL(url)
//                }
//            }
    }
    
    @objc private func openProjectDetailScreen() {
        
        let getProjectIdStr = UserDefaults.standard.string(forKey: "linkProjectid")
//        let mainStoryBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
//        redViewController.projectId = getProjectIdStr ?? ""
//        UserDefaults.standard.removeObject(forKey: "linkProjectid")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = redViewController
//
        
                let storyboard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let projectDetailVc = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
                   // UserDefaults.standard.set(self.projectId, forKey: "linkProjectid")
                    projectDetailVc.projectId = getProjectIdStr ?? ""
                UserDefaults.standard.removeObject(forKey: "linkProjectid")
                    nav = UINavigationController.init(rootViewController:projectDetailVc)
                    nav.navigationBar.isHidden = true
                    self.window?.rootViewController = self.nav
                    self.window?.makeKeyAndVisible()
                       }
    
    func setUpVw(){
        
        postConnectVw.layer.cornerRadius = 30
        postConnectVw.clipsToBounds = true
        postConnectVw.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        //postConnectVw.addSubview(blurredView)
        
        profileBtn.layer.cornerRadius =  profileBtn.frame.size.height/2
        profileBtn.clipsToBounds = true
        
        myServiceVw.layer.cornerRadius = 30
        myServiceVw.clipsToBounds = true
        
        learnDjVw.layer.cornerRadius = 30
        learnDjVw.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        learnDjVw.clipsToBounds = true
        
    }
    
    //MARK:- WEBSERVICE CALLING
    func callcheckUserVerifyAPI(getIndex:Int){
        
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid": "\(UserModel.sharedInstance().userId!)"
            ]
            print("parameters34",parameters)
            Loader.shared.show()
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.checkUserVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<CheckUserVerifyModel>) in
       
                switch response.result {
                case .success(_):
                    self.removeLoader()
                    Loader.shared.hide()
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        
                        self.userVerifyStr = ""
                        self.userVerifyStr = getProfile.userdata?.admin_verify ?? ""
                        print("userVerifyStr",self.userVerifyStr)
                        if(self.userVerifyStr == "0"){
                            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                    self.present(alert, animated: true)
                            UserDefaults.standard.set(self.userVerifyStr, forKey: "userVerify")
                        }
                        else if(self.userVerifyStr == "1"){
                            UserDefaults.standard.set(self.userVerifyStr, forKey: "userVerify")
                        
                            if getIndex == 1 {
                                let homeSB = UIStoryboard(name: "DJHome", bundle: nil)
                                let desiredViewController = homeSB.instantiateViewController(withIdentifier: "PostConnectVC") as! PostConnectVC
                                let transition = CATransition()
                                transition.duration = 0.3
                                transition.type = CATransitionType(rawValue: "fade")
                                transition.subtype = CATransitionSubtype.fromLeft
                                self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                                self.navigationController?.pushViewController(desiredViewController, animated: false)
                            }
                            else if getIndex == 2 {
                                let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
                                let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
                                desiredViewController.buttonSelected = "service"
                                let transition = CATransition()
                                transition.duration = 0.5
                                transition.type = CATransitionType(rawValue: "flip")
                                transition.subtype = CATransitionSubtype.fromLeft
                                self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                                self.navigationController?.pushViewController(desiredViewController, animated: true)
                            }
                            else if getIndex == 3 {
                                let storyboard = UIStoryboard(name: "DJHome", bundle: nil)
                                let next1 = storyboard.instantiateViewController(withIdentifier: "firstDJPV") as? LearnDJConnectVC
                                self.navigationController?.pushViewController(next1!, animated: true)
                                
                            }
                            
//                            else if getIndex == 4 {
//                                self.Alert_Action()
//                            }
                            
                            else{
                                
                            }
//                            if self.arrSelectedTitle[getIndex] == "Post a Connect"{
//                            self.AddProject_Action()
//                            }else if self.arrSelectedTitle[getIndex] == "My Services"{
//                            self.Review_Action()
//
//                            }else if self.arrSelectedTitle[getIndex] == "Go to My Profile"{ // ashitesh
//                            self.Profile_Action()
//
//                            }else if self.arrSelectedTitle[getIndex] == "Go to My Alerts"{
//                            self.Alert_Action()
//                            }else if self.arrSelectedTitle[getIndex] == "Learn about DJ Connect"{
//                                self.vwInfo.isHidden = false
//                        }
                        }
                        else if(self.userVerifyStr == "2"){
                            self.callLogoutWebservice()
                        }
                       
                        print("sucessUserCheck")
                    }else{
                        Loader.shared.hide()
//                        self.view.makeToast("You are not authorised. Please login again.")
//                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
//                            })
                        
                        if getProfile.success == 0{
                            if(getProfile.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(getProfile.message)
                            }
                        }
                        
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    //MARK:- OTHER ACTIONS
    func setupData(){
        notificationCount()
        callGetProfileWebService()
        if UserModel.sharedInstance().uniqueUserName != nil{
            self.userNameLbl.text = "@\(UserModel.sharedInstance().uniqueUserName!)"
        }else{
            self.userNameLbl.text = "@DJUser"
        }
        if UserModel.sharedInstance().userProfileUrl != nil && UserModel.sharedInstance().userProfileUrl != ""{
            let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
            do { // http://54.167.191.25/DJJSON/public/uploads/profilePicture/4634userpic.png
                if profileImageUrl != nil {
                    
                    //imgProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                }
            }
        }else{
            //profileBtn.setImage(UIImage(named: "user-profile"), for: .normal)
        }
    }
    
    func notificationCount(){
        let notiCount = UserModel.sharedInstance().notificationCount
        if notiCount != nil {
            if notiCount! > 0 {
                self.notificationNoLbl.isHidden = false
                self.notificationNoLbl.text = "\(notiCount!)"
            }
            
        }
    }
    
    //MARK:- WEBSERVICE CALLING
    func callGetProfileWebService(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId ?? "")&token=\(UserModel.sharedInstance().token ?? "")&user_type=\(UserModel.sharedInstance().userType ?? "")&profileviewid=\(UserModel.sharedInstance().userId ?? "")&profileviewtype=\(UserModel.sharedInstance().userType ?? "")&current_date=\(dateFormatter.string(from: date))"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    self.removeLoader()
                    Loader.shared.hide()
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        globalObjects.shared.profileCompleted = true
                        UserModel.sharedInstance().remainingTime = getProfile.Profiledata![0].project_remaining_time ?? "1:30"
                        UserModel.sharedInstance().userProfileUrl = getProfile.Profiledata![0].profile_picture
                        UserModel.sharedInstance().synchroniseData()
                    }else{
                        Loader.shared.hide()
//                            self.view.makeToast("You are not authorised. Please login again.")
//                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                                    self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
//                                })
                        
                        if getProfile.success == 0{
                            if(getProfile.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(getProfile.message)
                            }
                        }
                        
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
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

                        print("logout success")
                        //self.logout()
                        
                        UserModel.sharedInstance().token = ""
                        UserModel.sharedInstance().userId = ""
                        UserModel.sharedInstance().removeData()
                        UserModel.sharedInstance().synchroniseData()
                        self.ChangeRoot()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(logoutModel.message)
                        if logoutModel.message == "You are not authorised. Please login again."{
                            self.logout()
                        }
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
       // let deviceToken = UserModel.sharedInstance().deviceToken
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
    
    @IBAction func sideMenuBtnTapped(_ sender: Any) {
        //self.sideMenuController?.showLeftView()
        sideMenuController?.showLeftView()
    }
    
    @IBAction func profileBtnTaped(_ sender: Any) {
        
        //callcheckUserVerifyAPI(getIndex: 3)
        if UserModel.sharedInstance().userType == "DJ"{
                    let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
                    let desiredViewController = homeSB.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
                    navigationController?.pushViewController(desiredViewController, animated: false)
        }else{

        }

    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
        //callcheckUserVerifyAPI(getIndex: 4)
        Alert_Action()
    }
    
    func Alert_Action() {
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
                let next1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
                next1?.isFromMenu = false
                navigationController?.pushViewController(next1!, animated: true)
        
    }
    
    @IBAction func postConnctBtnTapped(_ sender: Any) {
        callcheckUserVerifyAPI(getIndex: 1)
//        GlobalId.id == ""
//        let homeSB = UIStoryboard(name: "DJHome", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "PostConnectVC") as! PostConnectVC
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.type = CATransitionType(rawValue: "fade")
//        transition.subtype = CATransitionSubtype.fromLeft
//        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
//        self.navigationController?.pushViewController(desiredViewController, animated: false)
    }
    
    @IBAction func myServiceBtnTapped(_ sender: Any) {
        callcheckUserVerifyAPI(getIndex: 2)
//        let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
//        desiredViewController.buttonSelected = "service"
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType(rawValue: "flip")
//        transition.subtype = CATransitionSubtype.fromLeft
//        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
//        self.navigationController?.pushViewController(desiredViewController, animated: true)
    }
    @IBAction func learnDjConctBtnTapped(_ sender: Any) {
        callcheckUserVerifyAPI(getIndex: 3)
//        let storyboard = UIStoryboard(name: "DJHome", bundle: nil)
//        let next1 = storyboard.instantiateViewController(withIdentifier: "firstDJPV") as? LearnDJConnectVC
//        navigationController?.pushViewController(next1!, animated: true)
    }
    
}
