//
//  FacebookGoogleDetailVC.swift
//  DJConnect
//
//  Created by mac on 08/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ADCountryPicker
import Alamofire

class FacebookGoogleDetailVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var vwPhoneEmail: UIView!
    @IBOutlet weak var vwVerifyPhone: UIView!
    @IBOutlet weak var txfPhoneNo: textFieldProperties!
    @IBOutlet weak var txfOTP: textFieldProperties!
    @IBOutlet weak var txtfCountryCode: UITextField!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var vwGenre: UIView!
    @IBOutlet weak var txtGenre: textFieldProperties!
    
    //MARK: - GLOBAL VARIABLES
    var dictFB = [String : String]()
    var dictG = [String : String]()
    var dictApple = [String : String]()
    let picker = ADCountryPicker(style: .grouped)
    var country_code = String()
    var registerType = String()
    var emailString = String()
    var genreNames = ""
    var genreIds = ""
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        txtfCountryCode.text = "+91"
        country_code = "INR"
        picker.showFlags = true
        picker.showCallingCodes = true
        picker.pickerTitle = "Select a Country"
        picker.defaultCountryCode = "US"
        picker.forceDefaultCountryCode = true
        picker.alphabetScrollBarTintColor = UIColor.black
        picker.alphabetScrollBarBackgroundColor = UIColor.clear
        picker.closeButtonTintColor = UIColor.black
        picker.font = UIFont.systemFont(ofSize: 15)
        picker.flagHeight = 40
        picker.hidesNavigationBarWhenPresentingSearch = true
        picker.searchBarBackgroundColor = UIColor.lightGray
        
        if UserModel.sharedInstance().userType == "DJ"{
            self.imgBack.image = UIImage(named: "LoginBack_DJ")
            self.lblWelcome.text = "Welcome DJ!"
        }else{
            self.imgBack.image = UIImage(named: "LoginBack_AR")
            self.lblWelcome.text = "Welcome Artist!"
        }
        txtGenre.delegate = self 
        self.vwGenre.isHidden = false
        self.vwPhoneEmail.isHidden = true
        self.vwVerifyPhone.isHidden = true
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
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        vwGenre.addGestureRecognizer(tap)

        
        NotificationCenter.default.addObserver(self, selector: #selector(setGenre(_:)), name: NSNotification.Name(rawValue: "setGenreFromFGDetails"), object: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        
        let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GerneSelectorVC") as! GerneSelectorVC
        desiredViewController.oldSelectedIds = self.genreIds
        desiredViewController.notificationName = "setGenreFromFGDetails"
        desiredViewController.view.frame = (self.view.bounds)
        self.view.addSubview(desiredViewController.view)
        self.addChild(desiredViewController)
        desiredViewController.didMove(toParent: self)
    }
    //MARK: - ACTIONS
    @IBAction func btnNextAction(_ sender: UIButton) {
        if !self.vwGenre.isHidden {
            if txtGenre.text == ""{
                self.view.makeToast("Please Genre".localize)
                return
            }
            else{
                self.vwGenre.isHidden = true
                if(registerType == "apple"){
                    
                    UserModel.sharedInstance().isSignup = true
                    UserModel.sharedInstance().isSkip = false
                    UserModel.sharedInstance().paymentPopup = false
                    UserModel.sharedInstance().finishPopup = false
                    UserModel.sharedInstance().synchroniseData()
                    self.performSegue(withIdentifier: "segueFbPin", sender: nil)
                }
                else{
                    self.vwPhoneEmail.isHidden = false
                    self.vwVerifyPhone.isHidden = true
                }
                
            }
        }
        else if self.vwVerifyPhone.isHidden{
            if registerType == "gmail"{
                if dictG["email"]?.isEmpty == true{
                    validateDetails()
                }else{
                    let isValidated = (txfPhoneNo.text?.validPhoneNumber)!
                    if txfPhoneNo.text?.isEmpty == true{
                        self.view.makeToast("Enter Phone Number")
                    }else if !isValidated {
                        self.view.makeToast("Please Enter Valid Phone Number".localize)
                    }else{
                        callPhoneExistWebService()
                    }
                }
            }
            else if registerType == "apple" {
//                if dictApple["email"]?.isEmpty == true{
//                    validateDetails()
//                }else{
//                    let isValidated = (txfPhoneNo.text?.validPhoneNumber)!
//                    if txfPhoneNo.text?.isEmpty == true{
//                        self.view.makeToast("Enter Phone Number")
//                    }else if !isValidated {
//                        self.view.makeToast("Please Enter Valid Phone Number".localize)
//                    }else{
//                        callPhoneExistWebService()
//                    }
//                }
                UserModel.sharedInstance().isSignup = true
                UserModel.sharedInstance().isSkip = false
                UserModel.sharedInstance().paymentPopup = false
                UserModel.sharedInstance().finishPopup = false
                UserModel.sharedInstance().synchroniseData()
                self.performSegue(withIdentifier: "segueFbPin", sender: nil)
            }
            else{
                validateDetails()
            }
        }
        else{
            if(registerType == "apple"){
                UserModel.sharedInstance().isSignup = true
                UserModel.sharedInstance().isSkip = false
                UserModel.sharedInstance().paymentPopup = false
                UserModel.sharedInstance().finishPopup = false
                UserModel.sharedInstance().synchroniseData()
                self.performSegue(withIdentifier: "segueFbPin", sender: nil)
            }
            else{
                if txfOTP.text != ""{
                    callVerifyOTPWebService()
                }
            }
            
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        if !self.vwGenre.isHidden {
            ChangeRoot()
        }else if self.vwVerifyPhone.isHidden{
            self.vwGenre.isHidden = false
            self.vwPhoneEmail.isHidden = true
            self.vwVerifyPhone.isHidden = true
        }else{
            self.vwGenre.isHidden = true
            self.vwPhoneEmail.isHidden = false
            self.vwVerifyPhone.isHidden = true
        }
    }
    
    @IBAction func btnChooseCountryCodeAction(_ sender: UIButton) {
        let picker = ADCountryPicker(style: .grouped)
        picker.didSelectCountryWithCallingCodeClosure = { name, code, dialCode in
            self.country_code = code
            picker.dismiss(animated: true, completion: {
                self.txtfCountryCode.text = dialCode
            })
        }
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: - OTHER METHODS
    func validateDetails(){
        let isValidated = ((txfPhoneNo.text?.validPhoneNumber) != nil)
        if txfPhoneNo.text == ""{
            self.view.makeToast("Please Enter Phone Number".localize)
        }else if !isValidated {
            self.view.makeToast("Please Enter Valid Phone Number".localize)
            
        }else{
            callEmailPhoneExistWebService()
        }
    }
    
    @objc func setGenre(_ notification: NSNotification) {
        guard let names = notification.userInfo?["names"] as? String else { return }
        guard let ids = notification.userInfo?["ids"] as? String else { return }
        self.genreNames = names
        self.genreIds = ids
        self.txtGenre.text = self.genreNames
    }
    
    func ChangeRoot() {
//        let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SignUp") as! UINavigationController
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
        let navigationController = UINavigationController(rootViewController: nextViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFbPin"{
            let destinationVC = segue.destination as! SetPinVC
            
            destinationVC.genreIds = self.genreIds
            if registerType == "facebook"{
                destinationVC.registerType = "facebook"
                destinationVC.phone_no = "\(txtfCountryCode.text!)\(txfPhoneNo.text!)"
                destinationVC.country_code = country_code
                //                destinationVC.email = txfEmail.text!
            }
            if registerType == "gmail"{
                destinationVC.registerType = "gmail"
                destinationVC.phone_no = "\(txtfCountryCode.text!)\(txfPhoneNo.text!)"
                destinationVC.country_code = country_code
                destinationVC.email = "\(emailString)"
            }
            
            if registerType == "apple"{
                destinationVC.registerType = "apple"
                destinationVC.phone_no = ""
                destinationVC.country_code = country_code ?? ""
                destinationVC.email = "\(emailString)"
            }
            destinationVC.dictFB = dictFB
            destinationVC.dictG = dictG
            destinationVC.dictApp = dictApple
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
            let parameters = [
                "email":"\(emailString)",
                "username":usernameSt,
                "contactno":"\(self.txtfCountryCode.text ?? "")\(txfPhoneNo.text ?? "")"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let checkMailModel = response.result.value!
                                    if checkMailModel.success == 1{
                                        self.callOtpService()
//                                        self.vwVerifyPhone.isHidden = false
//                                        self.vwPhoneEmail.isHidden = true
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
    
    func callPhoneExistWebService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.checkEmailAPI)"
            let parameters = [
                "email":"\(emailString)",
                "contactno":"\(self.txtfCountryCode.text!)\(txfPhoneNo.text!)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post
                              , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                                switch response.result{
                                case .success(_):
                                    Loader.shared.hide()
                                    let checkPhoneModel = response.result.value!
                                    if checkPhoneModel.success == 1{
                                        self.callOtpService()
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
    
    func callOtpService(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.sendOtpAPI)"
            let tempContryCd = txtfCountryCode.text!
            let getNo = self.txfPhoneNo.text!
            var newPhoneNmbr = ""
            if getNo.contains(tempContryCd) {
                newPhoneNmbr = getNo.replacingOccurrences(of: tempContryCd, with: "")
                print("newPhoneNmbr",newPhoneNmbr)
            }
            else{
                newPhoneNmbr = self.txfPhoneNo.text!
                print("newPhoneNmbr2",newPhoneNmbr)
            }
            let parameters = [
//                "phone_number":"\(self.txtfCountryCode.text!)\(self.txfPhoneNo.text!)"]
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
                                        self.vwPhoneEmail.isHidden = true
                                        self.vwVerifyPhone.isHidden = false
                                    }else{
                                        Loader.shared.hide()
                                        self.view.makeToast(otpModel.message)
                                    }
                                case .failure(let error):
                                    Loader.shared.hide()
                                    debugPrint(error)
                                    self.view.makeToast("Server encountered some issue".localize)
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
                "email":"\(self.emailString)",
                "otp":"\(self.txfOTP.text!)",
                "phone":"\(self.txtfCountryCode.text!)\(self.txfPhoneNo.text!)"
            ]
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
                                        self.performSegue(withIdentifier: "segueFbPin", sender: nil)
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
    
}

//MARK: - EXTENSIONS
extension FacebookGoogleDetailVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == txtGenre{
            let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GerneSelectorVC") as! GerneSelectorVC
            desiredViewController.oldSelectedIds = self.genreIds
            desiredViewController.notificationName = "setGenreFromFGDetails"
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
        if textField == txfPhoneNo{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            } else if textField.text!.count > 14 {
                return false
            }
        }
        return true
    }
}

