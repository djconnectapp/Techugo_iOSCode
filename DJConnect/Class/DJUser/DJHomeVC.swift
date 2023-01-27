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

class HomeMenuItemCell : UITableViewCell{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivTitleImage: UIImageView!
}

class DJHomeVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var vwInfo: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblMenuNotifyNumber: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tblMenuData: UITableView!
    
    @IBOutlet weak var scrTutorial: UIScrollView!
    
    @IBOutlet weak var vwProfileComplete: UIView!
    
    @IBOutlet weak var lblprofileComplete: UILabel!
    
    @IBOutlet weak var lblNowythatyouhave: UILabel!
    @IBOutlet weak var lbl1st: UILabel!
    @IBOutlet weak var lblclicondate: UILabel!
    @IBOutlet weak var lbl2nd: UILabel!
    @IBOutlet weak var lblonceartistsubmit: UILabel!
    @IBOutlet weak var lbl3rd: UILabel!
    @IBOutlet weak var lblwheneyouhave: UILabel!
    @IBOutlet weak var lbl4th: UILabel!
    @IBOutlet weak var lblgotoyourproject: UILabel!
    @IBOutlet weak var lbl5th: UILabel!
    @IBOutlet weak var lblAfterDownloading: UILabel!
    @IBOutlet weak var lbl6th: UILabel!
    @IBOutlet weak var lblaftereachconnect: UILabel!
    
    @IBOutlet weak var btnclosepopup: UIButton!
    @IBOutlet weak var lblshowthisnext: UILabel!
    @IBOutlet weak var lblyesvwprofile: UILabel!
    @IBOutlet weak var lblnovwprofile: UILabel!
    
    @IBOutlet weak var btnYesCross: UIButton!
    @IBOutlet weak var btnNoCross: UIButton!
    
    var yesNoSelected = false
    var yesNoData = String()
    
    //MARK:- GLOBAL VARIABLE
    var arrImgIndex : [UIImage] = [#imageLiteral(resourceName: "HomeDisk"), #imageLiteral(resourceName: "HomeSong"),#imageLiteral(resourceName: "user-profile"),#imageLiteral(resourceName: "HomeAlert"),#imageLiteral(resourceName: "HomeInfo")]
    var arrSelectedTitle = ["Post a Connect","My Services","Go to My Profile","Go to My Alerts","Learn about DJ Connect"]
    
    var viewerId = String()
    var projectId = String()
    
    var userVerifyStr = String()
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        print("projectId",projectId)
        if viewerId.isEmpty{
            viewerId = UserModel.sharedInstance().userId!
        }
        // api is not running
        setupData()
        self.tblMenuData.reloadData()
        
        scrTutorial.isHidden = true
        // ashitesh - hide for now - given by client - as it is ot updated for now
//        if UserModel.sharedInstance().userId! == viewerId{
//            callGetDjTutorialWebService()
//        }
        // ashitesh - hide part end for now - given by client - as it is ot updated for now
        
    }
    
    @IBAction func btnClosePopUp(_ sender: buttonProperties) {
        if yesNoSelected == true{
            callSetDjTutorialWebService()
            scrTutorial.isHidden = true
        }else{
            self.view.makeToast("Please select yes or no.".localize)
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btn_No_act(_ sender: UIButton) {
        yesNoSelected = true
        yesNoData = "no"
        btnNoCross.setImage(UIImage(named: "check-with-close"), for: .normal)
        btnYesCross.setImage(UIImage(named: "uncheck"), for: .normal)
    }
    
    @IBAction func btn_Yes_act(_ sender: UIButton) {
        yesNoSelected = true
        yesNoData = "yes"
        btnYesCross.setImage(UIImage(named: "check-with-close"), for: .normal)
        btnNoCross.setImage(UIImage(named: "uncheck"), for: .normal)
    }
    
    //MARK:- WEBSERVICE CALLING
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
                        
                            if self.arrSelectedTitle[getIndex] == "Post a Connect"{
                            self.AddProject_Action()
                            }else if self.arrSelectedTitle[getIndex] == "My Services"{
                            self.Review_Action()

                            }else if self.arrSelectedTitle[getIndex] == "Go to My Profile"{ // ashitesh
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
    
    func callSetDjTutorialWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "user_token":"\(UserModel.sharedInstance().token!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "setting":"\(yesNoData)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.setTutorialAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let SetProfile = response.result.value!
                    if SetProfile.success == 1{
                        Loader.shared.hide()
                    }else{
                        self.view.makeToast(SetProfile.message)
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
    
    func callGetDjTutorialWebService(){
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getTutorialAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                
                if response.result.isSuccess == true{
                    if let json = response.result.value as? [String:Any] {
                        if json["success"]! as! NSNumber == 1{
                            if json["setting"] as! String == "0"{
                                self.scrTutorial.isHidden = true
                            }else{
                                self.scrTutorial.isHidden = false
                                self.scrTutorial.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                            }
                        }else{
                            self.scrTutorial.isHidden = false
                            self.scrTutorial.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                        }
                    }
                    print(response)
                }else{
                    self.scrTutorial.isHidden = false
                    self.scrTutorial.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // api is not running
        if UserModel.sharedInstance().userId != nil || UserModel.sharedInstance().userId != ""{
            setupData()
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
        callGetProfileWebService()
        if UserModel.sharedInstance().uniqueUserName != nil{
            self.lblUserName.text = "@\(UserModel.sharedInstance().uniqueUserName!)"
        }else{
            self.lblUserName.text = "@DJUser"
        }
        
        if UserModel.sharedInstance().userProfileUrl != nil && UserModel.sharedInstance().userProfileUrl != ""{
            let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
            do { // http://54.167.191.25/DJJSON/public/uploads/profilePicture/4634userpic.png
                if profileImageUrl != nil {
                    imgProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                }
            }
        }else{
            imgProfile.image = UIImage(named: "user-profile")
        }
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
        let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
        desiredViewController.buttonSelected = "service"
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "flip")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(desiredViewController, animated: true)
    }
    
    func AddProject_Action() {
        let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "DJAddPostVC") as! DJAddPostVC
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType(rawValue: "fade")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(desiredViewController, animated: false)
    }
    
    func Alert_Action() {
//        let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
//        let next1 = storyboard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
//        next1?.isFromMenu = false
//        navigationController?.pushViewController(next1!, animated: true)
        
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
                let next1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
                next1?.isFromMenu = false
                navigationController?.pushViewController(next1!, animated: true)
        
    }
    func Profile_Action() {
        let storyboard = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "CalendarVC") as? CalendarVC
        next1?.isFromMenu = false
        navigationController?.pushViewController(next1!, animated: true)
    }
    
    //MARK:- WEBSERVICE CALLING
    func callGetProfileWebService(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId ?? "")&token=\(UserModel.sharedInstance().token ?? "")&user_type=\(UserModel.sharedInstance().userType ?? "")&profileviewid=\(UserModel.sharedInstance().userId ?? "")&profileviewtype=\(UserModel.sharedInstance().userType ?? "")&current_date=\(dateFormatter.string(from: date))"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    self.removeLoader()
                    Loader.shared.hide()
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        globalObjects.shared.profileCompleted = true
                        UserModel.sharedInstance().remainingTime = getProfile.Profiledata![0].project_remaining_time ?? "1:30"
                        UserModel.sharedInstance().userProfileUrl = getProfile.Profiledata![0].profile_picture
                        UserModel.sharedInstance().synchroniseData()
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
       // let deviceToken = UserModel.sharedInstance().deviceToken
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

extension DJHomeVC : UITableViewDataSource, UITableViewDelegate{
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
        
        //self.userVerifyStr = ""
        //callcheckUserVerifyAPI(getIndex: indexPath.row)
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
        //else if(self.userVerifyStr == "1"){

        if arrSelectedTitle[indexPath.row] == "Post a Connect"{
            self.AddProject_Action()
        }else if arrSelectedTitle[indexPath.row] == "My Services"{
            self.Review_Action()

        }else if arrSelectedTitle[indexPath.row] == "Go to My Profile"{ // ashitesh
            self.Profile_Action()

        }else if arrSelectedTitle[indexPath.row] == "Go to My Alerts"{
            self.Alert_Action()
        }else if arrSelectedTitle[indexPath.row] == "Learn about DJ Connect"{
            vwInfo.isHidden = false
        }
//        }
//        else if(self.userVerifyStr == "2"){
//            callLogoutWebservice()
//        }
    }
}
