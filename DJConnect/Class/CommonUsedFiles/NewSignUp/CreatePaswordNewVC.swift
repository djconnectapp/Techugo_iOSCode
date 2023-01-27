//
//  CreatePaswordNewVC.swift
//  DJConnect
//
//  Created by Techugo on 10/10/22.
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


class CreatePaswordNewVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var hedrChangePaswrdLbl: UILabel!
    @IBOutlet weak var newPaswordVw: UIView!
    @IBOutlet weak var rePasswordVw: UIView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var newPaswordTxtFld: UITextField!
    @IBOutlet weak var rePaswordTxtFld: UITextField!
    
    
    @IBOutlet weak var newPaswrdImgVw: UIImageView!
    @IBOutlet weak var newPaswordHideShowBtn: UIButton!
    
    @IBOutlet weak var rePaswrdImgVw: UIImageView!
    @IBOutlet weak var rePaswordHideShowBtn: UIButton!
    
    @IBOutlet weak var updatePaswrdBtn: UIButton!
    var emailStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVw()
    }
    
    func setUpVw(){
         
        // theme pink color
        newPaswordVw.layer.cornerRadius = 10.0
        newPaswordVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
        newPaswordVw.layer.borderWidth = 0.5
        newPaswordVw.clipsToBounds = true
        
        newPaswordTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Enter new password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        // theme light pink color
        rePasswordVw.layer.cornerRadius = 10.0
        rePasswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        rePasswordVw.layer.borderWidth = 0.5
        rePasswordVw.clipsToBounds = true
        
        rePaswordTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Re-Enter new password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )

        updatePaswrdBtn.layer.cornerRadius = updatePaswrdBtn.frame.size.height/2
        updatePaswrdBtn.clipsToBounds = true
        
       
        newPaswordTxtFld.text = ""
        newPaswordTxtFld.delegate = self
        newPaswordTxtFld.isSecureTextEntry = true;
        
        rePaswordTxtFld.text = ""
        rePaswordTxtFld.delegate = self
        rePaswordTxtFld.isSecureTextEntry = true;
        
        newPaswordHideShowBtn.setTitle("", for: .normal)
        let myImageName = "Hide"
                 let myImage = UIImage(named: myImageName)
        newPaswrdImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
        newPaswrdImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        rePaswordHideShowBtn.setTitle("", for: .normal)
        let reImageName = "Hide"
                 let reImage = UIImage(named: reImageName)
        rePaswrdImgVw.image = reImage?.withRenderingMode(.alwaysTemplate)
        rePaswrdImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == newPaswordTxtFld {
            // theme pink color
            newPaswordVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            rePasswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            
            return true
        }
        
        else {
            
            newPaswordVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
            rePasswordVw.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
            
            
            return true
            
        }

    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func updatePaswordBtnTapped(_ sender: Any) {
        
            if newPaswordTxtFld.text?.isEmpty == true{
            self.view.makeToast("Please Enter new password".localize)
        }else if rePaswordTxtFld.text?.isEmpty == true{
            self.view.makeToast("Please Enter confirm password".localize)
        }else{
            let enteredPwd = newPaswordTxtFld.text
            let validPwdBool = validatePassword(password: enteredPwd!)
            
            let enteredConfirmPwd = rePaswordTxtFld.text
            let validConfirmPwdBool = validateConfirmPassword(_Pwd: enteredPwd!, _cPwd: enteredConfirmPwd!)
            if enteredPwd?.isEmpty == true || validPwdBool == false {
                self.view.makeToast("Enter password of length 6-18 characters.".localize)
            }else if enteredConfirmPwd?.isEmpty == true || validConfirmPwdBool == false{
                self.view.makeToast("Password and Confirm password doesnot match".localize)
            }
            else {
                
                self.callChangePaswordApi()
               
            }
        }
        
       
    }
    
    
    @IBAction func newPaswordHideShowBtnTapped(_ sender: Any) {
        newPaswrdImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        if(newPaswordTxtFld.isSecureTextEntry == true){
            let myImageName = "eye"
            let myImage = UIImage(named: myImageName)
            newPaswrdImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
            newPaswordTxtFld.isSecureTextEntry                   = false;
        }
        else{
            let myImageName = "Hide"
            let myImage = UIImage(named: myImageName)
            newPaswrdImgVw.image = myImage?.withRenderingMode(.alwaysTemplate)
            newPaswordTxtFld.isSecureTextEntry                   = true;
        }
    }
    
    @IBAction func rePaswordHideShowBtnTapped(_ sender: Any) {
        
        rePaswrdImgVw.tintColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        if(rePaswordTxtFld.isSecureTextEntry == true){
            let myImageName1 = "eye"
            let myImage1 = UIImage(named: myImageName1)
            rePaswrdImgVw.image = myImage1?.withRenderingMode(.alwaysTemplate)
            rePaswordTxtFld.isSecureTextEntry                   = false;
        }
        else{
            let myImageName1 = "Hide"
            let myImage1 = UIImage(named: myImageName1)
            rePaswrdImgVw.image = myImage1?.withRenderingMode(.alwaysTemplate)
            rePaswordTxtFld.isSecureTextEntry                   = true;
        }
    }
    
    //MARK: - WEBSERVICES
    func callChangePaswordApi(){
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.updatePasswordAPI)"
            let parameters = [
                "email":"\(self.emailStr)",
                "password":"\(newPaswordTxtFld.text!)",
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ForgotPasswordModel>) in
                switch response.result{
                case .success(_):
                    Loader.shared.hide()
                    let forgotPasswordModel = response.result.value!
                    if forgotPasswordModel.success == 1{
                        //self.view.makeToast("Success")
                        self.view.makeToast(forgotPasswordModel.message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            // navigate / pop to start screen screen
                            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
                        })
                        
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
}
