//
//  ChangePinVC.swift
//  DJConnect
//
//  Created by mac on 12/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class ChangePinVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var txtPin1: UITextField!
    @IBOutlet weak var txtPin2: UITextField!
    @IBOutlet weak var txtPin3: UITextField!
    @IBOutlet weak var txtPin4: UITextField!
    @IBOutlet weak var btnNext1: UIButton!
    @IBOutlet weak var btnNext2: UIButton!
    @IBOutlet weak var btnNext3: UIButton!
    @IBOutlet weak var lblPinAck1: UILabel!
    @IBOutlet weak var lblPinAck2: UILabel!
    @IBOutlet weak var lbl1: labelProperties!
    @IBOutlet weak var lbl2: labelProperties!
    @IBOutlet weak var lbl3: labelProperties!
    @IBOutlet weak var lbl4: labelProperties!
    
    //MARK: - GLOBAL VARIABLES
    var pin1 = String()
    var pin2 = String()
    var pin3 = String()
    var pin4 = String()
    var currentPin = String()
    var newPin = Int()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - ACTIONS
    @IBAction func btnNext1_Action(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == false && txtPin2.text?.isEmpty == false && txtPin3.text?.isEmpty == false && txtPin4.text?.isEmpty == false{
            pin1 = txtPin1.text!
            txtPin1.text?.removeAll()
            pin2 = txtPin2.text!
            txtPin2.text?.removeAll()
            pin3 = txtPin3.text!
            txtPin3.text?.removeAll()
            pin4 = txtPin4.text!
            txtPin4.text?.removeAll()
            currentPin = "\(pin1)\(pin2)\(pin3)\(pin4)"
            print("CURRENT PIN - \(currentPin)")
            if UserModel.sharedInstance().userPin != "\(currentPin)"{
                self.view.makeToast("Please enter correct current pin")
                return
            }
            lbl1.backgroundColor = .clear
            lbl2.backgroundColor = .clear
            lbl3.backgroundColor = .clear
            lbl4.backgroundColor = .clear
            lblPinAck1.text = "Create a PIN"
            btnNext2.isHidden = false
            btnNext1.isHidden = true
            btnNext3.isHidden = true
            pin1 = ""
            pin2 = ""
            pin3 = ""
            pin4 = ""
            
        }else{
            self.view.makeToast("Please enter your pin")
        }
        
    }
    
    @IBAction func btnNext2_Action(_ sender: UIButton) {
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
            lblPinAck1.text = "Confirm your PIN"
            lblPinAck2.isHidden = false
            lblPinAck2.text = "Re-enter pin to confirm"
            btnNext2.isHidden = true
            btnNext1.isHidden = true
            btnNext3.isHidden = false
        }else{
            self.view.makeToast("Please enter your confirm pin")
        }
    }
    
    @IBAction func btnNext3_Action(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == false && txtPin2.text?.isEmpty == false && txtPin3.text?.isEmpty == false && txtPin4.text?.isEmpty == false{
            
            if pin1 == txtPin1.text && pin2 == txtPin2.text && pin3 == txtPin3.text && pin4 == txtPin4.text{
                let pin = pin1 + pin2 + pin3 + pin4
                newPin = Int(pin)!
                print("PIN = \(newPin)")
                print("MATCHED")
                callUpdateUsernamePwdWebService()
            }else{
                lblPinAck1.isHidden = true
                lblPinAck2.text = "The PIN number you entered did not match."
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
    }
    
    @IBAction func btnNumberPadAction(_ sender: UIButton) {
        if txtPin1.text?.isEmpty == true{
            txtPin1.text = "\(sender.tag)"
            lbl1.backgroundColor = .white
        }else if txtPin2.text?.isEmpty == true{
            txtPin2.text = "\(sender.tag)"
            lbl2.backgroundColor = .white
        }else if txtPin3.text?.isEmpty == true{
            txtPin3.text = "\(sender.tag)"
            lbl3.backgroundColor = .white
        }else if txtPin4.text?.isEmpty == true{
            txtPin4.text = "\(sender.tag)"
            lbl4.backgroundColor = .white
        }else{
            
        }
    }
    @IBAction func btnClear_Action(_ sender: UIButton) {
        txtPin1.text = ""
        txtPin2.text = ""
        txtPin3.text = ""
        txtPin4.text = ""
        lbl1.backgroundColor = .clear
        lbl2.backgroundColor = .clear
        lbl3.backgroundColor = .clear
        lbl4.backgroundColor = .clear
    }
    
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        lbl1.backgroundColor = .clear
        lbl2.backgroundColor = .clear
        lbl3.backgroundColor = .clear
        lbl4.backgroundColor = .clear
        txtPin1.text?.removeAll()
        txtPin2.text?.removeAll()
        txtPin3.text?.removeAll()
        txtPin4.text?.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - WEBSERVICES
    func callUpdateUsernamePwdWebService()
    {
        if getReachabilityStatus(){
            let parameters = [
                "email":"",
                "password":"",
                "current_password":"",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "current_pin":"\(currentPin)",
                "new_pin":"\(newPin)",
                "edit_type":"pin"
            ]
            
            print("parameters creat pin", parameters)
            Loader.shared.show()
            
            print("createPInApi:", Alamofire.request(getServiceURL("\(webservice.url)\(webservice.updateUserPassAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil))
            
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.updateUserPassAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let updateModel = response.result.value!
                    if updateModel.success == 1{
                        UserModel.sharedInstance().userPin = String(self.newPin)
                        UserModel.sharedInstance().synchroniseData()
                        self.view.makeToast(updateModel.message)
                        self.txtPin1.text?.removeAll()
                        self.txtPin2.text?.removeAll()
                        self.txtPin3.text?.removeAll()
                        self.txtPin4.text?.removeAll()
                        self.lbl1.backgroundColor = .clear
                        self.lbl2.backgroundColor = .clear
                        self.lbl3.backgroundColor = .clear
                        self.lbl4.backgroundColor = .clear
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(updateModel.message)
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
