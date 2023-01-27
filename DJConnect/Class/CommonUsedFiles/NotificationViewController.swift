//
//  NotificationViewController.swift
//  DJConnect
//
//  Created by Techugo on 04/04/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import LGSideMenuController

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var notificationLbl: UILabel!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tblBgVw: UIView!
    @IBOutlet weak var noticationTblVw: UITableView!
    
    @IBOutlet weak var verifyVideoPopBgVw: UIView!
    @IBOutlet weak var verifyVideoPopVw: UIView!
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var btnOption: UIButton!
    
    let refreshControl = UIRefreshControl()
    //MARK: - GLOBAL VARIABLES

    //var lblNotifyMessageArray = ["Rambo requested a song review for their","Connect? - arabatros submitted music for your project Demo projects.","Rambo requested a song review for their","Connect? - arabatros submitted music for your project Demo projects.","Rambo requested a song review for their","Connect? - arabatros submitted music for your project Demo projects."]
    
    
    //MARK: - GLOBAL VARIABLES
    var lblDjNameArray = [String](repeating: "DJ NYC", count: 15)
    var lblDjNotifyTypeArray = [String](repeating: "new", count: 15)
    var lblNotifyMessageArray = [String](repeating: "New Updates - are you loving this app", count: 15)
    var tempOldArray = [Int]()
    var tempNewArray = [Int]()
    var toggle = "0"
    var selected = 0
    var sectionArray = ["View", "Viewed"]
    var newArray = [AlertNewNotifyDetails]()
    var oldArray = [AlertNewNotifyDetails]()
    var searchArray = [AlertNewNotifyDetails]()
    var searchOldArray = [AlertNewNotifyDetails]()
    var alert_id = String()
    var sectionId = Int()
    var isDeleteMode = Bool()
    var selectedNotifyId = [String]()
    var selectAllIds = String()
    var isSelectAllMode = Bool()
    var tempNewSelectedId = [String]()
    var tempOldSelectedId = [String]()
    var isNavigatetoAdmin = Bool()
    var vc1 = DJProjectDetail()
    var vc2 = ArtistProjectDetailVC()
    var currentCurrency = String()
    var isFromMenu = true
    
    
    var getBrdcastIDSTr = String()
    var getVideoIdStr = String()
    var getProjectIDSTr = String()
    var getAlertIdStr = String()
    var getVideoStatusStr = String()
    var getSenderIdStr = String()
    var videoStr = String()
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTxtFld.delegate = self
        searchTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Search Alerts",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        deleteBtn.isHidden = true
        searchVw.layer.cornerRadius = 15
        
         callAlertApi()
        noticationTblVw.tableFooterView = UIView()
        noticationTblVw.allowsMultipleSelection = false
        
        verifyVideoPopBgVw.isHidden = true
        verifyVideoPopVw.isHidden = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        verifyVideoPopBgVw.addGestureRecognizer(tap1)

        verifyVideoPopBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        verifyVideoPopVw.layer.cornerRadius = 10;
        verifyVideoPopVw.layer.masksToBounds = true;
        
       // callAlertApi()
        noticationTblVw.allowsMultipleSelection = false
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
//        lblMenuNotifyNumber.addGestureRecognizer(tap)
        
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        noticationTblVw.addSubview(refreshControl)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if isNavigatetoAdmin == true{
            callAlertApi()
        }
    }
    
    @IBAction func deleteBtnTapped(_ sender: Any) {
        selected = 0
        
        var cleanDeleteId = String()
        cleanDeleteId = selectedNotifyId.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
        if isSelectAllMode == true{
            callAlertDeleteWebService(_id: selectAllIds)
        }else{
            callAlertDeleteWebService(_id: cleanDeleteId)
        }
    }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        searchTxtFld.text?.removeAll()
        searchArray.removeAll()
        searchOldArray.removeAll()
        callAlertApi()
        refreshControl.endRefreshing()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.verifyVideoPopBgVw.isHidden = true
        self.verifyVideoPopVw.isHidden = true
    }
    
    //MARK:- OTHER METHODS
    func callDjProjectDetail(id: String){
        let storyboard = UIStoryboard(name: "DJProfile", bundle: Bundle.main)
        vc1 = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
        vc1.delegate = self
        vc1.projectId = id
        vc1.isFromAlert = true
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc1, animated: false)
    }
    
    func callArtistProjectDetail(id: String){
        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
        vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
        vc2.delegate = self
        vc2.projectId = id
        vc2.isFromAlert = true
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc2, animated: false)
    }
    
    func callBuyConnectVC(id: String){
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        
                        let startString = detailProject.projectDetails![0].event_start_time!
                        let startDate12 = startString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
                        
                        let endString = detailProject.projectDetails![0].event_end_time!
                        let endDate12 = endString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
                        
                        let dateString = detailProject.projectDetails![0].event_day_date!.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "MM/dd/yyyy")
                        let dateFormatter1 = DateFormatter()
                        dateFormatter1.dateFormat = "MM/dd/yyyy"
                        let date = dateFormatter1.date(from: dateString)
                        dateFormatter1.dateFormat = "MMM d, yyyy"
                        let date2 = dateFormatter1.string(from: date!)
                        let weekday = Calendar.current.component(.weekday, from: date!)
                        var day = String()
                        switch weekday {
                        case 1:
                            day = "Sunday - "
                        case 2:
                            day = "Monday - "
                        case 3:
                            day = "Tuesday - "
                        case 4:
                            day = "Wednesday - "
                        case 5:
                            day = "Thursday - "
                        case 6:
                            day = "Friday - "
                        case 7:
                            day = "Saturday - "
                        default:
                            day = "Sunday - "
                        }
                        let storyBoard = UIStoryboard(name: "ArtistProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "BuyConnectVC") as? BuyConnectVC
                        next1?.userDetailDict["projectId"] = id
                        next1?.userDetailDict["projectName"] = detailProject.projectDetails![0].title!
                        next1?.userDetailDict["projectBy"] = "By ".localize + detailProject.projectDetails![0].project_by!
                        
                        let formatter = NumberFormatter()
                        formatter.groupingSeparator = "," // or possibly "." / ","
                        formatter.numberStyle = .decimal
//                        formatter.string(from: Int(detailProject.projectDetails![0].price!)! as NSNumber)
//                        let string2 = formatter.string(from: Int(detailProject.projectDetails![0].price!)! as NSNumber)
//                        next1?.userDetailDict["ProjectCost"] = "COST :".localize + " \(self.currentCurrency)" + " " + string2!
                        next1?.userDetailDict["ProjectCost"] = "COST :".localize + " \(self.currentCurrency)\(detailProject.projectDetails![0].price!)"
                        
                        next1?.userDetailDict["EventDayandDate"] = day + date2
//                        next1?.userDetailDict["eventTime"] = startDate12 + " to ".localize
//                            + endDate12
                        next1?.userDetailDict["eventTime"] = startDate12
                        next1?.userDetailDict["imgUrl"] = "\(detailProject.projectDetails![0].project_image!)"
                        next1?.userDetailDict["projUserId"] = "\(detailProject.projectDetails![0].userid!)"
                        next1?.userDetailDict["is_complete"] = "\(detailProject.projectDetails![0].is_completed!)"
                        next1?.userDetailDict["isBuyOn"] = "\(detailProject.projectDetails![0].is_buy_project!)"
                        next1?.userDetailDict["TrialCurrency"] = self.currentCurrency
                        next1?.userDetailDict["audio_status"] = detailProject.projectDetails![0].audio_status ?? ""
                        next1?.isFromAlert = true
                        self.sideMenuController()?.setContentViewController(next1!)
                    }else{
                        self.view.makeToast(detailProject.message)
                    }
                case .failure(let error):
                    debugPrint(error)
                    print("Error")
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callArtistOfferVC(id: String){
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        let storyBoard = UIStoryboard(name: "ArtistProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistOfferVC") as? ArtistOfferVC
                        next1?.userDetailDict["projectBy"] = detailProject.projectDetails![0].project_by!
                        
                        let formatter = NumberFormatter()
                        formatter.groupingSeparator = "," // or possibly "." / ","
                        formatter.numberStyle = .decimal
//                        formatter.string(from: Int(detailProject.projectDetails![0].price!)! as NSNumber)
//                        let string2 = formatter.string(from: Int(detailProject.projectDetails![0].price!)! as NSNumber)
//                        next1?.userDetailDict["ProjectCost"] = "\(self.currentCurrency)" + " " + string2!
                        
                        next1?.userDetailDict["projectCost"] = "\(self.currentCurrency)\(detailProject.projectDetails![0].price!)"
                        next1?.userDetailDict["userProfile"] = "\(detailProject.projectDetails![0].project_image!)"
                        next1?.userDetailDict["projId"] = id
                        next1?.userDetailDict["projUserId"] = "\(detailProject.projectDetails![0].userid!)"
                        next1?.userDetailDict["isOfferOn"] = "\(detailProject.projectDetails![0].is_buy_offer!)"
                        next1?.userDetailDict["currentCurrency"] = self.currentCurrency
                        next1?.userDetailDict["projectName"] = detailProject.projectDetails![0].title!
                        next1?.isFromAlert = true
                        self.sideMenuController()?.setContentViewController(next1!)
                    }else{
                        self.view.makeToast(detailProject.message)
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func timeAgoDisplay(date: Date) -> String {
        // create dateFormatter with UTC time format
        let currentDate = Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter2.timeZone = NSTimeZone(name: "Asia/Kolkata") as TimeZone?
        let timeStamp = dateFormatter2.string(from: currentDate)
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let considerateDate = dateFormatter3.date(from: "\(timeStamp)")
        
        let calendar = Calendar.current
        
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: considerateDate!)!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: considerateDate!)!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: considerateDate!)!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: considerateDate!)!
        
        if minuteAgo < date {
            let diff = Calendar.current.dateComponents([.second], from: date, to: Date()).second ?? 0
            return "now"
        } else if hourAgo < date {
            let diff = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < date {
            let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
            return "\(diff) hrs ago"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let date2 = dateFormatter.string(from: date)
        return date2
    }
    
    //MARK: - WEBSERVICES
    func callAlertApi(){
       
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAlertListAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<AlertModel>) in
               // print(response.result.value!)
                switch response.result {
                
                case .success(_):
                    let alertModelProfile = response.result.value!
                    if alertModelProfile.success == 1{
                        Loader.shared.hide()
                        
                        if alertModelProfile.newData?.count == nil && alertModelProfile.viewData?.count == nil{
                            //self.lblNoNotify.isHidden = false
                            self.noticationTblVw.isHidden = true
                        }else{
                            //self.lblNoNotify.isHidden = true
                            self.noticationTblVw.isHidden = false
                            if let newalert = alertModelProfile.newData{
                                let x = newalert.sorted(by: { $0.create_date! > $1.create_date!})
                                self.newArray = x
                                self.tempNewArray = [Int](repeating: 0, count: self.newArray.count)
                                let newNotify = newalert.count
                                print("alertVCNotiCount1",newNotify)
                                UserModel.sharedInstance().notificationCount = newalert.count
                                if newNotify > 0{
                                    //self.lblMenuNotifyNumber.isHidden = false
                                    //self.lblMenuNotifyNumber.text = "\(newNotify)"
                                }else{
                                    //self.lblMenuNotifyNumber.isHidden = true
                                }
                                
                                self.noticationTblVw.reloadData()
                                
                            }
                            if let oldAlert = alertModelProfile.viewData{
                            
                                let x = oldAlert.sorted(by: { $0.create_date! > $1.create_date!})
                                self.oldArray = x
                                self.tempOldArray = [Int](repeating: 0, count: self.oldArray.count)
                                self.noticationTblVw.reloadData()
                            }
                        }
                    }else{
                        Loader.shared.hide()
                        
                        if alertModelProfile.success == 0{
                            if(alertModelProfile.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(alertModelProfile.message)
                            }
                        }
                        //self.view.makeToast(alertModelProfile.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callNotifyReadStatus(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "alert_id":"\(alert_id)"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.setReadAlertAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let changeReadStatusProfile = response.result.value!
                    if changeReadStatusProfile.success == 1{
                        Loader.shared.hide()
                        UserModel.sharedInstance().notificationCount = self.newArray.count
                        UserModel.sharedInstance().synchroniseData()
                        if self.newArray.count > 0{
                            //self.lblMenuNotifyNumber.isHidden = false
                            //self.lblMenuNotifyNumber.text = "\(self.newArray.count)"
                        }else{
                            //self.lblMenuNotifyNumber.isHidden = true
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(changeReadStatusProfile.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callAlertDeleteWebService(_id : String){
        if getReachabilityStatus(){
            var removeSec1index = [Int]()
            var removeSec2Index = [Int]()
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "alertid":"\(_id)"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.deleteAlertAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let deleteAlertProfile = response.result.value!
                    if deleteAlertProfile.success == 1{
                        Loader.shared.hide()
                        self.view.makeToast(deleteAlertProfile.message)
                        //self.lblSelectedMessage.text = "0 selected"
                        if self.tempNewArray.contains(1){
                            for (index, element) in self.tempNewArray.enumerated() {
                                if element == 1{
                                    removeSec1index .append(index)
                                }
                            }
                            self.tempNewArray.remove(at: removeSec1index)
                            self.newArray.remove(at: removeSec1index)
                            
                        }
                        if self.tempOldArray.contains(1){
                            for (index, element) in self.tempOldArray.enumerated() {
                                if element == 1{
                                    removeSec2Index .append(index)
                                }
                            }
                            self.tempOldArray.remove(at: removeSec2Index)
                            self.oldArray.remove(at: removeSec2Index)
                        }
                        //self.btnCancelAction(UIButton())
                        self.noticationTblVw .reloadData()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(deleteAlertProfile.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    //to verify video
    func callArtistVideoWebService(_ brodcastID : String, video_id : String){
        if getReachabilityStatus(){
            
            let headers = [
                "Content-Type":"application/json",
                "Accept":"application/vnd.bambuser.v1+json",
                "Authorization":"Bearer GMSWiinwYhbj81RcnuhpP7"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(brodcastID)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { (response:DataResponse<VideoVerifyModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let videoModelProfile = response.result.value!
                    
                    let uri = videoModelProfile.resourceUri
                    let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistLiveVideoRecieveVC") as? ArtistLiveVideoRecieveVC
                    if uri == nil || uri!.isEmpty == true {
                        self.view.makeToast("This video was removed by user")
                    }else{
                        next1?.uri = uri!
                        next1?.id = video_id
                        next1?.broadCastID = brodcastID
                        next1?.projectIdStr = self.getProjectIDSTr
                        next1?.getAlertId = self.getAlertIdStr
                        next1?.getVideoStatusStr = "\(self.getVideoStatusStr)"
                        next1?.getSenderIdStr = "\(self.getSenderIdStr)"
                        
                        self.navigationController?.pushViewController(next1!, animated: false)
                        
                        //self.sideMenuController()?.setContentViewController(next1!)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    self.view.makeToast("This broadcast was removed by user")
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callSongReviewVideoWebService(_ brodcastID : String, video_id : String, senderId:String){
        if getReachabilityStatus(){
            
            let headers = [
                "Content-Type":"application/json",
                "Accept":"application/vnd.bambuser.v1+json",
                "Authorization":"Bearer GMSWiinwYhbj81RcnuhpP7"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(brodcastID)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { (response:DataResponse<VideoVerifyModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    print("userId",video_id)
                    let videoModelProfile = response.result.value!
                    let uri = videoModelProfile.resourceUri
                    let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "SongReviewVideoRecieveVC") as? SongReviewVideoRecieveVC
                    next1?.uri = uri!
                    next1?.id = video_id
                    next1?.getSenderId = senderId
                    next1?.broadCastID = brodcastID ?? ""
                    
                    next1?.projectIdStr = self.getProjectIDSTr
                    next1?.getAlertId = self.getAlertIdStr
                    next1?.getVideoStatusStr = "\(self.getVideoStatusStr)"
                    //next1?.getSenderIdStr = "\(self.getSenderIdStr)"
                    
                    self.sideMenuController()?.setContentViewController(next1!)
                case .failure(let error):
                    Loader.shared.hide()
                    self.view.makeToast("This broadcast was removed by user")
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callCurrencyListWebService(){
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
        }
    }
    
    @IBAction func okBTnTapped(_ sender: Any) {
        self.verifyVideoPopBgVw.isHidden = true
        self.verifyVideoPopVw.isHidden = true
        if(videoStr == "1"){
        callArtistVideoWebService(getBrdcastIDSTr, video_id: getVideoIdStr)
        }
        else{
            callSongReviewVideoWebService(getBrdcastIDSTr, video_id: getVideoIdStr, senderId: getSenderIdStr)
        }
    }
    
    @IBAction func sortBtnTapped(_ sender: Any) {
        
        if newArray.isEmpty == true && oldArray.isEmpty == true{
            
        }else{
//            vwSearch.isHidden = true
//            btnSelectAll.isHidden = false
//            btnCancel.isHidden = false
//            lblSelectedMessage.isHidden = false
            btnOption.isHidden = true
            //btnBack.isHidden = true
            //btnMenu.isHidden = true
            //lblMenuNotifyNumber.isHidden = true
            if toggle == "0"{
                isDeleteMode = true
                deleteBtn.isHidden = false
                //lblSelectedMessage.text = "0 selected"
                toggle = "1"
            }else{
                isDeleteMode = false
                deleteBtn.isHidden = true
                noticationTblVw.allowsMultipleSelection = false
                toggle = "0"
            }
            noticationTblVw.reloadData()
        }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        if(navigationController != nil){
        if !isFromMenu{
           // navigationController?.popViewController(animated: true)
            if UserModel.sharedInstance().userType == "DJ"{
                self.setUpDrawer()

            }else{
                self.setUpDrawerArtist()
            }
        }else{
            if UserModel.sharedInstance().userType == "DJ"{
//                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
//                let next1 = storyBoard.instantiateViewController(withIdentifier: "DJHomeVC") as? DJHomeVC
//                sideMenuController()?.setContentViewController(next1!)
                
                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "NewDJHomeVC") as! NewDJHomeVC
                self.sideMenuController?.hideLeftView()
                self.sideMenuController?.rootViewController?.show(viewController, sender: self)
                self.navigationController?.popToViewController(viewController, animated: true)
            }else{
                let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "NewArtistHomeVC") as! NewArtistHomeVC
                self.sideMenuController?.hideLeftView()
                self.sideMenuController?.rootViewController?.show(viewController, sender: self)
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
        }else{
            if UserModel.sharedInstance().userType == "DJ"{
                self.setUpDrawer()

            }else{
                self.setUpDrawerArtist()
            }
        }
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
//
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
    
}

//MARK:- EXTENSIONS
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return sectionArray[0]
            }
        case 1:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return sectionArray[1]
            }
        default:
            return nil // when return nil no header will be shown
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if(searchArray.count > 0){
                return searchArray.count
            }
            else{
                if(searchOldArray.count > 0 && searchArray.count < 1){
                    return 0
                }
                else if(searchArray.count > 0 && searchOldArray.count > 0){
                    return searchArray.count
                }
                else{
            return newArray.count
                }
            }
        }else{
            if(searchOldArray.count > 0){
                return searchOldArray.count
            }
            else{
                if(searchArray.count > 0 && searchOldArray.count < 1){
                    return 0
                }
                else if(searchArray.count > 0 && searchOldArray.count > 0){
                    return searchOldArray.count
                }
                else{
            return oldArray.count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.selectionStyle = .none
        if indexPath.section == 0{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if(searchArray.count > 0){
                let dateDisplay = dateFormatter.date(from:searchArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))!
                cell.nameLbl.text = searchArray[indexPath.row].sender
                //cell.lblNotifyType.text = dateDisplay.timeAgoSinceDate()
                cell.msgLbl.text = searchArray[indexPath.row].message
                cell.timeLbl.text = dateDisplay.timeAgoSinceDate()
            }
            else{
                let dateDisplay = dateFormatter.date(from:newArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))!
                cell.nameLbl.text = newArray[indexPath.row].sender
                //cell.lblNotifyType.text = dateDisplay.timeAgoSinceDate()
                cell.msgLbl.text = newArray[indexPath.row].message
                cell.timeLbl.text = dateDisplay.timeAgoSinceDate()
            }
           
            
            sectionId = indexPath.section
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if(searchOldArray.count > 0){
                let displayDate = dateFormatter.date(from:searchOldArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))!
    //            cell.lblNotifyType.text = displayDate.timeAgoSinceDate()
                cell.msgLbl.text = searchOldArray[indexPath.row].message
                cell.nameLbl.text = searchOldArray[indexPath.row].sender
                cell.timeLbl.text = displayDate.timeAgoSinceDate()
            }else{
                let displayDate = dateFormatter.date(from:oldArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))!
    //            cell.lblNotifyType.text = displayDate.timeAgoSinceDate()
                cell.msgLbl.text = oldArray[indexPath.row].message
                cell.nameLbl.text = oldArray[indexPath.row].sender
                cell.timeLbl.text = displayDate.timeAgoSinceDate()
            }
            
            sectionId = indexPath.section
        }
        if toggle == "0"{
            //cell.cnsLblMain.constant = 10
            //cell.btnCheck .isHidden = true
            cell.chekView.isHidden = true
            //cell.chekView.backgroundColor = .clear
        }else{
           // cell.cnsLblMain.constant = 60
            //cell.btnCheck .isHidden = false
            cell.chekView.isHidden = false
//            cell.chekView.backgroundColor = .red
            if sectionId == 0{
                if tempNewArray[indexPath.row] == 1{
                    //cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
                    cell.chekView.backgroundColor = .red
                }else{
                    //cell.btnCheck.setImage(nil, for: .normal)
                    cell.chekView.backgroundColor = .clear
                }
            }else{
                if tempOldArray[indexPath.row] == 1{
                    //cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
                    cell.chekView.backgroundColor = .red
                }else{
                    //cell.btnCheck.setImage(nil, for: .normal)
                    cell.chekView.backgroundColor = .clear
                }
            }

        }
       // cell.btnCheck.layer .borderWidth = 2
       // cell.btnCheck .layer .borderColor = UIColor.themeBlack.cgColor
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 118
//    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if isDeleteMode == true{
            print(indexPath.section)
            let currSection = indexPath.section
            sectionId = currSection
            if currSection == 0{
                if tempNewArray[indexPath.row] == 0 {
                    tempNewArray[indexPath.row] = 1
                    selected = selected + 1
                    //lblSelectedMessage.text = "\(selected) selected"
                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
                    let cell = noticationTblVw.cellForRow(at: indexPath1) as! NotificationTableViewCell
                    cell.chekView.isHidden = false
                    cell.chekView.backgroundColor = .red
                    cell.chekView.tag = indexPath.row
                    //cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
                    //cell.btnCheck.tag = indexPath.row
                    selectedNotifyId.append("\(newArray[indexPath.row].id!)")
                    tempNewSelectedId.append("\(newArray[indexPath.row].id!)")
                }else{
                    tempNewArray[indexPath.row] = 0
                    selected = selected - 1
                    //lblSelectedMessage.text = "\(selected) selected"
                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
                    let cell = noticationTblVw.cellForRow(at: indexPath1) as! NotificationTableViewCell
                    //cell.btnCheck.setImage(nil, for: .normal)
                    //cell.btnCheck.tag = indexPath.row
                    cell.chekView.isHidden = true
                    cell.chekView.backgroundColor = .clear
                    cell.chekView.tag = indexPath.row
                    if selectedNotifyId.contains("\(newArray[indexPath.row].id!)"){
                        print(selectedNotifyId.count)
                        for i in 0..<selectedNotifyId.count{
                            if selectedNotifyId[i] == "\(newArray[indexPath.row].id!)"{
                                selectedNotifyId.remove(at: i)
                                break
                            }
                        }
                    }
                    if tempNewSelectedId.contains("\(newArray[indexPath.row].id!)"){
                        for i in 0..<tempNewSelectedId.count{
                            if tempNewSelectedId[i] == "\(newArray[indexPath.row].id!)"{
                                tempNewSelectedId.remove(at: i)
                                break
                            }
                        }
                    }
                }
                noticationTblVw .reloadData()
            }
            if indexPath.section == 1{
                if tempOldArray[indexPath.row] == 0 {
                    tempOldArray[indexPath.row] = 1
                    selected = selected + 1
                    //lblSelectedMessage.text = "\(selected) selected"
                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
                    let cell = noticationTblVw.cellForRow(at: indexPath1) as! NotificationTableViewCell
                    //cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
                    //cell.btnCheck.tag = indexPath.row
                    cell.chekView.isHidden = false
                    cell.chekView.backgroundColor = .red
                    cell.chekView.tag = indexPath.row
                    selectedNotifyId.append("\(oldArray[indexPath.row].id!)")
                    tempOldSelectedId.append("\(oldArray[indexPath.row].id!)")
                }else{
                    tempOldArray[indexPath.row] = 0
                    selected = selected - 1
                    //lblSelectedMessage.text = "\(selected) selected"
                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
                    let cell = noticationTblVw.cellForRow(at: indexPath1) as! NotificationTableViewCell
                   // cell.btnCheck.setImage(nil, for: .normal)
                    //cell.btnCheck.tag = indexPath.row
                    cell.chekView.isHidden = true
                    cell.chekView.backgroundColor = .clear
                    cell.chekView.tag = indexPath.row
                    if selectedNotifyId.contains("\(oldArray[indexPath.row].id!)"){
                        for i in 0..<selectedNotifyId.count{
                            if selectedNotifyId[i] == "\(oldArray[indexPath.row].id!)"{
                                selectedNotifyId.remove(at: i)
                                break
                            }
                        }
                    }
                    if tempOldSelectedId.contains("\(oldArray[indexPath.row].id!)"){
                        for i in 0..<tempOldSelectedId.count{
                            if tempOldSelectedId[i] == "\(oldArray[indexPath.row].id!)"{
                                tempOldSelectedId.remove(at: i)
                                break
                            }
                        }
                    }
                }
                noticationTblVw.reloadData()
            }

        }else{
            if indexPath.section == 0{
                //manage the array first and then return back
                self.isNavigatetoAdmin = false
                
                // ******** new search array start here ********* /////
                if(self.searchArray.count > 0){
                    
                    alert_id = "\(searchArray[indexPath.row].id!)"

                    if searchArray[indexPath.row].type == "drop_request"{
                        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "DjDropVC") as? DjDropVC
                        next1?.artist_id = "\(searchArray[indexPath.row].sender_id!)"
                        next1?.projectUserId = "\(searchArray[indexPath.row].sender_id!)"
                        next1?.isDropAlert = true
                        self.sideMenuController()?.setContentViewController(next1!)
                    }

                    if searchArray[indexPath.row].type == "review_request"{
                        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "DJSongReviewsVC") as? DJSongReviewsVC
                        next1?.artist_id = "\(searchArray[indexPath.row].sender_id!)"
                        next1?.djId = "\(searchArray[indexPath.row].sender_id!)"
                        next1?.broadCast = searchArray[indexPath.row].broadcastID!
                        next1?.songReviewIdStr = searchArray[indexPath.row].song_review_id ?? 0
                        next1?.getVideoStatusStr = "\(searchArray[indexPath.row].verify_status!)"
                        next1?.projectIdStr = "\(searchArray[indexPath.row].project_id!)"
                        next1?.getAlertId = "\(searchArray[indexPath.row].id!)"

                        getVideoStatusStr = "\(searchArray[indexPath.row].verify_status!)"
                        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                            let video_id = searchArray[indexPath.row].id_for_verify ?? 0
                            print("id_for_verify",video_id)
                            next1?.videoid = "\(video_id)"

                        }

                        next1?.isSongReviewAlert = true
                        self.sideMenuController()?.setContentViewController(next1!)
                    }

                    if searchArray[indexPath.row].type == "djremix_request"{
                        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "DjRemixVC") as? DjRemixVC
                        next1?.artist_id = "\(searchArray[indexPath.row].sender_id!)"
                        next1?.projectUserId = "\(searchArray[indexPath.row].sender_id!)"
                        next1?.isRemixAlert = true
                        next1?.remix_id = "\(searchArray[indexPath.row].project_id!)"

                        self.sideMenuController()?.setContentViewController(next1!)
                    }

                    if searchArray[indexPath.row].type == "Buy_Project_Artist_Audio_Rejected" || searchArray[indexPath.row].type == "Buy_Project_Artist_Audio_Accepted"{

                        if UserModel.sharedInstance().userType == "DJ"{
                            callDjProjectDetail(id: "\(searchArray[indexPath.row].project_id!)")
                        }else{
                            if searchArray[indexPath.row].isOffer == 0{
                                callBuyConnectVC(id: "\(searchArray[indexPath.row].project_id!)")
                            }else{
                                callArtistOfferVC(id: "\(searchArray[indexPath.row].project_id!)")
                            }
                        }
                    }

                    if searchArray[indexPath.row].type == "Buy_Project_Artist_Audio"{
                        callDjProjectDetail(id: "\(searchArray[indexPath.row].project_id!)")
                    }

                    if searchArray[indexPath.row].type == "admin"{
                        self.isNavigatetoAdmin = true
                        let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "AdminAlertVC") as? AdminAlertVC
                        print(indexPath.row)
                        next1?.messageType = searchArray[indexPath.row].title!
                        next1?.dateTimeInfo = searchArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                        next1?.messageDesc = searchArray[indexPath.row].message!
                        next1?.deleteId = "\(searchArray[indexPath.row].id!)"
                        self.sideMenuController()?.setContentViewController(next1!)
                    }

                    // artist verify video - video added by dj side
                    if searchArray[indexPath.row].type == "drop_live"{

                        getBrdcastIDSTr = "\(searchArray[indexPath.row].broadcastID!)"
                        getVideoIdStr = "\(searchArray[indexPath.row].id_for_verify!)"
                        getProjectIDSTr = "\(searchArray[indexPath.row].project_id!)"
                        getAlertIdStr = "\(searchArray[indexPath.row].id!)"
                        getVideoStatusStr = "\(searchArray[indexPath.row].verify_status!)"
                        getSenderIdStr  = "\(searchArray[indexPath.row].sender_id!)"
                        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){

                            let video_id = searchArray[indexPath.row].id_for_verify!
                            callArtistVideoWebService("\(searchArray[indexPath.row].broadcastID!)",video_id: "\(video_id)")
                        }
                        else{
                        if(getBrdcastIDSTr != ""){
                            self.videoStr = "1"
                            self.verifyVideoPopBgVw.isHidden = false
                            self.verifyVideoPopVw.isHidden = false
                        }
                        }

                    }

                    if searchArray[indexPath.row].type == "drop_song_live"{

                        getBrdcastIDSTr = "\(searchArray[indexPath.row].broadcastID!)"
                        getVideoIdStr = "\(searchArray[indexPath.row].id_for_verify!)"
                        getProjectIDSTr = "\(searchArray[indexPath.row].project_id!)"
                        getAlertIdStr = "\(searchArray[indexPath.row].id!)"

                        getSenderIdStr  = "\(searchArray[indexPath.row].sender_id!)"
                        getVideoStatusStr = "\(searchArray[indexPath.row].verify_status!)"
                        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                            let video_id = searchArray[indexPath.row].id_for_verify!
                            print("id_for_verify",video_id)

                            let sendrIdStr = searchArray[indexPath.row].sender_id!
                            callSongReviewVideoWebService("\(searchArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
                        }
                        else{
                        if(getBrdcastIDSTr != ""){
                            self.videoStr = "2"
                            self.verifyVideoPopBgVw.isHidden = false
                            self.verifyVideoPopVw.isHidden = false
                        }
                        }
                    }

                    if searchArray[indexPath.row].type == "newproject_added"{
                        if UserModel.sharedInstance().userType == "AR"{
                            callArtistProjectDetail(id: "\(searchArray[indexPath.row].project_id!)")
                        }
                    }
                    if searchArray[indexPath.row].type == "refund_cancle_project"{
                        if UserModel.sharedInstance().userType == "AR"{
                            callArtistProjectDetail(id: "\(searchArray[indexPath.row].project_id!)")
                        }
                    }
                    if searchArray[indexPath.row].type == "add_favorite"{
                       // callFavouriteVC()
                    }
                    if searchArray[indexPath.row].type == "rate_project"{
                        if searchArray[indexPath.row].isOffer == 0{
                            callBuyConnectVC(id: "\(searchArray[indexPath.row].project_id!)")
                        }else{
                            callArtistOfferVC(id: "\(searchArray[indexPath.row].project_id!)")
                        }
                    }

                    if searchArray[indexPath.row].type == "project_ending"{
                        callArtistProjectDetail(id: "\(searchArray[indexPath.row].project_id!)")
                    }

                    searchOldArray.append(searchArray[indexPath.row])
                    newArray.remove(at: indexPath.row)
                    noticationTblVw.reloadData()
                    callNotifyReadStatus()
                    
                    
                }
                
                else{
                    // ********  new array start  here  ******* //
                alert_id = "\(newArray[indexPath.row].id!)"

                if newArray[indexPath.row].type == "drop_request"{
                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjDropVC") as? DjDropVC
                    next1?.artist_id = "\(newArray[indexPath.row].sender_id!)"
                    next1?.projectUserId = "\(newArray[indexPath.row].sender_id!)"
                    next1?.isDropAlert = true
                    self.sideMenuController()?.setContentViewController(next1!)
                }

                if newArray[indexPath.row].type == "review_request"{
                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DJSongReviewsVC") as? DJSongReviewsVC
                    next1?.artist_id = "\(newArray[indexPath.row].sender_id!)"
                    next1?.djId = "\(newArray[indexPath.row].sender_id!)"
                    next1?.broadCast = newArray[indexPath.row].broadcastID!
                    next1?.songReviewIdStr = newArray[indexPath.row].song_review_id ?? 0
                    next1?.getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
                    next1?.projectIdStr = "\(newArray[indexPath.row].project_id!)"
                    next1?.getAlertId = "\(newArray[indexPath.row].id!)"

                    getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                        let video_id = newArray[indexPath.row].id_for_verify ?? 0
                        print("id_for_verify",video_id)
                        next1?.videoid = "\(video_id)"

                    }

                    next1?.isSongReviewAlert = true
                    self.sideMenuController()?.setContentViewController(next1!)
                }

                if newArray[indexPath.row].type == "djremix_request"{
                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjRemixVC") as? DjRemixVC
                    next1?.artist_id = "\(newArray[indexPath.row].sender_id!)"
                    next1?.projectUserId = "\(newArray[indexPath.row].sender_id!)"
                    next1?.isRemixAlert = true
                    next1?.remix_id = "\(newArray[indexPath.row].project_id!)"

                    self.sideMenuController()?.setContentViewController(next1!)
                }

                if newArray[indexPath.row].type == "Buy_Project_Artist_Audio_Rejected" || newArray[indexPath.row].type == "Buy_Project_Artist_Audio_Accepted"{

                    if UserModel.sharedInstance().userType == "DJ"{
                        callDjProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
                    }else{
                        if newArray[indexPath.row].isOffer == 0{
                            callBuyConnectVC(id: "\(newArray[indexPath.row].project_id!)")
                        }else{
                            callArtistOfferVC(id: "\(newArray[indexPath.row].project_id!)")
                        }
                    }
                }

                if newArray[indexPath.row].type == "Buy_Project_Artist_Audio"{
                    callDjProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
                }

                if newArray[indexPath.row].type == "admin"{
                    self.isNavigatetoAdmin = true
                    let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "AdminAlertVC") as? AdminAlertVC
                    print(indexPath.row)
                    next1?.messageType = newArray[indexPath.row].title!
                    next1?.dateTimeInfo = newArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                    next1?.messageDesc = newArray[indexPath.row].message!
                    next1?.deleteId = "\(newArray[indexPath.row].id!)"
                    self.sideMenuController()?.setContentViewController(next1!)
                }

                // artist verify video - video added by dj side
                if newArray[indexPath.row].type == "drop_live"{

                    getBrdcastIDSTr = "\(newArray[indexPath.row].broadcastID!)"
                    getVideoIdStr = "\(newArray[indexPath.row].id_for_verify!)"
                    getProjectIDSTr = "\(newArray[indexPath.row].project_id!)"
                    getAlertIdStr = "\(newArray[indexPath.row].id!)"
                    getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
                    getSenderIdStr  = "\(newArray[indexPath.row].sender_id!)"
                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){

                        let video_id = newArray[indexPath.row].id_for_verify!
                        callArtistVideoWebService("\(newArray[indexPath.row].broadcastID!)",video_id: "\(video_id)")
                    }
                    else{
                    if(getBrdcastIDSTr != ""){
                        self.videoStr = "1"
                        self.verifyVideoPopBgVw.isHidden = false
                        self.verifyVideoPopVw.isHidden = false
                    }
                    }

                }

                if newArray[indexPath.row].type == "drop_song_live"{

                    getBrdcastIDSTr = "\(newArray[indexPath.row].broadcastID!)"
                    getVideoIdStr = "\(newArray[indexPath.row].id_for_verify!)"
                    getProjectIDSTr = "\(newArray[indexPath.row].project_id!)"
                    getAlertIdStr = "\(newArray[indexPath.row].id!)"

                    getSenderIdStr  = "\(newArray[indexPath.row].sender_id!)"
                    getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                        let video_id = newArray[indexPath.row].id_for_verify!
                        print("id_for_verify",video_id)

                        let sendrIdStr = newArray[indexPath.row].sender_id!
                        callSongReviewVideoWebService("\(newArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
                    }
                    else{
                    if(getBrdcastIDSTr != ""){
                        self.videoStr = "2"
                        self.verifyVideoPopBgVw.isHidden = false
                        self.verifyVideoPopVw.isHidden = false
                    }
                    }
                }

                if newArray[indexPath.row].type == "newproject_added"{
                    if UserModel.sharedInstance().userType == "AR"{
                        callArtistProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
                    }
                }
                if newArray[indexPath.row].type == "refund_cancle_project"{
                    if UserModel.sharedInstance().userType == "AR"{
                        callArtistProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
                    }
                }
                if newArray[indexPath.row].type == "add_favorite"{
                   // callFavouriteVC()
                }
                if newArray[indexPath.row].type == "rate_project"{
                    if newArray[indexPath.row].isOffer == 0{
                        callBuyConnectVC(id: "\(newArray[indexPath.row].project_id!)")
                    }else{
                        callArtistOfferVC(id: "\(newArray[indexPath.row].project_id!)")
                    }
                }

                if newArray[indexPath.row].type == "project_ending"{
                    callArtistProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
                }

                oldArray.append(newArray[indexPath.row])
                newArray.remove(at: indexPath.row)
                noticationTblVw.reloadData()
                callNotifyReadStatus()
            }
            }
            
            else{
                self.isNavigatetoAdmin = false
                
                // ******* Old Search Array Start ********* //
                if(searchOldArray.count > 0){
                    
                    if searchOldArray[indexPath.row].type == "drop_request"{ //2
                        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "DjDropVC") as? DjDropVC
                        next1?.artist_id = "\(searchOldArray[indexPath.row].sender_id!)"
                        next1?.projectUserId = "\(searchOldArray[indexPath.row].sender_id!)"
                        next1?.isDropAlert = true
                        self.sideMenuController()?.setContentViewController(next1!)
                    }
                    if searchOldArray[indexPath.row].type == "Buy_Project_Artist_Audio_Rejected" || searchOldArray[indexPath.row].type == "Buy_Project_Artist_Audio_Accepted"{ // 1
                        if UserModel.sharedInstance().userType == "DJ"{
                            callDjProjectDetail(id: "\(searchOldArray[indexPath.row].project_id!)")

                        }else{
                            if searchOldArray[indexPath.row].isOffer == 0{
                                callBuyConnectVC(id: "\(searchOldArray[indexPath.row].project_id!)")
                            }else{
                                callArtistOfferVC(id: "\(searchOldArray[indexPath.row].project_id!)")
                            }
                        }

                    }
                    if searchOldArray[indexPath.row].type == "Buy_Project_Artist_Audio"{ //5
                        callDjProjectDetail(id: "\(searchOldArray[indexPath.row].project_id!)")
                    }

                    if searchOldArray[indexPath.row].type == "review_request"{ //3
                        print("DJSongReviewsVC screen selected")
                        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "DJSongReviewsVC") as? DJSongReviewsVC

                        next1?.artist_id = "\(searchOldArray[indexPath.row].sender_id!)"
                        next1?.djId = "\(searchOldArray[indexPath.row].sender_id!)"

                        next1?.broadCast = searchOldArray[indexPath.row].broadcastID!

                        next1?.songReviewIdStr = searchOldArray[indexPath.row].song_review_id ?? 0
                        next1?.getVideoStatusStr = "\(searchOldArray[indexPath.row].verify_status!)"
                        next1?.projectIdStr = "\(searchOldArray[indexPath.row].project_id!)"
                        next1?.getAlertId = "\(searchOldArray[indexPath.row].id!)"

                        getVideoStatusStr = "\(searchOldArray[indexPath.row].verify_status!)"
                        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                            let video_id = searchOldArray[indexPath.row].id_for_verify ?? 0
                            print("id_for_verify",video_id)
                            next1?.videoid = "\(video_id)"
                            print("video_id:",video_id)
                        }


                        next1?.isSongReviewAlert = true
                        self.sideMenuController()?.setContentViewController(next1!)
                    }

                    if searchOldArray[indexPath.row].type == "djremix_request"{ // 7
                        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "DjRemixVC") as? DjRemixVC
                        next1?.artist_id = "\(searchOldArray[indexPath.row].sender_id!)"
                        next1?.projectUserId = "\(searchOldArray[indexPath.row].sender_id!)"
                        next1?.isRemixAlert = true
                        next1?.remix_id = "\(searchOldArray[indexPath.row].project_id!)"
                        self.sideMenuController()?.setContentViewController(next1!)
                    }

                    if searchOldArray[indexPath.row].type == "admin"{
                        self.isNavigatetoAdmin = true
                        let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "AdminAlertVC") as? AdminAlertVC
                        next1?.messageType = searchOldArray[indexPath.row].title!
                        next1?.dateTimeInfo = searchOldArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                        next1?.messageDesc = searchOldArray[indexPath.row].message!
                        next1?.deleteId = "\(searchOldArray[indexPath.row].id!)"
                        self.sideMenuController()?.setContentViewController(next1!)

                    }

                    // artist verify video - video added by dj side
                    if searchOldArray[indexPath.row].type == "drop_live"{

                        getBrdcastIDSTr = "\(searchOldArray[indexPath.row].broadcastID!)"
                        getVideoIdStr = "\(searchOldArray[indexPath.row].id_for_verify!)"
                        getProjectIDSTr = "\(searchOldArray[indexPath.row].project_id!)"
                        getAlertIdStr = "\(searchOldArray[indexPath.row].id!)"
                        getVideoStatusStr = "\(searchOldArray[indexPath.row].verify_status!)"
                        getSenderIdStr  = "\(searchOldArray[indexPath.row].sender_id!)"
                        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                            let video_id = searchOldArray[indexPath.row].id_for_verify!
                            callArtistVideoWebService("\(searchOldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)")
                        }
                        else{
                        if(getBrdcastIDSTr != ""){
                            self.videoStr = "1"
                            self.verifyVideoPopBgVw.isHidden = false
                            self.verifyVideoPopVw.isHidden = false
                        }
                        }

                    }

                    if searchOldArray[indexPath.row].type == "drop_song_live"{ //4

                        getBrdcastIDSTr = "\(searchOldArray[indexPath.row].broadcastID!)"
                        getVideoIdStr = "\(searchOldArray[indexPath.row].id_for_verify!)"
                        getProjectIDSTr = "\(searchOldArray[indexPath.row].project_id!)"
                        getAlertIdStr = "\(searchOldArray[indexPath.row].id!)"
                        getVideoStatusStr = "\(searchOldArray[indexPath.row].verify_status!)"
                        getSenderIdStr  = "\(searchOldArray[indexPath.row].sender_id!)"
                        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                            let video_id = searchOldArray[indexPath.row].id_for_verify!


                                                let sendrIdStr = searchOldArray[indexPath.row].sender_id!

                                                callSongReviewVideoWebService("\(searchOldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
                        }
                        else{
                        if(getBrdcastIDSTr != ""){
                            self.videoStr = "2"
                            self.verifyVideoPopBgVw.isHidden = false
                            self.verifyVideoPopVw.isHidden = false
                        }
                        }
    //                    let video_id = oldArray[indexPath.row].id_for_verify!
    //                    print("name",oldArray[indexPath.row].sender)
    //                    print("id_for_verify1",video_id)
    //
    //                    let sendrIdStr = oldArray[indexPath.row].sender_id!
    //
    //                    callSongReviewVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
                    }

                    if searchOldArray[indexPath.row].type == "newproject_added"{ //6
                        if UserModel.sharedInstance().userType == "AR"{
                            callArtistProjectDetail(id: "\(searchOldArray[indexPath.row].project_id!)")
                        }
                    }
                    if searchOldArray[indexPath.row].type == "refund_cancle_project"{
                        if UserModel.sharedInstance().userType == "AR"{
                            callArtistProjectDetail(id: "\(searchOldArray[indexPath.row].project_id!)")
                        }
                    }
                    if searchOldArray[indexPath.row].type == "add_favorite"{
                        //callFavouriteVC()
                    }

                    if searchOldArray[indexPath.row].type == "rate_project"{ //8
                        if searchOldArray[indexPath.row].isOffer == 0{
                            callBuyConnectVC(id: "\(searchOldArray[indexPath.row].project_id!)")
                        }else{
                            callArtistOfferVC(id: "\(searchOldArray[indexPath.row].project_id!)")
                        }
                    }

                    if searchOldArray[indexPath.row].type == "project_ending"{
                        callArtistProjectDetail(id: "\(searchOldArray[indexPath.row].project_id!)")
                    }
                    
                }
                else{
                    
                    // ******* old array start ********* //
                if oldArray[indexPath.row].type == "drop_request"{ //2
                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjDropVC") as? DjDropVC
                    next1?.artist_id = "\(oldArray[indexPath.row].sender_id!)"
                    next1?.projectUserId = "\(oldArray[indexPath.row].sender_id!)"
                    next1?.isDropAlert = true
                    self.sideMenuController()?.setContentViewController(next1!)
                }
                if oldArray[indexPath.row].type == "Buy_Project_Artist_Audio_Rejected" || oldArray[indexPath.row].type == "Buy_Project_Artist_Audio_Accepted"{ // 1
                    if UserModel.sharedInstance().userType == "DJ"{
                        callDjProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")

                    }else{
                        if oldArray[indexPath.row].isOffer == 0{
                            callBuyConnectVC(id: "\(oldArray[indexPath.row].project_id!)")
                        }else{
                            callArtistOfferVC(id: "\(oldArray[indexPath.row].project_id!)")
                        }
                    }

                }
                if oldArray[indexPath.row].type == "Buy_Project_Artist_Audio"{ //5
                    callDjProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
                }

                if oldArray[indexPath.row].type == "review_request"{ //3
                    print("DJSongReviewsVC screen selected")
                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DJSongReviewsVC") as? DJSongReviewsVC

                    next1?.artist_id = "\(oldArray[indexPath.row].sender_id!)"
                    next1?.djId = "\(oldArray[indexPath.row].sender_id!)"

                    next1?.broadCast = oldArray[indexPath.row].broadcastID!

                    next1?.songReviewIdStr = oldArray[indexPath.row].song_review_id ?? 0
                    next1?.getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
                    next1?.projectIdStr = "\(oldArray[indexPath.row].project_id!)"
                    next1?.getAlertId = "\(oldArray[indexPath.row].id!)"

                    getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                        let video_id = oldArray[indexPath.row].id_for_verify ?? 0
                        print("id_for_verify",video_id)
                        next1?.videoid = "\(video_id)"
                        print("video_id:",video_id)
                    }


                    print("id:","\(oldArray[indexPath.row].id!)")
                    print("projectID:","\(oldArray[indexPath.row].project_id!)")
                    print("alertId:","\(oldArray[indexPath.row].id!)")

                    next1?.isSongReviewAlert = true
                    self.sideMenuController()?.setContentViewController(next1!)
                }

                if oldArray[indexPath.row].type == "djremix_request"{ // 7
                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjRemixVC") as? DjRemixVC
                    next1?.artist_id = "\(oldArray[indexPath.row].sender_id!)"
                    next1?.projectUserId = "\(oldArray[indexPath.row].sender_id!)"
                    next1?.isRemixAlert = true
                    next1?.remix_id = "\(oldArray[indexPath.row].project_id!)"
                    self.sideMenuController()?.setContentViewController(next1!)
                }

                if oldArray[indexPath.row].type == "admin"{
                    self.isNavigatetoAdmin = true
                    let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "AdminAlertVC") as? AdminAlertVC
                    next1?.messageType = oldArray[indexPath.row].title!
                    next1?.dateTimeInfo = oldArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                    next1?.messageDesc = oldArray[indexPath.row].message!
                    next1?.deleteId = "\(oldArray[indexPath.row].id!)"
                    self.sideMenuController()?.setContentViewController(next1!)

                }

                // artist verify video - video added by dj side
                if oldArray[indexPath.row].type == "drop_live"{

                    getBrdcastIDSTr = "\(oldArray[indexPath.row].broadcastID!)"
                    getVideoIdStr = "\(oldArray[indexPath.row].id_for_verify!)"
                    getProjectIDSTr = "\(oldArray[indexPath.row].project_id!)"
                    getAlertIdStr = "\(oldArray[indexPath.row].id!)"
                    getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
                    getSenderIdStr  = "\(oldArray[indexPath.row].sender_id!)"
                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                        let video_id = oldArray[indexPath.row].id_for_verify!
                        callArtistVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)")
                    }
                    else{
                    if(getBrdcastIDSTr != ""){
                        self.videoStr = "1"
                        self.verifyVideoPopBgVw.isHidden = false
                        self.verifyVideoPopVw.isHidden = false
                    }
                    }

                   // let video_id = oldArray[indexPath.row].id_for_verify!
//                    callArtistVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)")
                }

                if oldArray[indexPath.row].type == "drop_song_live"{ //4

                    getBrdcastIDSTr = "\(oldArray[indexPath.row].broadcastID!)"
                    getVideoIdStr = "\(oldArray[indexPath.row].id_for_verify!)"
                    getProjectIDSTr = "\(oldArray[indexPath.row].project_id!)"
                    getAlertIdStr = "\(oldArray[indexPath.row].id!)"
                    getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
                    getSenderIdStr  = "\(oldArray[indexPath.row].sender_id!)"
                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
                        let video_id = oldArray[indexPath.row].id_for_verify!
                                            print("name",oldArray[indexPath.row].sender)
                                            print("id_for_verify1",video_id)

                                            let sendrIdStr = oldArray[indexPath.row].sender_id!

                                            callSongReviewVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
                    }
                    else{
                        
                    if(getBrdcastIDSTr != ""){
                        self.videoStr = "2"
                        self.verifyVideoPopBgVw.isHidden = false
                        self.verifyVideoPopVw.isHidden = false
                    }
                    }
//                    let video_id = oldArray[indexPath.row].id_for_verify!
//                    print("name",oldArray[indexPath.row].sender)
//                    print("id_for_verify1",video_id)
//
//                    let sendrIdStr = oldArray[indexPath.row].sender_id!
//
//                    callSongReviewVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
                }

                if oldArray[indexPath.row].type == "newproject_added"{ //6
                    if UserModel.sharedInstance().userType == "AR"{
                        callArtistProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
                    }
                }
                if oldArray[indexPath.row].type == "refund_cancle_project"{
                    if UserModel.sharedInstance().userType == "AR"{
                        callArtistProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
                    }
                }
                if oldArray[indexPath.row].type == "add_favorite"{
                    //callFavouriteVC()
                }

                if oldArray[indexPath.row].type == "rate_project"{ //8
                    if oldArray[indexPath.row].isOffer == 0{
                        callBuyConnectVC(id: "\(oldArray[indexPath.row].project_id!)")
                    }else{
                        callArtistOfferVC(id: "\(oldArray[indexPath.row].project_id!)")
                    }
                }

                if oldArray[indexPath.row].type == "project_ending"{
                    callArtistProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
                }
            }
        }
        }
    }
    
}
extension Array {
    mutating func remove(at indexes: [Int]) {
        for index in indexes.sorted(by: >) {
            remove(at: index)
        }
    }
}
extension NotificationViewController : DummyViewDelegate {
    func dummyViewBtnCloseClicked() {
    }
    
    func dummyViewBtnMenuClicked() {
        toggleSideMenuView()
    }
}

extension NotificationViewController : artistDummyViewDelegate{
    func artistViewBtnCloseClicked() {
    }
    
    func artistViewBtnMenuClicked() {
        toggleSideMenuView()
    }
}

extension NotificationViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchTxtFld{
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if newString.isEmpty{
                //tblsearch.isHidden = true
                self.searchArray.removeAll()
                self.searchOldArray.removeAll()
                self.noticationTblVw.reloadData()
            }
            var setUserStr = ""
            setUserStr = setUserStr + newString
            print("setUserStr",setUserStr)
            
            if textField == searchTxtFld{
                
                if setUserStr.count > 0 {
                    if(oldArray.count > 0){
                        searchOldArray = oldArray.filter{$0.sender?.range(of: setUserStr, options: .caseInsensitive) != nil}
                    }
                    if(newArray.count > 0){
                        searchArray = newArray.filter{$0.sender?.range(of: setUserStr, options: .caseInsensitive) != nil}
                    }
                }
                else{
                    self.searchOldArray.removeAll()
                    self.searchArray.removeAll()
                    self.noticationTblVw.reloadData()
                }
                    self.noticationTblVw.reloadData()

            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //searchTxtFld.text?.removeAll()
       // self.tblsearch.isHidden = true
       // self.arrSearchResult.removeAll()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == searchTxtFld{
//            if txt_search.text == "Where would you like to connect?".localize{
            if searchTxtFld.text != ""{
                searchTxtFld.text = ""
            }
            
        }
       }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField == searchTxtFld{
            if searchTxtFld.text == ""{
                searchTxtFld.text = ""
            }
            
        }
    }
    
}
