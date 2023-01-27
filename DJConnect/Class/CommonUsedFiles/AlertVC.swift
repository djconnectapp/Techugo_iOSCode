//
//  AlertVC.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 14/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class ArtistAlertDetails: UITableViewCell{
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblNotifyType: UILabel!
    @IBOutlet weak var lblNotifyMessage: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var cnsLblMain: NSLayoutConstraint!
}

class AlertVC: UIViewController, UIGestureRecognizerDelegate{
    
    //MARK: - OUTLETS
    @IBOutlet weak var vwSearch: viewProperties!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblSelectedMessage: UILabel!
    @IBOutlet weak var tblAlert: UITableView!
    @IBOutlet weak var btnOption: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    @IBOutlet weak var lblNoNotify: UILabel!
    
    
    @IBOutlet weak var verifyVideoPopBgVw: UIView!
    @IBOutlet weak var verifyVideoPopVw: UIView!
    @IBOutlet weak var okBtn: UIButton!
    
    
    let refreshControl = UIRefreshControl()
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
    
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verifyVideoPopBgVw.isHidden = true
        verifyVideoPopVw.isHidden = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        verifyVideoPopBgVw.addGestureRecognizer(tap1)
        
        verifyVideoPopBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        verifyVideoPopVw.layer.cornerRadius = 10;
        verifyVideoPopVw.layer.masksToBounds = true;
        
       // callAlertApi()
        tblAlert.allowsMultipleSelection = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblAlert.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if isNavigatetoAdmin == true{
            callAlertApi()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        callAlertApi()
        refreshControl.endRefreshing()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.verifyVideoPopBgVw.isHidden = true
        self.verifyVideoPopVw.isHidden = true
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        
        self.verifyVideoPopBgVw.isHidden = true
        self.verifyVideoPopVw.isHidden = true
        if(videoStr == "1"){
        callArtistVideoWebService(getBrdcastIDSTr, video_id: getVideoIdStr)
        }
        else{
            callSongReviewVideoWebService(getBrdcastIDSTr, video_id: getVideoIdStr, senderId: getSenderIdStr)
            //callSongReviewVideoWebService("\(newArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
        }
        //callArtistVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)")
        
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
    
    func callFavouriteVC(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "FavoriteMenuVC") as? FavoriteMenuVC
        next1?.isFromNotification = true
        sideMenuController()?.setContentViewController(next1!)
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
    
    func localizeElements(){
        btnSelectAll.setTitle("Select all".localize, for: .normal)
        btnCancel.setTitle("Cancel".localize, for: .normal)
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
    
    //MARK:- SELECTOR METHODS
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
    }
    
    @objc func onSect1CheckBoxValueChange(_ sender: UIButton) {
        if sectionId == 0{
            if tempNewArray[sender.tag] == 0 {
                tempNewArray[sender.tag] = 1
                selected = selected + 1
                lblSelectedMessage.text = "\(selected) selected"
            }else{
                tempNewArray[sender.tag] = 0
                selected = selected - 1
                lblSelectedMessage.text = "\(selected) selected"
            }
            tblAlert .reloadData()
            
        }else{
            if tempOldArray[sender.tag] == 0 {
                tempOldArray[sender.tag] = 1
                selected = selected + 1
                lblSelectedMessage.text = "\(selected) selected"
            }else{
                tempOldArray[sender.tag] = 0
                selected = selected - 1
                lblSelectedMessage.text = "\(selected) selected"
            }
            tblAlert .reloadData()
        }
    }
    
    @objc func onSect2CheckBoxValueChange(_ sender: UIButton) {
        if tempOldArray[sender.tag] == 0 {
            tempOldArray[sender.tag] = 1
            selected = selected + 1
            lblSelectedMessage.text = "\(selected) selected"
        }else{
            tempOldArray[sender.tag] = 0
            selected = selected - 1
            lblSelectedMessage.text = "\(selected) selected"
        }
        tblAlert .reloadData()
    }
    
    //MARK:- ACTIONS
    @IBAction func btnBackAction(_ sender: UIButton) {
        if !isFromMenu{
            navigationController?.popViewController(animated: true)
        }else{
            if UserModel.sharedInstance().userType == "DJ"{
                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
                let next1 = storyBoard.instantiateViewController(withIdentifier: "DJHomeVC") as? DJHomeVC
                sideMenuController()?.setContentViewController(next1!)
            }else{
                let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
                let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
                sideMenuController()?.setContentViewController(next1!)
            }
        }
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        toggleSideMenuView()
    }
    @IBAction func btnOptionAction(_ sender: UIButton) {
        if newArray.isEmpty == true && oldArray.isEmpty == true{
            
        }else{
            vwSearch.isHidden = true
            btnSelectAll.isHidden = false
            btnCancel.isHidden = false
            lblSelectedMessage.isHidden = false
            btnOption.isHidden = true
            btnBack.isHidden = true
            btnMenu.isHidden = true
            lblMenuNotifyNumber.isHidden = true
            if toggle == "0"{
                isDeleteMode = true
                btnDelete.isHidden = false
                lblSelectedMessage.text = "0 selected"
                toggle = "1"
            }else{
                isDeleteMode = false
                btnDelete.isHidden = true
                tblAlert.allowsMultipleSelection = false
                toggle = "0"
            }
            tblAlert.reloadData()
        }
    }
    
    @IBAction func btnSelectAll_Action(_ sender: UIButton) {
        isSelectAllMode = true
        tblAlert.allowsMultipleSelection = false
        var tempNewSelectedId = [String]()
        var tempOldSelectedId = [String]()
        var selectAllsec1Id = String()
        var selectAllsec2Id = String()
        for i in 0..<self.tempNewArray.count{
            if tempNewArray[i] == 0{
                tempNewArray[i] = 1
            }
        }
        for i in 0..<self.tempOldArray.count{
            if tempOldArray[i] == 0{
                tempOldArray[i] = 1
            }
        }
        for i in 0..<newArray.count{
            if tempNewSelectedId.contains("\(newArray[i].id!)") == false{
                tempNewSelectedId.append("\(newArray[i].id!)")
            }
        }
        selectAllsec1Id = tempNewSelectedId.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
        
        for i in 0..<oldArray.count{
            if tempOldSelectedId.contains("\(oldArray[i].id!)") == false{
                tempOldSelectedId.append("\(oldArray[i].id!)")
            }
        }
        selectAllsec2Id = tempOldSelectedId.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
        selectAllIds = selectAllsec1Id + "," + selectAllsec2Id
        print(selectAllIds)
        let total = newArray.count + oldArray.count
        lblSelectedMessage.text = "\(total) selected"
        tblAlert.reloadData()
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        isSelectAllMode = false
        tblAlert.allowsMultipleSelection = true
        btnDelete.isHidden = true
        isDeleteMode = false
        tblAlert.allowsSelection = true
        for i in 0..<self.tempNewArray.count{
            if tempNewArray[i] == 1{
                tempNewArray[i] = 0
            }
        }
        for i in 0..<self.tempOldArray.count{
            if tempOldArray[i] == 1{
                tempOldArray[i] = 0
            }
        }
        selectedNotifyId.removeAll()
        lblSelectedMessage.text = "0 selected"
        toggle = "0"
        tblAlert.reloadData()
        vwSearch.isHidden = false
        btnSelectAll.isHidden = true
        btnCancel.isHidden = true
        lblSelectedMessage.isHidden = true
        btnOption.isHidden = false
        btnBack.isHidden = false
        btnMenu.isHidden = false
        if self.newArray.count > 0{
            self.lblMenuNotifyNumber.isHidden = false
            self.lblMenuNotifyNumber.text = "\(self.newArray.count)"
        }else{
            self.lblMenuNotifyNumber.isHidden = true
        }
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        selected = 0
        
        var cleanDeleteId = String()
        cleanDeleteId = selectedNotifyId.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
        if isSelectAllMode == true{
            callAlertDeleteWebService(_id: selectAllIds)
        }else{
            callAlertDeleteWebService(_id: cleanDeleteId)
        }
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
                            self.lblNoNotify.isHidden = false
                            self.tblAlert.isHidden = true
                        }else{
                            self.lblNoNotify.isHidden = true
                            self.tblAlert.isHidden = false
                            if let newalert = alertModelProfile.newData{
                                let x = newalert.sorted(by: { $0.create_date! > $1.create_date!})
                                self.newArray = x
                                self.tempNewArray = [Int](repeating: 0, count: self.newArray.count)
                                let newNotify = newalert.count
                                print("alertVCNotiCount1",newNotify)
                                UserModel.sharedInstance().notificationCount = newalert.count
                                if newNotify > 0{
                                    self.lblMenuNotifyNumber.isHidden = false
                                    self.lblMenuNotifyNumber.text = "\(newNotify)"
                                }else{
                                    self.lblMenuNotifyNumber.isHidden = true
                                }
                                
                                self.tblAlert.reloadData()
                                
                            }
                            if let oldAlert = alertModelProfile.viewData{
                            
                                let x = oldAlert.sorted(by: { $0.create_date! > $1.create_date!})
                                self.oldArray = x
                                self.tempOldArray = [Int](repeating: 0, count: self.oldArray.count)
                                self.tblAlert.reloadData()
                            }
                        }
                    }else{
                        Loader.shared.hide()
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
                            self.lblMenuNotifyNumber.isHidden = false
                            self.lblMenuNotifyNumber.text = "\(self.newArray.count)"
                        }else{
                            self.lblMenuNotifyNumber.isHidden = true
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
                        self.lblSelectedMessage.text = "0 selected"
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
                        self.btnCancelAction(UIButton())
                        self.tblAlert .reloadData()
                        
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
                        self.sideMenuController()?.setContentViewController(next1!)
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
}

//MARK:- EXTENSIONS
extension AlertVC: UITableViewDelegate, UITableViewDataSource{
    
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
//            return newArray.count
            return 4
        }else{
//            return oldArray.count
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertDetails", for: indexPath) as! ArtistAlertDetails
        cell.selectionStyle = .none
        if indexPath.section == 0{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //let dateDisplay = dateFormatter.date(from:newArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))!
//            cell.lblDjName.text = newArray[indexPath.row].sender
            //cell.lblNotifyType.text = dateDisplay.timeAgoSinceDate()
            //cell.lblNotifyMessage.text = newArray[indexPath.row].message
            cell.lblDjName.text = "Ashitesh"
            cell.lblNotifyMessage.text = "Connect? - arabatros submitted music for your project Demo projects."
            sectionId = indexPath.section
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let displayDate = dateFormatter.date(from:oldArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))!
//            cell.lblNotifyType.text = displayDate.timeAgoSinceDate()
//            cell.lblNotifyMessage.text = oldArray[indexPath.row].message
//            cell.lblDjName.text = oldArray[indexPath.row].sender
            
            cell.lblDjName.text = "Siddharth"
            cell.lblNotifyMessage.text = "Rambo requested a song review for their song test."
            sectionId = indexPath.section
        }
//        if toggle == "0"{
//            cell.cnsLblMain.constant = 10
//            cell.btnCheck .isHidden = true
//        }else{
//            cell.cnsLblMain.constant = 60
//            cell.btnCheck .isHidden = false
//            if sectionId == 0{
//                if tempNewArray[indexPath.row] == 1{
//                    cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
//                }else{
//                    cell.btnCheck.setImage(nil, for: .normal)
//                }
//            }else{
//                if tempOldArray[indexPath.row] == 1{
//                    cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
//                }else{
//                    cell.btnCheck.setImage(nil, for: .normal)
//                }
//            }
//            
//        }
        cell.btnCheck.layer .borderWidth = 2
        cell.btnCheck .layer .borderColor = UIColor.themeBlack.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if isDeleteMode == true{
//            print(indexPath.section)
//            let currSection = indexPath.section
//            sectionId = currSection
//            if currSection == 0{
//                if tempNewArray[indexPath.row] == 0 {
//                    tempNewArray[indexPath.row] = 1
//                    selected = selected + 1
//                    lblSelectedMessage.text = "\(selected) selected"
//                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
//                    let cell = tblAlert.cellForRow(at: indexPath1) as! ArtistAlertDetails
//                    cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
//                    cell.btnCheck.tag = indexPath.row
//                    selectedNotifyId.append("\(newArray[indexPath.row].id!)")
//                    tempNewSelectedId.append("\(newArray[indexPath.row].id!)")
//                }else{
//                    tempNewArray[indexPath.row] = 0
//                    selected = selected - 1
//                    lblSelectedMessage.text = "\(selected) selected"
//                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
//                    let cell = tblAlert.cellForRow(at: indexPath1) as! ArtistAlertDetails
//                    cell.btnCheck.setImage(nil, for: .normal)
//                    cell.btnCheck.tag = indexPath.row
//                    if selectedNotifyId.contains("\(newArray[indexPath.row].id!)"){
//                        print(selectedNotifyId.count)
//                        for i in 0..<selectedNotifyId.count{
//                            if selectedNotifyId[i] == "\(newArray[indexPath.row].id!)"{
//                                selectedNotifyId.remove(at: i)
//                                break
//                            }
//                        }
//                    }
//                    if tempNewSelectedId.contains("\(newArray[indexPath.row].id!)"){
//                        for i in 0..<tempNewSelectedId.count{
//                            if tempNewSelectedId[i] == "\(newArray[indexPath.row].id!)"{
//                                tempNewSelectedId.remove(at: i)
//                                break
//                            }
//                        }
//                    }
//                }
//                tblAlert .reloadData()
//            }
//            if indexPath.section == 1{
//                if tempOldArray[indexPath.row] == 0 {
//                    tempOldArray[indexPath.row] = 1
//                    selected = selected + 1
//                    lblSelectedMessage.text = "\(selected) selected"
//                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
//                    let cell = tblAlert.cellForRow(at: indexPath1) as! ArtistAlertDetails
//                    cell.btnCheck.setImage(UIImage(named: "check"), for: .normal)
//                    cell.btnCheck.tag = indexPath.row
//                    selectedNotifyId.append("\(oldArray[indexPath.row].id!)")
//                    tempOldSelectedId.append("\(oldArray[indexPath.row].id!)")
//                }else{
//                    tempOldArray[indexPath.row] = 0
//                    selected = selected - 1
//                    lblSelectedMessage.text = "\(selected) selected"
//                    let indexPath1 = IndexPath(row: indexPath.row, section: indexPath.section)
//                    let cell = tblAlert.cellForRow(at: indexPath1) as! ArtistAlertDetails
//                    cell.btnCheck.setImage(nil, for: .normal)
//                    cell.btnCheck.tag = indexPath.row
//                    if selectedNotifyId.contains("\(oldArray[indexPath.row].id!)"){
//                        for i in 0..<selectedNotifyId.count{
//                            if selectedNotifyId[i] == "\(oldArray[indexPath.row].id!)"{
//                                selectedNotifyId.remove(at: i)
//                                break
//                            }
//                        }
//                    }
//                    if tempOldSelectedId.contains("\(oldArray[indexPath.row].id!)"){
//                        for i in 0..<tempOldSelectedId.count{
//                            if tempOldSelectedId[i] == "\(oldArray[indexPath.row].id!)"{
//                                tempOldSelectedId.remove(at: i)
//                                break
//                            }
//                        }
//                    }
//                }
//                tblAlert.reloadData()
//            }
//
//        }else{
//            if indexPath.section == 0{
//                //manage the array first and then return back
//                self.isNavigatetoAdmin = false
//                alert_id = "\(newArray[indexPath.row].id!)"
//
//                if newArray[indexPath.row].type == "drop_request"{
//                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjDropVC") as? DjDropVC
//                    next1?.artist_id = "\(newArray[indexPath.row].sender_id!)"
//                    next1?.projectUserId = "\(newArray[indexPath.row].sender_id!)"
//                    next1?.isDropAlert = true
//                    self.sideMenuController()?.setContentViewController(next1!)
//                }
//
//                if newArray[indexPath.row].type == "review_request"{
//                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DJSongReviewsVC") as? DJSongReviewsVC
//                    next1?.artist_id = "\(newArray[indexPath.row].sender_id!)"
//                    next1?.djId = "\(newArray[indexPath.row].sender_id!)"
//                    next1?.broadCast = newArray[indexPath.row].broadcastID!
//                    next1?.songReviewIdStr = newArray[indexPath.row].song_review_id ?? 0
//                    next1?.getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
//                    next1?.projectIdStr = "\(newArray[indexPath.row].project_id!)"
//                    next1?.getAlertId = "\(newArray[indexPath.row].id!)"
//
//                    getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
//                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
//                        let video_id = newArray[indexPath.row].id_for_verify ?? 0
//                        print("id_for_verify",video_id)
//                        next1?.videoid = "\(video_id)"
//
//                    }
//
//                    next1?.isSongReviewAlert = true
//                    self.sideMenuController()?.setContentViewController(next1!)
//                }
//
//                if newArray[indexPath.row].type == "djremix_request"{
//                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjRemixVC") as? DjRemixVC
//                    next1?.artist_id = "\(newArray[indexPath.row].sender_id!)"
//                    next1?.projectUserId = "\(newArray[indexPath.row].sender_id!)"
//                    next1?.isRemixAlert = true
//                    next1?.remix_id = "\(newArray[indexPath.row].project_id!)"
//
//                    self.sideMenuController()?.setContentViewController(next1!)
//                }
//
//                if newArray[indexPath.row].type == "Buy_Project_Artist_Audio_Rejected" || newArray[indexPath.row].type == "Buy_Project_Artist_Audio_Accepted"{
//
//                    if UserModel.sharedInstance().userType == "DJ"{
//                        callDjProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
//                    }else{
//                        if newArray[indexPath.row].isOffer == 0{
//                            callBuyConnectVC(id: "\(newArray[indexPath.row].project_id!)")
//                        }else{
//                            callArtistOfferVC(id: "\(newArray[indexPath.row].project_id!)")
//                        }
//                    }
//                }
//
//                if newArray[indexPath.row].type == "Buy_Project_Artist_Audio"{
//                    callDjProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
//                }
//
//                if newArray[indexPath.row].type == "admin"{
//                    self.isNavigatetoAdmin = true
//                    let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "AdminAlertVC") as? AdminAlertVC
//                    print(indexPath.row)
//                    next1?.messageType = newArray[indexPath.row].title!
//                    next1?.dateTimeInfo = newArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
//                    next1?.messageDesc = newArray[indexPath.row].message!
//                    next1?.deleteId = "\(newArray[indexPath.row].id!)"
//                    self.sideMenuController()?.setContentViewController(next1!)
//                }
//
//                if newArray[indexPath.row].type == "drop_live"{
//
//                    getBrdcastIDSTr = "\(newArray[indexPath.row].broadcastID!)"
//                    getVideoIdStr = "\(newArray[indexPath.row].id_for_verify!)"
//                    getProjectIDSTr = "\(newArray[indexPath.row].project_id!)"
//                    getAlertIdStr = "\(newArray[indexPath.row].id!)"
//                    getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
//                    getSenderIdStr  = "\(newArray[indexPath.row].sender_id!)"
//                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
//
//                        let video_id = newArray[indexPath.row].id_for_verify!
//                        callArtistVideoWebService("\(newArray[indexPath.row].broadcastID!)",video_id: "\(video_id)")
//                    }
//                    else{
//                    if(getBrdcastIDSTr != ""){
//                        self.videoStr = "1"
//                        self.verifyVideoPopBgVw.isHidden = false
//                        self.verifyVideoPopVw.isHidden = false
//                    }
//                    }
////                    let video_id = newArray[indexPath.row].id_for_verify!
////                    callArtistVideoWebService("\(newArray[indexPath.row].broadcastID!)",video_id: "\(video_id)")
//                }
//
//                if newArray[indexPath.row].type == "drop_song_live"{
//
//                    getBrdcastIDSTr = "\(newArray[indexPath.row].broadcastID!)"
//                    getVideoIdStr = "\(newArray[indexPath.row].id_for_verify!)"
//                    getProjectIDSTr = "\(newArray[indexPath.row].project_id!)"
//                    getAlertIdStr = "\(newArray[indexPath.row].id!)"
//
//                    getSenderIdStr  = "\(newArray[indexPath.row].sender_id!)"
//                    getVideoStatusStr = "\(newArray[indexPath.row].verify_status!)"
//                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
//                        let video_id = newArray[indexPath.row].id_for_verify!
//                        print("id_for_verify",video_id)
//
//                        let sendrIdStr = newArray[indexPath.row].sender_id!
//                        callSongReviewVideoWebService("\(newArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
//                    }
//                    else{
//                    if(getBrdcastIDSTr != ""){
//                        self.videoStr = "2"
//                        self.verifyVideoPopBgVw.isHidden = false
//                        self.verifyVideoPopVw.isHidden = false
//                    }
//                    }
//
////                    let video_id = newArray[indexPath.row].id_for_verify!
////                    print("id_for_verify",video_id)
////
////                    let sendrIdStr = newArray[indexPath.row].sender_id!
////                    callSongReviewVideoWebService("\(newArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
//                }
//
//                if newArray[indexPath.row].type == "newproject_added"{
//                    if UserModel.sharedInstance().userType == "AR"{
//                        callArtistProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
//                    }
//                }
//                if newArray[indexPath.row].type == "refund_cancle_project"{
//                    if UserModel.sharedInstance().userType == "AR"{
//                        callArtistProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
//                    }
//                }
//                if newArray[indexPath.row].type == "add_favorite"{
//                    callFavouriteVC()
//                }
//                if newArray[indexPath.row].type == "rate_project"{
//                    if newArray[indexPath.row].isOffer == 0{
//                        callBuyConnectVC(id: "\(newArray[indexPath.row].project_id!)")
//                    }else{
//                        callArtistOfferVC(id: "\(newArray[indexPath.row].project_id!)")
//                    }
//                }
//
//                if newArray[indexPath.row].type == "project_ending"{
//                    callArtistProjectDetail(id: "\(newArray[indexPath.row].project_id!)")
//                }
//
//                oldArray.append(newArray[indexPath.row])
//                newArray.remove(at: indexPath.row)
//                tblAlert.reloadData()
//                callNotifyReadStatus()
//            }else{
//                self.isNavigatetoAdmin = false
//                if oldArray[indexPath.row].type == "drop_request"{
//                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjDropVC") as? DjDropVC
//                    next1?.artist_id = "\(oldArray[indexPath.row].sender_id!)"
//                    next1?.projectUserId = "\(oldArray[indexPath.row].sender_id!)"
//                    next1?.isDropAlert = true
//                    self.sideMenuController()?.setContentViewController(next1!)
//                }
//                if oldArray[indexPath.row].type == "Buy_Project_Artist_Audio_Rejected" || oldArray[indexPath.row].type == "Buy_Project_Artist_Audio_Accepted"{
//                    if UserModel.sharedInstance().userType == "DJ"{
//                        callDjProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
//
//                    }else{
//                        if oldArray[indexPath.row].isOffer == 0{
//                            callBuyConnectVC(id: "\(oldArray[indexPath.row].project_id!)")
//                        }else{
//                            callArtistOfferVC(id: "\(oldArray[indexPath.row].project_id!)")
//                        }
//                    }
//
//                }
//                if oldArray[indexPath.row].type == "Buy_Project_Artist_Audio"{
//                    callDjProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
//                }
//
//                if oldArray[indexPath.row].type == "review_request"{
//                    print("DJSongReviewsVC screen selected")
//                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DJSongReviewsVC") as? DJSongReviewsVC
//
//                    next1?.artist_id = "\(oldArray[indexPath.row].sender_id!)"
//                    next1?.djId = "\(oldArray[indexPath.row].sender_id!)"
//
//                    next1?.broadCast = oldArray[indexPath.row].broadcastID!
//
//                    next1?.songReviewIdStr = oldArray[indexPath.row].song_review_id ?? 0
//                    next1?.getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
//                    next1?.projectIdStr = "\(oldArray[indexPath.row].project_id!)"
//                    next1?.getAlertId = "\(oldArray[indexPath.row].id!)"
//
//                    getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
//                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
//                        let video_id = oldArray[indexPath.row].id_for_verify ?? 0
//                        print("id_for_verify",video_id)
//                        next1?.videoid = "\(video_id)"
//                        print("video_id:",video_id)
//                    }
//
//
//                    print("id:","\(oldArray[indexPath.row].id!)")
//                    print("projectID:","\(oldArray[indexPath.row].project_id!)")
//                    print("alertId:","\(oldArray[indexPath.row].id!)")
//
//                    next1?.isSongReviewAlert = true
//                    self.sideMenuController()?.setContentViewController(next1!)
//                }
//
//                if oldArray[indexPath.row].type == "djremix_request"{
//                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "DjRemixVC") as? DjRemixVC
//                    next1?.artist_id = "\(oldArray[indexPath.row].sender_id!)"
//                    next1?.projectUserId = "\(oldArray[indexPath.row].sender_id!)"
//                    next1?.isRemixAlert = true
//                    next1?.remix_id = "\(oldArray[indexPath.row].project_id!)"
//                    self.sideMenuController()?.setContentViewController(next1!)
//                }
//
//                if oldArray[indexPath.row].type == "admin"{
//                    self.isNavigatetoAdmin = true
//                    let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
//                    let next1 = storyBoard.instantiateViewController(withIdentifier: "AdminAlertVC") as? AdminAlertVC
//                    next1?.messageType = oldArray[indexPath.row].title!
//                    next1?.dateTimeInfo = oldArray[indexPath.row].create_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
//                    next1?.messageDesc = oldArray[indexPath.row].message!
//                    next1?.deleteId = "\(oldArray[indexPath.row].id!)"
//                    self.sideMenuController()?.setContentViewController(next1!)
//
//                }
//
//                if oldArray[indexPath.row].type == "drop_live"{
//
//                    getBrdcastIDSTr = "\(oldArray[indexPath.row].broadcastID!)"
//                    getVideoIdStr = "\(oldArray[indexPath.row].id_for_verify!)"
//                    getProjectIDSTr = "\(oldArray[indexPath.row].project_id!)"
//                    getAlertIdStr = "\(oldArray[indexPath.row].id!)"
//                    getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
//                    getSenderIdStr  = "\(oldArray[indexPath.row].sender_id!)"
//                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
//                        let video_id = oldArray[indexPath.row].id_for_verify!
//                        callArtistVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)")
//                    }
//                    else{
//                    if(getBrdcastIDSTr != ""){
//                        self.videoStr = "1"
//                        self.verifyVideoPopBgVw.isHidden = false
//                        self.verifyVideoPopVw.isHidden = false
//                    }
//                    }
//
//                   // let video_id = oldArray[indexPath.row].id_for_verify!
////                    callArtistVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)")
//                }
//
//                if oldArray[indexPath.row].type == "drop_song_live"{
//
//                    getBrdcastIDSTr = "\(oldArray[indexPath.row].broadcastID!)"
//                    getVideoIdStr = "\(oldArray[indexPath.row].id_for_verify!)"
//                    getProjectIDSTr = "\(oldArray[indexPath.row].project_id!)"
//                    getAlertIdStr = "\(oldArray[indexPath.row].id!)"
//                    getVideoStatusStr = "\(oldArray[indexPath.row].verify_status!)"
//                    getSenderIdStr  = "\(oldArray[indexPath.row].sender_id!)"
//                    if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
//                        let video_id = oldArray[indexPath.row].id_for_verify!
//                                            print("name",oldArray[indexPath.row].sender)
//                                            print("id_for_verify1",video_id)
//
//                                            let sendrIdStr = oldArray[indexPath.row].sender_id!
//
//                                            callSongReviewVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
//                    }
//                    else{
//                    if(getBrdcastIDSTr != ""){
//                        self.videoStr = "2"
//                        self.verifyVideoPopBgVw.isHidden = false
//                        self.verifyVideoPopVw.isHidden = false
//                    }
//                    }
////                    let video_id = oldArray[indexPath.row].id_for_verify!
////                    print("name",oldArray[indexPath.row].sender)
////                    print("id_for_verify1",video_id)
////
////                    let sendrIdStr = oldArray[indexPath.row].sender_id!
////
////                    callSongReviewVideoWebService("\(oldArray[indexPath.row].broadcastID!)", video_id: "\(video_id)", senderId:"\(sendrIdStr)")
//                }
//
//                if oldArray[indexPath.row].type == "newproject_added"{
//                    if UserModel.sharedInstance().userType == "AR"{
//                        callArtistProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
//                    }
//                }
//                if oldArray[indexPath.row].type == "refund_cancle_project"{
//                    if UserModel.sharedInstance().userType == "AR"{
//                        callArtistProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
//                    }
//                }
//                if oldArray[indexPath.row].type == "add_favorite"{
//                    callFavouriteVC()
//                }
//
//                if oldArray[indexPath.row].type == "rate_project"{
//                    if oldArray[indexPath.row].isOffer == 0{
//                        callBuyConnectVC(id: "\(oldArray[indexPath.row].project_id!)")
//                    }else{
//                        callArtistOfferVC(id: "\(oldArray[indexPath.row].project_id!)")
//                    }
//                }
//
//                if oldArray[indexPath.row].type == "project_ending"{
//                    callArtistProjectDetail(id: "\(oldArray[indexPath.row].project_id!)")
//                }
//            }
//        }
//    }
    
}
//extension Array {
//    mutating func remove(at indexes: [Int]) {
//        for index in indexes.sorted(by: >) {
//            remove(at: index)
//        }
//    }
//}
extension AlertVC : DummyViewDelegate {
    func dummyViewBtnCloseClicked() {
    }
    
    func dummyViewBtnMenuClicked() {
        toggleSideMenuView()
    }
}

extension AlertVC : artistDummyViewDelegate{
    func artistViewBtnCloseClicked() {
    }
    
    func artistViewBtnMenuClicked() {
        toggleSideMenuView()
    }
}
