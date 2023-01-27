//
//  SetPinVC.swift
//  DJConnect
//
//  Created by mac on 17/09/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import LGSideMenuController

class SetPinVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblPinAck: UILabel!
    @IBOutlet weak var txtPin1: UITextField!
    @IBOutlet weak var txtPin2: UITextField!
    @IBOutlet weak var txtPin3: UITextField!
    @IBOutlet weak var txtPin4: UITextField!
    @IBOutlet weak var btnRegisterNext: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbl1: labelProperties!
    @IBOutlet weak var lbl2: labelProperties!
    @IBOutlet weak var lbl3: labelProperties!
    @IBOutlet weak var lbl4: labelProperties!
    
    @IBOutlet weak var backBtn: UIButton!
    //MARK: - GLOBAL VARIABLES
    var pin1 = String()
    var pin2 = String()
    var pin3 = String()
    var pin4 = String()
    
    var newpin1 = String()
    var newpin2 = String()
    var newpin3 = String()
    var newpin4 = String()
    
    var birthdate = String()
    var email = String()
    var phone_no = String()
    var newPhoneWithoutC = ""
    var password = String()
    var userType = String()
    var accept_terms = String()
    var userName = String()
    var final_pin = Int()
    var country_code = String()
    var registerType = String()
    var dictFB = [String : String]()
    var dictG = [String : String]()
    var dictApp = [String : String]()
    var genreIds = "1"
    var registrdStatus = String()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        print("newPhoneWithoutC1",newPhoneWithoutC)
        backBtn.isHidden = true
        backBtn.isUserInteractionEnabled = false
        print("deviceToken2",UserModel.sharedInstance().deviceToken)
        if UserModel.sharedInstance().userType == "DJ"{
        lblPinAck.text = "Enter a 4 digit pin number to quickly login to DJ."
        }else{
        lblPinAck.text = "Enter a 4 digit pin number to quickly login to Artist."
        }
    }

    //MARK: - ACTIONS
    @IBAction func btnNumberAction(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == true{
            txtPin1.text = "\(sender.tag)"
            if(registrdStatus != "1"){
                pin1 = txtPin1.text!
            }
            lbl1.backgroundColor = .white
            if(registrdStatus == "1"){
                newpin1 = txtPin1.text!
            }
        }else if txtPin2.text?.isEmpty == true{
            txtPin2.text = "\(sender.tag)"
            //pin2 = txtPin2.text!
            if(registrdStatus != "1"){
                pin2 = txtPin2.text!
            }
            lbl2.backgroundColor = .white
            if(registrdStatus == "1"){
                newpin2 = txtPin2.text!
            }
        }else if txtPin3.text?.isEmpty == true{
            txtPin3.text = "\(sender.tag)"
            //pin3 = txtPin3.text!
            if(registrdStatus != "1"){
                pin3 = txtPin3.text!
            }
            lbl3.backgroundColor = .white
            if(registrdStatus == "1"){
                newpin3 = txtPin3.text!
            }
        }else if txtPin4.text?.isEmpty == true{
            txtPin4.text = "\(sender.tag)"
            //pin4 = txtPin4.text!
            if(registrdStatus != "1"){
                pin4 = txtPin4.text!
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.btnNextAction(UIButton())
                }
            }
            lbl4.backgroundColor = .white
            if(registrdStatus == "1"){
                newpin4 = txtPin4.text!
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.btnNextToRegisterAction(UIButton())
                }
            }
            
            
        }
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == false && txtPin2.text?.isEmpty == false && txtPin3.text?.isEmpty == false && txtPin4.text?.isEmpty == false{
            pin1 = txtPin1.text!
            txtPin1.text?.removeAll()
            pin2 = txtPin2.text!
            txtPin2.text?.removeAll()
            pin3 = txtPin3.text!
            txtPin3.text?.removeAll()
            pin4 = txtPin4.text!
            txtPin4.text?.removeAll()
            lbl1.backgroundColor = .clear
            lbl2.backgroundColor = .clear
            lbl3.backgroundColor = .clear
            lbl4.backgroundColor = .clear
            lblPinAck.text = "Please re-enter your pin."
           // btnRegisterNext.isHidden = false
            btnRegisterNext.isHidden = true
            btnNext.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.btnNextToRegisterAction(UIButton())
                self.registrdStatus = "1"
            }
        }else{
            generateAlert(msg:"Please enter your pin")
        }
        
    }
    
    @IBAction func btnNextToRegisterAction(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == false && txtPin2.text?.isEmpty == false && txtPin3.text?.isEmpty == false && txtPin4.text?.isEmpty == false{
            print("pin",pin1,pin2,pin3,pin4)
//            if pin1 == txtPin1.text && pin2 == txtPin2.text && pin3 == txtPin3.text && pin4 == txtPin4.text{
            if pin1 == newpin1 && pin2 == newpin2 && pin3 == newpin3 && pin4 == newpin4{
                let pin = pin1 + pin2 + pin3 + pin4
                final_pin = Int(pin)!
                if registerType == "facebook"{
                    // commented by ashitesh
                    callFbLoginService(Data: dictFB, mail: email, phone: phone_no, pin: "\(Int(final_pin))", c_code: country_code)
                }else if registerType == "gmail"{
                    // commented by ashitesh
                    googleSignIn(Data: dictG, mail: email, phone: phone_no, pin: "\(Int(final_pin))", c_code: country_code)
                }
                else if registerType == "apple"{
                    // commented by ashitesh
                    appleSignIn(Data: dictApp, mail: email, phone: phone_no, pin: "\(Int(final_pin))", c_code: country_code)
                }
                else{
                    callRegisterService()
                   
                }
            }else{
//                lblPinAck.text = "The PIN number you entered did not match."
                lblPinAck.text = "PIN did not match. Try Again"
                self.view.makeToast("PIN did not match. Try Again")
                txtPin1.text?.removeAll()
                txtPin2.text?.removeAll()
                txtPin3.text?.removeAll()
                txtPin4.text?.removeAll()
                lbl1.backgroundColor = .clear
                lbl2.backgroundColor = .clear
                lbl3.backgroundColor = .clear
                lbl4.backgroundColor = .clear
                
            }
        }
//        else{
//            generateAlert(msg:"Please enter your pin")
//        }
    }
    @IBAction func btnClear_Action(_ sender: UIButton) {
        lbl1.backgroundColor = .clear
        lbl2.backgroundColor = .clear
        lbl3.backgroundColor = .clear
        lbl4.backgroundColor = .clear
        txtPin1.text = ""
        txtPin2.text = ""
        txtPin3.text = ""
        txtPin4.text = ""
    }
    
    //MARK: - OTHER METHODS
    func calculateEnteredTime(){
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        globalObjects.shared.AppEnteredTime = formatter.string(from: now)
    }
    
    func ChangeRoot(storyboard : String, identifier : String) {
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
    
    func generateAlert(msg: String){
        self.showAlertView(msg,"Error!")
    }
    
    //MARK: - WEBSERVICES
    func callRegisterService() {
        if getReachabilityStatus() {
            var sendDate = ""
            if birthdate != ""{
            let formatter = DateFormatter()
            formatter.dateFormat =  "MM/dd/yyyy"
            let date = formatter.date(from: self.birthdate)
            formatter.dateFormat = "yyyy-MM-dd"
            sendDate = formatter.string(from: date!)
            }
            let requestURL = "\(webservice.url)\(webservice.registerAPI)"
            let parameters = [
                "birthdate":"\(sendDate)",
                "email":"\(email)",
//                "phone_number":"\(phone_no)",
                "phone_number":"\(newPhoneWithoutC)",
                //"phone_number":"",newPhoneWithoutC
                "password":"\(password)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "accept_terms": "1",
                "username":"\(userName)",
                "pin":"\(Int(final_pin))",
                "genre_id":self.genreIds,
                "country_code":"\(country_code)"
                //"country_code":""
            ] as [String : Any]
            Loader.shared.show()
            print("requestURL",requestURL)
            print("requestURLparameters",parameters)
            
            Alamofire.request(getServiceURL(requestURL), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<RegisterModel>) in
                switch response.result {
                //print(response)
                case .success(_):
                    Loader.shared.hide()
                    let registerModel = response.result.value!
                    if registerModel.success == 1{
                        UserModel.sharedInstance().userId = "\(registerModel.userid!)"
                        UserModel.sharedInstance().token = registerModel.token!
                        UserModel.sharedInstance().uniqueUserName = registerModel.username!
                        UserModel.sharedInstance().isSignup = true
                        UserModel.sharedInstance().finishProfile = true
                        UserModel.sharedInstance().email = self.email
                        UserModel.sharedInstance().currency_code = registerModel.country_code ?? ""
                        UserModel.sharedInstance().userCurrency = registerModel.currncySymbol!
                        UserModel.sharedInstance().currency_name =  registerModel.currncyName!
                        UserModel.sharedInstance().currency_id = "\(registerModel.currencyId!)"
                        UserModel.sharedInstance().userPin = "\(registerModel.userPin!)"
                        UserModel.sharedInstance().genereList = registerModel.genre ?? "1"
                        
                        UserModel.sharedInstance().synchroniseData()
                        self.callDeviceRegistrationApi()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast("Server error encountered while creating your user account. Please try again later.")
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
    
    func callDeviceRegistrationApi(){
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
                parameters = [
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
                
                print("deviceRegister",parameters)
                Loader.shared.show()
                Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addRecordAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                    switch response.result {
                    case .success(_):
                        let loginModel = response.result.value!
                        if loginModel.success == 1{
                            Loader.shared.hide()
                            self.calculateEnteredTime()
                            if UserModel.sharedInstance().userType == "DJ"{
                                self.setUpDrawer()
                            }else{
                                //self.setUpDrawerArtist()
                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                let next1 = storyBoard.instantiateViewController(withIdentifier: "AddSubscribeVC") as? AddSubscribeVC
                                next1?.screenType = "SignUp"
                                self.navigationController?.pushViewController(next1!, animated: true)
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
//       // }else{
//           // self.view.makeToast("Something error, Please relogin")
//            if UserModel.sharedInstance().userType == "DJ"{
//                self.setUpDrawer()
//            }else{
//                //self.setUpDrawerArtist()
//                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
//                let next1 = storyBoard.instantiateViewController(withIdentifier: "AddSubscribeVC") as? AddSubscribeVC
//                navigationController?.pushViewController(next1!, animated: true)
//            }
//
//        //}
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
       // if #available(iOS 13, *) {
//                  guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                      let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
//                         return window
       // } else {
            
      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
        //}
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
       // }
    }
    
    func callFbLoginService(Data:[String : String], mail: String, phone: String, pin: String, c_code: String){
        if getReachabilityStatus(){
            
            let parameters = [
                "profile_image":Data["profile_image"]!,
                "name":Data["name"]!,
                "username":Data["name"]!,
                "birthdate":Data["birthdate"]!,
                "email":"\(mail.isEmpty)",
                "phone_number":"\(phone)",
                "fb_token":"",//Data["fb_token"]!,
                "fb_id":Data["fb_id"]!,
                "user_type":Data["user_type"]!,
                "pin":"\(pin)",
                "genre_id":self.genreIds,
                "country_code":"\(c_code)"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.facebookAPI)"), method: .post, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GoogleSucessModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let googleModel = response.result.value!
                    if let result = googleModel.success {
                        if result == 1{
                            self.view.makeToast(googleModel.message)
                            let _modelData = googleModel.responseData!
                            UserModel.sharedInstance().userId = "\(_modelData.userid!)"
                            UserModel.sharedInstance().userType = "\(UserModel.sharedInstance().userType!)"
                            UserModel.sharedInstance().token = _modelData.token ?? ""
                            UserModel.sharedInstance().email = Data["email"] ?? ""
                            UserModel.sharedInstance().uniqueUserName = Data["name"] ?? ""
                            UserModel.sharedInstance().currency_code = _modelData.currency_code ?? ""
                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol ?? ""
                           // UserModel.sharedInstance().currency_id = "\(_modelData.currncyId!)"
                            
                            UserModel.sharedInstance().currency_id = "\(_modelData.currncyId ?? 0)"
                            
                            UserModel.sharedInstance().currency_name =  _modelData.currncyName!
//                            if(_modelData.currncyName == ""){
//
//                                if(UserModel.sharedInstance().setCurrencyNameSt == "$"){
//                                    UserModel.sharedInstance().currency_name = "$"
//                                }
//                                else{
//                                    UserModel.sharedInstance().currency_name = "₹"
//                                }
//                            }
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount!
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time ?? ""
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin!)"
                            UserModel.sharedInstance().isSkip = false
                            UserModel.sharedInstance().paymentPopup = false
                            UserModel.sharedInstance().finishProfile = true
                            UserModel.sharedInstance().isSignup = false
                            UserModel.sharedInstance().synchroniseData()
                            self.callDeviceRegistrationApi()
                        }
                        else {
                            Loader.shared.hide()
                            self.view.makeToast(googleModel.message)
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
    
    func googleSignIn(Data: [String : String], mail: String, phone: String, pin: String, c_code: String){
        if getReachabilityStatus(){
            let parameters = [
                "profile_image":Data["img_url"]!,
                "name":Data["full_name"]!,
                "birthdate":"",
                "email":"\(mail)",
                "phone_number":"\(phone)",
                "google_token":"",//"Data["token"]!",
                "google_id":Data["google_id"]!,
                "user_type":Data["user_type"]!,
                "pin":"\(pin)",
                "genre_id":self.genreIds,
                "country_code":"\(c_code)"
            ]
            //print(parameters)
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
                            UserModel.sharedInstance().token = _modelData.token!
                            UserModel.sharedInstance().email = Data["email"]!
                            UserModel.sharedInstance().uniqueUserName = Data["full_name"]!
                            UserModel.sharedInstance().currency_code = _modelData.currency_code ?? ""
                            
                            UserModel.sharedInstance().currency_id = "\(_modelData.currncyId ?? 0)"
                            UserModel.sharedInstance().currency_name = "\(_modelData.currncyName!)"

                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol!
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount!
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time!
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin!)"
                            UserModel.sharedInstance().isSkip = false
                            UserModel.sharedInstance().paymentPopup = false
                            UserModel.sharedInstance().finishProfile = true
                            UserModel.sharedInstance().isSignup = false
                            UserModel.sharedInstance().synchroniseData()
                            self.callDeviceRegistrationApi()
                        }
                        else {
                            Loader.shared.hide()
                            self.view.makeToast(googleModel.message)
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
    
    func appleSignIn(Data: [String : String], mail: String, phone: String, pin: String, c_code: String){
        if getReachabilityStatus(){
            let parameters = [
                "profile_image":Data["img_url"] ?? "",
                "name":Data["name"] ?? "",
//                "profile_image":"https://lh3.googleusercontent.com/a-/AOh14Gg2JuBnRtqQLwHkBL6R4RyfTw7Y3tWEgx-znfF3pjw=s200",
//              "apple_id":"001703.2de9bebc40964e9f9499622712351862.1044",
                "birthdate":"",
                "email":"\(mail)",
//                "phone_number":"\(phone)",
                "phone_number":"+91",
                "apple_token":"",
                "apple_id":Data["apple_id"] ?? "",
                "user_type":Data["user_type"] ?? "",
                "pin":"\(pin)",
                "genre_id":self.genreIds,
                //"country_code":"\(c_code)"
                "country_code":"USD"
            ]
            
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
                            UserModel.sharedInstance().email = Data["email"] ?? ""
                            UserModel.sharedInstance().uniqueUserName = Data["name"] ?? ""
                            UserModel.sharedInstance().currency_code = _modelData.currency_code ?? ""
                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol ?? ""
                            // added by ashitesh
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
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount!
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time!
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin!)"
                            UserModel.sharedInstance().genereList = _modelData.genre ?? "1"
                            UserModel.sharedInstance().finishProfile = false
                            UserModel.sharedInstance().isSignup = false
                            UserModel.sharedInstance().synchroniseData()
                            self.callDeviceRegistrationApi()
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
                print("response.resultApplePin", response.result)
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
