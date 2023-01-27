//
//  FinancialSecondViewController.swift
//  DJConnect
//
//  Created by Techugo on 24/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Stripe
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import AlamofireObjectMapper
import CryptoSwift
import JMMaskTextField_Swift

class FinancialSecondViewController: UIViewController {
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .dark)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.5)
//            customBlurEffectView.frame = self.view.bounds
        customBlurEffectView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 810)
        
            // 3. create semi-transparent black view
            let dimmedView = UIView()
        //dimmedView.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).withAlphaComponent(0.5)
            dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
//            dimmedView.frame = self.view.bounds
        //dimmedView.frame = self.view.bounds
        dimmedView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 810)
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
    @IBOutlet weak var scrollBgVw: UIView!
    
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var profileImgBgVw: UIView!
    @IBOutlet weak var proImgVw: UIImageView!
    @IBOutlet weak var cashVw: UIView!
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var creditNameVw: UIView!
    @IBOutlet weak var creditNameTxtFld: UITextField!
    @IBOutlet weak var cardNmbrVw: UIView!
    //@IBOutlet weak var cardNmbrTxtFld: UITextField!
    
    @IBOutlet weak var cardNmbrTxtFld: textFieldProperties!
    
    
    @IBOutlet weak var expirationVw: UIView!
    
    @IBOutlet weak var expirtnTxtFld: textFieldProperties!
    
    @IBOutlet weak var codeVw: UIView!
    @IBOutlet weak var codeTxtFld: UITextField!
    @IBOutlet weak var processPaymntBtn: UIButton!
    
    @IBOutlet weak var financialAmountLbl: UILabel!
    @IBOutlet weak var pendingAmountLbl: UILabel!
    
    var getFinancialAmntStr = ""
    var getPendingAmntStr = ""
    var getAddedAmntStr = ""
    var connectCashAmountStr = String()
    
    enum ExpiryValidation {//For card expiry date validation
        case valid, invalidInput, expired
    }
    
    var api = ""
    
    @IBOutlet weak var conctFrmDjLbl: UILabel!
    var callBackSecondFinancialAmount: ((_ toalAddedamount: Int)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        api = "1"
        creditNameTxtFld.delegate = self
        creditNameTxtFld.returnKeyType = .next
        cardNmbrTxtFld.delegate = self
        expirtnTxtFld.delegate = self
        codeTxtFld.delegate = self
        codeTxtFld.keyboardType = .numberPad
        
            financialAmountLbl.text = getFinancialAmntStr
            pendingAmountLbl.text = getPendingAmntStr
            amountLbl.text = getAddedAmntStr
                
        setUpVw()
    }
    
    func setUpVw(){
        
        bgVw.addSubview(blurredView)
        bgVw.sendSubviewToBack(blurredView)
        bgVw.layer.cornerRadius = 30
        bgVw.clipsToBounds = true
        //bgVw.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        profileImgBgVw.layer.cornerRadius =  profileImgBgVw.frame.size.height/2
        profileImgBgVw.clipsToBounds = true
        
        proImgVw.layer.cornerRadius = proImgVw.frame.size.height/2
        proImgVw.clipsToBounds = true
        
        // theme light pink color
        cashVw.layer.cornerRadius = 10.0
        cashVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        cashVw.layer.borderWidth = 0.5
        cashVw.clipsToBounds = true
        
        creditNameVw.layer.cornerRadius = 10.0
        creditNameVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        creditNameVw.layer.borderWidth = 0.5
        creditNameVw.clipsToBounds = true
        
        cardNmbrVw.layer.cornerRadius = 10.0
        cardNmbrVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        cardNmbrVw.layer.borderWidth = 0.5
        cardNmbrVw.clipsToBounds = true
        
        expirationVw.layer.cornerRadius = 10.0
        expirationVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        expirationVw.layer.borderWidth = 0.5
        expirationVw.clipsToBounds = true
        
        codeVw.layer.cornerRadius = 10.0
        codeVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        codeVw.layer.borderWidth = 0.5
        codeVw.clipsToBounds = true
        
        
        creditNameTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Name on credit card",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        cardNmbrTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Card Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        expirtnTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Expiration",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        codeTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Code",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        processPaymntBtn.layer.cornerRadius = processPaymntBtn.frame.size.height/2
        processPaymntBtn.clipsToBounds = true
        
    }
    

    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func processPaymntBtnTapped(_ sender: Any) {
        
        creditNameTxtFld.resignFirstResponder()
        cardNmbrTxtFld.resignFirstResponder()
        expirtnTxtFld.resignFirstResponder()
        codeTxtFld.resignFirstResponder()
        getDjStripeToken() // process payment
        
        //for default stripe payment screen opening here
        //goToStripePaymentGateway()
        
    }
    
    func getDjStripeToken(){
        let DjStripeCard = STPCardParams()
        
        if creditNameTxtFld.text?.isEmpty == true{
            self.view.makeToast("Please Enter Name on Card.")
        }else if cardNmbrTxtFld.text?.isEmpty == true{
            self.view.makeToast("Please Enter Card Number.")
        }else if expirtnTxtFld.text?.isEmpty == true{
            self.view.makeToast("Please Enter Card Expiry details.")
        }else if codeTxtFld.text?.isEmpty == true{
            self.view.makeToast("Please Enter Code.")
        }else{
            let expirationDate = self.expirtnTxtFld.text?.components(separatedBy: "/")
            if expirationDate?.isEmpty == true{
                self.view.makeToast("Please Enter Valid Expiry date Format.")
            }else{
                let expMonth = Int(expirationDate![0])
                let expYear = Int(expirationDate![1])
                let _date = validateCardExpiry("\(self.expirtnTxtFld.text!)")
                if _date == .expired{
                    self.view.makeToast("Card is Expired. Please try other Card")
                    return
                }else if _date == .invalidInput{
                    self.view.makeToast("Card Expiry Date is Invalid.")
                    return
                }
                Loader.shared.show()
                let mask = JMStringMask(mask: "0000 0000 0000 0000")
                let cardNo = mask.unmask(string: cardNmbrTxtFld.text!)
                DjStripeCard.number = cardNo
                DjStripeCard.currency = UserModel.sharedInstance().currency_code!
                DjStripeCard.cvc = codeTxtFld.text!
                //DjStripeCard.cvc = "333"
                DjStripeCard.name = creditNameTxtFld.text!
                DjStripeCard.expMonth = UInt(expMonth!)
                DjStripeCard.expYear = UInt(expYear!)
                
                STPAPIClient.shared().createToken(withCard: DjStripeCard, completion: { (token, error) -> Void in
                    Loader.shared.hide()
                    if error != nil {
                        
                        self.handleError(error: error! as NSError)
                        self.view.makeToast("Your card's number is invalid")
                        return
                    }
                    
                    print("stripeToken",token!)
                    if token == nil{
                        self.view.makeToast("Stripe Token generation failure")
                    }else{

                        self.callStripePaymentWebService(token: "\(token!)", amt: self.getAddedAmntStr)
                    }
                })
            }
        }
    }
    
    func handleError(error: NSError) {
        print(error)
    }
    
    func validateCardExpiry(_ input: String) -> ExpiryValidation {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YY"
        guard let enteredDate = dateFormatter.date(from: input) else {
            return .invalidInput
        }
        let calendar = Calendar.current
        let components = Set([Calendar.Component.month, Calendar.Component.year])
        let currentDateComponents = calendar.dateComponents(components, from: Date())
        let enteredDateComponents = calendar.dateComponents(components, from: enteredDate)
        guard let eMonth = enteredDateComponents.month, let eYear = enteredDateComponents.year, let cMonth = currentDateComponents.month, let cYear = currentDateComponents.year, eMonth >= cMonth, eYear >= cYear else {
            return .expired
        }
        return .valid
    }
    
    func callStripePaymentWebService(token: String, amt: String){
        // also delete dj card details
        if getReachabilityStatus(){
            let parameters = [
                "user_id":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "stripeyoken":"\(token)",
                "email":"\(UserModel.sharedInstance().email ?? "")",
                "amount":"\(amt)",
                "userid":"\(UserModel.sharedInstance().userId!)", // comment while run on dev build
                "currency":"\(UserModel.sharedInstance().currency_code!)"
            ]
           
            Loader.shared.show()
            
            Alamofire.request(getServiceURL(webservice.stripePaymentAPI), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<StripeModel>) in
                print(response)
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let stripeModel = response.result.value!
                    if stripeModel.success == 1{
                        self.view.makeToast(stripeModel.message)
                        self.creditNameTxtFld.text?.removeAll()
                        self.expirtnTxtFld.text?.removeAll()
                        self.codeTxtFld.text?.removeAll()
                       /// if (stripeModel.transaction_id != nil){
                            print("stripeModel.transaction_id",stripeModel.transaction_id)
                        self.callpurchaseCreditWebService(trans_id: stripeModel.transaction_id ?? "")
                        //}
                    }else{
                        Loader.shared.hide()
                        self.creditNameTxtFld.text?.removeAll()
                        self.expirtnTxtFld.text?.removeAll()
                        self.codeTxtFld.text?.removeAll()
                        self.view.makeToast(stripeModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    self.creditNameTxtFld.text?.removeAll()
                    self.expirtnTxtFld.text?.removeAll()
                    self.codeTxtFld.text?.removeAll()
                    self.view.makeToast("Error, Please try again")
                    debugPrint(error)
                    print("Error")
                }
            }
        }
            else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    
    func callpurchaseCreditWebService(trans_id: String){
        if getReachabilityStatus(){
            var acc = String()
            if UserModel.sharedInstance().userType == "AR"{
                acc = cardNmbrTxtFld.text!
            }else{
                acc = cardNmbrTxtFld.text!
            }
            var acc_no = String()
            acc_no = acc.description.replacingOccurrences(of: " ", with: "")
            print(acc_no)
            acc_no = CommonFunctions.encryptValue(value: "\(acc_no)")
            print("ENCRYPTED ACC_NO - \(acc_no)")
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "transction_id":"\(trans_id)",
                "amount":getAddedAmntStr,
                "account_no":"\(acc_no)"
            ]
            
            print(parameters)
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.purchaseCreditslAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let purchaseCreditModel = response.result.value!
                    if purchaseCreditModel.success == 1{
                        self.view.makeToast(purchaseCreditModel.message)
                        if UserModel.sharedInstance().userType! == "DJ"{
                            
                            self.connectCashAmountStr.removeAll()
                        }else{

                            self.connectCashAmountStr = "0"
                        }
//                        self.numberArrayCleaned.removeAll()
//                        self.numberArray.removeAll()
                        self.CallGetCreditsWebService()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(purchaseCreditModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func CallGetCreditsWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getCurrentCreditsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    if let jsonData = response.result.value as? [String: AnyObject]{
                        print(jsonData)
                        if jsonData["success"]! as! NSNumber == 1{
                            
                            let formatter = NumberFormatter()
                            formatter.groupingSeparator = "," // or possibly "." / ","
                            formatter.numberStyle = .decimal
                            
                            if let x = (jsonData["total_current_credit"] as? String){
                                if UserModel.sharedInstance().userType == "DJ"{
                                    
                                   // self.lblDjCurrentBalance.text = self.lblDjCurrencySymbol.text! + "\(x)"
                                }else{
                                    
                                   // self.lblArCurrentBalance.text = self.lblArCurrencySymbol.text! + "\(x)"
                                }
                            }
                            NotificationCenter.default.post(name: NSNotification.Name("Test12"), object: self, userInfo: ["name": "Webkul"])
                            if let y = (jsonData["total_pedding_credit"] as? String){
                                var value : String?
                                value = y
                                if value!.contains("-") {
                                    value = y.replacingOccurrences(of: "-", with: "")
                                    print("value",value!)
                                }
                                if value!.contains("+") {
                                    value = y.replacingOccurrences(of: "+", with: "")
                                    print("value",value!)
                                }
                                if UserModel.sharedInstance().userType == "DJ"{
                                
                                    if value == "0"{
                                       // self.lblDjPendingBalance.text = ""
                                    }else{
                                        
                                       // self.lblDjPendingBalance.text = " (" + UserModel.sharedInstance().userCurrency! + " \(value!))"
                                        
                                    }
                                }else{
                                    ///
                                    if value == "0"{
                                       // self.lblArPendingBalance.text = ""
                                    }else{

                                        //self.lblArPendingBalance.text =  " (" + UserModel.sharedInstance().userCurrency! + " \(value!))"
                                    }
                                }
                            }
                            if let call = self.callBackSecondFinancialAmount{
                                self.navigationController?.popViewController(animated: false)
                            }
                            self.navigationController?.popViewController(animated: false)
                        }else{
                            Loader.shared.hide()
                            self.view.makeToast("There is some issue loading current credit.")
                        }
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
            )}else{
                self.view.makeToast("Please check your Internet Connection")
            }
    }
    
    // for default stripe payment screen opening here
//    private func makePaymentRequest(stripeToken: String = "") {
//            self.requestToMakePayment(stripeToken: stripeToken)
//        }
//
//    func requestToMakePayment(stripeToken:String)
//       {
//        callStripePaymentWebService(token: stripeToken, amt: self.getAddedAmntStr)
//        }
}

extension FinancialSecondViewController: UITextFieldDelegate{

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == cardNmbrTxtFld {
        if string.count == 0 {
            if textField.text!.count != 0 {
                return true
            }
        } else if textField.text!.count > 18 {
            return false
        }
    }
    if textField == expirtnTxtFld{
        if string.count == 0 {
            if textField.text!.count != 0 {
                return true
            }
        } else if textField.text!.count > 5 {
            return false
        }
    }
    if textField == codeTxtFld {
        if string.count == 0 {
            if textField.text!.count != 0 {
                return true
            }
        } else if textField.text!.count > 3 {
            return false
        }
    }
    

    return true
}
}

 //for default stripe payment screen opening here
//extension FinancialSecondViewController: STPAddCardViewControllerDelegate {
//    func goToStripePaymentGateway() {
//            let config = STPPaymentConfiguration.shared()
//            config.requiredBillingAddressFields = .full
//            let addCardViewController = STPAddCardViewController(configuration: config, theme: STPTheme.default())
//            addCardViewController.delegate = self
//            let navigationController = UINavigationController(rootViewController: addCardViewController)
//            self.present(navigationController, animated: true, completion: nil)
//
//        }
//
//        func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//            dismiss(animated: true, completion: nil)
//        }
//
//        func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
//            let token = "\(token.tokenId)"
//            print("Stripe Token=====\(token)")
//            dismiss(animated: true) {
//                //let a = STPBankAccount.ban
//            self.makePaymentRequest(stripeToken: token)
//            }
//
//        }
//        func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
//            print("Did Create Payment Method")
//        }
//}
