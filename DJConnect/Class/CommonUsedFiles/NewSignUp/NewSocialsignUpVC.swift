//
//  NewSocialsignUpVC.swift
//  DJConnect
//
//  Created by Techugo on 26/05/22.
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

class NewSocialsignUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var enterBelowDetail: UILabel!
    
    
    @IBOutlet weak var userNameVw: UIView!
    @IBOutlet weak var genreVw: UIView!
    @IBOutlet weak var mobileVw: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var genreTxtFld: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var txtfCountryCode: UITextField!
    @IBOutlet weak var mobileNoTxtFld: UITextField!
    
    var isValidated = false
    var genreNames = ""
    var genreIds = ""
    var userName = ""
    let picker = ADCountryPicker(style: .grouped)
    var pickerSelected = Bool()
    var otpVerifyToast = String()
    var country_code = String()
    
    var gerneDataObj = [GenreData]()
    enum registerMode{
        case facebook
        case gmail
        case apple
    }
    
    //MARK: - GLOBAL VARIABLES
    var dictFB = [String : String]()
    var dictG = [String : String]()
    var dictApple = [String : String]()
    var registerType = String()
    var emailString = String()
    var newPhoneNmbr = String()
    var newPhoneWithoutC = String()
    
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
        
        if registerType == "gmail"{
            if dictG["email"]?.isEmpty == true{
            }else{
                emailString = dictG["email"]!
            }
        }
        if registerType == "apple"{
            if dictApple["email"]?.isEmpty == true{
            }else{
                emailString = dictApple["email"]!
            }
        }
        
        if registerType == "facebook"{
            if dictFB["email"]?.isEmpty == true{
            }else{
                emailString = dictFB["email"] ?? ""
            }
        }
        
       // userSelection()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setGenre(_:)), name: NSNotification.Name(rawValue: "setGenreFromSignup"), object: nil)
        
        setUpVw()
    }
    
    @objc func setGenre(_ notification: NSNotification) {
        guard let names = notification.userInfo?["names"] as? String else { return }
        guard let ids = notification.userInfo?["ids"] as? String else { return }
        self.genreNames = names
        self.genreIds = ids
        self.genreTxtFld.text = self.genreNames
    }
    
    func setUpVw(){
         
        genreTxtFld.isUserInteractionEnabled = false
        // theme pink color
        userNameVw.layer.cornerRadius = 10.0
        userNameVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
        userNameVw.layer.borderWidth = 0.5
        userNameVw.clipsToBounds = true
        
        // theme light pink color
        genreVw.layer.cornerRadius = 10.0
        genreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        genreVw.layer.borderWidth = 0.5
        genreVw.clipsToBounds = true
        
        mobileVw.layer.cornerRadius = 10.0
        mobileVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        mobileVw.layer.borderWidth = 0.5
        mobileVw.clipsToBounds = true
        
        usernameTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        mobileNoTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Mobile No",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        genreTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Enter Genre",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )

        nextBtn.layer.cornerRadius = nextBtn.frame.size.height/2
        nextBtn.clipsToBounds = true
        
       
        usernameTxtFld.text = ""
        mobileNoTxtFld.text = ""
        genreTxtFld.text = ""
        
        usernameTxtFld.delegate = self
        genreTxtFld.delegate = self
        mobileNoTxtFld.delegate = self
        mobileNoTxtFld.keyboardType = .numberPad
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
               self.view.endEditing(true)
       return true
   }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == usernameTxtFld {
            // theme pink color
            userNameVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            
            mobileVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
           
            genreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            return true
        }
        
        else if textField == mobileNoTxtFld{
            
            userNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            
            mobileVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            
            genreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            return true
        }
        
        
        else {
           // if textField == enterGenreTxtFld{
            userNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            
            mobileVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            
            genreVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            
            return true
            
        }

    }
    
    func vlidateEntry() -> Bool {
         isValidated = false
        
            if usernameTxtFld.text == ""{
                self.view.makeToast("Please Enter User Name ".localize)
                isValidated = false
            }
            
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
               
        else if usernameTxtFld.text!.trimmingCharacters(in: .whitespaces).isEmpty{
            self.view.makeToast("Please Enter valid username".localize)
            isValidated = false
        }else{
            self.userName = usernameTxtFld.text!
            isValidated = true
        }
                        
        return isValidated
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
    

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        if vlidateEntry() {
        
            UserModel.sharedInstance().isSignup = true
            UserModel.sharedInstance().isSkip = false
            UserModel.sharedInstance().paymentPopup = false
            UserModel.sharedInstance().finishPopup = false
            UserModel.sharedInstance().synchroniseData()
            
                    let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                    let destinationVC = storyBoard.instantiateViewController(withIdentifier: "SetPinVC") as! SetPinVC
                    //destinationVC.birthdate = self.birthdate
                    destinationVC.email = self.emailString
                    //destinationVC.phone_no = "\(self.country_code)\(self.phone_no)"
            destinationVC.phone_no = "\(self.mobileNoTxtFld.text!)"
                    destinationVC.userType = UserModel.sharedInstance().userType!
            //destinationVC.accept_terms = self.accept_terms
                    destinationVC.userName = self.userName
            destinationVC.country_code = self.country_code
                    destinationVC.genreIds = self.genreIds
            destinationVC.registerType = self.registerType
            destinationVC.dictFB = self.dictFB
            destinationVC.dictG = self.dictG
            self.navigationController?.pushViewController(destinationVC, animated: false)
            //callPhoneExistWebService()
           
        }
    }
    
    func callPhoneExistWebService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.checkEmailAPI)"
            let tempContryCd = txtfCountryCode.text!
            let getNo = mobileNoTxtFld.text!
            var setCountryC = ""
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
                "email":"\(emailString)",
                //"username":usernameSt,
                "contactno":"\(setCountryC)\(newPhoneNmbr)"
                //"contactno":"\(self.txtfCountryCode.text!)\(mobileNoTxtFld.text!)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let checkPhoneModel = response.result.value!
                                    if checkPhoneModel.success == 1{
                                        self.openOtpscreen()
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
    
    //MARK: - WEBSERVICES
    func callEmailPhoneExistWebService(){
        if getReachabilityStatus(){
            var usernameSt = ""
            if registerType == "apple"{
                usernameSt = dictApple["name"] ?? ""
            }
            if registerType == "gmail"{
                usernameSt = dictG["name"] ?? ""
            }
            if registerType == "facebook"{
                usernameSt = dictFB["name"] ?? ""
            }
            let requestUrl = "\(webservice.url)\(webservice.checkEmailAPI)"
                        
            let tempContryCd = txtfCountryCode.text!
            let getNo = mobileNoTxtFld.text!
            var setCountryC = ""
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
                "email":"\(emailString)",
                "username":usernameTxtFld.text!,
                "contactno":"\(setCountryC)\(newPhoneNmbr)"
            ] as [String : Any]
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let checkMailModel = response.result.value!
                                    if checkMailModel.success == 1{
                                        self.openOtpscreen()

                                    }else {
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
    
    func openOtpscreen(){
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                let destinationVC = storyBoard.instantiateViewController(withIdentifier: "VerificationOTPVC") as! VerificationOTPVC
                destinationVC.email = self.emailString
                
                    destinationVC.phone_no = "\(self.mobileNoTxtFld.text!)"
                //destinationVC.password = self.passwordTxtFld.text!
        destinationVC.onlyPhone = self.mobileNoTxtFld.text!
                destinationVC.userType = UserModel.sharedInstance().userType!
                //destinationVC.accept_terms = checkAccept
                destinationVC.userName = self.usernameTxtFld.text!
                destinationVC.country_code = country_code
        destinationVC.newPhoneWithoutC = newPhoneWithoutC
                destinationVC.genreIds = self.genreIds
                navigationController?.pushViewController(destinationVC, animated: false)
    }
    
    @IBAction func genreBtnTapped(_ sender: Any) {
        let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SelectGenreVC") as! SelectGenreVC
        desiredViewController.arrGenrelist = self.gerneDataObj
        desiredViewController.callbackGenreData = {  gerneData, selectAlGenre in
            self.gerneDataObj.removeAll()
            self.gerneDataObj = gerneData
            dump(self.gerneDataObj)
//            self.genreNames = names
//            self.genreIds = ids
            var gerneSelectedList = [GenreData]()
            for data in self.gerneDataObj{
                if data.isSelected{
                    gerneSelectedList.append(data)
                }
            }
            let txtgern: [String] = gerneSelectedList.map{$0.title} as? [String] ?? []
            let data = txtgern.joined(separator: ", ")
            
            let txtgernId: [String] = gerneSelectedList.map{String($0.id!)} as? [String] ?? []
            //let dataid = txtgernId.joined(separator: ",")
            let dataid = txtgernId.joined(separator: ",")
            print("generIdValue",dataid)
            self.genreTxtFld.text = data
            self.genreIds = dataid
        }
       // desiredViewController.oldSelectedIds = self.genreIds
        //desiredViewController.notificationName = "setGenreFromSignup"
        self.navigationController?.pushViewController(desiredViewController, animated: false)
        
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
    
}
