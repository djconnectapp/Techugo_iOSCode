//
//  FinancialViewController.swift
//  DJConnect
//
//  Created by Techugo on 24/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import AlamofireObjectMapper
import Stripe
import CryptoSwift
import LGSideMenuController
import WebKit

class FinancialViewController: UIViewController,UITextFieldDelegate,UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate {
    
   // WKNavigationDelegate
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .dark)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.5)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
        //dimmedView.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).withAlphaComponent(0.5)
            dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
    
    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var profileImgBgVw: UIView!
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var financialHdrLbl: UILabel!
    @IBOutlet weak var financialLbl: UILabel!
    @IBOutlet weak var financialPendingLbl: UILabel!
    @IBOutlet weak var cashCnctDjLbl: UILabel!
    
    @IBOutlet weak var cashCnctBotmLbl: UILabel!
    @IBOutlet weak var cashTxtFldBgVw: UIView!
    
    @IBOutlet weak var addCashconctTxtFld: UITextField!
    
    @IBOutlet weak var conctCashBotmLineVw: UIView!
    @IBOutlet weak var cashOutBtmLIneVw: UIView!
    
    @IBOutlet weak var dotOneVw: UIView!
    @IBOutlet weak var dotSecondVw: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    //@IBOutlet weak var withdrawWebView: WKWebView!
        
    @IBOutlet weak var withdrawBottomBgVw: UIView!
    @IBOutlet weak var addWithDrawTxtFldBgVw: UIView!
    @IBOutlet weak var addWithdrawTxtFld: UITextField!
    @IBOutlet weak var withdrawPaymntBtn: UIButton!
    @IBOutlet weak var addStripeAcountbtn: UIButton!
        
    @IBOutlet weak var manageAccountBtn: UIButton!
    var currentCurrency = String()
    var screenType = ""
    var callBackFinancialAmount: ((_ toalamount: Int)->Void)?
    var financialTxtStr = ""
    
    var weekDate = String()
    var searchUserType = String()
    var getStripeToken = String()
    var getStripeUrlStr = String()
    var getStripeObjStr = String()
    var getAmountValue = Float()
    var getStripestatus = String()
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 14),
          .foregroundColor: UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1),
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    
    //MARK: - New Stripe Properties
//    var objCheckOutViewModel = StripeCheckoutVwModel()
//    var customerId = ""
//    var ephermalKey = ""
//    var ephermalKeySecret = ""
//    var paymentIntentClientSecret = ""
    //var paymentSheet: PaymentSheet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.objCheckOutViewModel.view = self
       // self.getCustomerList()
        
        manageAccountBtn.isHidden = true
        withdrawBottomBgVw.isHidden = true
        addWithDrawTxtFldBgVw.isHidden = true
        addWithdrawTxtFld.isHidden = true
        withdrawPaymntBtn.isHidden = true
        addStripeAcountbtn.isHidden = true
        
        cashTxtFldBgVw.isHidden = false
        addCashconctTxtFld.isHidden = false
        nextBtn.isHidden = false
        
        conctCashBotmLineVw.isHidden = false
        cashOutBtmLIneVw.isHidden = true
        dotOneVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        dotSecondVw.backgroundColor = .white
        
        addCashconctTxtFld.delegate = self
        addCashconctTxtFld.returnKeyType = .next
        addCashconctTxtFld.keyboardType = .numberPad
        
        addWithdrawTxtFld.delegate = self
        addWithdrawTxtFld.keyboardType = .numberPad
        
        nextBtn.layer.cornerRadius = nextBtn.frame.size.height/2
        nextBtn.clipsToBounds = true
        
        withdrawPaymntBtn.layer.cornerRadius = withdrawPaymntBtn.frame.size.height/2
        withdrawPaymntBtn.clipsToBounds = true
        
        addStripeAcountbtn.layer.cornerRadius = addStripeAcountbtn.frame.size.height/2
        addStripeAcountbtn.clipsToBounds = true
        
        if UserModel.sharedInstance().userType == "DJ" {
            addCashconctTxtFld.text = ""
        }else {
            addCashconctTxtFld.text = ""
        }
        addCashconctTxtFld.text = ""
        addWithdrawTxtFld.text = ""
        setUpVw()
        
        let attributeString = NSMutableAttributedString(
                string: "Manage Account",
                attributes: yourAttributes
             )
        manageAccountBtn.setAttributedTitle(attributeString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        addCashconctTxtFld.text = ""
        addWithdrawTxtFld.text = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        weekDate = formatter.string(from:now)
        NSLog("weekDate", weekDate)
                
        if globalObjects.shared.searchResultUserType?.isEmpty == true || globalObjects.shared.searchResultUserType == nil{
            searchUserType = UserModel.sharedInstance().userType!
        }else{
            searchUserType = globalObjects.shared.searchResultUserType!
        }
        
        callGetProfileWebService()
        
        conctCashBotmLineVw.isHidden = false
        cashOutBtmLIneVw.isHidden = true
        dotOneVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        dotSecondVw.backgroundColor = .white
        
        withdrawBottomBgVw.isHidden = true
        addWithDrawTxtFldBgVw.isHidden = true
        addWithdrawTxtFld.isHidden = true
        withdrawPaymntBtn.isHidden = true
        addStripeAcountbtn.isHidden = true
        
        cashTxtFldBgVw.isHidden = false
        addCashconctTxtFld.isHidden = false
        nextBtn.isHidden = false
                
        CallGetCreditsWebService()
        callCurrencyListWebService()
        
    }
    
    func setUpVw(){
        
        bgVw.addSubview(blurredView)
        bgVw.sendSubviewToBack(blurredView)
        
        bgVw.layer.cornerRadius = 30
        bgVw.clipsToBounds = true
        //bgVw.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                
        profileImgBgVw.layer.cornerRadius =  profileImgBgVw.frame.size.height/2
        profileImgBgVw.backgroundColor =  UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)
        profileImgBgVw.clipsToBounds = true
        
        profileImgVw.layer.cornerRadius = profileImgVw.frame.size.height/2
        profileImgVw.clipsToBounds = true
        
        
        cashTxtFldBgVw.layer.cornerRadius = 10.0
        cashTxtFldBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        cashTxtFldBgVw.layer.borderWidth = 0.5
        cashTxtFldBgVw.clipsToBounds = true
        
        addCashconctTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Add Connect Cash",
                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        addWithDrawTxtFldBgVw.layer.cornerRadius = 10.0
        addWithDrawTxtFldBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        addWithDrawTxtFldBgVw.layer.borderWidth = 0.5
        addWithDrawTxtFldBgVw.clipsToBounds = true
        
        addWithdrawTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Add Withdraw Cash",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        
    }
    
//    private func getCustomerList(){
//        self.objCheckOutViewModel.getCustomerList(){ value in
//            if let customerId = value.data?[0].id {
//                self.customerId = customerId
//            }
//            self.getEphemeralKey()
//        }
//    }
//
//    private func getEphemeralKey(){
//        self.objCheckOutViewModel.getEphemeralKey(customerID: self.customerId){ value in
//            if let id = value.id {
//                self.ephermalKey = id
//            }
//
//            if let secretKey = value.secret {
//                self.ephermalKeySecret = secretKey
//            }
//            self.getPaymentIntent()
//        }
//    }
//
//    private func getPaymentIntent(){
//        self.objCheckOutViewModel.getPaymentIntent(customerID: self.customerId, amount: addCashconctTxtFld.text!, currency: "INR"){ value in
//            if let clientSecret = value.client_secret {
//                self.paymentIntentClientSecret  = clientSecret
//            }
//            self.setPaymentSheet()
//        }
//    }
//
//    private func setPaymentSheet(){
//        STPAPIClient.shared.publishableKey = KeyConstants.stripePublishableKey
//        // MARK: Create a PaymentSheet instance
//        var configuration = PaymentSheet.Configuration()
//        configuration.merchantDisplayName = "Example, Inc."
//        configuration.customer = .init(id: self.customerId, ephemeralKeySecret:self.ephermalKeySecret)
//        configuration.allowsDelayedPaymentMethods = true
//        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: self.paymentIntentClientSecret, configuration: configuration)
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            textField.resignFirstResponder()

        return true
    }
    
    @IBAction func addStripeBtnTapped(_ sender: Any) {
        callAddStripeAccountAPIService()
    }
    @IBAction func withdrawPaymentBtnTapped(_ sender: Any) {

       var withdrawAmnt = Float(addWithdrawTxtFld.text ?? "") ?? 0.0
        var financialAmntVal = Float(self.financialLbl.text ?? "")
        if (financialAmntVal == 0.0 || financialAmntVal == 0){
            self.view.makeToast("Please add some amount")
        }
        else if(withdrawAmnt == 0.0 || withdrawAmnt == 0){
            self.view.makeToast("Please add some amount")
        }
        else if(withdrawAmnt > getAmountValue){
            self.view.makeToast("Your withdraw amount is more than your wallet amount")
        }
        else{
            print("callWithdrawApi")
            callWithdrawAmountService(withdrawAmnt: withdrawAmnt)
        }
    }
    
    func callCurrencyListWebService(){
        
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
            if UserModel.sharedInstance().userType! == "DJ"{
                self.currentCurrency = currencySymbol
            }else{
                self.currentCurrency = currencySymbol
            }
            
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
                                    self.getAmountValue = 0.0
                                    self.getAmountValue = Float(x) ?? 0.0
                                    self.financialLbl.text = self.currentCurrency + "\(x)"
                                }else{
                                  // let totalPrice = Double(String(format: "%.3f", x)) ?? 0.0
                                   //let priceval = String(format: "%.3f",totalPrice)
                                    
                                    self.getAmountValue = 0.0
                                    self.getAmountValue = Float(x) ?? 0.0
                                    self.financialLbl.text = self.currentCurrency + "\(x)"
                                }
                            }
                            if(self.financialTxtStr != self.financialLbl.text && self.financialTxtStr != ""){
                            if let call = self.callBackFinancialAmount{
                                let financialAmnt = Int(self.financialLbl.text ?? "")
                                call(financialAmnt ?? 0)
                                self.navigationController?.popViewController(animated: false)
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
                                        self.financialPendingLbl.text = ""
                                    }else{
                                        
                                        self.financialPendingLbl.text = UserModel.sharedInstance().userCurrency! + "\(value!)" + " Pending"

                                    }
                                }else{
                                    if value == "0"{
                                        self.financialPendingLbl.text = ""
                                    }else{

                                        self.financialPendingLbl.text =  UserModel.sharedInstance().userCurrency! + "\(value!)" + " Pending"
                                    }
                                }
                            }
                        }else{
                            Loader.shared.hide()
                            self.view.makeToast("There is some issue loading current credit.")
//                            if(getProfile.message == "You are not authorised. Please login again."){
//                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                                    self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
//                                })
//
//                            }
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
    
    //MARK: - WEBSERVICES
    func callGetProfileWebService(){
        if getReachabilityStatus(){
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&current_date=\(weekDate)&profileviewid=\(UserModel.sharedInstance().userId!)&profileviewtype=\(searchUserType)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let getProfile = response.result.value!
                    print(getProfile.Profiledata)
                    if getProfile.success == 1{
                        
                        let formatter = NumberFormatter()
                        formatter.groupingSeparator = "," // or possibly "." / ","
                        formatter.numberStyle = .decimal
                        
                        self.getStripeToken = getProfile.Profiledata![0].srtipe_token!
                        self.getStripestatus = getProfile.Profiledata![0].stripe_status ?? ""
                        print("getStripeToken",self.getStripeToken)
                        
                    }else{
                        Loader.shared.hide()
                       // self.view.makeToast(getProfile.message)
                        print("getProfile.message",getProfile.message)
                        if getProfile.success == 0{
                            if(getProfile.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(getProfile.message)
                            }
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
    
    
    //MARK: - WEBSERVICES
    func callAddStripeAccountAPIService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAddStripeAccountAPI)?user_id=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<StripeWebViewModel>) in
                
                switch response.result {
                case .success(_):
                    let getStripeData = response.result.value!
                    print(getStripeData.stripe)
                    if getStripeData.success == 1{
                        Loader.shared.hide()
                        self.getStripeUrlStr = getStripeData.stripe?.url ?? ""
                        self.getStripeObjStr = getStripeData.stripe?.object ?? ""
                        print("getStripeUrlStr",self.getStripeUrlStr)
                        if(self.getStripeUrlStr != ""){
                            if(self.getStripestatus == "1"){
                                // open logged in user stripe account
                                if let url = URL(string: self.getStripeUrlStr) {
                                           UIApplication.shared.open(url)
                                       }
                            }
                            else{
                                // open SignUp user stripe account
                                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
                                let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "AddStripeAccountVC") as! AddStripeAccountVC
                                
                                desiredViewController.getStripeUrlStr = self.getStripeUrlStr
                                desiredViewController.callbackWithdrawSucess = {  getWithdrawStatus in

                                    if(getWithdrawStatus == "withdrawSuccess"){

                                        self.callUpdateStripeStatusWebService()

                                    }
                                    }
                                
                                self.navigationController?.pushViewController(desiredViewController, animated: false)
                            }
                        }
                        
                        Loader.shared.hide()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(getStripeData.message)
                        print("getStripeData.message",getStripeData.message)
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
    
    //MARK: - WEBSERVICES
    func callUpdateStripeStatusWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getupdateStripeStatus)?user_id=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ForgotPasswordModel>) in
                
                switch response.result {
                case .success(_):
                    let getStatus = response.result.value!
                    if getStatus.success == 1{
                        
                        self.view.makeToast("account created successfully")
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast("Something error")
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
    
    
    func callWithdrawAmountService(withdrawAmnt:Float){
        if getReachabilityStatus(){
            let getAmnt = Int(withdrawAmnt)
            Loader.shared.show()
            let requestUrl = "\(webservice.url)\(webservice.getWithdrawAmountAPI)"
            let parameters = [
                "user_id":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "amount":"\(getAmnt)"
            ]
                        
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<WithdrawAmountModel>) in
                
                switch response.result {
                case .success(_):
                    let withdrawModel = response.result.value!
                    if withdrawModel.success == 1{
                        Loader.shared.hide()
                        self.view.makeToast(withdrawModel.message)
                        self.addWithdrawTxtFld.text = ""
                        self.CallGetCreditsWebService()
                        self.callCurrencyListWebService()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(withdrawModel.message)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == addCashconctTxtFld{
//            if txt_search.text == "Where would you like to connect?".localize{
            if addCashconctTxtFld.text != ""{
                addCashconctTxtFld.text = ""
            }
            
        }
       }
    
    @IBAction func conctCashBtntapped(_ sender: Any) {
        conctCashBotmLineVw.isHidden = false
        cashOutBtmLIneVw.isHidden = true
        dotOneVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        dotSecondVw.backgroundColor = .white
        
        withdrawBottomBgVw.isHidden = true
        addWithDrawTxtFldBgVw.isHidden = true
        addWithdrawTxtFld.isHidden = true
        withdrawPaymntBtn.isHidden = true
        addStripeAcountbtn.isHidden = true
        
        cashTxtFldBgVw.isHidden = false
        addCashconctTxtFld.isHidden = false
        nextBtn.isHidden = false
        
    }
    @IBAction func cashOutBtntapped(_ sender: Any) {
        conctCashBotmLineVw.isHidden = true
        cashOutBtmLIneVw.isHidden = false
        dotOneVw.backgroundColor = .white
        dotSecondVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        
        withdrawBottomBgVw.isHidden = false
        //if(getStripeToken == ""){
        if(getStripestatus == "0"){
            manageAccountBtn.isHidden = true
            addWithDrawTxtFldBgVw.isHidden = true
            addWithdrawTxtFld.isHidden = true
            withdrawPaymntBtn.isHidden = true
            addStripeAcountbtn.isHidden = false
        }else{
            manageAccountBtn.isHidden = false
        addWithDrawTxtFldBgVw.isHidden = false
        addWithdrawTxtFld.isHidden = false
        withdrawPaymntBtn.isHidden = false
        addStripeAcountbtn.isHidden = true
        }
        
        cashTxtFldBgVw.isHidden = true
        addCashconctTxtFld.isHidden = true
        nextBtn.isHidden = true
        
    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        if addCashconctTxtFld.text == "0" || addCashconctTxtFld.text == "" {
            self.view.makeToast("Please add amount")
        }
        else{
            let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
            let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "FinancialSecondViewController") as! FinancialSecondViewController
            
            financialTxtStr = self.financialLbl.text! // "rs 87"
            desiredViewController.getFinancialAmntStr = self.financialLbl.text!
            desiredViewController.getPendingAmntStr = self.financialPendingLbl.text!
            desiredViewController.getAddedAmntStr = addCashconctTxtFld.text! // "50"
            addCashconctTxtFld.text = ""
            
            navigationController?.pushViewController(desiredViewController, animated: false)
            
            // New Stripe Payment Method
            
//            paymentSheet?.present(from: self) { paymentResult in
//                // MARK: Handle the payment result
//                switch paymentResult {
//                case .completed:
//                    self.showAlertMessage(strMessage: "Your Order is Confirmed")
//                  print("Your order is confirmed")
//                case .canceled:
//                    self.showAlertMessage(strMessage: "Payment Cancelled")
//                  print("Canceled!")
//                case .failed(let error):
//                    self.showAlertMessage(strMessage: "Payment failed")
//                  print("Payment failed: \(error)")
//                }
//              }

        }
    }
    
//    func showAlertMessage(strMessage:String) {
//        let alert = UIAlertController(title: "Alert", message: strMessage, preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
//               //Cancel Action
//           }))
//           self.present(alert, animated: true, completion: nil)
//       }
    
    @IBAction func manageAcntBtntapped(_ sender: Any) {
        callAddStripeAccountAPIService()
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        
        if let call = self.callBackFinancialAmount{
            let financialAmnt = Int(self.financialLbl.text ?? "")
            call(financialAmnt ?? 0)
            self.navigationController?.popViewController(animated: false)
        }
        sideMenuController?.showLeftView()
    }
    
}
