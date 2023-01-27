//
//  ArtistHomeVC.swift
//  DJConnect
//
//  Created by My Mac on 10/02/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit

class ArtistHomeVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var vwInfo: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblMenuNotifyNumber: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblMenuData: UITableView!
    
    //MARK:- GLOBAL VARIABLE
    var arrImgIndex : [UIImage] = [#imageLiteral(resourceName: "HomeDisk"), #imageLiteral(resourceName: "HomeSong"),#imageLiteral(resourceName: "user-profile"),#imageLiteral(resourceName: "HomeAlert"),#imageLiteral(resourceName: "HomeInfo")]
    var arrSelectedTitle = ["Buy a Connect","Buy a Song Review","View My Profile","Go to My Alerts","Learn about DJ Connect"]
    
    var userVerifyStr = String()
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
       // callcheckUserVerifyAPI(getIndex: 0)
        
        if UserModel.sharedInstance().userId != nil || UserModel.sharedInstance().userId != ""{
            setupData()
            callGetProfileWebService()
        }else{
            ChangeRoot()
        }
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func btnMenu_Action(_ sender: UIButton) {
        toggleSideMenuView()
    }
    
    @IBAction func closeInfoContainer_Action(_ sender: UIButton) {
        vwInfo.isHidden = true
    }
    
    //MARK:- OTHER ACTIONS
    func setupData(){
        notificationCount()
        if UserModel.sharedInstance().uniqueUserName != nil{
            self.lblUserName.text = "@\(UserModel.sharedInstance().uniqueUserName!)"
        }else{
            self.lblUserName.text = "@ArtistUser"
        }
        
        if UserModel.sharedInstance().userProfileUrl != nil && UserModel.sharedInstance().userProfileUrl != ""{
            self.imgProfile.kf.setImage(with: URL(string: (UserModel.sharedInstance().userProfileUrl)!), placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        }else{
            imgProfile.image = UIImage(named: "user-profile")
        }       
        self.tblMenuData.reloadData()
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
//        let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SignUp") as! UINavigationController
//        let appdel = UIApplication.shared.delegate as! AppDelegate
//        appdel.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        (appdel.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
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
    
    func Review_Action() {
        UserModel.sharedInstance().mapType = "Review"
        UserModel.sharedInstance().synchroniseData()
        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistMapReviewVC") as? ArtistMapReviewVC
        navigationController?.pushViewController(next1!, animated: true)
    }
    
    func AddProject_Action() {
        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "WelcomeScreenVC") as? WelcomeScreenVC
        navigationController?.pushViewController(next1!, animated: true)
    }
    
    func Alert_Action() {
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
        next1?.isFromMenu = false
        navigationController?.pushViewController(next1!, animated: true)
    }
    func Profile_Action() {
        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as? ArtistViewProfileVC
        next1?.isFromMenu = false
        navigationController?.pushViewController(next1!, animated: true)
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
                            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                                    self.present(alert, animated: true)
                        }
                        else if(self.userVerifyStr == "1"){
                        
                            if self.arrSelectedTitle[getIndex] == "Buy a Connect"{
                                self.AddProject_Action()
                            }else if self.arrSelectedTitle[getIndex] == "Buy a Song Review"{
                            self.Review_Action()

                            }else if self.arrSelectedTitle[getIndex] == "View My Profile"{ // ashitesh
                            self.Profile_Action()
                                        
                            }else if self.arrSelectedTitle[getIndex] == "Go to My Alerts"{
                            self.Alert_Action()
                            }else if self.arrSelectedTitle[getIndex] == "Learn about DJ Connect"{
                                self.vwInfo.isHidden = false
                        }
                        }
                        else if(self.userVerifyStr == "2"){
                            self.callLogoutWebservice()
                        }
                       
                        print("sucessUserCheck")
                    }else{
                        Loader.shared.hide()
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
                        self.setupData()
                    }else{
                        Loader.shared.hide()
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
}

extension ArtistHomeVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSelectedTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMenuItemCell", for: indexPath) as! HomeMenuItemCell
        
        cell.lblTitle.text = arrSelectedTitle[indexPath.row].localize
        cell.ivTitleImage.image = arrImgIndex[indexPath.row]
        
        if indexPath.row == 2{
            if UserModel.sharedInstance().userProfileUrl != nil && UserModel.sharedInstance().userProfileUrl != ""{
                let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
                do {
                    if profileImageUrl != nil {
                        cell.ivTitleImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                    }
                }
            }else{
                cell.ivTitleImage.image = UIImage(named: "user-profile")
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        callcheckUserVerifyAPI(getIndex: indexPath.row)
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
//            if arrSelectedTitle[indexPath.row] == "Buy a Connect"{
//                self.AddProject_Action()
//            }else if arrSelectedTitle[indexPath.row] == "Buy a Song Review"{
//                self.Review_Action()
//    //            self.showAlertView("CommingSoon".localize)
//            }else if arrSelectedTitle[indexPath.row] == "View My Profile"{
//                self.Profile_Action()
//            }else if arrSelectedTitle[indexPath.row] == "Go to My Alerts"{
//                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                let vc1 = storyboard.instantiateViewController(withIdentifier: "ABCDViewController") as! ABCDViewController
//                navigationController?.pushViewController(vc1, animated: false)
//                self.Alert_Action()
//            }else if arrSelectedTitle[indexPath.row] == "Learn about DJ Connect"{
//                vwInfo.isHidden = false
//            }
//        }
//        else{
//            self.callLogoutWebservice()
//        }
    }
}
