//
//  NewArtistHomeVC.swift
//  DJConnect
//
//  Created by Techugo on 08/04/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import LGSideMenuController
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import StoreKit

class NewArtistHomeVC: UIViewController {
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var welcomeBackLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var BuyaConnectBgVw: UIView!
    @IBOutlet weak var buyaConnectBtn: UIButton!
    @IBOutlet weak var songReviewBgVw: UIView!
    @IBOutlet weak var songREviewBtn: UIButton!
    
    @IBOutlet weak var learnAboutArtistVw: UIView!
    @IBOutlet weak var learnArtistBtn: UIButton!
    
    @IBOutlet weak var djIconImgVw: UIImageView!
    @IBOutlet weak var lblMenuNotifyNumber: UILabel!
    
    var userVerifyStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMenuNotifyNumber.isHidden = true
        lblMenuNotifyNumber.layer.cornerRadius = lblMenuNotifyNumber.frame.size.height/2
        lblMenuNotifyNumber.clipsToBounds = true
        
        //callsubscriptionDetailsAPI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
                        
        if UserModel.sharedInstance().userId != nil || UserModel.sharedInstance().userId != ""{
            setUpVw()
            callGetProfileWebService()
        }else{
            ChangeRoot()
        }
        
        callcheckUserVerifyAPI(getIndex: 0)
        
        if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()

            } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1601360647") {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)

                } else {
                    UIApplication.shared.openURL(url)
                }
            }
    }
    
    func setUpVw(){
        
        notificationCount()
        
        if UserModel.sharedInstance().uniqueUserName != nil{
            self.userNameLbl.text = "@\(UserModel.sharedInstance().uniqueUserName!)"
        }else{
            self.userNameLbl.text = "@ArtistUser"
        }
        
        if UserModel.sharedInstance().userProfileUrl != nil && UserModel.sharedInstance().userProfileUrl != ""{
            //self.imgProfile.kf.setImage(with: URL(string: (UserModel.sharedInstance().userProfileUrl)!), placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        }else{
            //imgProfile.image = UIImage(named: "user-profile")
        }
        
        BuyaConnectBgVw.layer.cornerRadius = 30
        BuyaConnectBgVw.clipsToBounds = true
        BuyaConnectBgVw.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        profileBtn.layer.cornerRadius =  profileBtn.frame.size.height/2
        profileBtn.clipsToBounds = true
        
        songReviewBgVw.layer.cornerRadius = 30
        songReviewBgVw.clipsToBounds = true
        
        learnAboutArtistVw.layer.cornerRadius = 30
        learnAboutArtistVw.clipsToBounds = true
        learnAboutArtistVw.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
    }
    
    func notificationCount(){
        let notiCount = UserModel.sharedInstance().notificationCount
        if notiCount != nil {
            if notiCount! > 0 {
                self.lblMenuNotifyNumber.isHidden = false
                self.lblMenuNotifyNumber.text = "\(notiCount!)"
            }
        }
    }
    
    func ChangeRoot() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
        let navigationController = UINavigationController(rootViewController: nextViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController
    }
    
    //MARK:- WEBSERVICE CALLING
    func callGetProfileWebService(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if getReachabilityStatus(){
            Loader.shared.show() //ashitesh - userId empty
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId ?? "")&token=\(UserModel.sharedInstance().token ?? "")&user_type=\(UserModel.sharedInstance().userType ?? "")&profileviewid=\(UserModel.sharedInstance().userId ?? "")&profileviewtype=\(UserModel.sharedInstance().userType ?? "")&current_date=\(dateFormatter.string(from: date).localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd"))"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    self.removeLoader()
                    Loader.shared.hide()
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        UserModel.sharedInstance().userProfileUrl = getProfile.Profiledata![0].profile_picture ?? ""
                        UserModel.sharedInstance().synchroniseData()
                        self.setUpVw()
                    }else{
                        Loader.shared.hide()
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
    
    func callcheckUserVerifyAPI(getIndex:Int){
        
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid": "\(UserModel.sharedInstance().userId!)"
            ]
            print("parameters34",parameters)
            Loader.shared.show()
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.checkUserVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<CheckUserVerifyModel>) in
       
                switch response.result {
                case .success(_):
                    self.removeLoader()
                    Loader.shared.hide()
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        
                        self.userVerifyStr = ""
                        self.userVerifyStr = getProfile.userdata?.admin_verify ?? ""
                        print("userVerifyStr",self.userVerifyStr)
                        if(self.userVerifyStr == "0"){
                            UserDefaults.standard.set(self.userVerifyStr, forKey: "userVerify")
                            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                    self.present(alert, animated: true)
                        }
                        else if(self.userVerifyStr == "1"){
                            UserDefaults.standard.set(self.userVerifyStr, forKey: "userVerify")
                        if getIndex == 0
                            {
                            }
                        else if getIndex == 1{
                            self.openbuyAConnectScreen()
                        }
                        else if getIndex == 2{
                            self.openReviewScreen()
                        }
                        else if getIndex == 3{
                            let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
                            let next1 = storyboard.instantiateViewController(withIdentifier: "firstPV") as? LearnArtistBuyConnectVC
                            self.navigationController?.pushViewController(next1!, animated: true)
                        }
                        
                        else {
                        }
                        }
                        else if(self.userVerifyStr == "2"){
                            self.callLogoutWebservice()
                        }
                       
                        print("sucessUserCheck")
                    }else{
                        Loader.shared.hide()
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
    
//    //MARK: - WEBSERVICES
//    func callsubscriptionDetailsAPI(){
//        if getReachabilityStatus(){
//            Loader.shared.show()
//            print("subscriptionDetailsAPI:",Alamofire.request(getServiceURL("\(webservice.url)\(webservice.subscriptionDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil))
//            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.subscriptionDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<InAppPurchaseDetailModel>) in
//
//                switch response.result {
//                case .success(_):
//                    Loader.shared.hide()
//                    let inAppPurchaseModel = response.result.value!
//                    if inAppPurchaseModel.success == 1{
//                        Loader.shared.hide()
//                        let serviceTypeInAppPurchase = inAppPurchaseModel.userSubscription?.artist_type ?? ""
//                        print("artistType-inApp-purchase",serviceTypeInAppPurchase)
//                        UserDefaults.standard.set(serviceTypeInAppPurchase , forKey: "inAppServiceType")
//                        NotificationCenter.default.post(name: Notification.Name("InAppPurchaseServiceType"), object: nil)
//                    }
//
//                case .failure(let error):
//                    Loader.shared.hide()
//                    debugPrint(error)
//                    print("Error")
//                }
//            }
//        }
//        else{
//            self.view.makeToast("Please check your Internet Connection".localize)
//        }
//    }
    
    func callLogoutWebservice(){
        if getReachabilityStatus(){
            
           
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
            ]
            debugPrint(parameters)
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.logoutAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let logoutModel = response.result.value!
                    if logoutModel.success == 1{

                        print("logout success")
                        //self.logout()
                        
                        UserModel.sharedInstance().token = ""
                        UserModel.sharedInstance().userId = ""
                        UserModel.sharedInstance().removeData()
                        UserModel.sharedInstance().synchroniseData()
                        self.ChangeRoot()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(logoutModel.message)
                        if logoutModel.message == "You are not authorised. Please login again."{
                            self.logout()
                        }
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
    
    func logout(){
        UserModel.sharedInstance().isSignup = true
        UserModel.sharedInstance().isSkip = false
        UserDefaults.standard.set(false, forKey: "isProfileComplete")
        UserDefaults.standard.set(false, forKey: "isPaymentComplete")
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logOut()
        let applanguage = UserModel.sharedInstance().appLanguage
        let latitude = UserModel.sharedInstance().currentLatitude
        let longitude = UserModel.sharedInstance().currentLongitude
        //let deviceToken = UserModel.sharedInstance().deviceToken
        let username = UserModel.sharedInstance().userName
        let password = UserModel.sharedInstance().password
        let isRemember = UserModel.sharedInstance().isRemembered
        let rememberType = UserModel.sharedInstance().RememberUserType
        let arname = UserModel.sharedInstance().arname
        let arpassword = UserModel.sharedInstance().arpassword
        UserModel.sharedInstance().removeData()
        UserModel.sharedInstance().synchroniseData()
        UserModel.sharedInstance().appLanguage = applanguage
        UserModel.sharedInstance().currentLatitude = latitude
        UserModel.sharedInstance().currentLongitude = longitude
       // UserModel.sharedInstance().deviceToken = deviceToken
        UserModel.sharedInstance().synchroniseData()
        if isRemember == "1"{
            UserModel.sharedInstance().arname = arname
            UserModel.sharedInstance().arpassword = arpassword
            UserModel.sharedInstance().userName = username
            UserModel.sharedInstance().password = password
            UserModel.sharedInstance().isRemembered = isRemember
            UserModel.sharedInstance().RememberUserType = rememberType
            UserModel.sharedInstance().synchroniseData()
        }else{
            UserModel.sharedInstance().isRemembered = isRemember
        }
        
        UserModel.sharedInstance().token = ""
        UserModel.sharedInstance().userId = ""
        UserModel.sharedInstance().removeData()
        UserModel.sharedInstance().synchroniseData()
        self.ChangeRoot()
        
    }
    
    @IBAction func sideMenuBtnTapped(_ sender: Any) {
        sideMenuController?.showLeftView()
    }
    
    @IBAction func notificationBtnTapped(_ sender: Any) {
        
        //callcheckUserVerifyAPI(getIndex: 4)
        Alert_Action()
        
        //let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        //        let next1 = storyBoard.instantiateViewController(withIdentifier: "AddSubscribeVC") as? AddSubscribeVC
        //        navigationController?.pushViewController(next1!, animated: true)
        
    }
    
    func Alert_Action() {
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
                let next1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
                next1?.isFromMenu = false
                navigationController?.pushViewController(next1!, animated: true)
        
    }
    
    @IBAction func profileBtnTapped(_ sender: Any) {
        
        //callcheckUserVerifyAPI(getIndex: 3)
        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as? ArtistViewProfileVC
        next1?.isFromMenu = false
        navigationController?.pushViewController(next1!, animated: true)
        
    }
    
    @IBAction func buyAConnectBtnTapped(_ sender: Any) {
        
        callcheckUserVerifyAPI(getIndex: 1)
       // openbuyAConnectScreen()
    }
    
    func openbuyAConnectScreen(){
        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "WelcomeScreenVC") as? WelcomeScreenVC
        navigationController?.pushViewController(next1!, animated: true)
    }
    
    @IBAction func songReviewBtnTapped(_ sender: Any) {
        
        callcheckUserVerifyAPI(getIndex: 2)
        //openReviewScreen()
    }
    
    func openReviewScreen(){
        UserModel.sharedInstance().mapType = "Review"
        UserModel.sharedInstance().synchroniseData()
        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistMapReviewVC") as? ArtistMapReviewVC
        navigationController?.pushViewController(next1!, animated: true)
    }
    
    @IBAction func learnArtistTapped(_ sender: Any) {
        callcheckUserVerifyAPI(getIndex: 3)
//        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
//        let next1 = storyboard.instantiateViewController(withIdentifier: "firstPV") as? LearnArtistBuyConnectVC
//        navigationController?.pushViewController(next1!, animated: true)
    }
    
    
}
