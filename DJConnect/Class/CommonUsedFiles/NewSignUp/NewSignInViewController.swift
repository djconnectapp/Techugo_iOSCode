//
//  NewSignInViewController.swift
//  DJConnect
//
//  Created by Techugo on 16/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import AlamofireObjectMapper
import Lottie

import AuthenticationServices
import LGSideMenuController


class NewSignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var helloAgainLbl: UILabel!
    @IBOutlet weak var signIntoyouracntLbl: UILabel!
    @IBOutlet weak var emailVw: UIView!
    @IBOutlet weak var paswrdVw: UIView!
    @IBOutlet weak var emailTxtfld: UITextField!
    @IBOutlet weak var paswordTxtFld: UITextField!
    @IBOutlet weak var forgotPaswrdBtn: UIButton!
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var orwithLbl: UILabel!
    @IBOutlet weak var googleSignInBtn: UIButton!
    @IBOutlet weak var fbSignInBtn: UIButton!
    @IBOutlet weak var dontHveacntLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var appleSignInBtn: UIButton!
    
    @IBOutlet weak var hideShowPaswrdBtn: UIButton!
    @IBOutlet weak var hideShowImgVw: UIImageView!
        
    var onboardType = String()
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 14),
          .foregroundColor: UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1),
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        globalObjects.shared.isFromBackGroundState = false
                
       let userDeviceToken = UserDefaults.standard.string(forKey: "device_token")
        UserModel.sharedInstance().deviceToken = userDeviceToken
        print("oneDeviceToken",UserModel.sharedInstance().deviceToken ?? "")
        hideShowPaswrdBtn.setTitle("", for: .normal)
        
        let myImageName = "Hide"
                 let myImage = UIImage(named: myImageName)
        hideShowImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
        hideShowImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
                
        if UserModel.sharedInstance().userType == "AR"{
            helloAgainLbl.text = "Hello Artist!"
            let attributeString1 = NSMutableAttributedString(
                    string: "Sign up",
                    attributes: yourAttributes
                 )
            signUpBtn.setAttributedTitle(attributeString1, for: .normal)
        }
        else{
            helloAgainLbl.text = "Hello DJ!"
            let attributeString1 = NSMutableAttributedString(
                    string: "Sign up",
                    attributes: yourAttributes
                 )
            signUpBtn.setAttributedTitle(attributeString1, for: .normal)
        }
        
        let attributeString = NSMutableAttributedString(
                string: "Forgot your password?",
                attributes: yourAttributes
             )
        forgotPaswrdBtn.setAttributedTitle(attributeString, for: .normal)
        

        setUpVw()
    }
    
    func setUpVw(){
         
        // theme pink color
        emailVw.layer.cornerRadius = 10.0
        emailVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
        emailVw.layer.borderWidth = 0.5
        emailVw.clipsToBounds = true
        
        emailTxtfld.attributedPlaceholder = NSAttributedString(
            string: "Email address/Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        // theme light pink color
        paswrdVw.layer.cornerRadius = 10.0
        paswrdVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        paswrdVw.layer.borderWidth = 0.5
        paswrdVw.clipsToBounds = true
        
        paswordTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )

        signInBtn.layer.cornerRadius = signInBtn.frame.size.height/2
        signInBtn.clipsToBounds = true
        
        googleSignInBtn.layer.cornerRadius = googleSignInBtn.frame.size.height/2
        googleSignInBtn.clipsToBounds = true
        
        fbSignInBtn.layer.cornerRadius = fbSignInBtn.frame.size.height/2
        fbSignInBtn.clipsToBounds = true
        
        appleSignInBtn.layer.cornerRadius = appleSignInBtn.frame.size.height/2
        appleSignInBtn.clipsToBounds = true
        
       // print("LogindeviceToken",UserModel.sharedInstance().deviceToken)
        userSelection()
        //GIDSignIn.sharedInstance.clientID = Constant.google_client_id
        emailTxtfld.text = ""
        paswordTxtFld.text = ""
        emailTxtfld.delegate = self
        emailTxtfld.keyboardType = .emailAddress
        paswordTxtFld.delegate = self
        paswordTxtFld.isSecureTextEntry = true;
    }
    
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
    
    
    //MARK: - OTHER METHODS
    func userSelection(){
        setupPolicyLbl()
        if UserModel.sharedInstance().userType == "DJ"{
//            self.imgBack.image = UIImage(named: "LoginBack_DJ")
//            self.lblWelcome.text = "Welcome DJ".localize
//            self.lblHeader.text = "Log In DJ".localize
//            self.btnLogin.setTitle("Log In DJ".localize, for: .normal)
//            self.btnSignup.setTitle("Sign Up DJ".localize, for: .normal)
//            self.backHomeBtn.setTitle("BACK HOME".localize, for: .normal)
//            txtEmail.placeholder = "Username or email".localize
//            txtPassword.placeholder = "password".localize
//            self.forgotPaswrdBtn.setTitle("Forgot password?".localize, for: .normal)
//            self.orUseLbl.text = "Or Use".localize
        }else{
//            self.imgBack.image = UIImage(named: "LoginBack_AR")
//            self.lblWelcome.text = "Welcome Artist".localize
//            self.lblHeader.text = "Log In Artist".localize
//            self.btnLogin.setTitle("Log In Artist".localize, for: .normal)
//            self.btnSignup.setTitle("Sign Up Artist".localize, for: .normal)
//            self.backHomeBtn.setTitle("BACK HOME".localize, for: .normal)
//            txtEmail.placeholder = "Username or email".localize
//            txtPassword.placeholder = "password".localize
//            self.forgotPaswrdBtn.setTitle("Forgot password?".localize, for: .normal)
//            self.orUseLbl.text = "Or Use".localize
        }
    }
    
    func setupPolicyLbl() {
//        lblPrivacyTerm.text = "By continuing you agree to our Terms of Use and Privacy Policy.".localize
//        let text = (lblPrivacyTerm.text)!
//        let underlineAttriString = NSMutableAttributedString(string: text)
//        let termsRange = (text as NSString).range(of: "Terms of Use")
//        let privacyRange = (text as NSString).range(of: "Privacy Policy")
//
//        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: privacyRange)
//        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: termsRange)
//        lblPrivacyTerm.attributedText = underlineAttriString
//        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
//        lblPrivacyTerm.isUserInteractionEnabled = true
//        lblPrivacyTerm.addGestureRecognizer(tapAction)
    }
    
    func ChangeRoot(storyboard : String, identifier : String) {
        callDeviceRegistrationApi()
//        let homeSB = UIStoryboard(name: "\(storyboard)", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "\(identifier)") as! UINavigationController
//        let appdel = UIApplication.shared.delegate as! AppDelegate
//        let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
//        desiredViewController.view.addSubview(snapshot);
//        appdel.window?.rootViewController = desiredViewController;
//        UIView.animate(withDuration: 0.3, animations: {() in
//            snapshot.layer.opacity = 0
//            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
//        }, completion: {
//            (value: Bool) in
//            snapshot.removeFromSuperview()
//        })
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
                                self.callFacebookGoogleStatusService(id: self.dictFB["fb_id"]!, type: "facebook", dictData: self.dictFB)
                            }
                        }
                    })
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func ChangeRootProfile() {
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
                "username":"\(emailTxtfld.text!)",
                "password":"\(paswordTxtFld.text!)",
                "user_type":"\(UserModel.sharedInstance().userType!)"
            ]
                        
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<LoginModel>) in
                
                switch response.result {
                case .success(_):
                    let loginModel = response.result.value!
                    if loginModel.success == 1{
                        Loader.shared.hide()
                        globalObjects.shared.isFromBackGroundState = false
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
                        UserModel.sharedInstance().artist_typeSt = "\(loginModel.responseData!.subscription_id ?? 0)"
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
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addRecordAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    let loginModel = response.result.value!
                    if loginModel.success == 1{
                        Loader.shared.hide()
                        self.calculateEnteredTime()
                                                
                        if canChange{
                            
                            // new code for open pin screen
                            
                            let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                            let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC

                            self.navigationController?.pushViewController(desiredViewController, animated: false)

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
                               // self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "NewSocialsignUpVC") as! NewSocialsignUpVC
                                desiredViewController.dictFB = self.dictFB
                                desiredViewController.dictG = self.dictG
                                if self.selectedRegisterMode == .facebook{
                                    desiredViewController.registerType = "facebook"
                                }
                                if self.selectedRegisterMode == .gmail{
                                    desiredViewController.registerType = "gmail"
                                }
                                
                                if self.selectedRegisterMode == .apple{
                                    desiredViewController.registerType = "apple"
                                    desiredViewController.dictApple = self.dictApple
                                }
                                self.navigationController?.pushViewController(desiredViewController, animated: false)
                            }else{
                                self.callFbLoginService(Data: dictData)
                            }
                            
                        }
                        else{
                            if status == "0"{
                                //self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "NewSocialsignUpVC") as! NewSocialsignUpVC
                                desiredViewController.dictFB = self.dictFB
                                desiredViewController.dictG = self.dictG
                                if self.selectedRegisterMode == .facebook{
                                    desiredViewController.registerType = "facebook"
                                }
                                if self.selectedRegisterMode == .gmail{
                                    desiredViewController.registerType = "gmail"
                                }
                                
                                if self.selectedRegisterMode == .apple{
                                    desiredViewController.registerType = "apple"
                                    desiredViewController.dictApple = self.dictApple
                                }
                                self.navigationController?.pushViewController(desiredViewController, animated: false)
                            }else{
                                self.googleSignIn(Data: dictData)
                            }
                        }
                    }else{
                        if type == "facebook"{
                            if statusModel.success == 0{
                                //self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "NewSocialsignUpVC") as! NewSocialsignUpVC
                                desiredViewController.dictFB = self.dictFB
                                desiredViewController.dictG = self.dictG
                                if self.selectedRegisterMode == .facebook{
                                    desiredViewController.registerType = "facebook"
                                }
                                if self.selectedRegisterMode == .gmail{
                                    desiredViewController.registerType = "gmail"
                                }
                                
                                if self.selectedRegisterMode == .apple{
                                    desiredViewController.registerType = "apple"
                                    desiredViewController.dictApple = self.dictApple
                                }
                                self.navigationController?.pushViewController(desiredViewController, animated: false)
                            }else{
                                self.callFbLoginService(Data: dictData)
                            }
                            
                        }
                        else{
                            if statusModel.success == 0{
                               // self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "NewSocialsignUpVC") as! NewSocialsignUpVC
                                desiredViewController.dictFB = self.dictFB
                                desiredViewController.dictG = self.dictG
                                if self.selectedRegisterMode == .facebook{
                                    desiredViewController.registerType = "facebook"
                                }
                                if self.selectedRegisterMode == .gmail{
                                    desiredViewController.registerType = "gmail"
                                }
                                
                                if self.selectedRegisterMode == .apple{
                                    desiredViewController.registerType = "apple"
                                    desiredViewController.dictApple = self.dictApple
                                }
                                self.navigationController?.pushViewController(desiredViewController, animated: false)
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
                                

                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC

                                self.navigationController?.pushViewController(desiredViewController, animated: false)
                                
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
//                            if  _modelData.profile_completion == "no"{
//                                UserModel.sharedInstance().isSignup = true
//                                UserModel.sharedInstance().isSkip = false
//                                UserModel.sharedInstance().paymentPopup = false
//                                UserModel.sharedInstance().finishPopup = false
//                                UserModel.sharedInstance().finishProfile = true
//                                UserModel.sharedInstance().synchroniseData()
//                                self.ChangeRootProfile()
//                            }else{
                                UserModel.sharedInstance().finishProfile = false
                                UserModel.sharedInstance().isSignup = false
                                UserModel.sharedInstance().synchroniseData()
                                
                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC

                                self.navigationController?.pushViewController(desiredViewController, animated: false)
                           // }
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
                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC

                                self.navigationController?.pushViewController(desiredViewController, animated: false)
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == emailTxtfld {
            // theme pink color
            emailVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            paswrdVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            return true
        }
        else{
            
            emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            paswrdVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
        }

        return true
    }
    
    @IBAction func hideShowPaswrdBtnTapped(_ sender: Any) {
        
        hideShowImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        if(paswordTxtFld.isSecureTextEntry == true){
            let myImageName = "eye"
            let myImage = UIImage(named: myImageName)
            hideShowImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
            paswordTxtFld.isSecureTextEntry                   = false;
        }
        else{
            let myImageName = "Hide"
            let myImage = UIImage(named: myImageName)
            hideShowImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
            paswordTxtFld.isSecureTextEntry                   = true;
        }
        
    }
    @IBAction func forgtbTnTapped(_ sender: Any) {
        
        paswordTxtFld.resignFirstResponder()
        emailTxtfld.resignFirstResponder()
        loginButtonSelected = "forget"
        //self.performSegue(withIdentifier: "segueWelcomeBackJoin", sender: nil)
                
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "NewForgotPasswordVC") as! NewForgotPasswordVC
        //desiredViewController.onboardType = "artist"
        //UserModel.sharedInstance().userType = "AR"
        navigationController?.pushViewController(desiredViewController, animated: false)
    }
    @IBAction func signInBtnTapped(_ sender: Any) {
                
        paswordTxtFld.resignFirstResponder()
        emailTxtfld.resignFirstResponder()
        let enteredEmail = emailTxtfld.text
        let enteredPassword = paswordTxtFld.text
        let validatePwdBool = validatePassword(password: enteredPassword!)
        if enteredEmail?.isEmpty == true {

            self.view.makeToast("Please enter your email.".localize)
        }else if validatePwdBool == false {
            self.view.makeToast("Please enter valid password.".localize)
        }else {
            callLoginService()

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
        //if #available(iOS 13, *) {
//                  guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                      let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
//                         return window
       // } else {
            
      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
       // }
    }
    
    fileprivate func setUpDrawerArtist() {
        
        guard let centerController = UIStoryboard.init(name: "ArtistHome", bundle: nil).instantiateViewController(withIdentifier: "NewArtistHomeVC") as? NewArtistHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
    
            let navigation = UINavigationController.init(rootViewController: centerController)
            navigation.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
            //sideMenuController.leftViewWidth = 280.0
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle
       // if #available(iOS 13, *) {
//                  guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                      let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
//                         return window
       // } else {
            
      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
        //}
    }
    
    
    @IBAction func googleBtnTapped(_ sender: Any) {
        selectedRegisterMode = .gmail
        callGmailLoginSDK()
    }
    @IBAction func fbBtnTapped(_ sender: Any) {
        selectedRegisterMode = .facebook
        facebookCall()
    }
    
    @IBAction func appleBtnTapped(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            selectedRegisterMode = .apple
                    self.handleLogInWithAppleIDButtonPress()
            print("1")
                } else {
                    print("2")
                }
        print("3")
    }
    
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "CreateScreenViewController") as! CreateScreenViewController
        desiredViewController.onboardType = onboardType
        navigationController?.pushViewController(desiredViewController, animated: false)
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension NewSignInViewController {
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
                               self.callFacebookGoogleStatusService(id: dictG["google_id"]!, type: "google", dictData: dictG)
                    
                    
                           }

            }else {
                print("\(error?.localizedDescription ?? "")")
            }
            
        }
    }
}

//MARK:- Signin With Apple
@available(iOS 13.0, *)
extension NewSignInViewController : ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

  @available(iOS 13.0, *)
  extension NewSignInViewController : ASAuthorizationControllerDelegate {
          
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
              
              if appleIDCredential.email !=  nil{
                KeychainItem.currentUserIdentifier = appleIDCredential.user
                KeychainItem.currentUserFirstName = appleIDCredential.fullName?.givenName
                KeychainItem.currentUserLastName = appleIDCredential.fullName?.familyName
                KeychainItem.currentUserEmail = appleIDCredential.email
              }
            
              if let identityTokenData = appleIDCredential.identityToken,
                  let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                strAppleToken = identityTokenString
                  print("Identity Token \(identityTokenString)")
              }
                        
            dictApple["apple_id"] = "\(KeychainItem.currentUserIdentifier ?? "")"
            dictApple["token"] = strAppleToken
            dictApple["full_name"] = "\(KeychainItem.currentUserFirstName ?? "") \(KeychainItem.currentUserLastName ?? "")"
            dictApple["name"] = KeychainItem.currentUserFirstName
            dictApple["email"] = KeychainItem.currentUserEmail
            dictApple["img_url"] = ""
            dictApple["user_type"] = "\(UserModel.sharedInstance().userType ?? "")"
            //ashitesh - 18 may
            self.callFacebookGoogleStatusService(id: dictApple["apple_id"] ?? "", type: "apple", dictData: dictApple)
              
          } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
              // Sign in using an existing iCloud Keychain credential.
              let username = passwordCredential.user
              let password = passwordCredential.password
              
            
            self.view.makeToast("The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)")
              
          }
      }
  }

//extension LAContext {
//    enum BiometricType: String {
//        case none
//        case touchID
//        case faceID
//    }
//
//    var biometricType: BiometricType {
//        var error: NSError?
//
//        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
//            // Capture these recoverable error thru Crashlytics
//            return .none
//        }
//
//        if #available(iOS 11.0, *) {
//            switch self.biometryType {
//            case .none:
//                return .none
//            case .touchID:
//                return .touchID
//            case .faceID:
//                return .faceID
//            }
//        } else {
//            return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
//        }
//    }
//}
