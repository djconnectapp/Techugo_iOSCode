//
//  AddSubscribeVC.swift
//  DJConnect
//
//  Created by Techugo on 01/06/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import LGSideMenuController
import StoreKit
import Alamofire

class AddSubscribeVC: UIViewController {
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var subscribeHdrLbl: UILabel!
    @IBOutlet weak var subscribeDescrLbl: UILabel!
    
    @IBOutlet weak var basicPriceBgVw: UIView!
    @IBOutlet weak var goldPriceBgVw: UIView!
    
    @IBOutlet weak var basicBtn: UIButton!
    @IBOutlet weak var basicPricLbl: UILabel!
    @IBOutlet weak var goldBTn: UIButton!
    @IBOutlet weak var glodPriceLbl: UILabel!
    
    @IBOutlet weak var basicBgVw: UIView!
    @IBOutlet weak var trialBtn: UIButton!
    
    var myProducts = [SKProduct]()
    var productIDs = ["12"]
    var priceSelected = Int()
    var selectedProductIndex = 0
    var subscriptionSelected = String()
    var subscriptionIdStr = ""
    var screenType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goldPriceBgVw.isHidden = true
        goldBTn.isUserInteractionEnabled = false
        subscriptionSelected = "basic"
        
        if screenType == "SignUp"{
            backBtn.isHidden = true
        }else
        {
            backBtn.isHidden = false
        }
       // basicBtn.backgroundColor = .white
       // basicBtn.setTitleColor(UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1), for: .normal)
        basicPriceBgVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        goldPriceBgVw.backgroundColor = UIColor(red: 5/255, green: 26/255, blue: 46/255, alpha: 1.0)
        setUpVw()
        
        self.fetchAllProducts()
    }
    
    @IBAction func termsServicesBtnTapped(_ sender: Any) {
//        self.callHelpSubMenuWebService(webservice.termsOfUse)
        
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "TermsServiceWebViewVC") as? TermsServiceWebViewVC
        self.present(next1!, animated: true, completion: nil)
        
    }
    

    
    // 29 9 38 brown
    // 5 26 46 green
    
    func setUpVw(){
        
        createGradient(view: goldBTn, bounds: .init(width: self.goldBTn.frame.width, height: self.goldBTn.frame.height))
        
        basicPriceBgVw.layer.cornerRadius = 20.0
        basicPriceBgVw.clipsToBounds = true
        
        basicBgVw.layer.cornerRadius = basicBgVw.frame.size.height/2
        basicBgVw.clipsToBounds = true
        
        goldPriceBgVw.layer.cornerRadius = 20.0
        goldPriceBgVw.clipsToBounds = true
        
        basicBtn.layer.cornerRadius = basicBtn.frame.size.height/2
        basicBtn.clipsToBounds = true
        
        goldBTn.layer.cornerRadius = goldBTn.frame.size.height/2
        goldBTn.clipsToBounds = true

        trialBtn.layer.cornerRadius = trialBtn.frame.size.height/2
        trialBtn.clipsToBounds = true
        
        
    }
    
    func createGradient(view: UIView, bounds: CGSize) {
            let gradientLayer = CAGradientLayer()
            var updatedFrame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: bounds)
            updatedFrame.size.height += 100
            gradientLayer.frame = updatedFrame
        gradientLayer.colors = [UIColor(red: 209 / 255, green: 126 / 255, blue: 51 / 255, alpha: 1).cgColor, UIColor(red: 213 / 255, green: 222 / 255, blue: 69 / 255, alpha: 1).cgColor] // start color and end color
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // horizontal gradient start
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) // horizontal gradient end
            UIGraphicsBeginImageContext(gradientLayer.bounds.size)
            // gradientLayer.render(in: UIGraphicsGetCurrentContext() ?? UIGraphicsGetCurrentContext())
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor.init(patternImage: (image ?? UIImage()).resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch))
        }
    
    @IBAction func basicPriceBtnTapped(_ sender: Any) {
        print("BasicBtnTapped")
        //basicPriceBgVw.backgroundColor = UIColor(red: 29/255, green: 9/255, blue: 38/255, alpha: 1.0)
        basicPriceBgVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        goldPriceBgVw.backgroundColor = UIColor(red: 5/255, green: 26/255, blue: 46/255, alpha: 1.0)
        self.selectedProductIndex = 0
        priceSelected = Int(myProducts[0].price)
        print("basicpriceSelected",priceSelected)
        subscriptionSelected = "basic"
        subscriptionIdStr = "1"
    }
    @IBAction func basicVwBtnTapped(_ sender: Any) {
        print("BasicViewTapped")
        
        //basicPriceBgVw.backgroundColor = UIColor(red: 29/255, green: 9/255, blue: 38/255, alpha: 1.0)
        basicPriceBgVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        goldPriceBgVw.backgroundColor = UIColor(red: 5/255, green: 26/255, blue: 46/255, alpha: 1.0)
        subscriptionSelected = "basic"
        self.selectedProductIndex = 0
        priceSelected = Int(myProducts[0].price)
        print("basicpriceSelected",priceSelected)
        subscriptionIdStr = "1"
        
    }
    
    
    @IBAction func goldPriceBTnTapped(_ sender: Any) {
        print("GoldBtnTapped")
//        basicPriceBgVw.backgroundColor = UIColor(red: 5/255, green: 26/255, blue: 46/255, alpha: 1.0)
//        //goldPriceBgVw.backgroundColor = UIColor(red: 29/255, green: 9/255, blue: 38/255, alpha: 1.0)
//        goldPriceBgVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
//        self.selectedProductIndex = 1
//        subscriptionSelected = "exclusive"
//        priceSelected = Int(myProducts[1].price)
//        print("basicpriceSelected",priceSelected)
//        subscriptionIdStr = "2"
    }
    @IBAction func goldVwBTnTpped(_ sender: Any) {
        print("GoldViewTapped")
        
//        basicPriceBgVw.backgroundColor = UIColor(red: 5/255, green: 26/255, blue: 46/255, alpha: 1.0)
//        //goldPriceBgVw.backgroundColor = UIColor(red: 29/255, green: 9/255, blue: 38/255, alpha: 1.0)
//        goldPriceBgVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
//        subscriptionSelected = "exclusive"
//        self.selectedProductIndex = 1
//        priceSelected = Int(myProducts[1].price)
//        print("basicpriceSelected",priceSelected)
//        subscriptionIdStr = "2"
        
    }
    
    @IBAction func trialBtnTapped(_ sender: Any) {
        
        purchasedItem()

    }
    
    @IBAction func backBtnTaped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    fileprivate func setUpDrawer() {
        guard let centerController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "NewDJHomeVC") as? NewDJHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
    
            let navigation = UINavigationController.init(rootViewController: centerController)
            navigation.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
            //sideMenuController.leftViewWidth = 280.0
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle
       
      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
    }
   
    func setUpDrawerArtist() {
        guard let centerController = UIStoryboard.init(name: "ArtistHome", bundle: nil).instantiateViewController(withIdentifier: "NewArtistHomeVC") as? NewArtistHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
    
            let navigation = UINavigationController.init(rootViewController: centerController)
            navigation.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
            //sideMenuController.leftViewWidth = 280.0
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle
       
      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
   }
    
    func purchasedItem(){
//        guard let guestValue = UserDefaults.standard.value(forKey: "iSGuestUser") as? String else{
//            return
//        }
//
       // if guestValue == "false"{
        Loader.shared.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            Loader.shared.hide()
        })
            PKIAPHandler.shared.purchase(product: self.myProducts[selectedProductIndex]) { (alert, product, transaction) in
                Loader.shared.hide()
                if let tran = transaction, let prod = product {
                    //use transaction details and purchased product as you want
                    print(tran)
                    print(prod)
//                    isSubscribed = "Yes"
//                    isValid = "Yes"
//                    UserDefaults.standard.set("Yes" , forKey: "isSubscribed")
                    Loader.shared.hide()
                    self.getingReciept()
                }
                Loader.shared.hide()
                //Globals.shared.showWarnigMessage(alert.message)
                print(alert.message)
            }
        //}
        //else {

//            DispatchQueue.main.async {
//                let alertController = UIAlertController(title: APP_NAME , message: "GuestMsgKey".localizableString(), preferredStyle: .alert)
//
//                let action1 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
//                    UserDefaults.standard.set("Yes" , forKey: "isGuestPrimium")
//
//                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
//                    nextVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//                    nextVC.modalTransitionStyle = .crossDissolve
//                    nextVC.accountType = "new"
//                    nextVC.socialEnable = self.issocialLogin
//                    self.present(nextVC, animated: true, completion: nil)
//
//                }
//                let action2 = UIAlertAction(title: "BtnCancelKey".localizableString(), style: .default) { (action:UIAlertAction) in
//
//                }
//                alertController.addAction(action1)
//                alertController.addAction(action2)
//                self.present(alertController, animated: true, completion: nil)
//            }
       // }
    }
    
}

//MARK:- INAPP PURCHASE CODE
extension AddSubscribeVC {
    func fetchAllProducts(){
        DispatchQueue.main.async {
            
            Loader.shared.show()
        }
        PKIAPHandler.shared.setProductIds(ids: self.productIDs)
        PKIAPHandler.shared.fetchAvailableProducts { [weak self](products)   in
            
            guard let sSelf = self else {return}
            DispatchQueue.main.async {
                //appDelegate.stopLoader()
                Loader.shared.hide()
                sSelf.myProducts = products
                print("sSelf.myProducts",sSelf.myProducts)
                let a = products[0].price
                //let b = products[1].price
                print("aPrice",a)
                let numberFormatter = NumberFormatter()
                    numberFormatter.formatterBehavior = .behavior10_4
                    numberFormatter.numberStyle = .currency
                self?.basicPricLbl.text = "\(products[0].priceLocale.currencySymbol!)" + "\(products[0].price)"
                print("currencySymbol",products[0].priceLocale.currencySymbol)
                self?.priceSelected = Int(products[0].price)

            }
            
        }
        
    }
    
    func getingReciept(){
        Loader.shared.hide()
        //    let SUBSCRIPTION_SECRET = "35d185b46f3940a292cfa79e8f55a3c2"
        let receiptPath = Bundle.main.appStoreReceiptURL?.path
        if FileManager.default.fileExists(atPath: receiptPath!){
            var receiptData:NSData?
            do{
                Loader.shared.hide()
                receiptData = try NSData(contentsOf: Bundle.main.appStoreReceiptURL!, options: NSData.ReadingOptions.alwaysMapped)
            }
            catch{
                print("ERROR: " + error.localizedDescription)
            }
            Loader.shared.hide()
            let base64encodedReceipt = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithCarriageReturn)
            
            let getInApptransactionId = UserDefaults.standard.string(forKey: "inAppTransactionId")
            print("getInApptransactionId",getInApptransactionId)
           // self.storeReciptOnServer(Recipt: base64encodedReceipt ?? "")
            if(getInApptransactionId != nil && getInApptransactionId != ""){
            self.callartistSubscriptionAPI(transactionId: getInApptransactionId!)
            }
        }
    }
    
    //MARK:- WEBSERVICES
    func callartistSubscriptionAPI(transactionId : String){
        if getReachabilityStatus(){
            Loader.shared.show()
            let requestUrl = "\(webservice.url)\(webservice.artistSubscriptionAPI)"
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
               // "userid":"25",
                "subscription_id":"1",
                "transaction_id":transactionId,
                "amount":"\(priceSelected)",
                "payment_type":"new",
                "artist_type":subscriptionSelected,
                "token":"\(UserModel.sharedInstance().token!)",
            ]
            
            print("parametersInAppPurchaseApi:",parameters)
            
            Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<InAppPurchaseModel>) in
                
                switch response.result {
                case .success(_):
                    print("InAppPurchaseApi_Success")
                    UserModel.sharedInstance().artist_typeSt = "1"
                    UserModel.sharedInstance().synchroniseData()
                    if UserModel.sharedInstance().userType == "DJ"{
                        self.setUpDrawer()
            
                    }else{
                        self.setUpDrawerArtist()
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
    
    //Local Server Api
    func storeReciptOnServer(Recipt : String){
//        let userId = "userID" as? String ?? ""
//        let dictBody :[String:Any] = ["method": "validateReceipt","type":"ios","receipt":Recipt,"user_id":userId]
//        request = CYLServices.requestToSendRecipt(dict: dictBody as NSDictionary)
//
    }
    
//    func getDynamicTitleLblApi(){
//
//        var request = CYLRequestObject()
//        let dictBody :[String:Any] = ["method": "getPost"]
//        request = CYLServices.requestToHitGetAPI(dict: dictBody as NSDictionary)
//        CYLServiceMaster.sharedInstance.callWebServiceWithRequest(
//            rqst: request, withResponse:
//                { (serviceResponse) -> Void in
//                    if ((serviceResponse?.object?["error_code"] as! Int) == 200)
//                    {
//
//                        if let response = serviceResponse?.object?["result"] as? Dictionary<String,AnyObject>{
//                            self.unlockLbl.text = response["post_name"] as? String ?? ""
//                            self.headingStr = response["post_content"] as? String ?? ""
//                            self.discriptionStr = response["description"] as? String ?? ""
//                            self.discriptionLbl.text = self.discriptionStr
//
//                            let checkPromotionalText = self.discriptionStr.contains("PROMOTIONAL LAUNCH")
//
//                            print("checkPromotionalText: \(checkPromotionalText)")
//
//
//                            if checkPromotionalText == true {
//                                self.dynamicDiscountLbl.text = self.DynamicDiscountStr
//                                self.isPromotionalOfferValid = true
//                            }else{
//                                self.isPromotionalOfferValid = false
//                            }
//                            self.setupCardsUi()
//                        }
//
//                    } else if ((serviceResponse?.object?["error_code"] as! Int) == 400){
//
//                    }else if ((serviceResponse?.object?["error_code"] as! Int) == 501){
//
//                    }else {
//
//                    }
//                },  withError: { (error) -> Void in
//
//                })
//        { (isNetworkFailure) -> Void in
//        }
//
//    }
}

