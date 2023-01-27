//
//  CreateScreenViewController.swift
//  DJConnect
//
//  Created by Techugo on 16/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Toast_Swift
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import AlamofireObjectMapper
import ADCountryPicker
import AuthenticationServices

class CreateScreenViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var hedrCreateLbl: UILabel!
    @IBOutlet weak var hedrAccountLbl: UILabel!
   // @IBOutlet weak var fullNameVw: UIView!
    @IBOutlet weak var emailVw: UIView!
    @IBOutlet weak var dOBVw: UIView!
    @IBOutlet weak var mobilenoVw: UIView!
    @IBOutlet weak var paswordVw: UIView!
    @IBOutlet weak var userNameVw: UIView!
    @IBOutlet weak var bottomDescrVw: UILabel!
    
   // @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var dOBTxtFld: UITextField!
    @IBOutlet weak var mobileNoTxtFld: UITextField!
    
    @IBOutlet weak var txtfCountryCode: UITextField!
    
    @IBOutlet weak var btnCountry: UIButton!
    
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var userNameTxtFld: UITextField!
    @IBOutlet weak var validUserImgVw: UIImageView!
    
    @IBOutlet weak var enterGenreVw: UIView!
    @IBOutlet weak var enterGenreTxtFld: UITextField!
    @IBOutlet weak var enterGenreBtn: UIButton!
    
    @IBOutlet weak var registrationBtn: UIButton!
    
    @IBOutlet weak var hideShowPaswrdBtn: UIButton!
    
    @IBOutlet weak var hideShowImgVw: UIImageView!
    
    @IBOutlet weak var termsServiceBtn: UIButton!
    @IBOutlet weak var privacyPolicyBtn: UIButton!
    @IBOutlet weak var bysigningupLbl: UILabel!
    @IBOutlet weak var andLbl: UILabel!
    
    var onboardType = String()
    let picker1 : UIDatePicker = UIDatePicker()
    var userName = ""
    var email = ""
    var password = ""
    var phoneNum = ""
    var dobtxtFldStr = ""
    
    var isValidated = false
    
    //MARK: - GLOBAL VARIABLES
    var checkAccept = "0"
    var fbType = String()
    var googleType = String()
    var loginButtonSelected = String()
    let picker = ADCountryPicker(style: .grouped)
    var pickerSelected = Bool()
    var otpVerifyToast = String()
    var country_code = String()
//    var userName = ""
//    var birthdate = ""
//    var email = ""
//    var password = ""
//    var phoneNum = ""
    var genreNames = ""
    var genreIds = ""
    var dictFB = [String : String]()
    var dictG = [String : String]()
    var dictApple = [String : String]()
    var selectedRegisterMode = registerMode.facebook
    var currentScreenIndex = 0 //used to maintain current screen
    
    var statusCodeSocial = String()
    var statusCodeFBSocial = String()
    
    var strAppleToken = ""
    var newPhoneNmbr = String()
    var newPhoneWithoutC = String()
    
    var gerneDataObj = [GenreData]()
    var selectAlGenStr = ""
    var getUserValue = ""
    
    enum registerMode{
        case facebook
        case gmail
        case apple
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        globalObjects.shared.isFromBackGroundState = false
        hideShowPaswrdBtn.setTitle("", for: .normal)
        
        let myImageName = "Hide"
                 let myImage = UIImage(named: myImageName)
        hideShowImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
        hideShowImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1) 
        
        if UserModel.sharedInstance().userType == "AR"{
            hedrCreateLbl.text = "Artist Create"
            
            hedrAccountLbl.text = "Account"
        }
        else{
            hedrCreateLbl.text = "DJ Create"
            hedrAccountLbl.text = "Account"
        }
        
        let userDeviceToken = UserDefaults.standard.string(forKey: "device_token")
         UserModel.sharedInstance().deviceToken = userDeviceToken
        print("deviceToken1",UserModel.sharedInstance().deviceToken)
        
        let locale: NSLocale = NSLocale.current as NSLocale
        let countryy: String? = locale.countryCode
        let getCode = self.getCountryPhonceCode(countryy ?? "IN")
            print("getCode getCode",getCode)
        
        print("bydafault countrycode",countryy)
       
        GetGenreList()
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
        
        picker.defaultCountryCode = "US"
        picker.forceDefaultCountryCode = true
        picker.alphabetScrollBarTintColor = UIColor.black
        picker.alphabetScrollBarBackgroundColor = UIColor.clear
        picker.closeButtonTintColor = UIColor.black
        picker.font = .systemFont(ofSize: 15)
        picker.flagHeight = 40
        picker.hidesNavigationBarWhenPresentingSearch = true
        picker.searchBarBackgroundColor = UIColor.lightGray
        
       // userSelection()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setGenre(_:)), name: NSNotification.Name(rawValue: "setGenreFromSignup"), object: nil)
        
        validUserImgVw.isHidden = true
        setUpVw()
    }
    
    @objc func setGenre(_ notification: NSNotification) {
        guard let names = notification.userInfo?["names"] as? String else { return }
        guard let ids = notification.userInfo?["ids"] as? String else { return }
        self.genreNames = names
        self.genreIds = ids
        self.enterGenreTxtFld.text = self.genreNames
    }
    
    
    func setUpVw(){
         
        enterGenreTxtFld.isUserInteractionEnabled = false
        // theme pink color
        userNameVw.layer.cornerRadius = 10.0
        userNameVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
        userNameVw.layer.borderWidth = 0.5
        userNameVw.clipsToBounds = true
        
        // theme light pink color
        emailVw.layer.cornerRadius = 10.0
        emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        emailVw.layer.borderWidth = 0.5
        emailVw.clipsToBounds = true
        
        dOBVw.layer.cornerRadius = 10.0
        dOBVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        dOBVw.layer.borderWidth = 0.5
        dOBVw.clipsToBounds = true
        
        mobilenoVw.layer.cornerRadius = 10.0
        mobilenoVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        mobilenoVw.layer.borderWidth = 0.5
        mobilenoVw.clipsToBounds = true
        
        paswordVw.layer.cornerRadius = 10.0
        paswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        paswordVw.layer.borderWidth = 0.5
        paswordVw.clipsToBounds = true
        
//        userNameVw.layer.cornerRadius = 10.0
//        userNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
//        userNameVw.layer.borderWidth = 0.5
//        userNameVw.clipsToBounds = true
        
        enterGenreVw.layer.cornerRadius = 10.0
        enterGenreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        enterGenreVw.layer.borderWidth = 0.5
        enterGenreVw.clipsToBounds = true
        
        userNameTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        emailTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Email Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        dOBTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Date of Birth",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        mobileNoTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Mobile No",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        passwordTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        enterGenreTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Enter Genre",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )

        registrationBtn.layer.cornerRadius = registrationBtn.frame.size.height/2
        registrationBtn.clipsToBounds = true
        
       
        userNameTxtFld.text = ""
        emailTxtFld.text = ""
        dOBTxtFld.text = ""
        mobileNoTxtFld.text = ""
        passwordTxtFld.text = ""
        enterGenreTxtFld.text = ""
        
        userNameTxtFld.delegate = self
        emailTxtFld.delegate = self
        emailTxtFld.keyboardType = .emailAddress
        emailTxtFld.returnKeyType = .next
        dOBTxtFld.delegate = self
        mobileNoTxtFld.delegate = self
        mobileNoTxtFld.keyboardType = .numberPad
        passwordTxtFld.delegate = self
        passwordTxtFld.isSecureTextEntry = true;
        enterGenreTxtFld.delegate = self
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       // emailTxtFld.resignFirstResponder()
        if textField == emailTxtFld {
            if emailTxtFld.text == ""{
                self.view.endEditing(true)
                self.view.makeToast("Please Enter Email Address".localize)
                isValidated = false
            }
            else if !validateEmail(email: emailTxtFld.text!){
                self.view.endEditing(true)
                self.view.makeToast("Please Enter Valid Email Address".localize)
                isValidated = false
            }
            else{
                self.view.endEditing(true)
                self.email = emailTxtFld.text!
                callEmailExistWebService(text: "")
            }
            print("hey")
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == userNameTxtFld {
            // theme pink color
            userNameVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            dOBVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            mobilenoVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            paswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            enterGenreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            return true
        }
        else if textField == emailTxtFld{
            
            userNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            emailVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            dOBVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            mobilenoVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            paswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            enterGenreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            return true
        }
        
        else if textField == dOBTxtFld{
            
            userNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            dOBVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            mobilenoVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            paswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            enterGenreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            showStartDatePicker()
            return true
        }
        
        else if textField == mobileNoTxtFld{
            
            userNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            dOBVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            mobilenoVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            paswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            enterGenreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            return true
        }
        
        else if textField == passwordTxtFld{
            
            userNameVw.layer.borderColor =  UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            dOBVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            mobilenoVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            paswordVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            enterGenreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            return true
        }
        
        else {
           // if textField == enterGenreTxtFld{
            userNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            dOBVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            mobilenoVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            paswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            enterGenreVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            
            
            return true
            
        }

    }
    
    func showStartDatePicker(){
        if #available(iOS 13.4, *) {
            picker1.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        //Formate Date
        picker1.frame = CGRect(x:0, y: self.view.frame.height-picker1.frame.height, width: picker1.frame.width, height: picker1.frame.height)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolbar.backgroundColor = #colorLiteral(red: 0.768627451, green: 0, blue: 0.4901960784, alpha: 1)
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action:#selector(startDateTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        picker1.datePickerMode = .date
       // let currentDate = NSDate()  //get the current date
        picker1.maximumDate = Date()
        dOBTxtFld.inputAccessoryView = toolbar
        dOBTxtFld.inputView = picker1
    }
    
    @objc func startDateTimePicker(){
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateStyle = .medium
        dateFormatterr.dateFormat = "MMM d, yyyy"
        //dOBTxtFld.text = dateFormatterr.string(from: picker1.date)
        dobtxtFldStr = dateFormatterr.string(from: picker1.date)
        let dateFormatterr1 = DateFormatter()
        dateFormatterr1.dateStyle = .medium
        dateFormatterr1.dateFormat = "MM/dd/yyyy"
        dOBTxtFld.text = dateFormatterr1.string(from: picker1.date)
        print("dob", dOBTxtFld.text)
        self.view.endEditing(true)
    }
    
    //MARK: - SELECTOR METHODS
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func vlidateEntry() -> Bool {
         isValidated = false
        
         if userNameTxtFld.text == ""{
            self.view.makeToast("Please Enter User Name".localize)
            isValidated = false
        }else if userNameTxtFld.text!.trimmingCharacters(in: .whitespaces).isEmpty{
            self.view.makeToast("Please Enter valid username".localize)
            isValidated = false
            
        }
           else if emailTxtFld.text == ""{
                self.view.makeToast("Please Enter Email Address".localize)
                isValidated = false
            }
            else if !validateEmail(email: emailTxtFld.text!){
                self.view.makeToast("Please Enter Valid Email Address".localize)
                isValidated = false
            }

           else if dOBTxtFld.text == ""{
                 self.view.makeToast("Please Enter Date of Birth".localize)
                 isValidated = false
             }
            //isValidated = ((mobileNoTxtFld.text?.validPhoneNumber) != nil)
           else if mobileNoTxtFld.text == ""{
                self.view.makeToast("Please Enter Phone Number".localize)
                isValidated = false
            }
                else if mobileNoTxtFld.text!.count < 6{
                    self.view.makeToast("Please Enter Valid Phone Number".localize)
                    isValidated = false
                }
                else if isValidated == ((mobileNoTxtFld.text?.validPhoneNumber) != nil) {
                    self.view.makeToast("Please Enter Valid Phone Number".localize)
            isValidated = false
        }
                else if passwordTxtFld.text == ""{
                    self.view.makeToast("Please Enter Password".localize)
                    isValidated = false
         }      else if !validatePassword(password: passwordTxtFld.text!){
                self.view.makeToast("Enter valid password. Password should be between 6 to 18 characters and should not be empty spaces only".localize)
                isValidated = false
         }
        else if enterGenreTxtFld.text == ""{
            self.view.makeToast("Please Select Genre".localize)
            isValidated = false
        }
        
        else{
            self.userName = userNameTxtFld.text!
            isValidated = true
        }
                        
        return isValidated
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == userNameTxtFld{
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if newString.isEmpty{
                validUserImgVw.isHidden = true
                //tblsearch.isHidden = true
            }
            var setUserSt = ""
            setUserSt = setUserSt + newString
            print("setUserSt",setUserSt)
            
            if textField == userNameTxtFld{
                //if textField.text!.count > 2 {
                if setUserSt.count > 2 {
                    // api block by ashitesh - not running - 11 oct 2022
                   // self.callUserExistWebService(text: setUserSt)
                }
                else{
                    validUserImgVw.isHidden = true
                }
            }
        }
        
        if textField == mobileNoTxtFld{
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
    
    @IBAction func enterGenreBtnTapped(_ sender: Any) {
        var gerneSelectedList = [GenreData]()
        let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SelectGenreVC") as! SelectGenreVC
        desiredViewController.arrGenrelist = self.gerneDataObj
        desiredViewController.callbackGenreData = {  gerneData, selectAlGen in
            self.gerneDataObj.removeAll()
            gerneSelectedList.removeAll()
            self.gerneDataObj = gerneData
            self.selectAlGenStr = selectAlGen
            dump(self.gerneDataObj)
//            self.genreNames = names
//            self.genreIds = ids
           // var gerneSelectedList = [GenreData]()
            for (index, data) in self.gerneDataObj.enumerated() {
                if data.isSelected{
                    gerneSelectedList.append(data)
                }
                self.gerneDataObj[index].isSelected = data.isSelected
            }
            let txtgern: [String] = gerneSelectedList.map{$0.title} as? [String] ?? []
            let data = txtgern.joined(separator: ", ")
            
            let txtgernId: [String] = gerneSelectedList.map{String($0.id!)} as? [String] ?? []
            //let dataid = txtgernId.joined(separator: ",")
            let dataid = txtgernId.joined(separator: ",")
            print("generIdValue",dataid)
            self.enterGenreTxtFld.text = data
            self.genreIds = dataid
        }
//        if(genreIds != ""){
//            desiredViewController.genreIndexId = genreIds
//            desiredViewController.selectedgerneDataObj = gerneSelectedList
//        }selectaLStr
        desiredViewController.selectaLStr = self.selectAlGenStr
       
        self.navigationController?.pushViewController(desiredViewController, animated: false)

    }
    
    @IBAction func hideShowPaswrdBtnTapped(_ sender: Any) {
        hideShowImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        if(passwordTxtFld.isSecureTextEntry == true){
            let myImageName = "eye"
            let myImage = UIImage(named: myImageName)
            hideShowImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
            passwordTxtFld.isSecureTextEntry                   = false;
        }
        else{
            let myImageName = "Hide"
            let myImage = UIImage(named: myImageName)
            hideShowImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
            passwordTxtFld.isSecureTextEntry                   = true;
        }
        
    }
    
    @IBAction func termsServicesBtntapped(_ sender: Any) {
            self.callHelpSubMenuWebService(webservice.termsOfUse)

    }
    
    
    @IBAction func privacyBtnTapped(_ sender: Any) {

            self.callHelpSubMenuWebService(webservice.privacyPolicy)
    }
    
    //MARK: - OTHER METHODS
    func GetGenreList() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.getGenreAPI)?token=&userid="
            
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GenreModel>) in
                
                switch response.result {
                case .success(_):
                    let GenreModel = response.result.value!
                    if GenreModel.success == 1{
                        Loader.shared.hide()
                        self.gerneDataObj = GenreModel.genreList!
                        
                        print("GenrelistCount",self.gerneDataObj.count)
                        
                        //self.setUpGerne()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(GenreModel.message)
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
    
    @IBAction func btnAddCountry_Action(_ sender: Any) {
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
    
    func callEmailExistWebService(text: String){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.checkEmailAPI)"
            
            let tempContryCd = txtfCountryCode.text!
            let getNo = mobileNoTxtFld.text!
            var setCountryC = ""
            //var newPhoneNmbr = ""
            if getNo.contains(tempContryCd) {
                newPhoneNmbr = getNo.replacingOccurrences(of: tempContryCd, with: "")
                print("newPhoneNmbr",newPhoneNmbr)
            }
            else{
                newPhoneNmbr = mobileNoTxtFld.text!
                print("newPhoneNmbr2",newPhoneNmbr)
            }
                        if self.txtfCountryCode.text!.contains("+") {
                            setCountryC = self.txtfCountryCode.text!.replacingOccurrences(of: "+", with: "")
                        }
            newPhoneWithoutC = "\(setCountryC)\(newPhoneNmbr)"
           // let parameters = [
               // "phone_number":"\(setCountryC)\(newPhoneNmbr)"]
            
            var parameters = [
                "email":emailTxtFld.text!,
                "phone":"\(setCountryC)\(newPhoneNmbr)"
                //"phone":mobileNoTxtFld.text!
            ]
            
            if !self.email.isEmpty{
                parameters = [
                    "email":emailTxtFld.text!,
                    "phone":"\(setCountryC)\(newPhoneNmbr)"
                ]
                
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
                                        //self.validUserImgVw.isHidden = false
                                        self.callOtpService()
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
    
    func callUserExistWebService(text: String){
        getUserValue = text
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.checkEmailAPI)"
            var parameters = [
                "email":emailTxtFld.text!,
                //"phone":mobileNoTxtFld.text!
                "phone":"\(newPhoneWithoutC)"
            ]
            if getUserValue != ""{
                parameters["username"] = "\(self.getUserValue)"
                parameters = [
                    "email":"\(self.getUserValue)",
                    //"phone":"\(mobileNoTxtFld.text!)"
                    "phone":"\(newPhoneWithoutC)"
                ]
            }
            if !self.userName.isEmpty{
                parameters["username"] = "\(self.userName)"
            }
            print("a31",parameters)
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let checkMailModel = response.result.value!
                                    if checkMailModel.success == 1{
                                        self.validUserImgVw.isHidden = false
                                    }else{
                                        self.validUserImgVw.isHidden = true
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
    
    
    @IBAction func registrationBtnTapped(_ sender: Any) {
                   
        if vlidateEntry() {
        
            callEmailExistWebService(text: "")
            //callOtpService()
//
        }
    }
        
    func callOtpService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.sendOtpAPI)"
            let tempContryCd = txtfCountryCode.text!
            let getNo = mobileNoTxtFld.text!
            var setCountryC = ""
            //var newPhoneNmbr = ""
            if getNo.contains(tempContryCd) {
                newPhoneNmbr = getNo.replacingOccurrences(of: tempContryCd, with: "")
                print("newPhoneNmbr",newPhoneNmbr)
            }
            else{
                newPhoneNmbr = mobileNoTxtFld.text!
                print("newPhoneNmbr2",newPhoneNmbr)
            }
                        if self.txtfCountryCode.text!.contains("+") {
                            setCountryC = self.txtfCountryCode.text!.replacingOccurrences(of: "+", with: "")
                        }
            newPhoneWithoutC = "\(setCountryC)\(newPhoneNmbr)"
            let parameters = [
                "phone_number":"\(setCountryC)\(newPhoneNmbr)"]
                //"phone_number":"\(self.txtfCountryCode.text!)\(newPhoneNmbr)"]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SendOtpModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let otpModel = response.result.value!
                                    if otpModel.success == 1{
                                        self.view.makeToast(otpModel.message)
                                        
//                                        if #available(iOS 12.0, *) {
//                                            self.txtOTP.textContentType = .oneTimeCode
//                                        }
//                                        self.txtOTP.becomeFirstResponder()
//                                        self.joinVerifyPage()
                                        self.openOtpscreen()
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
    
    func openOtpscreen(){
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                let destinationVC = storyBoard.instantiateViewController(withIdentifier: "VerificationOTPVC") as! VerificationOTPVC
        //destinationVC.birthdate = self.dOBTxtFld.text!
        destinationVC.birthdate = self.dobtxtFldStr
                destinationVC.email = self.emailTxtFld.text!
                //destinationVC.phone_no = "\(self.txtfCountryCode.text!)\(self.mobileNoTxtFld.text!)"
                    destinationVC.phone_no = "\(self.mobileNoTxtFld.text!)"
                destinationVC.password = self.passwordTxtFld.text!
        destinationVC.onlyPhone = self.mobileNoTxtFld.text!
                destinationVC.userType = UserModel.sharedInstance().userType!
                destinationVC.accept_terms = checkAccept
                destinationVC.userName = self.userNameTxtFld.text!
                destinationVC.country_code = country_code
        destinationVC.newPhoneWithoutC = newPhoneWithoutC
                destinationVC.genreIds = self.genreIds
                navigationController?.pushViewController(destinationVC, animated: false)
    }
    

    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
