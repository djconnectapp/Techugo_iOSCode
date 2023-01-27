//
//  GetPinVC.swift
//  DJConnect
//
//  Created by mac on 18/09/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseDynamicLinks
import LGSideMenuController
import LocalAuthentication

var projectIdStr = ""


class GetPinVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var txtPin1: UITextField!
    @IBOutlet weak var txtPin2: UITextField!
    @IBOutlet weak var txtPin3: UITextField!
    @IBOutlet weak var txtPin4: UITextField!
    @IBOutlet weak var lbl1: labelProperties!
    @IBOutlet weak var lbl2: labelProperties!
    @IBOutlet weak var lbl3: labelProperties!
    @IBOutlet weak var lbl4: labelProperties!
    
    //MARK: - GLOBAL VARIABLES
    var pin1 = String()
    var pin2 = String()
    var pin3 = String()
    var pin4 = String()
    var final_pin = Int()
    var count = Int()
    var notify_type = String()
    var notify_detail = NSDictionary()
    
    var projectId:String = ""
    
    var window: UIWindow?
    var context = LAContext()
        
    //MARK: - UIVIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        print("projectId12",projectId)
        projectIdStr = projectId
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        
        faceIdFunc()

    }
    
    func faceIdFunc() {
        
            context = LAContext()
        context.localizedFallbackTitle = ""
            context.localizedCancelTitle = "Enter Pin"

            // First check if we have the needed hardware support.
            var error: NSError?
            guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
                print(error?.localizedDescription ?? "Can't evaluate policy")

                // Fall back to a asking for username and password.
                // ...
                return
            }
            if #available(iOS 13.0, *) {
                Task {
                    do {
                        try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
                       // state = .loggedin
                        
                        //print("congrats, your faceID success")
                        
                        if UserModel.sharedInstance().userType == "DJ"{
                            self.setUpDrawer()

                        }else{
                            self.setUpDrawerArtist()
                        }
                    } catch let error {
                        print(error.localizedDescription)
                                                // ...
                    }
                }
            } else {
            }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnNumber_Action(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == true{
            txtPin1.text = "\(sender.tag)"
            pin1 = txtPin1.text!
            lbl1.backgroundColor = .white
        }else if txtPin2.text?.isEmpty == true{
            txtPin2.text = "\(sender.tag)"
            pin2 = txtPin2.text!
            lbl2.backgroundColor = .white
        }else if txtPin3.text?.isEmpty == true{
            txtPin3.text = "\(sender.tag)"
            pin3 = txtPin3.text!
            lbl3.backgroundColor = .white
        }else if txtPin4.text?.isEmpty == true{
            txtPin4.text = "\(sender.tag)"
            pin4 = txtPin4.text!
            lbl4.backgroundColor = .white
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.btnConfirm_Action(UIButton())
            }
        }
    }
    
    @IBAction func btnClear_Action(_ sender: UIButton) {
        if lbl4.backgroundColor == UIColor.white{
            txtPin4.text = ""
            lbl4.backgroundColor = .clear
        }else if lbl3.backgroundColor == UIColor.white{
            txtPin3.text = ""
            lbl3.backgroundColor = .clear
        }else if lbl2.backgroundColor == UIColor.white{
            txtPin2.text = ""
            lbl2.backgroundColor = .clear
        }else if lbl1.backgroundColor == UIColor.white{
            txtPin1.text = ""
            lbl1.backgroundColor = .clear
        }
        
    }
    
    @IBAction func btnConfirm_Action(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == false && txtPin2.text?.isEmpty == false && txtPin3.text?.isEmpty == false && txtPin4.text?.isEmpty == false{
            let pin = pin1 + pin2 + pin3 + pin4
            final_pin = Int(pin)!
            txtPin1.text?.removeAll()
            txtPin2.text?.removeAll()
            txtPin3.text?.removeAll()
            txtPin4.text?.removeAll()
            lbl1.backgroundColor = .clear
            lbl2.backgroundColor = .clear
            lbl3.backgroundColor = .clear
            lbl4.backgroundColor = .clear
            count = count + 1
            if count < 5{
                checkPin(userPin: String(final_pin))
            }else{
                self.view.makeToast("You have attepmt max entered pin. Please login again")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
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
                let arname = UserModel.sharedInstance().userName
                let arpassword = UserModel.sharedInstance().password
                UserModel.sharedInstance().removeData()
                UserModel.sharedInstance().synchroniseData()
                UserModel.sharedInstance().appLanguage = applanguage
                UserModel.sharedInstance().currentLatitude = latitude
                UserModel.sharedInstance().currentLongitude = longitude
               // UserModel.sharedInstance().deviceToken = deviceToken
                UserModel.sharedInstance().synchroniseData()
                if isRemember == "1"{
                    // ashitesh
                    if UserModel.sharedInstance().userType == "DJ"{
                        self.setUpDrawer()
                    }else{
                        self.setUpDrawerArtist()
                    }
                }else{
                    UserModel.sharedInstance().isRemembered = isRemember
                }
                self.ChangeRoot()
            })
            }
        }else{
            self.view.makeToast("Please enter your pin.")
        }
    }
    
    fileprivate func setUpDrawer() {
        guard let centerController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "NewDJHomeVC") as? NewDJHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
    
            let navigation = UINavigationController.init(rootViewController: centerController)
            navigation.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
            //sideMenuController.leftViewWidth = 280.0
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle
       
      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
    }
//   
    func setUpDrawerArtist() {
        guard let centerController = UIStoryboard.init(name: "ArtistHome", bundle: nil).instantiateViewController(withIdentifier: "NewArtistHomeVC") as? NewArtistHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
    
            let navigation = UINavigationController.init(rootViewController: centerController)
            navigation.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
            //sideMenuController.leftViewWidth = 280.0
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle
       
      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
   }
    
    func ChangeRoot(storyboard : String, identifier : String) {
       // callDeviceRegistrationApi()
        let homeSB = UIStoryboard(name: "\(storyboard)", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "\(identifier)") as! UINavigationController
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
        desiredViewController.view.addSubview(snapshot);
        appdel.window?.rootViewController = desiredViewController;
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview()
        })
    }
    
    @IBAction func btnLogout_Action(_ sender: UIButton) {
        //logout code
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
            if UserModel.sharedInstance().RememberUserType == "AR"{
                UserModel.sharedInstance().arname = arname
                UserModel.sharedInstance().arpassword = arpassword
                UserModel.sharedInstance().isRemembered = isRemember
                UserModel.sharedInstance().RememberUserType = rememberType
                UserModel.sharedInstance().synchroniseData()
            }else{
                UserModel.sharedInstance().userName = username
                UserModel.sharedInstance().password = password
                UserModel.sharedInstance().isRemembered = isRemember
                UserModel.sharedInstance().RememberUserType = rememberType
                UserModel.sharedInstance().synchroniseData()
            }
        }else{
            UserModel.sharedInstance().isRemembered = isRemember
        }
        self.ChangeRoot()
    }
    
    //MARK: - OTHER METHODS
    func userHome(stroyBoard : String,identifier : String){
        let homeSB = UIStoryboard(name: "\(stroyBoard)", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "\(identifier)") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = desiredViewController
    }
    
    func checkPin(userPin : String){
        if UserModel.sharedInstance().userPin == "\(userPin)"{
            if globalObjects.shared.isFromBackGroundState == true{
                //globalObjects.shared.isFromBackGroundState = false
                self.count = 0

                if UserModel.sharedInstance().userType == "DJ"{
                    if(projectIdStr != ""){
                        
                        if(UserModel.sharedInstance().token != nil || UserModel.sharedInstance().token != "")
                        {
                            
                            let mainStoryBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
                            redViewController.projectId = projectId
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window?.rootViewController = redViewController
                            projectIdStr = ""
                            
                        }
                        
                    }else{
                    
                        self.dismiss(animated: true, completion: nil)
                    }

                }else{
                   // globalObjects.shared.isFromBackGroundState = false
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                self.count = 0

                if UserModel.sharedInstance().userType == "DJ"{
                    self.setUpDrawer()

                }else{
                    self.setUpDrawerArtist()
                }
            }
        }else {
            Loader.shared.hide()
            self.view.makeToast("Wrong pin")
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
            if UserModel.sharedInstance().RememberUserType == "AR"{
                UserModel.sharedInstance().arname = arname
                UserModel.sharedInstance().arpassword = arpassword
                UserModel.sharedInstance().isRemembered = isRemember
                UserModel.sharedInstance().RememberUserType = rememberType
                UserModel.sharedInstance().synchroniseData()
                
            }else{
                UserModel.sharedInstance().userName = username
                UserModel.sharedInstance().password = password
                UserModel.sharedInstance().isRemembered = isRemember
                UserModel.sharedInstance().RememberUserType = rememberType
                UserModel.sharedInstance().synchroniseData()
                
            }
        }else{
            UserModel.sharedInstance().isRemembered = isRemember
        }
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
    
    func Buy_Project_Artist_Audio(_ projectId : String){
        let storyboard = UIStoryboard(name: "DJProfile", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
        vc1.isFromAlert = false
        vc1.isFromNotification = true
        vc1.projectId = "\(projectId)"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = vc1
    }
    
    //MARK: - WEBSERVICES
    func callLogoutWebservice(){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
            ]
           // CommonFunctions.shared.showLoader()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.logoutAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    CommonFunctions.shared.hideLoader()
                    let logoutModel = response.result.value!
                    if logoutModel.success == 1{

                    }else{
                        CommonFunctions.shared.hideLoader()
                        if logoutModel.message == "You are not authorised. Please login again."{
                            //self.logout()
                        }
                    }
                case .failure(let error):
                    CommonFunctions.shared.hideLoader()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
}
