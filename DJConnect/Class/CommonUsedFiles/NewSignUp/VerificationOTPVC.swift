//
//  VerificationOTPVC.swift
//  DJConnect
//
//  Created by Techugo on 17/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire

class VerificationOTPVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var verifyCodeLbl: UILabel!
    @IBOutlet weak var firstTxtFldVw: UIView!
    @IBOutlet weak var secondTxtFldVw: UIView!
    @IBOutlet weak var thirdTxtFldVw: UIView!
    @IBOutlet weak var fourthTxtFldVw: UIView!
    @IBOutlet weak var fifthTxtFldVw: UIView!
    @IBOutlet weak var sisthTxtFldVw: UIView!
    
    @IBOutlet weak var firstTxtFld: UITextField!
    @IBOutlet weak var secondTxtFld: UITextField!
    @IBOutlet weak var thirdTxtFld: UITextField!
    @IBOutlet weak var fourthTxtFld: UITextField!
    @IBOutlet weak var fifthTxtFld: UITextField!
    @IBOutlet weak var sixThTxtFld: UITextField!
    
    @IBOutlet weak var verificationCodeDescLbl: UILabel!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var resendCodeVw: UIView!
    @IBOutlet weak var okBtn: UIButton!
    
    var birthdate = String()
    var email = String()
    var phone_no = String()
    var password = String()
    var onlyPhone = String()
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
    var newPhoneWithoutC = ""
    
    var setOtp = ""
    var screenType = ""
    var emailStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resendCodeVw.isHidden = true
        resendCodeVw.layer.cornerRadius = 10
        okBtn.layer.cornerRadius = okBtn.frame.size.height/2
        setUpVw()
    }
    
    func setUpVw(){
         
        firstTxtFldVw.layer.cornerRadius = 10.0
        firstTxtFldVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        firstTxtFldVw.layer.borderWidth = 0.5
        firstTxtFldVw.clipsToBounds = true
        
        secondTxtFldVw.layer.cornerRadius = 10.0
        secondTxtFldVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        secondTxtFldVw.layer.borderWidth = 0.5
        secondTxtFldVw.clipsToBounds = true
        
        thirdTxtFldVw.layer.cornerRadius = 10.0
        thirdTxtFldVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        thirdTxtFldVw.layer.borderWidth = 0.5
        thirdTxtFldVw.clipsToBounds = true
        
        fourthTxtFldVw.layer.cornerRadius = 10.0
        fourthTxtFldVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        fourthTxtFldVw.layer.borderWidth = 0.5
        fourthTxtFldVw.clipsToBounds = true
        
        fifthTxtFldVw.layer.cornerRadius = 10.0
        fifthTxtFldVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        fifthTxtFldVw.layer.borderWidth = 0.5
        fifthTxtFldVw.clipsToBounds = true

        sisthTxtFldVw.layer.cornerRadius = 10.0
        sisthTxtFldVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        sisthTxtFldVw.layer.borderWidth = 0.5
        sisthTxtFldVw.clipsToBounds = true
        
        submitBtn.layer.cornerRadius = submitBtn.frame.size.height/2
        submitBtn.clipsToBounds = true
        
        firstTxtFld.text = ""
        secondTxtFld.text = ""
        thirdTxtFld.text = ""
        fourthTxtFld.text = ""
        fifthTxtFld.text = ""
        sixThTxtFld.text = ""
        
        firstTxtFld.delegate = self
        secondTxtFld.delegate = self
        thirdTxtFld.delegate = self
        fourthTxtFld.delegate = self
        fifthTxtFld.delegate = self
        sixThTxtFld.delegate = self
        
        firstTxtFld.keyboardType = .numberPad
        secondTxtFld.keyboardType = .numberPad
        thirdTxtFld.keyboardType = .numberPad
        fourthTxtFld.keyboardType = .numberPad
        fifthTxtFld.keyboardType = .numberPad
        sixThTxtFld.keyboardType = .numberPad
        
//        firstTxtFld.text = ""
//        secondTxtFld.text = ""
//        thirdTxtFld.text = ""
//        fourthTxtFld.text = ""
        self.firstTxtFld.becomeFirstResponder()
        
        firstTxtFld.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        secondTxtFld.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        thirdTxtFld.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        fourthTxtFld.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        
        fifthTxtFld.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        
        sixThTxtFld.addTarget(self, action:#selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text
        //        if text?.utf16. count ?? 0 >= 1{
        if let otpCode = textField.text ,  otpCode.count > 7 {
            firstTxtFld.text = String(otpCode[otpCode.startIndex])
            secondTxtFld.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
            thirdTxtFld.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
            fourthTxtFld.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
            fifthTxtFld.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 4)])
            sixThTxtFld.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 5)])
            //txtOtp1.isUserInteractionEnabled = false
            self.view.endEditing(true)
        } else if textField.text?.count ?? 0 == 1 && textField.text?.count ?? 0 < 5 {
            let newLength = text?.count ?? 0
            if !(newLength < 1) {
                switch textField {
                case self.firstTxtFld:
                    self.secondTxtFld.becomeFirstResponder()
                    self.firstTxtFld.text = text
                case self.secondTxtFld:
                    self.thirdTxtFld.becomeFirstResponder()
                    self.secondTxtFld.text = text
                case self.thirdTxtFld:
                    self.fourthTxtFld.becomeFirstResponder()
                    self.thirdTxtFld.text = text
                case self.fourthTxtFld:
                    self.fifthTxtFld.becomeFirstResponder()
                    self.fourthTxtFld.text = text
                case self.fifthTxtFld:
                    self.sixThTxtFld.becomeFirstResponder()
                    self.fifthTxtFld.text = text
                case self.sixThTxtFld:
                    self.sixThTxtFld.becomeFirstResponder()
                    self.sixThTxtFld.text = text
                    
                    self.setOtp = self.firstTxtFld.text! + self.secondTxtFld.text! + self.thirdTxtFld.text! + self.fourthTxtFld.text!
                    
                    self.setOtp = self.setOtp + self.fifthTxtFld.text! + self.sixThTxtFld.text!
                  
                    print("self.setOtp", self.setOtp)
                    
                    if(screenType == "forgotPassword"){
                        
                        print("forgotPasswordscreen")
                        self.callVerifyForgotOTPWebService()
                        
                    }else{
                        print("Not_forgotPasswordscreen")
                    self.callVerifyOTPWebService()
                    }
//                case self.txt5:
//                    self.txt6.becomeFirstResponder()
//                    self.txt5.text = text
//                case self.txt6:
//                    self.txt6.resignFirstResponder()
//                    self.txt6.text = text
//                    if viewmodel.otpvalidation(textfield1: firstTxtFld, textfield2: txt2, textfield3: txt3, textfield4: txt4, textfield5: txt5, textfield6: txt6, vc: self){
//                        concatination()
//                        checkfirebaseOtp()
//                    }
               // case self.txt6:
                   // self.txt6.resignFirstResponder()
                default:
                    break
                }
            }
        }
        else if textField.text?.count ?? 0 == 0 && textField != firstTxtFld{
            switch textField {
            case self.firstTxtFld:
                self.firstTxtFld.becomeFirstResponder()
                self.firstTxtFld.resignFirstResponder()
            case self.secondTxtFld:
                firstTxtFld.becomeFirstResponder()
            case self.thirdTxtFld:
                secondTxtFld.becomeFirstResponder()
            case self.fourthTxtFld:
                self.thirdTxtFld.becomeFirstResponder()
            case self.fifthTxtFld:
                self.fourthTxtFld.becomeFirstResponder()
            case self.sixThTxtFld:
                self.fifthTxtFld.becomeFirstResponder()
//            case self.txt5:
//                self.fourthTxtFld.becomeFirstResponder()
//            case self.txt6:
//                self.txt5.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == firstTxtFld{
            let currentCharacterCount = firstTxtFld.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return true
            }
            let newLength = currentCharacterCount + string.utf16.count - range.length
            return newLength <= 1
        }
        
        if textField == secondTxtFld{
            let currentCharacterCount = secondTxtFld.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return true
            }
            let newLength = currentCharacterCount + string.utf16.count - range.length
            return newLength <= 1
        }
        
        if textField == thirdTxtFld{
            let currentCharacterCount = thirdTxtFld.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return true
            }
            let newLength = currentCharacterCount + string.utf16.count - range.length
            return newLength <= 1
        }
        
        if textField == fourthTxtFld{
            let currentCharacterCount = fourthTxtFld.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return true
            }
            let newLength = currentCharacterCount + string.utf16.count - range.length
            return newLength <= 1
        }
        
        if textField == fifthTxtFld{
            let currentCharacterCount = fifthTxtFld.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return true
            }
            let newLength = currentCharacterCount + string.utf16.count - range.length
            return newLength <= 1
        }
        
        if textField == sixThTxtFld{
            let currentCharacterCount = sixThTxtFld.text?.count ?? 0
            if (range.length + range.location > currentCharacterCount){
                return true
            }
            let newLength = currentCharacterCount + string.utf16.count - range.length
            return newLength <= 1
        }

        return true
    }
    
    func callVerifyOTPWebService() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.verifyOTP)"
            
//            if phone_no.contains("+") {
//                phone_no = phone_no.replacingOccurrences(of: "+", with: "")
//            }
            let parameters = [
                //"email":"\(self.email)",
                "otp":"\(self.setOtp)",
                "phone":"\(newPhoneWithoutC)"
                //"phone":"\(phone_no)"
                //"phone":"\(country_code)\(phone_no)"
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
                                        
                                                let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                                let destinationVC = storyBoard.instantiateViewController(withIdentifier: "SetPinVC") as! SetPinVC
                                                destinationVC.birthdate = self.birthdate
                                                destinationVC.email = self.email
                                                //destinationVC.phone_no = "\(self.country_code)\(self.phone_no)"
                                        destinationVC.phone_no = "\(self.onlyPhone)"
                                        destinationVC.newPhoneWithoutC = self.newPhoneWithoutC
                                                destinationVC.password = self.password
                                                destinationVC.userType = UserModel.sharedInstance().userType!
                                        destinationVC.accept_terms = self.accept_terms
                                                destinationVC.userName = self.userName
                                        destinationVC.country_code = self.country_code
                                                destinationVC.genreIds = self.genreIds
                                        self.navigationController?.pushViewController(destinationVC, animated: false)
                                        
                                        
                                    }else {
                                        Loader.shared.hide()
//                                        self.view.makeToast(verifyOtpModel.message)
                                        self.view.makeToast("Incorrect Code, Please try again")
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
    
    
    func callVerifyForgotOTPWebService() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.forgotVerifyOtpAPI)"
            
            let parameters = [
                "otp":"\(self.setOtp)",
                "email":emailStr
                
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
                                       
                                        
                                        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                                        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "CreatePaswordNewVC") as! CreatePaswordNewVC
                                        desiredViewController.emailStr = self.emailStr
                                        self.navigationController?.pushViewController(desiredViewController, animated: false)
                                        
                                        
                                    }else {
                                        Loader.shared.hide()
                                        self.view.makeToast("Incorrect Code, Please try again")
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
    
    @IBAction func resendCodeBtnTapped(_ sender: Any) {
        
        if(screenType == "forgotPassword"){
            
            print("forgotPasswordscreen")
            self.callForgotPasswordService()
            
        }else{
            print("Not_forgotPasswordscreen")
            self.callOtpService()
        }

        firstTxtFld.text = ""
        secondTxtFld.text = ""
        thirdTxtFld.text = ""
        fourthTxtFld.text = ""
        fifthTxtFld.text = ""
        sixThTxtFld.text = ""
        self.firstTxtFld.becomeFirstResponder()
//        resendCodeVw.isHidden = false
        
    }
    
    //MARK: - WEBSERVICES
    func callForgotPasswordService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.forgotPwdAPI)"
            let parameters = [
                "email":"\(self.emailStr)",
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
                        globalObjects.shared.forgotEmail = self.emailStr
                        
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
    
    @IBAction func okBtnTapped(_ sender: Any) {
        resendCodeVw.isHidden = true
    }
    
    func callOtpService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.sendOtpAPI)"
            
            let parameters = [
                "phone_number":newPhoneWithoutC]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SendOtpModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let otpModel = response.result.value!
                                    if otpModel.success == 1{
                                        self.view.makeToast(otpModel.message)
                                        //self.resendCodeVw.isHidden = true
                                        self.resendCodeVw.isHidden = false

                                    }else{
                                        Loader.shared.hide()
                                        self.view.makeToast(otpModel.message)
                                    }
                                case .failure(let error):
                                    Loader.shared.hide()
                                    debugPrint(error)
                                    self.view.makeToast("Not able to send otp. Try again later. Phone number not found")
                                    print("Error")
                                }
                              }
        }else{
            print("Please check your Internet Connection.")
        }
    }
    
    @IBAction func submiyBtnTapped(_ sender: Any) {
        
        if(firstTxtFld.text == "" || secondTxtFld.text == "" || thirdTxtFld.text == "" || fourthTxtFld.text == "" || fifthTxtFld.text == "" || sixThTxtFld.text == ""){
            self.view.makeToast("Enter valid OTP")
        }else{
            if(screenType == "forgotPassword"){
                
                print("forgotPasswordscreen")
                self.callVerifyForgotOTPWebService()
            }else{
                print("Not_forgotPasswordscreen")
            self.callVerifyOTPWebService()
            }
            //self.callVerifyOTPWebService()
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
