//
//  NewForgotPasswordVC.swift
//  DJConnect
//
//  Created by Techugo on 17/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire


class NewForgotPasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forgotPasswordLbl: UILabel!
    @IBOutlet weak var emailVw: UIView!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var verificationDescrLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    
    var email = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVw()
    }
    
    func setUpVw(){
         
        emailVw.layer.cornerRadius = 10.0
        emailVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        emailVw.layer.borderWidth = 0.5
        emailVw.clipsToBounds = true
        
        emailTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Email Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        submitBtn.layer.cornerRadius = submitBtn.frame.size.height/2
        submitBtn.clipsToBounds = true
        
        emailTxtFld.text = ""
        emailTxtFld.delegate = self
        
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
//                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//                            self.navigationController?.popViewController(animated: true)
//                        })
                        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
                        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "VerificationOTPVC") as! VerificationOTPVC
                        desiredViewController.screenType = "forgotPassword"
                        desiredViewController.emailStr = self.emailTxtFld.text!
                        self.navigationController?.pushViewController(desiredViewController, animated: false)
                        
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
    
    @IBAction func submitBtnTapped(_ sender: Any) {
       
        let enteredEmail = emailTxtFld.text ?? ""
        let validateEmailBool = validateEmail(email: enteredEmail)
        if enteredEmail.isEmpty == true || validateEmailBool == false{
            self.view.makeToast("Please enter valid email.".localize)
        }else{
            self.email = enteredEmail
            callForgotPasswordService()
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}
