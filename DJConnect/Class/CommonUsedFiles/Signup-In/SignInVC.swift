//
//  djSignInVC.swift
//  DJConnect
//
//  Created by mac on 10/12/19.
//  Copyright © 2019 mac. All rights reserved.
// set UserModel.sharedInstance().finishProfile = false Login
// set UserModel.sharedInstance().finishProfile = true register,fblogin, googlesign in

import UIKit
import Toast_Swift
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import AlamofireObjectMapper
import ADCountryPicker
import AuthenticationServices


struct UserModelData {
    let strName:String = ""
    
}

class SignInVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblWelcome: UILabel!
    
    @IBOutlet weak var vwDOB: UIView! //Default view for Date of Birth
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblEnterDOB: UILabel!
    @IBOutlet weak var lblPrivacyTerm: UILabel!
    
    @IBOutlet weak var vwOther: UIView! //Other views master
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var txtEmail: textFieldProperties!
    
    @IBOutlet weak var vwConfirmEmail: UIView!
    @IBOutlet weak var txtConfirmEmail: textFieldProperties!
    
    @IBOutlet weak var vwUsername: UIView!
    @IBOutlet weak var txtUsername: textFieldProperties!
    
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var txtPassword: textFieldProperties!
    
    @IBOutlet weak var vwConfirmPassword: UIView!
    @IBOutlet weak var txtConfirmPassword: textFieldProperties!
    
    @IBOutlet weak var vwGenre: UIView!
    @IBOutlet weak var txtGenre: textFieldProperties!
    
    @IBOutlet weak var vwPhone: UIView!
    @IBOutlet weak var txtfCountryCode: textFieldProperties!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var txtPhone: textFieldProperties!
    
    @IBOutlet weak var vwOTP: UIView!
    @IBOutlet weak var txtOTP: textFieldProperties!
    
    @IBOutlet weak var vwForgetPwd: UIView!
    @IBOutlet weak var txtForgetEmail: textFieldProperties!
    @IBOutlet weak var btnForgetLogin: UIButton!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var BackHomeBtn: buttonProperties!
    
    
    @IBOutlet weak var NextBtnn: buttonProperties!
    
    @IBOutlet weak var orUseLbl: UILabel!
    
    @IBOutlet weak var backBtnn: buttonProperties!
    
    @IBOutlet weak var verificationCodeBtn: UIButton!
    
    @IBAction func vrifictnCodeBtnTapped(_ sender: Any) {
       // callOtpService()
        resendBgVw.isHidden = false
        resendVw.isHidden = false
        resendAlertTitleLbl.text = "Your verification code has been resent. If you do not receive this code click the back button and re-enter your phone number."
    }
    

    @IBOutlet weak var resendBgVw: UIView!
    @IBOutlet weak var resendVw: UIView!
    @IBOutlet weak var resendAlertTitleLbl: UILabel!
    

    @IBOutlet weak var okBtn: UIButton!
    
    
    @IBOutlet weak var pShowHidePaswrdBtn: UIButton!
    @IBAction func pShowHidePaswrdBtnTapped(_ sender: Any) {
        
        if(txtPassword.isSecureTextEntry == true){
            pShowHidePaswrdBtn.setImage(UIImage(named: "Hide"), for: .normal)
            txtPassword.isSecureTextEntry                   = false;
        }
        else{
            pShowHidePaswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
            txtPassword.isSecureTextEntry                   = true;
        }
    }
    
    @IBOutlet weak var vpShowHidePaswrdBtn: UIButton!
    @IBAction func vpShowHidePaswrdBtnTapped(_ sender: Any) {
        
//        if(txtPassword.isSecureTextEntry == true){
//            pShowHidePaswrdBtn.setImage(UIImage(named: "Hide"), for: .normal)
//            txtPassword.isSecureTextEntry                   = false;
//        }
//        else{
//            pShowHidePaswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
//            txtPassword.isSecureTextEntry                   = true;
//        }
        
       
    }
    
    
    @IBAction func okBtntapped(_ sender: Any) {
        resendBgVw.isHidden = true
        resendVw.isHidden = true
        resendAlertTitleLbl.text = ""
    }
    
    
    
    enum registerMode{
        case facebook
        case gmail
        case apple
    }
    
    
    @IBOutlet weak var newVeriFyEmail: UIView!
    @IBOutlet weak var newReEnterEmailTxtFld: textFieldProperties!
    
    @IBOutlet weak var newVeriFyPaswrdVw: UIView!
    
    @IBOutlet weak var newVerifyPaswrdTxtFld: textFieldProperties!
    

    @IBAction func newShowPaswrdBtnTapped(_ sender: Any) {
        if(newVerifyPaswrdTxtFld.isSecureTextEntry == true){
            newShowPaswrdBtn.setImage(UIImage(named: "Hide"), for: .normal)
            newVerifyPaswrdTxtFld.isSecureTextEntry                   = false;
            pShowHidePaswrdBtn.setImage(UIImage(named: "Hide"), for: .normal)
            txtPassword.isSecureTextEntry                   = false;
        }
        else{
            newShowPaswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
            newVerifyPaswrdTxtFld.isSecureTextEntry                   = true;
            pShowHidePaswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
            txtPassword.isSecureTextEntry                   = true;
        }
    }
    
    @IBOutlet weak var newShowPaswrdBtn: UIButton!
    
    
    //MARK: - GLOBAL VARIABLES
    var checkAccept = "0"
    var fbType = String()
    var googleType = String()
    var loginButtonSelected = String()
    let picker = ADCountryPicker(style: .grouped)
    var pickerSelected = Bool()
    var otpVerifyToast = String()
    var country_code = String()
    var userName = ""
    var birthdate = ""
    var email = ""
    var password = ""
    var phoneNum = ""
    var genreNames = ""
    var genreIds = ""
    var dictFB = [String : String]()
    var dictG = [String : String]()
    var dictApple = [String : String]()
    var selectedRegisterMode = registerMode.facebook
    var currentScreenIndex = 0 //used to maintain current screen
    /*
     0 - Date Of Birth
     1 - Email
     2 - Confirm Email
     3 - Username
     4 - Password
     5 - Confirm Password
     6 - Genre IDs
     7 - Telephone
     8 - OTP
     */
    
    var statusCodeSocial = String()
    var statusCodeFBSocial = String()
    
    var strAppleToken = ""
    var newPhoneNmbr = String()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("deviceToken1",UserModel.sharedInstance().deviceToken)
        
        pShowHidePaswrdBtn.isHidden = true
        resendBgVw.isHidden = true
        resendVw.isHidden = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        resendBgVw.addGestureRecognizer(tap1)
        
        resendBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        resendVw.layer.cornerRadius = 10;
        resendVw.layer.masksToBounds = true;
        
        okBtn.layer.cornerRadius = 10;
        okBtn.layer.masksToBounds = true;
        
        txtEmail.delegate = self
        txtEmail.autocorrectionType = .yes
        
        
        txtUsername.delegate = self
        txtUsername.autocorrectionType = .yes
        
        txtPhone.delegate = self
        txtPhone.autocorrectionType = .yes

        txtPassword.isSecureTextEntry = true;
        pShowHidePaswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
        
        newVerifyPaswrdTxtFld.isSecureTextEntry = true;
        newShowPaswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
        
       // txtConfirmPassword.isSecureTextEntry = true;
       // vpShowHidePaswrdBtn.setImage(UIImage(named: "eye"), for: .normal)
        
        let locale: NSLocale = NSLocale.current as NSLocale
        let countryy: String? = locale.countryCode
        
        let getCode = self.getCountryPhonceCode(countryy ?? "IN")
            print("getCode getCode",getCode)
        
        print("bydafault countrycode",countryy)
        
       
        if(countryy == "US"){
            txtfCountryCode.text = "+1"
            country_code = "US"
            UserModel.sharedInstance().setCurrencyNameSt = "$"
            UserModel.sharedInstance().synchroniseData()
        }
        else{
            txtfCountryCode.text = "+91"
            country_code = "INR"
            UserModel.sharedInstance().setCurrencyNameSt = "₹"
            UserModel.sharedInstance().synchroniseData()
        }
                
//        txtfCountryCode.text = "+91"
        //        country_code = "INR"
        
        if #available(iOS 12.0, *) {
            txtOTP.textContentType = .oneTimeCode
        }
        
        txtOTP.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        
        picker.showFlags = true
        picker.showCallingCodes = true
        if UserModel.sharedInstance().userType == "DJ"{
            picker.pickerTitle = "Select a Country".localize
        }
        else{
            picker.pickerTitle = "Select a Country".localize
        }
        //Resend Verification Code?
        picker.defaultCountryCode = "US"
        picker.forceDefaultCountryCode = true
        picker.alphabetScrollBarTintColor = UIColor.black
        picker.alphabetScrollBarBackgroundColor = UIColor.clear
        picker.closeButtonTintColor = UIColor.black
        picker.font = .systemFont(ofSize: 15)
        picker.flagHeight = 40
        picker.hidesNavigationBarWhenPresentingSearch = true
        picker.searchBarBackgroundColor = UIColor.lightGray
        //GIDSignIn.sharedInstance.clientID = Constant.google_client_id
        userSelection()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        //formatter.dateFormat = "MMM dd,yyyy" by client choice.. but not affected
        self.birthdate = formatter.string(from: Date())
        datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        datePicker.setValue(UIColor.green, forKeyPath: "highlightColor")
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.maximumDate = Date()
        
        datePicker.addTarget(self, action: #selector(datePickerChanged(datePicker:)), for: UIControl.Event.valueChanged)
        if loginButtonSelected == "forget"{
            forgotPasswordPage()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(setGenre(_:)), name: NSNotification.Name(rawValue: "setGenreFromSignup"), object: nil)
    }
    
    //When changed value in textField
        @objc func textFieldDidChange(textField: UITextField){
            //let text = txtOTP.text
           // if(text!.count > 0){
            txtOTP.becomeFirstResponder()
//            }
//            else{
//
//            }
            
        }
    
    func dismissKeyboard(){

            self.view.endEditing(true)

        }
    
    
    func getCountryPhonceCode (_ country : String) -> String
        {
            var countryDictionary  = ["AF":"+93",
                                      "AL":"+355",
                                      "DZ":"+213",
                                      "AS":"+1",
                                      "AD":"+376",
                                      "AO":"+244",
                                      "AI":"+1",
                                      "AG":"+1",
                                      "AR":"+54",
                                      "AM":"374",
                                      "AW":"297",
                                      "AU":"61",
                                      "AT":"43",
                                      "AZ":"994",
                                      "BS":"1",
                                      "BH":"973",
                                      "BD":"880",
                                      "BB":"1",
                                      "BY":"375",
                                      "BE":"32",
                                      "BZ":"501",
                                      "BJ":"229",
                                      "BM":"1",
                                      "BT":"975",
                                      "BA":"387",
                                      "BW":"267",
                                      "BR":"55",
                                      "IO":"246",
                                      "BG":"359",
                                      "BF":"226",
                                      "BI":"257",
                                      "KH":"855",
                                      "CM":"237",
                                      "CA":"1",
                                      "CV":"238",
                                      "KY":"345",
                                      "CF":"236",
                                      "TD":"235",
                                      "CL":"56",
                                      "CN":"86",
                                      "CX":"61",
                                      "CO":"57",
                                      "KM":"269",
                                      "CG":"242",
                                      "CK":"682",
                                      "CR":"506",
                                      "HR":"385",
                                      "CU":"53",
                                      "CY":"537",
                                      "CZ":"420",
                                      "DK":"45",
                                      "DJ":"253",
                                      "DM":"1",
                                      "DO":"1",
                                      "EC":"593",
                                      "EG":"20",
                                      "SV":"503",
                                      "GQ":"240",
                                      "ER":"291",
                                      "EE":"372",
                                      "ET":"251",
                                      "FO":"298",
                                      "FJ":"679",
                                      "FI":"358",
                                      "FR":"33",
                                      "GF":"594",
                                      "PF":"689",
                                      "GA":"241",
                                      "GM":"220",
                                      "GE":"995",
                                      "DE":"49",
                                      "GH":"233",
                                      "GI":"350",
                                      "GR":"30",
                                      "GL":"299",
                                      "GD":"1",
                                      "GP":"590",
                                      "GU":"1",
                                      "GT":"502",
                                      "GN":"224",
                                      "GW":"245",
                                      "GY":"595",
                                      "HT":"509",
                                      "HN":"504",
                                      "HU":"36",
                                      "IS":"354",
                                      "IN":"+91",
                                      "ID":"62",
                                      "IQ":"964",
                                      "IE":"353",
                                      "IL":"972",
                                      "IT":"39",
                                      "JM":"1",
                                      "JP":"81",
                                      "JO":"962",
                                      "KZ":"77",
                                      "KE":"254",
                                      "KI":"686",
                                      "KW":"965",
                                      "KG":"996",
                                      "LV":"371",
                                      "LB":"961",
                                      "LS":"266",
                                      "LR":"231",
                                      "LI":"423",
                                      "LT":"370",
                                      "LU":"352",
                                      "MG":"261",
                                      "MW":"265",
                                      "MY":"60",
                                      "MV":"960",
                                      "ML":"223",
                                      "MT":"356",
                                      "MH":"692",
                                      "MQ":"596",
                                      "MR":"222",
                                      "MU":"230",
                                      "YT":"262",
                                      "MX":"52",
                                      "MC":"377",
                                      "MN":"976",
                                      "ME":"382",
                                      "MS":"1",
                                      "MA":"212",
                                      "MM":"95",
                                      "NA":"264",
                                      "NR":"674",
                                      "NP":"977",
                                      "NL":"31",
                                      "AN":"599",
                                      "NC":"687",
                                      "NZ":"64",
                                      "NI":"505",
                                      "NE":"227",
                                      "NG":"234",
                                      "NU":"683",
                                      "NF":"672",
                                      "MP":"1",
                                      "NO":"47",
                                      "OM":"968",
                                      "PK":"92",
                                      "PW":"680",
                                      "PA":"507",
                                      "PG":"675",
                                      "PY":"595",
                                      "PE":"51",
                                      "PH":"63",
                                      "PL":"48",
                                      "PT":"351",
                                      "PR":"1",
                                      "QA":"974",
                                      "RO":"40",
                                      "RW":"250",
                                      "WS":"685",
                                      "SM":"378",
                                      "SA":"966",
                                      "SN":"221",
                                      "RS":"381",
                                      "SC":"248",
                                      "SL":"232",
                                      "SG":"65",
                                      "SK":"421",
                                      "SI":"386",
                                      "SB":"677",
                                      "ZA":"27",
                                      "GS":"500",
                                      "ES":"34",
                                      "LK":"94",
                                      "SD":"249",
                                      "SR":"597",
                                      "SZ":"268",
                                      "SE":"46",
                                      "CH":"41",
                                      "TJ":"992",
                                      "TH":"66",
                                      "TG":"228",
                                      "TK":"690",
                                      "TO":"676",
                                      "TT":"1",
                                      "TN":"216",
                                      "TR":"90",
                                      "TM":"993",
                                      "TC":"1",
                                      "TV":"688",
                                      "UG":"256",
                                      "UA":"380",
                                      "AE":"971",
                                      "GB":"44",
                                      "US":"+1",
                                      "UY":"598",
                                      "UZ":"998",
                                      "VU":"678",
                                      "WF":"681",
                                      "YE":"967",
                                      "ZM":"260",
                                      "ZW":"263",
                                      "BO":"591",
                                      "BN":"673",
                                      "CC":"61",
                                      "CD":"243",
                                      "CI":"225",
                                      "FK":"500",
                                      "GG":"44",
                                      "VA":"379",
                                      "HK":"852",
                                      "IR":"98",
                                      "IM":"44",
                                      "JE":"44",
                                      "KP":"850",
                                      "KR":"82",
                                      "LA":"856",
                                      "LY":"218",
                                      "MO":"853",
                                      "MK":"389",
                                      "FM":"691",
                                      "MD":"373",
                                      "MZ":"258",
                                      "PS":"970",
                                      "PN":"872",
                                      "RE":"262",
                                      "RU":"7",
                                      "BL":"590",
                                      "SH":"290",
                                      "KN":"1",
                                      "LC":"1",
                                      "MF":"590",
                                      "PM":"508",
                                      "VC":"1",
                                      "ST":"239",
                                      "SO":"252",
                                      "SJ":"47",
                                      "SY":"963",
                                      "TW":"886",
                                      "TZ":"255",
                                      "TL":"670",
                                      "VE":"58",
                                      "VN":"84",
                                      "VG":"284",
                                      "VI":"340"]
            if countryDictionary[country] != nil {
                return countryDictionary[country]!
            }

            else {
                return ""
            }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.resendBgVw.isHidden = true
        self.resendVw.isHidden = true
        
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
    
    @objc func setGenre(_ notification: NSNotification) {
        guard let names = notification.userInfo?["names"] as? String else { return }
        guard let ids = notification.userInfo?["ids"] as? String else { return }
        self.genreNames = names
        self.genreIds = ids
        self.txtGenre.text = self.genreNames
    }
    
    func facebookCall(){
        if getReachabilityStatus(){
            
            let fbManager = LoginManager()
           // fbManager.logOut()
            if AccessToken.current != nil {
                LoginManager().logOut()
            }
            
            fbManager.logIn(permissions: ["public_profile,email"], from: self) { (result, error) in
                if (error == nil){
                    GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, first_name, last_name, picture.type(large)"]).start(completionHandler: { (connection, result, error) -> Void in
                        if (error == nil){
                            if let result = result as? [String:AnyObject]{
                                let url = URL(string: "https://graph.facebook.com/\(result["id"] as! String)/picture?type=large&return_ssl_resources=1")
                                print(result)
                                self.dictFB["profile_image"] = url?.absoluteString
                                self.dictFB["name"] = result["name"] as? String
                                self.dictFB["birthdate"] = " "
                                self.dictFB["email"] = result["email"] as? String ?? ""
                                self.dictFB["phone_number"] = " "
                                self.dictFB["fb_token"] = AccessToken.current?.tokenString
                                self.dictFB["fb_id"] = result["id"] as? String
                                self.dictFB["user_type"] = "\(UserModel.sharedInstance().userType!)"
                                print(self.dictFB)
                                //ashitesh - 18 may
                               // self.callFacebookGoogleStatusService(id: self.dictFB["fb_id"]!, type: "facebook", dictData: self.dictFB)
                            }
                        }
                    })
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
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
    
    func ChangeRootProfile() {
        let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
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
    
    func joinwithEmailPage() {
        currentScreenIndex = 0
        setScreen()
    }
    
    func joinwithPhonePage() {
        currentScreenIndex = 3
        setScreen()
    }
    
    func joinVerifyPage() {
        currentScreenIndex = 6
        setScreen()
    }
    
    func forgotPasswordPage() {
        currentScreenIndex = 8
        setScreen()
    }
    
    func toPinPage() {
        performSegue(withIdentifier: "segueRegisterSetPin", sender: nil)
    }
    
    func userSelection() {
        //setupPolicyLbl()
        if UserModel.sharedInstance().userType == "DJ"{
            setupPolicyLbl()
            self.imgBack.image = UIImage(named: "LoginBack_DJ")
            self.lblWelcome.text = "Welcome DJ".localize
            self.btnLogin.setTitle("Log In DJ".localize, for: .normal)
            self.btnForgetLogin.setTitle("Log In DJ".localize, for: .normal)
            self.lblHeader.text = "Sign Up DJ".localize
            self.lblEnterDOB.text = "DJ Enter Date of Birth to Sign Up".localize
            self.BackHomeBtn.setTitle("BACK HOME".localize, for: .normal)
            self.btnNext.setTitle("Next".localize, for: .normal)
            self.NextBtnn.setTitle("Next".localize, for: .normal)
            self.orUseLbl.text = "Or Use".localize
            self.backBtnn.setTitle("BACK HOME".localize, for: .normal)
            self.txtEmail.placeholder = "Enter Email".localize
            self.newReEnterEmailTxtFld.placeholder = "Re-enter Email".localize
            //self.txtConfirmEmail.placeholder = "Re-enter Email".localize
            self.txtUsername.placeholder = "Enter Username".localize
            self.txtPassword.placeholder = "Enter password".localize
            self.newVerifyPaswrdTxtFld.placeholder = "Re-enter Password".localize
           // self.txtConfirmPassword.placeholder = "Re-enter Password".localize
            self.txtGenre.placeholder = "Select Genre".localize
            
            
        }else{
            setupPolicyLbl()
            self.imgBack.image = UIImage(named: "LoginBack_AR")
            self.lblWelcome.text = "Welcome Artist".localize
            self.btnLogin.setTitle("Log In Artist".localize, for: .normal)
            self.btnForgetLogin.setTitle("Log In Artist".localize, for: .normal)
            self.lblHeader.text = "Sign Up Artist".localize
            self.lblEnterDOB.text = "Artist Enter Date of Birth to Sign Up".localize
            self.BackHomeBtn.setTitle("BACK HOME".localize, for: .normal)
            self.btnNext.setTitle("Next".localize, for: .normal)
            self.NextBtnn.setTitle("Next".localize, for: .normal)
            self.orUseLbl.text = "Or Use".localize
            self.backBtnn.setTitle("BACK HOME".localize, for: .normal)
            
            self.txtEmail.placeholder = "Enter Email".localize
            self.newReEnterEmailTxtFld.placeholder = "Re-enter Email".localize
           // self.txtConfirmEmail.placeholder = "Re-enter Email".localize
            self.txtUsername.placeholder = "Enter Username".localize
            self.txtPassword.placeholder = "Enter password".localize
            self.newVerifyPaswrdTxtFld.placeholder = "Re-enter Password".localize
            //self.txtConfirmPassword.placeholder = "Re-enter Password".localize
            self.txtGenre.placeholder = "Select Genre".localize
        }
    }
    
    //validation_functions
    func validateName(_name: String) -> Bool {
        // regular expression for allowing 7-18 characters
        let nameRegExpr = "[a-zA-Z0-9]"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegExpr)
        
        return nameTest.evaluate(with: nameRegExpr)
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    func calculateEnteredTime(){
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        globalObjects.shared.AppEnteredTime = formatter.string(from: now)
    }
    
    //MARK: - SELECTOR METHODS
    @objc func datePickerChanged(datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        self.birthdate = formatter.string(from: datePicker.date)
        print(self.birthdate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRegisterSetPin"{
            let destinationVC = segue.destination as! SetPinVC
            destinationVC.birthdate = self.birthdate
            destinationVC.email = self.email
            destinationVC.phone_no = "\(self.txtfCountryCode.text!)\(self.newPhoneNmbr)"
//            destinationVC.phone_no = "\(self.txtfCountryCode.text!)\(self.phoneNum)"
            destinationVC.password = self.password
            destinationVC.userType = UserModel.sharedInstance().userType!
            destinationVC.accept_terms = checkAccept
            destinationVC.userName = self.userName
            destinationVC.country_code = country_code
            destinationVC.genreIds = self.genreIds
            
//            destinationVC.birthdate = ""
//            destinationVC.email = "shubhamblixr@gmail.com"
//            destinationVC.phone_no = "+91"+"8800496719"
//            destinationVC.password = self.password
//            destinationVC.userType = UserModel.sharedInstance().userType!
//            destinationVC.accept_terms = checkAccept
//            destinationVC.userName = "lily"
//            destinationVC.country_code = "INR"
//            destinationVC.genreIds = "6"
        }else if segue.identifier == "segueFacebookDetail"{
            let destinationVC = segue.destination as! FacebookGoogleDetailVC
            
            destinationVC.genreIds = self.genreIds
            if selectedRegisterMode == .facebook{
                destinationVC.registerType = "facebook"
                destinationVC.dictFB = dictFB
            }
            if selectedRegisterMode == .gmail{
                destinationVC.registerType = "gmail"
                destinationVC.dictG = dictG
            }
            if selectedRegisterMode == .apple{
                destinationVC.registerType = "apple"
                destinationVC.dictApple = dictApple
                
            }
            
        }
    }
    //MARK: - ACTIONS
    
    @IBAction func btnHomeAction(_ sender: UIButton) {
        //        navigationController?.popViewController(animated: true)
        UserModel.sharedInstance().isHomePress = true
        UserModel.sharedInstance().synchroniseData()
        performSegue(withIdentifier: "segueHomeFordj", sender: nil)
    }
    
    @IBAction func btnSignInAction(_ sender: UIButton) {
        UserModel.sharedInstance().isHomePress = true
        UserModel.sharedInstance().synchroniseData()
        performSegue(withIdentifier: "segueLogin", sender: nil)
    }
    
    @IBAction func btnJoinWithGoogle_Action(_ sender: UIButton) {
        selectedRegisterMode = .gmail
       // callGmailLoginSDK() // ashitesh
//        GIDSignIn.sharedInstance.delegate = self
//        GIDSignIn.sharedInstance.uiDelegate = self
//        GIDSignIn.sharedInstance.signIn()
    }
    
    @IBAction func btnJoinWithFacebook_Action(_ sender: UIButton) {
        selectedRegisterMode = .facebook
       // facebookCall()
    }
    
    @IBAction func btnJoinWithApple_Action(_ sender: UIButton) {
        //self.showAlertView("Under Development")
        
        if #available(iOS 13.0, *) {
            selectedRegisterMode = .apple
            self.handleLogInWithAppleIDButtonPress()
        }

    }
    
    @IBAction func btnForgotPwdAction(_ sender: UIButton) {
//        currentScreenIndex = 10
//        currentScreenIndex = 9
        currentScreenIndex = 8
        forgotPasswordPage()
    }
    
    func vlidateEntry() -> Bool {
        var isValidated = false
        if currentScreenIndex == 0{
            isValidated = true
        }else if currentScreenIndex == 1{
            if txtEmail.text == ""{
                self.view.makeToast("Please Enter Email Address".localize)
                isValidated = false
            }else if !validateEmail(email: txtEmail.text!){
                self.view.makeToast("Please Enter Valid Email Address".localize)
                isValidated = false
            }else{
                self.email = txtEmail.text!
                isValidated = true
            }
            
             if newReEnterEmailTxtFld.text == ""{
                self.view.makeToast("Please Confirm Email Address".localize)
                isValidated = false
            }else if !validateEmail(email: newReEnterEmailTxtFld.text!){
                self.view.makeToast("Please Enter Valid Confirm Email Address".localize)
                isValidated = false
            }else if !validateConfirmEmail(_email: self.email, _cEmail: newReEnterEmailTxtFld.text!){
                self.view.makeToast("Both Email address does not match".localize)
                newReEnterEmailTxtFld.text = ""
                isValidated = false
                
            }else{
                //txtConfirmEmail.text = ""
                isValidated = true
            }
        }
       // else if currentScreenIndex == 2{
//            if txtConfirmEmail.text == ""{
//                self.view.makeToast("Please Confirm Email Address".localize)
//                isValidated = false
//            }else if !validateEmail(email: txtConfirmEmail.text!){
//                self.view.makeToast("Please Enter Valid Confirm Email Address".localize)
//                isValidated = false
//            }else if !validateConfirmEmail(_email: self.email, _cEmail: txtConfirmEmail.text!){
//                self.view.makeToast("Both Email address does not match".localize)
//                txtConfirmEmail.text = ""
//                isValidated = false
//
//            }else{
                //txtConfirmEmail.text = ""
                //isValidated = true
            //}
       // }
        else if currentScreenIndex == 2{
            if txtUsername.text == ""{
                self.view.makeToast("Please Enter User Name".localize)
                isValidated = false
            }else if txtUsername.text!.trimmingCharacters(in: .whitespaces).isEmpty{
                self.view.makeToast("Please Enter valid username".localize)
                isValidated = false
            }else{
                self.userName = txtUsername.text!
                isValidated = true
            }
        }else if currentScreenIndex == 3{
            if txtPassword.text == ""{
                self.view.makeToast("Please Enter Password".localize)
                isValidated = false
            }else if !validatePassword(password: txtPassword.text!){
                self.view.makeToast("Enter valid password. Password should be between 6 to 18 characters and should not be empty spaces only".localize)
                isValidated = false
            }else{
                self.password = txtPassword.text!
                txtPassword.text = ""
                isValidated = true
            }
            
            self.newVerifyPaswrdTxtFld.placeholder = "Re-enter Password".localize
            if newVerifyPaswrdTxtFld.text == ""{
                self.view.makeToast("Please Enter Confirm Password".localize)
                isValidated = false
            }else if !validatePassword(password: newVerifyPaswrdTxtFld.text!){
                self.view.makeToast("Enter valid password. Password should be between 6 to 18 characters and should not be empty spaces only".localize)
                isValidated = false
            }else if !validateConfirmPassword(_Pwd: self.password, _cPwd: newVerifyPaswrdTxtFld.text!){
                self.view.makeToast("Both passwords does not match".localize)
                isValidated = false
                currentScreenIndex = currentScreenIndex - 1
                if currentScreenIndex >= 0{
                    setScreen()
                }
            }else{
                newVerifyPaswrdTxtFld.text = ""
                isValidated = true
            }
            
        }
       // else if currentScreenIndex == 4{
//            if txtConfirmPassword.text == ""{
//                self.view.makeToast("Please Enter Confirm Password".localize)
//                isValidated = false
//            }else if !validatePassword(password: txtConfirmPassword.text!){
//                self.view.makeToast("Enter valid password. Password should be between 6 to 18 characters and should not be empty spaces only".localize)
//                isValidated = false
//            }else if !validateConfirmPassword(_Pwd: self.password, _cPwd: txtConfirmPassword.text!){
//                self.view.makeToast("Both passwords does not match".localize)
//                isValidated = false
//                currentScreenIndex = currentScreenIndex - 1
//                if currentScreenIndex >= 0{
//                    setScreen()
//                }
//            }else{
//                txtConfirmPassword.text = ""
//                isValidated = true
//            }
       // }
        else if currentScreenIndex == 4{
            if txtGenre.text == ""{
                self.view.makeToast("Please Select Genre".localize)
                isValidated = false
            }else{
                isValidated = true
            }
        }else if currentScreenIndex == 5{
            isValidated = ((txtPhone.text?.validPhoneNumber) != nil)
            if txtPhone.text == ""{
                self.view.makeToast("Please Enter Phone Number".localize)
                isValidated = false
            }
            else if txtPhone.text!.count < 6{
                self.view.makeToast("Please Enter Valid Phone Number".localize)
                isValidated = false
            }
            else if !isValidated {
                self.view.makeToast("Please Enter Valid Phone Number".localize)
                isValidated = false
            }else{
                self.phoneNum = txtPhone.text!
                isValidated = true
            }
        }
        return isValidated
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        currentScreenIndex = currentScreenIndex - 1
        if currentScreenIndex >= 0{
            setScreen()
        }
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        
        var selectDate = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        selectDate = formatter.string(from: Date())
        if (selectDate == "" || selectDate == self.birthdate) {
            self.view.makeToast("You cann't select current date")
        }
        else{
        
        if vlidateEntry(){
            if currentScreenIndex == 1 || currentScreenIndex == 2{
                callEmailExistWebService()
            }
            else if currentScreenIndex == 5{
                //callOtpService()
            }
//            else if currentScreenIndex == 4{ // it was hidden to test appl signup to hide phone part and ot part
//                self.toPinPage()
//            }
            else{
                currentScreenIndex = currentScreenIndex + 1
            }
        }
        if currentScreenIndex < 6{
            setScreen()
        }
        else{
            callVerifyOTPWebService()
        }
        }
        //        ()
        //        callPhoneExistWebService()
        //        callVerifyOTPWebService()
    }
    
    func setScreen() {
//        if UserModel.sharedInstance().userType == "DJ"{
//            self.btnNext.setTitle("Next".localize, for: .normal)
//        }
//        else{
//            self.btnNext.setTitle("Next".localize, for: .normal)
//        }
        
        switch currentScreenIndex {
        case 0:
            self.vwDOB.isHidden = false
            self.vwOther.isHidden = true
            self.vwForgetPwd.isHidden = true
            self.verificationCodeBtn.isHidden = true
            self.verificationCodeBtn.setTitle("", for: .normal)
            self.resendBgVw.isHidden = true
            self.resendVw.isHidden = true
            self.resendAlertTitleLbl.text = ""
            break
        case 1:
            self.vwDOB.isHidden = true
            self.vwOther.isHidden = false
            self.vwEmail.isHidden = false
            
            self.newVeriFyEmail.isHidden = false
            
            self.vwConfirmEmail.isHidden = true
            self.vwUsername.isHidden = true
            self.vwPassword.isHidden = true
            self.newVeriFyPaswrdVw.isHidden = true
            self.vwConfirmPassword.isHidden = true
            self.vwGenre.isHidden = true
            self.vwPhone.isHidden = true
            self.vwOTP.isHidden = true
            self.vwForgetPwd.isHidden = true
            self.verificationCodeBtn.isHidden = true
            self.verificationCodeBtn.setTitle("", for: .normal)
            self.resendBgVw.isHidden = true
            self.resendVw.isHidden = true
            self.resendAlertTitleLbl.text = ""
            break
        case 2:
            self.vwDOB.isHidden = true
            self.vwOther.isHidden = false
            self.vwEmail.isHidden = true
            self.newVeriFyEmail.isHidden = true
            self.vwConfirmEmail.isHidden = true
            self.vwUsername.isHidden = false
            self.vwPassword.isHidden = true
            self.newVeriFyPaswrdVw.isHidden = true
            self.vwConfirmPassword.isHidden = true
            self.vwGenre.isHidden = true
            self.vwPhone.isHidden = true
            self.vwOTP.isHidden = true
            self.vwForgetPwd.isHidden = true
            self.verificationCodeBtn.isHidden = true
            self.verificationCodeBtn.setTitle("", for: .normal)
            self.resendBgVw.isHidden = true
            self.resendVw.isHidden = true
            self.resendAlertTitleLbl.text = ""
            break
        case 3:
            self.vwDOB.isHidden = true
            self.vwOther.isHidden = false
            self.vwEmail.isHidden = true
            self.newVeriFyEmail.isHidden = true
            self.vwConfirmEmail.isHidden = true
            self.vwUsername.isHidden = true
            self.vwPassword.isHidden = false
            self.txtPassword.text = ""
            self.newVeriFyPaswrdVw.isHidden = false
            self.newVerifyPaswrdTxtFld.text = ""
            self.vwConfirmPassword.isHidden = true
            self.vwGenre.isHidden = true
            self.vwPhone.isHidden = true
            self.vwOTP.isHidden = true
            self.vwForgetPwd.isHidden = true
            self.verificationCodeBtn.isHidden = true
            self.verificationCodeBtn.setTitle("", for: .normal)
            self.resendBgVw.isHidden = true
            self.resendVw.isHidden = true
            self.resendAlertTitleLbl.text = ""
            break
        case 4:
            self.vwDOB.isHidden = true
            self.vwOther.isHidden = false
            self.vwEmail.isHidden = true
            self.newVeriFyEmail.isHidden = true
            self.vwConfirmEmail.isHidden = true
            self.vwUsername.isHidden = true
            self.vwPassword.isHidden = true
            self.newVeriFyPaswrdVw.isHidden = true
            self.vwConfirmPassword.isHidden = true
            self.vwGenre.isHidden = false
            self.vwPhone.isHidden = true
            self.vwOTP.isHidden = true
            self.vwForgetPwd.isHidden = true
            self.verificationCodeBtn.isHidden = true
            self.verificationCodeBtn.setTitle("", for: .normal)
            self.resendBgVw.isHidden = true
            self.resendVw.isHidden = true
            self.resendAlertTitleLbl.text = ""
            break
        case 5:
            self.vwDOB.isHidden = true
            self.vwOther.isHidden = false
            self.vwEmail.isHidden = true
            self.newVeriFyEmail.isHidden = true
            self.vwConfirmEmail.isHidden = true
            self.vwUsername.isHidden = true
            self.vwPassword.isHidden = true
            self.newVeriFyPaswrdVw.isHidden = true
            self.vwConfirmPassword.isHidden = true
            self.vwGenre.isHidden = true
            self.vwPhone.isHidden = false
            self.btnNext.setTitle("Log In", for: .normal)
            self.vwOTP.isHidden = true
            self.vwForgetPwd.isHidden = true
            self.verificationCodeBtn.isHidden = true
            self.verificationCodeBtn.setTitle("", for: .normal)
            self.resendBgVw.isHidden = true
            self.resendVw.isHidden = true
            self.resendAlertTitleLbl.text = ""
            break
        case 6:
            self.vwDOB.isHidden = true
            self.vwOther.isHidden = false
            self.vwEmail.isHidden = true
            self.newVeriFyEmail.isHidden = true
            self.vwConfirmEmail.isHidden = true
            self.vwUsername.isHidden = true
            self.vwPassword.isHidden = true
            self.newVeriFyPaswrdVw.isHidden = true
            self.vwConfirmPassword.isHidden = true
            self.vwGenre.isHidden = true
            self.vwPhone.isHidden = true
            self.vwOTP.isHidden = false
            self.verificationCodeBtn.isHidden = false
            self.verificationCodeBtn.setTitle("Resend Verification Code?", for: .normal)
            self.vwForgetPwd.isHidden = true
            break
        default:
            self.vwDOB.isHidden = true
            self.vwOther.isHidden = true
            self.vwForgetPwd.isHidden = false
            self.verificationCodeBtn.isHidden = true
            self.verificationCodeBtn.setTitle("", for: .normal)
            self.resendBgVw.isHidden = true
            self.resendVw.isHidden = true
            self.resendAlertTitleLbl.text = ""
        }
    }
    
    @IBAction func btnForgotPwdSendAction(_ sender: UIButton) {
        let enteredEmail = txtForgetEmail.text ?? ""
        let validateEmailBool = validateEmail(email: enteredEmail)
        if enteredEmail.isEmpty == true || validateEmailBool == false{
            self.view.makeToast("Please enter valid email.".localize)
        }else{
            self.email = enteredEmail
            callForgotPasswordService()
        }
    }
    
    @IBAction func btnAddCountry_Action(_ sender: UIButton) {
        pickerSelected = true
        let picker = ADCountryPicker(style: .grouped)
        picker.didSelectCountryWithCallingCodeClosure = { name, code, dialCode in
            self.country_code = code
            print("COUNTRY = \(code)")
            picker.dismiss(animated: true, completion: {
                print("dialCode = \(dialCode)")
                self.txtfCountryCode.text = dialCode
            })
        }
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: - WEBSERVICES
    func callForgotPasswordService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.forgotPwdAPI)"
            let parameters = [
                "email":"\(self.email)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ForgotPasswordModel>) in
                switch response.result{
                case .success(_):
                    Loader.shared.hide()
                    let forgotPasswordModel = response.result.value!
                    if forgotPasswordModel.success == 1{
                        self.view.makeToast(forgotPasswordModel.message)
                        globalObjects.shared.forgotEmail = self.email
                        self.navigationController?.popViewController(animated: true)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(forgotPasswordModel.message)
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
    
    func callOtpService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.sendOtpAPI)"
            let tempContryCd = txtfCountryCode.text!
            let getNo = phoneNum
            //var newPhoneNmbr = ""
            if getNo.contains(tempContryCd) {
                newPhoneNmbr = getNo.replacingOccurrences(of: tempContryCd, with: "")
                print("newPhoneNmbr",newPhoneNmbr)
            }
            else{
                newPhoneNmbr = phoneNum
                print("newPhoneNmbr2",newPhoneNmbr)
            }
            let parameters = [
//                "phone_number":"\(self.txtfCountryCode.text!)\(self.phoneNum)"]
                "phone_number":"\(self.txtfCountryCode.text!)\(newPhoneNmbr)"]
            Loader.shared.show()

            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SendOtpModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let otpModel = response.result.value!
                                    if otpModel.success == 1{
                                        self.view.makeToast(otpModel.message)
                                        
                                        if #available(iOS 12.0, *) {
                                            self.txtOTP.textContentType = .oneTimeCode
                                        }
                                        self.txtOTP.becomeFirstResponder()
                                        self.joinVerifyPage()
                                    }else{
                                        Loader.shared.hide()
                                        self.view.makeToast(otpModel.message)
                                    }
                                case .failure(let error):
                                    Loader.shared.hide()
                                    debugPrint(error)
                                    self.view.makeToast("Entered invalid mobile number")
                                    print("Error")
                                }
                              }
        }else{
            print("Please check your Internet Connection.")
        }
    }
    
    func callEmailExistWebService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.checkEmailAPI)"
            var parameters = [
                "email":""
            ]
            
            if !self.email.isEmpty{
                parameters["email"] = "\(self.email)"
            }
            
            if !self.userName.isEmpty{
                parameters["username"] = "\(self.userName)"
            }
            print("a3",parameters)
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let checkMailModel = response.result.value!
                                    if checkMailModel.success == 1{
                                        self.currentScreenIndex = self.currentScreenIndex + 1
                                        self.setScreen()
                                    }else{
                                        Loader.shared.hide()
                                        self.view.makeToast(checkMailModel.message)
                                    }
                                case .failure(let error):
                                    Loader.shared.hide()
                                    debugPrint(error)
                                    print("Error")
                                }
                              }
        }else{
            print("Please check your Internet Connection.")
        }
    }
    
    func callVerifyOTPWebService() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.verifyOTP)"
            
            let parameters = [
                "email":"\(self.email)",
                "otp":"\(self.txtOTP.text!)",
                "phone":"\(self.txtfCountryCode.text!)\(self.newPhoneNmbr)"
//                "phone":"\(self.txtfCountryCode.text!)\(self.phoneNum)"
            ]
            print("a2Verifyotp",parameters)
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let verifyOtpModel = response.result.value!
                                    if verifyOtpModel.success == 1{
                                        UserModel.sharedInstance().isSignup = true
                                        UserModel.sharedInstance().isSkip = false
                                        UserModel.sharedInstance().paymentPopup = false
                                        UserModel.sharedInstance().finishPopup = false
                                        UserModel.sharedInstance().synchroniseData()
                                        self.toPinPage()
                                        
                                    }else {
                                        Loader.shared.hide()
                                        self.view.makeToast(verifyOtpModel.message)
                                    }
                                case .failure(let error):
                                    Loader.shared.hide()
                                    debugPrint(error)
                                    print("Error")
                                }
                              }
        }else{
            print("Please check your Internet Connection.")
        }
    }
    
    func callPhoneExistWebService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.checkEmailAPI)"
            let parameters = [
                "email":"\(self.email)",
                "username":"\(self.userName)",
                "contactno":"\(self.txtfCountryCode.text!)\(self.newPhoneNmbr)"
//                "contactno":"\(self.txtfCountryCode.text!)\(self.phoneNum)"
            ]
            print("a1",parameters)
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let checkPhoneModel = response.result.value!
                                    if checkPhoneModel.success == 1{
                                        //self.callOtpService()
                                    }else {
                                        Loader.shared.hide()
                                        self.view.makeToast(checkPhoneModel.message)
                                    }
                                case .failure(let error):
                                    Loader.shared.hide()
                                    debugPrint(error)
                                    print("Error")
                                }
                              }
        }else{
            print("Please check your Internet Connection.")
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
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { [self] (response:DataResponse<FacebookGoogleStatusModel>) in
                
                switch response.result {
                case .success(_):
                    let statusModel = response.result.value!
                    if statusModel.success == 1{
                        Loader.shared.hide()
                        let status = statusModel.responceData?.registerStatus!
                        //                        self.callDeviceRegistrationApi(false)
                        if type == "facebook"{
                            if status == "0"{
                                statusCodeFBSocial = "0"
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                statusCodeFBSocial = "1"
                                self.callFbLoginService(Data: dictData)
                            }
                        }
                        else if type == "apple"{
                            if status == "0"{
                                                            statusCodeFBSocial = "0"
                                                            self.statusCodeSocial = "0"
                                                            // open apple page
                                                            self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                                                        }else{
                                                            statusCodeFBSocial = "1"
                                                            self.statusCodeSocial = "1"
                                                            // call apple api
                                                            //comented by ashitesh
                                                           // self.callAppleLoginService(Data: dictData)
                                                        }
                        }
                        else{
                            if status == "0"{
                                self.statusCodeSocial = "0"
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                            }else{
                                self.statusCodeSocial = "1"
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
                                //comented by ashitesh
                               // self.callAppleLoginService(Data: dictData)
                            }
                        }
                        else{ // when new user comes
                            if statusModel.success == 0{
                                self.performSegue(withIdentifier: "segueFacebookDetail", sender: nil)
                               // self.googleSignIn(Data: dictData)
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
                "email":Data["email"] ?? "",
                "phone_number":"123",
                "fb_token":Data["fb_token"]!,
                "fb_id":Data["fb_id"]!,
                "user_type":Data["user_type"]!,
                "pin":"1234",
                "country_code":country_code ?? "INR"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.facebookAPI)"), method: .post, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GoogleSucessModel>) in
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
                            UserModel.sharedInstance().uniqueUserName = Data["name"]!
                            UserModel.sharedInstance().currency_code = _modelData.currency_code!
                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol!
                            
                            // added by ashitesh
                            UserModel.sharedInstance().currency_id = "\(_modelData.currncyId ?? 0)"
                           
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount ?? 0
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time ?? ""
                            UserModel.sharedInstance().genereList = _modelData.genre ?? "1"
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin ?? 0)"
                           // UserModel.sharedInstance().currency_id = "\(_modelData.currncyId!)"
                            UserModel.sharedInstance().currency_name = "\(_modelData.currncyName ?? "")"
//                            if(self.country_code == "US"){
//                               // if(UserModel.sharedInstance().setCurrencyNameSt == "$"){
//                                    UserModel.sharedInstance().currency_name = "$"
//                                }
//                                else{
//                                    UserModel.sharedInstance().currency_name = "₹"
//                                }
//                            //}
                            UserModel.sharedInstance().isSkip = false
                            UserModel.sharedInstance().paymentPopup = false
                            UserModel.sharedInstance().finishProfile = true
                            UserModel.sharedInstance().isSignup = false
                            UserModel.sharedInstance().synchroniseData()
                            
                            if(self.statusCodeFBSocial == "1"){
                                                            if UserModel.sharedInstance().userType == "DJ"{
                                                                self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
                                                            }else{
                                                                self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
                                                            }
                            }
                            else{
                                self.currentScreenIndex = 4
                                self.setScreen()
                            }
                            
//                            if UserModel.sharedInstance().userType == "DJ"{
//                                self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
//                            }else{
//                                self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
//                            }
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
                "country_code":country_code ?? "INR"
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
                            UserModel.sharedInstance().token = _modelData.token!
                            UserModel.sharedInstance().email = Data["email"]!
                            UserModel.sharedInstance().uniqueUserName = Data["full_name"]!
                            UserModel.sharedInstance().currency_code = _modelData.currency_code!
                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol!
                            // added by ashitesh
                            UserModel.sharedInstance().currency_id = "\(_modelData.currncyId ?? 0)"
                            UserModel.sharedInstance().currency_name = "\(_modelData.currncyName ?? "")"
//                            if(self.country_code == "US"){
//                               // if(UserModel.sharedInstance().setCurrencyNameSt == "$"){
//                                    UserModel.sharedInstance().currency_name = "$"
//                                }
//                                else{
//                                    UserModel.sharedInstance().currency_name = "₹"
//                                }
//                            //}
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount ?? 0
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time ?? ""
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin ?? 0)"
                            UserModel.sharedInstance().genereList = _modelData.genre ?? ""
                            UserModel.sharedInstance().finishProfile = false
                            UserModel.sharedInstance().isSignup = false
                            UserModel.sharedInstance().synchroniseData()
                            
                            print("goglesignup")
                            if(self.statusCodeSocial == "1"){
                                                            if UserModel.sharedInstance().userType == "DJ"{
                                                                self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
                                                            }else{
                                                                self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
                                                            }
                            }
                            else{
                                self.currentScreenIndex = 4
                                self.setScreen()
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
                "country_code":country_code ?? "INR"
                
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
                            UserModel.sharedInstance().uniqueUserName = Data["full_name"]!
                            UserModel.sharedInstance().currency_code = _modelData.currency_code ?? ""
                            UserModel.sharedInstance().userCurrency = _modelData.currncySymbol ?? ""
                            // added by ashitesh
                            UserModel.sharedInstance().currency_id = "\(_modelData.currncyId ?? 0)"
                            UserModel.sharedInstance().currency_name = "\(_modelData.currncyName ?? "")"
                            UserModel.sharedInstance().notificationCount = _modelData.NotificationCount ?? 0
                            UserModel.sharedInstance().remainingTime = _modelData.project_remaining_time ?? ""
                            UserModel.sharedInstance().userPin = "\(_modelData.userPin ?? 0)"
                            UserModel.sharedInstance().genereList = _modelData.genre ?? ""
                            UserModel.sharedInstance().finishProfile = false
                            UserModel.sharedInstance().isSignup = false
                            UserModel.sharedInstance().synchroniseData()
                            
                            print("applesignup")
                            if(self.statusCodeSocial == "1"){
                                                            if UserModel.sharedInstance().userType == "DJ"{
                                                                self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
                                                            }else{
                                                                self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
                                                            }
                            }
                            else{
                                self.currentScreenIndex = 4
                                self.setScreen()
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
            
            print("deviceRegister12",parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addRecordAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    let loginModel = response.result.value!
                    if loginModel.success == 1{
                        Loader.shared.hide()
                        self.calculateEnteredTime()
                        if canChange{
                            if UserModel.sharedInstance().userType == "DJ"{
                                self.ChangeRoot(storyboard: "DJHome", identifier: "SideMenuNavigationDJHome")
                            }else{
                                self.ChangeRoot(storyboard: "ArtistHome", identifier: "SideMenuNavigationArtistHome")
                            }
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
}
//MARK: - EXTENSIONS

extension SignInVC : UITextFieldDelegate{
    
//     func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
//        if action == "paste:" {
//            return true
//        }
//        return super.canPerformAction(action, withSender: sender)
//    }

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == txtGenre{
            let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GerneSelectorVC") as! GerneSelectorVC
            desiredViewController.oldSelectedIds = self.genreIds
            desiredViewController.notificationName = "setGenreFromSignup"
            desiredViewController.view.frame = (self.view.bounds)
            self.view.addSubview(desiredViewController.view)
            self.addChild(desiredViewController)
            desiredViewController.didMove(toParent: self)
            return false
        }else{
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhone{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            }
            else if textField.text!.count > 14 {
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            // your code
        if textField == txtPhone {
            if (txtPhone.text != ""){
            let tempContryCd = txtfCountryCode.text!
            let getNmbr = txtPhone.text
            //var newPhoneNmbr = ""
                if ((getNmbr?.contains(tempContryCd)) != nil) { 
                txtPhone.text = getNmbr?.replacingOccurrences(of: tempContryCd, with: "")
                print("txtPhone.text",txtPhone.text)
            }
            else{
                txtPhone.text = txtPhone.text
                print("txtPhone2",txtPhone.text)
            }
            }
            
        }
        }
}
extension String {
    var validPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
}

/*extension SignInVC: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        }else{
            // Perform any operations on signed in user here.
            if (user != nil){
                dictG["google_id"] = user.userID!
                dictG["token"] = user.authentication.idToken!
                dictG["full_name"] = user.profile?.name
                dictG["email"] = user.profile?.email
                dictG["img_url"] = user.profile?.imageURL(withDimension: 200)?.absoluteString
                dictG["user_type"] = "\(UserModel.sharedInstance().userType!)"
                self.callFacebookGoogleStatusService(id: dictG["google_id"]!, type: "google", dictData: dictG)
            }
        }
    }
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
}
 */

extension SignInVC {
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
                    //ashitesh - 18 may
                              // self.callFacebookGoogleStatusService(id: dictG["google_id"]!, type: "google", dictData: dictG)
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

//MARK:- Signin With Apple
@available(iOS 13.0, *)
extension SignInVC : ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

  @available(iOS 13.0, *)
  extension SignInVC : ASAuthorizationControllerDelegate {
          
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
            //self.callFacebookGoogleStatusService(id: dictApple["apple_id"] ?? "", type: "apple", dictData: dictApple)
              
          } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
              // Sign in using an existing iCloud Keychain credential.
              let username = passwordCredential.user
              let password = passwordCredential.password
              
            
            self.view.makeToast("The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)")
              
          }
      }
  }
