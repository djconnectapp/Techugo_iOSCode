//
//  LoginInVC.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 11/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import AlamofireObjectMapper

import AuthenticationServices
//import Firebase

class LoginInVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var txtEmail: textFieldProperties!
    @IBOutlet weak var txtPassword: textFieldProperties!
    @IBOutlet weak var lblPrivacyTerm: UILabel!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var forgotPaswrdBtn: UIButton!
    @IBOutlet weak var backHomeBtn: buttonProperties!
    @IBOutlet weak var orUseLbl: UILabel!
    
    @IBOutlet weak var showHidePswrdBtn: UIButton!
    
    
    @IBAction func showHidePaswrdBtnTapped(_ sender: Any) {
        if(txtPassword.isSecureTextEntry == true){
            showHidePswrdBtn.setImage(UIImage(named: "Hide"), for: .normal)
            txtPassword.isSecureTextEntry                   = false;
        }
        else{
            showHidePswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
            txtPassword.isSecureTextEntry                   = true;
        }
    }
    
    //MARK: - ENUMS
    enum registerMode{
        case facebook
        case gmail
        case apple
    }
    
    //MARK:- GLOBAL VARIABLES
    var loginButtonSelected = String()
    var dictFB = [String : String]()
    var dictG = [String : String]()
    
    var dictApple = [String : String]()
    var selectedRegisterMode = registerMode.facebook
    
    var strAppleToken = ""
    //var application:UIApplication
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: {_, _ in })
//            // For iOS 10 data message (sent via FCM
//            //FIRMessaging.messaging().remoteMessageDelegate = self
//        } else {
//            let settings: UIUserNotificationSettings =
//            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//              application.registerUserNotificationSettings(settings)
//        }
//
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//        Messaging.messaging().isAutoInitEnabled = true
//
//        application.registerForRemoteNotifications()
//        //remoteNotification(application: application)
        
        print("LogindeviceToken",UserModel.sharedInstance().deviceToken)
        userSelection()
        //GIDSignIn.sharedInstance.clientID = Constant.google_client_id
        txtEmail.text = ""
        txtPassword.text = ""
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtPassword.isSecureTextEntry = true;
        showHidePswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
        
    }
    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("fcmToken",fcmToken ?? "")
//        //UserDefaults.standard.set(fcmToken, forKey: "device_token")
//
//        UserModel.sharedInstance().deviceToken = fcmToken!
//        UserModel.sharedInstance().synchroniseData()
//        print("deviceToken",UserModel.sharedInstance().deviceToken)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if UserModel.sharedInstance().userType == "AR"{
            if #available(iOS 13.0, *) {
                let app = UIApplication.shared
                let statusbarView = UIView(frame: app.statusBarFrame)
                statusbarView.backgroundColor = UIColor(red: 31/255, green: 31/255, blue: 91/255, alpha: 1.0)
                app.statusBarUIView?.addSubview(statusbarView)
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = UIColor(red: 31/255, green: 31/255, blue: 91/255, alpha: 1.0)
            }
        }else{
            if #available(iOS 13.0, *) {
                let app = UIApplication.shared
                
                let statusbarView = UIView(frame: app.statusBarFrame)
                statusbarView.backgroundColor = UIColor(red: 40/255, green: 42/255, blue: 87/255, alpha: 1.0)
                app.statusBarUIView?.addSubview(statusbarView)
                
            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = UIColor(red: 40/255, green: 42/255, blue: 87/255, alpha: 1.0)
            }
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnJoin_Action(_ sender: UIButton) {
        loginButtonSelected = "join"
        performSegue(withIdentifier: "segueWelcomeBackJoin", sender: nil)
    }
    
    @IBAction func btnBack_Action(_ sender: UIButton) {
        UserModel.sharedInstance().isHomePress = true
        UserModel.sharedInstance().synchroniseData()
        performSegue(withIdentifier: "segueHomeFordj", sender: nil)
    }
    
    @IBAction func btnContinue_Action(_ sender: UIButton) {
        txtPassword.resignFirstResponder()
        txtEmail.resignFirstResponder()
        let enteredEmail = txtEmail.text
        let enteredPassword = txtPassword.text
        let validatePwdBool = validatePassword(password: enteredPassword!)
        if enteredEmail?.isEmpty == true {
                        
            self.view.makeToast("Please enter your email.".localize)
        }else if validatePwdBool == false {
            self.view.makeToast("Please enter valid password.".localize)
        }else {
           // callLoginService()
        }
    }
    @IBAction func btnForgotAction(_ sender: UIButton) {
        txtPassword.resignFirstResponder()
        txtEmail.resignFirstResponder()
        loginButtonSelected = "forget"
        self.performSegue(withIdentifier: "segueWelcomeBackJoin", sender: nil)
    }
    
    @IBAction func btnJoinWithGoogle_Action(_ sender: UIButton) {
        selectedRegisterMode = .gmail
        callGmailLoginSDK()
//        GIDSignIn.sharedInstance.delegate = self
//        GIDSignIn.sharedInstance.uiDelegate = self
//        GIDSignIn.sharedInstance.signIn()
    }
    
    @IBAction func btnJoinWithFacebook_Action(_ sender: UIButton) {
        selectedRegisterMode = .facebook
        facebookCall()
    }
    
    @IBAction func btnJoinWithApple_Action(_ sender: UIButton) {
        //self.showAlertView("Under Development")
        
        if #available(iOS 13.0, *) {
            selectedRegisterMode = .apple
                    self.handleLogInWithAppleIDButtonPress()
            print("1")
                } else {
                    print("2")
                }
        print("3")
    }
    //MARK: - OTHER METHODS
    func userSelection(){
        setupPolicyLbl()
        if UserModel.sharedInstance().userType == "DJ"{
            self.imgBack.image = UIImage(named: "LoginBack_DJ")
            self.lblWelcome.text = "Welcome DJ".localize
            self.lblHeader.text = "Log In DJ".localize
            self.btnLogin.setTitle("Log In DJ".localize, for: .normal)
            self.btnSignup.setTitle("Sign Up DJ".localize, for: .normal)
            self.backHomeBtn.setTitle("BACK HOME".localize, for: .normal)
            txtEmail.placeholder = "Username or email".localize
            txtPassword.placeholder = "password".localize
            self.forgotPaswrdBtn.setTitle("Forgot password?".localize, for: .normal)
            self.orUseLbl.text = "Or Use".localize
        }else{
            self.imgBack.image = UIImage(named: "LoginBack_AR")
            self.lblWelcome.text = "Welcome Artist".localize
            self.lblHeader.text = "Log In Artist".localize
            self.btnLogin.setTitle("Log In Artist".localize, for: .normal)
            self.btnSignup.setTitle("Sign Up Artist".localize, for: .normal)
            self.backHomeBtn.setTitle("BACK HOME".localize, for: .normal)
            txtEmail.placeholder = "Username or email".localize
            txtPassword.placeholder = "password".localize
            self.forgotPaswrdBtn.setTitle("Forgot password?".localize, for: .normal)
            self.orUseLbl.text = "Or Use".localize
        }
    }
    
    func ChangeRoot(storyboard : String, identifier : String) {
        callDeviceRegistrationApi()
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
    
    func setupPolicyLbl() {
        lblPrivacyTerm.text = "By continuing you agree to our Terms of Use and Privacy Policy.".localize
        let text = (lblPrivacyTerm.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let termsRange = (text as NSString).range(of: "Terms of Use")
        let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: privacyRange)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: termsRange)
        lblPrivacyTerm.attributedText = underlineAttriString
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
        lblPrivacyTerm.isUserInteractionEnabled = true
        lblPrivacyTerm.addGestureRecognizer(tapAction)
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: lblPrivacyTerm, targetText: "Terms of Use") {
            self.callHelpSubMenuWebService(webservice.termsOfUse)
        }else if gesture.didTapAttributedTextInLabel(label: lblPrivacyTerm, targetText: "Privacy Policy") {
            self.callHelpSubMenuWebService(webservice.privacyPolicy)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueWelcomeBackJoin"{
            let destinationVC = segue.destination as! SignInVC
            destinationVC.loginButtonSelected = loginButtonSelected
        }
        if segue.identifier == "segueFacebookDetail"{
            let destinationVC = segue.destination as! FacebookGoogleDetailVC
            destinationVC.dictFB = dictFB
            destinationVC.dictG = dictG
            if selectedRegisterMode == .facebook{
                destinationVC.registerType = "facebook"
            }
            if selectedRegisterMode == .gmail{
                destinationVC.registerType = "gmail"
            }
            
            if selectedRegisterMode == .apple{
                destinationVC.registerType = "apple"
                destinationVC.dictApple = dictApple
            }
        }
    }
    
    func calculateEnteredTime(){
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        globalObjects.shared.AppEnteredTime = formatter.string(from: now)
    }
    
    func facebookCall(){
       // LoginManager().logOut()
        if getReachabilityStatus(){
            
            let fbManager = LoginManager()
           // fbManager.logOut()
            if AccessToken.current != nil {
                LoginManager().logOut()
            }
            fbManager.logIn(permissions: ["email"], from: self) { (result, error) in
                if (error == nil){
                    GraphRequest(graphPath: "me", parameters: ["fields": "id,name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                        if (error == nil){
                            if let result = result as? [String:AnyObject]{
                                let url = URL(string: "https://graph.facebook.com/\(result["id"] as! String)/picture?type=large&return_ssl_resources=1")
                                print(result)
                                self.dictFB["profile_image"] = url?.absoluteString
                                self.dictFB["name"] = result["name"] as? String
                                self.dictFB["birthdate"] = " "
                                self.dictFB["email"] = result["email"] as? String
                                self.dictFB["phone_number"] = " "
                                self.dictFB["fb_token"] = AccessToken.current?.tokenString
                                self.dictFB["fb_id"] = result["id"] as? String
                                self.dictFB["user_type"] = "\(UserModel.sharedInstance().userType!)"
                                
                                print(self.dictFB)
                                // ashitesh 18 may
                                //self.callFacebookGoogleStatusService(id: self.dictFB["fb_id"]!, type: "facebook", dictData: self.dictFB)
                            }
                        }
                    })
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func ChangeRootProfile() { // open edit profile screen - previous it was used
        callDeviceRegistrationApi(false)
//        let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "ProfilePageVC") as! ProfilePageVC
//        desiredViewController.initialName = "\(UserModel.sharedInstance().uniqueUserName!)"
//        let appdel = UIApplication.shared.delegate as! AppDelegate
//        let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
//        desiredViewController.view.addSubview(snapshot);
//        appdel.window?.rootViewController = desiredViewController;
//        UIView.animate(withDuration: 0.3, animations: {() in
//            snapshot.layer.opacity = 0;
//            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
//        }, completion: {
//            (value: Bool) in
//            snapshot.removeFromSuperview();
//        });
    }
    
    
    //MARK:- WEBSERVICES
    func callLoginService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            let requestUrl = "\(webservice.url)\(webservice.loginAPI)"
            let parameters = [
                "username":"\(txtEmail.text!)",
                "password":"\(txtPassword.text!)",
                "user_type":"\(UserModel.sharedInstance().userType!)"
            ]
            
            print("parameterslogin:",parameters)
            
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<LoginModel>) in
                
                switch response.result {
                case .success(_):
                    let loginModel = response.result.value!
                    if loginModel.success == 1{
                        Loader.shared.hide()
                        UserModel.sharedInstance().isSignup = false
                        UserModel.sharedInstance().name = loginModel.responseData!.username!
                        UserModel.sharedInstance().birthdate = loginModel.responseData!.birthdate!
                        UserModel.sharedInstance().email = loginModel.responseData!.email!
                        UserModel.sharedInstance().phone_number = loginModel.responseData!.phoneNumber!
                        UserModel.sharedInstance().userId
                            = loginModel.responseData?.userid.stringValue
                        
                        print("profilePic:",loginModel.responseData!.profilePicture ?? "")
                        UserModel.sharedInstance().userProfileUrl = loginModel.responseData!.profilePicture ?? ""
                        UserModel.sharedInstance().userType = (loginModel.responseData!.type!).uppercased()
                        UserModel.sharedInstance().token = loginModel.token
                        print("PrintNewToken:",UserModel.sharedInstance().token)
                        UserModel.sharedInstance().finishProfile = false
                        UserModel.sharedInstance().genereList = loginModel.responseData!.genre!
                        globalObjects.shared.isForgotPassword = loginModel.responseData!.isForgot!
                        UserModel.sharedInstance().currency_code = loginModel.responseData!.countryCode!
                        print("countryCode",loginModel.responseData!.countryCode)
                        UserModel.sharedInstance().uniqueUserName = loginModel.responseData!.username!
                        UserModel.sharedInstance().userCurrency =  loginModel.responseData!.currncySymbol!
                        UserModel.sharedInstance().currency_name =  loginModel.responseData!.currncyName!
                        UserModel.sharedInstance().currency_id =  loginModel.responseData!.currencyId.stringValue
                        print("pin:",loginModel.responseData!.userPin)
                        UserModel.sharedInstance().userPin = loginModel.responseData!.userPin
                        UserModel.sharedInstance().remainingTime = loginModel.responseData!.project_remaining_time
                        UserModel.sharedInstance().notificationCount = loginModel.responseData!.notificationCount
                        UserModel.sharedInstance().synchroniseData()
                        self.callDeviceRegistrationApi(true)
                        
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(loginModel.message)
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
    
    func callDeviceRegistrationApi(_ canChange : Bool = false){
        var parameters = [String : String]()
        let strDeviceUDID: String = UIDevice.current.identifierForVendor!.uuidString
        let strDeviceName: String = UIDevice.current.name
        let strDeviceModel: String = UIDevice.current.model
        let strDeviceVersion: String = UIDevice.current.systemVersion
        if getReachabilityStatus(){
            Loader.shared.show()
            if UserModel.sharedInstance().deviceToken != nil{
                if UserModel.sharedInstance().deviceToken == ""{
                    UserModel.sharedInstance().deviceToken = "225cb5dbc4d033bcc0b1b595af07fcca04ba27c97fdc91d7de586dd774c2e8c7"
                }
                parameters = [
                    "user_id":"\(UserModel.sharedInstance().userId!)",
                    "user_type":"\(UserModel.sharedInstance().userType!)",
                    "devicetoken":"\(UserModel.sharedInstance().deviceToken!)",
                    "deviceuid":"\(strDeviceUDID)",
                    "devicename":"\(strDeviceName)",
                    "devicemodel":"\(strDeviceModel)",
                    "deviceversion":"\(strDeviceVersion)",
                    "push_notification_status":"1"
                ]
            }else{
                //
                let userId = "\(UserModel.sharedInstance().userId)"
                
                parameters = [
                    
                    //"user_id":"10223766940795278",
                    //Ashitesh
                    "user_id":"\(UserModel.sharedInstance().userId!)",
                    "user_type":"\(UserModel.sharedInstance().userType!)",
                    "devicetoken":" 472f63ee65c35698975526a99fbb7718",
                    "deviceuid":"8E6ECAEF-A5C5-4AF9-835E-59BAD811ACC3",
                    "devicename":"Custom",
                    "devicemodel":"iPhone",
                    "deviceversion":"12.4.4",
                    "push_notification_status":"1"
                ]
            }
            
            print("device Register parameters",parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addRecordAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    let loginModel = response.result.value!
                    if loginModel.success == 1{
                        Loader.shared.hide()
                        self.calculateEnteredTime()
                                                
                        if canChange{
                            // new code for open pin screen
                            let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
                            let vc2 = storyboard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC
                            self.navigationController?.pushViewController(vc2, animated: false)
                            
                            // ashitesh
//                            if UserModel.sharedInstance().userType == "DJ"{
//                                self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
//                            }else{
//                                self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
//                            }
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(loginModel.message)
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
    
    func callFacebookGoogleStatusService(id: String, type: String, dictData: [String: String]){
        
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.checkGoogleFbAccountAPI)"
            let parameters = [
                "id":"\(id)",
                "sign_up_type":"\(type)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FacebookGoogleStatusModel>) in
                
                switch response.result {
                case .success(_):
                    let statusModel = response.result.value!
                    if statusModel.success == 1{
                        Loader.shared.hide()
                        let status = statusModel.responceData?.registerStatus!
                       // self.callDeviceRegistrationApi(false)
                        if type == "facebook"{
                            if status == "0"{
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                self.callFbLoginService(Data: dictData)
                            }
                            
                        }
                        
                        else if type == "apple"{
                            if status == "0"{
                                // open apple page
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                // call apple api
                                //self.callAppleLoginService(Data: dictData)
                            }
                        }
                        
                        else{
                            if status == "0"{
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                self.googleSignIn(Data: dictData)
                            }
                        }
                    }else{
                        if type == "facebook"{
                            if statusModel.success == 0{
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                self.callFbLoginService(Data: dictData)
                            }
                            
                        }
                        
                        else if type == "apple"{
                            if statusModel.success == 0{
                                // open apple page
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                // call apple api
                                self.callAppleLoginService(Data: dictData)
                            }
                        }
                        
                        else{
                            if statusModel.success == 0{
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                self.googleSignIn(Data: dictData)
                            }
                        }
                        Loader.shared.hide()
                        self.view.makeToast(statusModel.message)
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
    
    func callFbLoginService(Data:[String : String]){
        if getReachabilityStatus(){
            
            let parameters = [
                "profile_image":Data["profile_image"]!,
                "name":Data["name"]!,
                "birthdate":Data["birthdate"]!,
                "email":Data["email"]!,
                "phone_number":Data["phone_number"]!,
                "fb_token":Data["fb_token"]!,
                "fb_id":Data["fb_id"]!,
                "user_type":Data["user_type"]!,
                "pin":"",
                "country_code":""
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.facebookAPI)"), method: .post, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FaceBookModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let fbModel = response.result.value!
                    if let result = fbModel.success {
                        if result == 1 {
                            self.view.makeToast(fbModel.message)
//                            UserModel.sharedInstance().userId = "\(fbModel.responceData?.userid)"
//                            UserModel.sharedInstance().token = fbModel.responceData?.token
                            UserModel.sharedInstance().userId = Data["fb_id"]
                            UserModel.sharedInstance().token = Data["fb_token"]
                            UserModel.sharedInstance().email = Data["email"]
                            UserModel.sharedInstance().uniqueUserName = Data["name"]!
                            UserModel.sharedInstance().synchroniseData()
                            if  fbModel.responceData?.profile_completion == "no"{
                                UserModel.sharedInstance().isSignup = true
                                UserModel.sharedInstance().isSkip = false
                                UserModel.sharedInstance().paymentPopup = false
                                UserModel.sharedInstance().finishPopup = false
                                UserModel.sharedInstance().finishProfile = true
                                UserModel.sharedInstance().synchroniseData()
                                self.ChangeRootProfile()
                            }else{
                                UserModel.sharedInstance().finishProfile = false
                                UserModel.sharedInstance().isSignup = false
                                UserModel.sharedInstance().synchroniseData()
                                
                                if UserModel.sharedInstance().userType == "DJ"{
                                    self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
                                }else{
                                    self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
                                }
                            }
                        }
                        else {
                            Loader.shared.hide()
                            self.view.makeToast(fbModel.message)
                        }
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
    }
    
    func googleSignIn(Data: [String : String]){
        if getReachabilityStatus(){
            let parameters = [
                "profile_image":Data["img_url"]!,
                "name":Data["full_name"]!,
                "birthdate":"",
                "email":Data["email"]!,
                "phone_number":"",
                "google_token":"",//Data["token"]!,
                "google_id":Data["google_id"]!,
                "user_type":Data["user_type"]!,
                "pin":"",
                "country_code":""
            ]
            print(parameters)
            self.view.endEditing(true)
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.googleAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default,headers: nil).responseObject { (response:DataResponse<GoogleSucessModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let googleModel = response.result.value!
                    if let result = googleModel.success {
                        if result == 1 {
                            self.view.makeToast(googleModel.message)
                            let _modelData = googleModel.responseData!
                            UserModel.sharedInstance().userId = "\(_modelData.userid!)"
                            UserModel.sharedInstance().userType = "\(UserModel.sharedInstance().userType!)"
                            
                            //UserModel.sharedInstance().userId = Data["fb_id"]
                            //UserModel.sharedInstance().token = Data["fb_token"]
                            
                            UserModel.sharedInstance().token = _modelData.token!
                            UserModel.sharedInstance().email = Data["email"]!
                            UserModel.sharedInstance().uniqueUserName = Data["full_name"]!
                            UserModel.sharedInstance().currency_code = _modelData.currency_code!
                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol!
                            
                            UserModel.sharedInstance().currency_id = "\(_modelData.currncyId ?? 0)"
                            UserModel.sharedInstance().currency_name = "\(_modelData.currncyName ?? "")"
//                            if(_modelData.currncyName == ""){
//                                if(UserModel.sharedInstance().setCurrencyNameSt == "$"){
//                                    UserModel.sharedInstance().currency_name = "$"
//                                }
//                                else{
//                                    UserModel.sharedInstance().currency_name = "₹"
//                                }
//                            }
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount ?? 0
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time ?? ""
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin ?? 0)"
                            UserModel.sharedInstance().genereList = _modelData.genre ?? ""
                            
                            UserModel.sharedInstance().synchroniseData()
                            if  _modelData.profile_completion == "no"{
                                UserModel.sharedInstance().isSignup = true
                                UserModel.sharedInstance().isSkip = false
                                UserModel.sharedInstance().paymentPopup = false
                                UserModel.sharedInstance().finishPopup = false
                                UserModel.sharedInstance().finishProfile = true
                                UserModel.sharedInstance().synchroniseData()
                                self.ChangeRootProfile()
                            }else{
                                UserModel.sharedInstance().finishProfile = false
                                UserModel.sharedInstance().isSignup = false
                                UserModel.sharedInstance().synchroniseData()
                                if UserModel.sharedInstance().userType == "DJ"{
                                    self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
                                }else{
                                    self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
                                }
                            }
                        }
                        else {
                            Loader.shared.hide()
                            self.view.makeToast(googleModel.message)
                        }
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callAppleLoginService(Data: [String : String]){
        if getReachabilityStatus(){
            let parameters = [
                "profile_image":Data["img_url"] ?? "",
                "name":Data["name"] ?? "",
                "birthdate":"",
                "email":Data["email"] ?? "",
                "phone_number":"",
                "apple_token":strAppleToken,
                "apple_id":Data["apple_id"] ?? "",
                "user_type":Data["user_type"] ?? "",
                "pin":"",
                "country_code":""
            ]
            print(parameters)
            self.view.endEditing(true)
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.appleLoginAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default,headers: nil).responseObject { (response:DataResponse<AppleSucessModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let appleModel = response.result.value!
                    if let result = appleModel.success {
                        if result == 1 {
                            self.view.makeToast(appleModel.message)
                            let _modelData = appleModel.responseData!
                            UserModel.sharedInstance().userId = "\(_modelData.userid!)"
                            UserModel.sharedInstance().userType = "\(UserModel.sharedInstance().userType!)"
                            
                            UserModel.sharedInstance().token = _modelData.token ?? ""
                            UserModel.sharedInstance().email = Data["email"]!
                            UserModel.sharedInstance().uniqueUserName = Data["name"]!
                            UserModel.sharedInstance().currency_code = _modelData.currency_code ?? ""
                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol ?? ""
                            
                            
                            
                            UserModel.sharedInstance().currency_id = "\(_modelData.currncyId ?? 0)"
                            UserModel.sharedInstance().currency_name = "\(_modelData.currncyName ?? "")"
//                            if(_modelData.currncyName == ""){
//                                if(UserModel.sharedInstance().setCurrencyNameSt == "$"){
//                                    UserModel.sharedInstance().currency_name = "$"
//                                }
//                                else{
//                                    UserModel.sharedInstance().currency_name = "₹"
//                                }
//                            }
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount ?? 0
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time ?? ""
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin ?? 0)"
                            UserModel.sharedInstance().genereList = _modelData.genre ?? ""
                            
                            UserModel.sharedInstance().synchroniseData()
                            if  _modelData.profile_completion == "no"{
                                UserModel.sharedInstance().isSignup = true
                                UserModel.sharedInstance().isSkip = false
                                UserModel.sharedInstance().paymentPopup = false
                                UserModel.sharedInstance().finishPopup = false
                                UserModel.sharedInstance().finishProfile = true
                                UserModel.sharedInstance().synchroniseData()
                                self.ChangeRootProfile()
                            }else{
                                UserModel.sharedInstance().finishProfile = false
                                UserModel.sharedInstance().isSignup = false
                                UserModel.sharedInstance().synchroniseData()
                                if UserModel.sharedInstance().userType == "DJ"{
                                    self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
                                }else{
                                    self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
                                }
                            }
                        }
                        else {
                            Loader.shared.hide()
                            self.view.makeToast(appleModel.message)
                        }
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
}



//MARK: - EXTENSIONS
extension LoginInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // if textField == txtEmail{
        txtPassword.resignFirstResponder()
//        }
//        else{
//        self.view.endEditing(true)
//
//        }
        return true
    }
}


extension LoginInVC {
func callGmailLoginSDK() {
        let signInConfig = GIDConfiguration.init(clientID:  Constant.google_client_id)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [self] user, error in
            if (error == nil) {
                let gPlusId = user?.userID ?? ""
                let name = user?.profile?.name ?? ""
                let firstname = user?.profile?.familyName ?? ""
                let lastname = user?.profile?.givenName ?? ""
                var email:String = ""
                if let emailID = user?.profile?.email{
                    email = emailID
                }else{
                    email = ""
                }
                GIDSignIn.sharedInstance.signOut()
                
                print(name,gPlusId)
                
                if (name != nil){
                               dictG["google_id"] = user?.userID ?? ""
                    dictG["token"] = user?.authentication.idToken!
                    dictG["full_name"] = user?.profile?.name ?? ""
                    dictG["email"] = user?.profile?.email ?? ""
                    dictG["img_url"] = user?.profile?.imageURL(withDimension: 200)?.absoluteString
                               dictG["user_type"] = "\(UserModel.sharedInstance().userType!)"
                    // ashitesh 18 may
                               //self.callFacebookGoogleStatusService(id: dictG["google_id"]!, type: "google", dictData: dictG)
                           }
//                self.objSignup =  SignUpModel(userName: name, email: email,countryCode:"",countryName: "", phoneNumber: "")
//                socialUserName = name
//                objSocialSignup = SocialModel(email: email, id: gPlusId)
//                createGoogleRequest(firstName:firstname,lastName:lastname,googleId: gPlusId ,email: email)
            }else {
                print("\(error?.localizedDescription ?? "")")
            }
            
        }
    }
}

//extension LoginInVC: GIDSignInDelegate, GIDSignInUIDelegate {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print("\(error.localizedDescription)")
//        }else{
//            // Perform any operations on signed in user here.
//            if (user != nil){
//                dictG["google_id"] = user.userID!
//                dictG["token"] = user.authentication.idToken!
//                dictG["full_name"] = user.profile?.name
//                dictG["email"] = user.profile?.email
//                dictG["img_url"] = user.profile?.imageURL(withDimension: 200)?.absoluteString
//                dictG["user_type"] = "\(UserModel.sharedInstance().userType!)"
//                self.callFacebookGoogleStatusService(id: dictG["google_id"]!, type: "google", dictData: dictG)
//            }
//        }
//    }
//    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
//
//    }
//
//    func sign(_ signIn: GIDSignIn!,
//              present viewController: UIViewController!) {
//        self.present(viewController, animated: true, completion: nil)
//    }
//
//    func sign(_ signIn: GIDSignIn!,
//              dismiss viewController: UIViewController!) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}

//MARK:- Signin With Apple

@available(iOS 13.0, *)
extension LoginInVC : ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

  @available(iOS 13.0, *)
  extension LoginInVC : ASAuthorizationControllerDelegate {
          
          @available(iOS 13.0, *)
          private func performExistingAccountSetupFlows() {
              // Prepare requests for both Apple ID and password providers.
              let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]
              // Create an authorization controller with the given requests.
              let authorizationController = ASAuthorizationController(authorizationRequests: requests)
              authorizationController.delegate = self
              authorizationController.presentationContextProvider = self
              authorizationController.performRequests()
          }
          
          func handleLogInWithAppleIDButtonPress() {
              let appleIDProvider = ASAuthorizationAppleIDProvider()
              let request = appleIDProvider.createRequest()
              request.requestedScopes = [.fullName, .email]
              
              let authorizationController = ASAuthorizationController(authorizationRequests: [request])
              authorizationController.delegate = self
              authorizationController.presentationContextProvider = self
              authorizationController.performRequests()
          }
      
      
      
      @available(iOS 13.0, *)
      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

      }
      
      @available(iOS 13.0, *)
      func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
          if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
              // Create an account in your system.
              // For the purpose of this demo app, store the these details in the keychain.
            if appleIDCredential.email !=  nil{
              KeychainItem.currentUserIdentifier = appleIDCredential.user
              KeychainItem.currentUserFirstName = appleIDCredential.fullName?.givenName
              KeychainItem.currentUserLastName = appleIDCredential.fullName?.familyName
              KeychainItem.currentUserEmail = appleIDCredential.email
            }
              
              print("User Id - \(appleIDCredential.user)")
              print("User Name - \(appleIDCredential.fullName?.description ?? "")")
              print("User Email - \(appleIDCredential.email ?? "")")
              print("Real User Status - \(appleIDCredential.realUserStatus.rawValue)")
              
              if let identityTokenData = appleIDCredential.identityToken,
                  let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                strAppleToken = identityTokenString ?? ""
                  print("Identity Token \(identityTokenString)")
              }
              
             // let name = "\(appleIDCredential.fullName?.description ?? "")"
              
            dictApple["apple_id"] = "\(KeychainItem.currentUserIdentifier ?? "")"
            dictApple["token"] = strAppleToken
            dictApple["full_name"] = "\(KeychainItem.currentUserFirstName ?? "") \(KeychainItem.currentUserLastName ?? "")"
            dictApple["name"] = KeychainItem.currentUserFirstName
            dictApple["email"] = KeychainItem.currentUserEmail
            dictApple["img_url"] = ""
            dictApple["user_type"] = "\(UserModel.sharedInstance().userType ?? "")"
           // ashitesh 18 may
            //self.callFacebookGoogleStatusService(id: dictApple["apple_id"]!, type: "apple", dictData: dictApple)
              
          } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
              // Sign in using an existing iCloud Keychain credential.
              let username = passwordCredential.user
              let password = passwordCredential.password
              
            
            self.view.makeToast("The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)")
              
          }
      }
  }

