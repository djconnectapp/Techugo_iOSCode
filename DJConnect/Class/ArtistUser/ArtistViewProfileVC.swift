//
//  DJConnect
//
//  Created by mac on 16/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SwipeCellKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher
import MediaPlayer
import HCSStarRatingView
import AVFoundation
import AVKit
import Reachability
import FirebaseDynamicLinks
import LGSideMenuController

struct global {
    static var audioName = ""
}

class ArtistAllProjDetailCell : SwipeTableViewCell{
    @IBOutlet weak var imgAlbumImage: imageProperties!
    @IBOutlet weak var lblProjName: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblExpectedNum: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var projctTblBgVw: UIView!
    @IBOutlet weak var btnShare: UIButton!
    
}

class ArtistRecentDetails : UICollectionViewCell{
    @IBOutlet weak var cellBgVw: UIView!
    @IBOutlet weak var imgRecentImage: UIImageView!
    @IBOutlet weak var btnRecentPlay: UIButton!
    @IBOutlet weak var lblAlbumName: UILabel!
    @IBOutlet weak var lblByName: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    @IBOutlet weak var thirdNameLbl: UILabel!
    @IBOutlet weak var projectTimeLbl: UILabel!
    @IBOutlet weak var imgPlay: UIImageView!
    
    @IBOutlet weak var cellBgrndVw: UIView!
    func getServiceURL(_ strURL:String) -> URL {
        return URL(string: strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
    }
    
    func getReachabilityStatus() -> Bool{
        let reachability = try! Reachability.init(hostname: "http://www.google.com")
        if ((reachability.connection == .wifi) && (reachability.connection != .unavailable)) {
            return true
        }else {
            if ((reachability.connection == .cellular) && (reachability.connection != .unavailable)) {
                return true
            }else {
                return false
            }
        }
    }
}

class cellCalendar : UITableViewCell{
    
    @IBOutlet weak var imgAlbumImage: UIImageView!
    @IBOutlet weak var lblProjName: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblExpectedNum: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var lblShare: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var calenderCellBgVw: UIView!
    
}

class ArtistViewProfileVC: UIViewController{
    
    //MARK: - OUTLETS
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var vwCalendar: UIView!
    
    @IBOutlet var viewStats: UIView!
    
    @IBOutlet var viewArtistService: UIView!
    @IBOutlet weak var viewAllProj: UIView!
    @IBOutlet weak var vwNewCalendarView: UIView!
    @IBOutlet weak var cnsStatsHeight: NSLayoutConstraint!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var tblVwAllProj: UITableView!
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet weak var btnThreeDot: UIButton!
    @IBOutlet var viewDummyVC: UIView!
    @IBOutlet weak var lablSpin: UILabel!
    
    //height - constraints - outlet
    @IBOutlet weak var cnsRecentHeight: NSLayoutConstraint!
    
    //mainscreen localize outlets
    
    
    @IBOutlet weak var allProjctsVw: UIView!
    @IBOutlet weak var calenderVw: UIView!
    @IBOutlet weak var serviceBTnVw: UIView!
    @IBOutlet weak var statsBtnVw: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAllProjects: UIButton!
    @IBOutlet weak var btnCalendar: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnStats: UIButton!
    @IBOutlet weak var lblRecent: UILabel!
    @IBOutlet weak var lblVerified: UILabel!
    @IBOutlet weak var lblVerifyAck: UILabel!
    @IBOutlet weak var lblDJNAME: UILabel!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var lblBIO: UILabel!
    
    //other
    @IBOutlet weak var lblGenreOfMusic: UILabel!
    @IBOutlet weak var vwBlockReport: viewProperties!
    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var vwRecent: UIView!
    
    //media/no media view
    @IBOutlet weak var vwGradient: UIView!
    
    //active-line labels
    @IBOutlet weak var lblCalendarActive: UILabel!
    @IBOutlet weak var lblServiceActive: UILabel!
    @IBOutlet weak var lblStatsActive: UILabel!
    @IBOutlet weak var lblAllProjectActive: UILabel!
    
    //stats screen outlet
    @IBOutlet weak var lblProjectNumber: UILabel!
    @IBOutlet weak var lblProjTopUser: UILabel!
    @IBOutlet weak var lblProjLastMonth: UILabel!
    
    @IBOutlet weak var lblFavNumber: UILabel!
    @IBOutlet weak var lblfavTopUser: UILabel!
    @IBOutlet weak var lblFavLastMonth: UILabel!
    
    @IBOutlet weak var lblProfileViewNumber: UILabel!
    @IBOutlet weak var lblprofileTopUser: UILabel!
    @IBOutlet weak var lblprofileLastMonth: UILabel!
    
    @IBOutlet weak var lblAverageTime: UILabel!
    @IBOutlet weak var lblTopUserTime: UILabel!
    @IBOutlet weak var lblLastMonthTime: UILabel!
    
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var vwVerify: viewProperties!
    @IBOutlet weak var CVwRecent: UICollectionView!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    
    @IBOutlet weak var lblNoService: UILabel!
    @IBOutlet weak var lblNoServiceAck: UILabel!
    
    //stats
    @IBOutlet weak var lblLo_TotProj: UILabel!
    @IBOutlet weak var lblLo_FavUser: UILabel!
    @IBOutlet weak var lblLo_AvgTime: UILabel!
    @IBOutlet weak var lblLo_ProfVw: UILabel!
    @IBOutlet weak var lblLo_TopUser1: UILabel!
    @IBOutlet weak var lblLo_TopUser2: UILabel!
    @IBOutlet weak var lblLo_TopUser3: UILabel!
    @IBOutlet weak var lblLo_TopUser4: UILabel!
    @IBOutlet weak var lblLo_LastMon1: UILabel!
    @IBOutlet weak var lblLo_LastMon2: UILabel!
    @IBOutlet weak var lblLo_LastMon3: UILabel!
    @IBOutlet weak var lblLo_LastMon4: UILabel!
    
    // view report
    @IBOutlet var vwReport: UIView!
    @IBOutlet weak var imgRe_UserImage: imageProperties!
    @IBOutlet weak var lblRe_UserName: UILabel!
    @IBOutlet weak var txtVwRe_ReportDetail: UITextView!
    
    @IBOutlet var viewDeletePost: UIView!
    
    @IBOutlet weak var editImgeBtn: UIButton!
    
    @IBOutlet weak var userEmailNameLbl: UILabel!
    @IBOutlet weak var userPhoneNoLbl: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    fileprivate weak var calendar: FSCalendar!
    var thisWeek : Int?
    var myWeek : Int?
    let startingIndex = 400
    var postDate = String()
    var selectedButton = "all project"
    var vc1 = DJProjectDetail ()
    var currentDateValue : String!
    var projectId = String()
    var viewerId = String()
    var currentWeek = true
    var BroadcastId = ""
    var BroadcastName = ""
    
    var setImgStr = String()
    var getImage:UIImage?
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    
    var projectList = [DjAllProjectDataDetail]()
    var weekProjectList = [weeklyProjectListDetails]()
    let imgArray = ["djCrowd","djimage","djCrowd","djimage","djCrowd","djCrowd","djimage","djCrowd","djimage","djCrowd"]
    var weekDate = String()
    var apiSongData = String()
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    var isCurrentWeek = false
    var minuteString = String()
    var secondString = String()
    var yesNoSelected = false
    var gradientLayer: CAGradientLayer!
    var searchUserType = String()
    var FacebookUrlLink = String()
    var InstagramUrlLInk = String()
    var YoutubeUrlLink = String()
    var TwitterUrlLink = String()
    var vc2 = ArtistProjectDetailVC()
    var releaseDate = [NSDate?]()
    var countdownTimer = Timer()
    var RemainingTimeArray = [String]()
    var WeeklyRemainingTimeArray = [String]()
    var stringAvgTimeCleaned = String()
    var stringTopTimeCleaned = String()
    var stringLastTimeCleaned = String()
    var isProjOld = String()
    var currList = [CurrencyDataDetail]()
    var currentCurrency = String()
    var recentArray = [recentDataDetail]()
    var apiVideoData = String()
    var videoType = String()
    var mediaRemainingTime = String()
    var mediaReleaseDate: NSDate?
    var mediaCountDownTimer = Timer()
    let blurEffectView = UIVisualEffectView(effect: globalObjects.shared.blurEffect)
    var startIndexAllProj = 0
    var resourceURI = String()
    var video_verify_Id = String()
    var video_broadcastId = String()
    var arrRecentImage = [Bool]()
    var arrRecentLink = [String]()
    var isFromMenu = true
    
    var spinnerr = UIActivityIndicatorView(style: .whiteLarge)
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblVwAllProj.separatorStyle = .none
        tableVw.separatorStyle = .none
        
        self.vwRecent.isHidden = true
        self.cnsRecentHeight.constant = 0
        let origImage = UIImage(named: "edit (3)")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        editImgeBtn.setImage(tintedImage, for: .normal)
        editImgeBtn.tintColor = .white
        
        callCurrencyListWebService()
        self.calendarview()
        
        txtVwRe_ReportDetail.layer.borderWidth = 2
        txtVwRe_ReportDetail.layer.borderColor = UIColor.black.cgColor
        let placeholderString = "Enter Report Detail"
        txtVwRe_ReportDetail.placeholder = placeholderString
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        vwNewCalendarView.isHidden = true
        
        self.viewAllProj.isHidden = false
        self.viewAllProj.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.vwGradient.frame.height)
        self.vwGradient.addSubview(viewAllProj)
        
        if globalObjects.shared.searchResultUserType?.isEmpty == true || globalObjects.shared.searchResultUserType == nil{
            searchUserType = UserModel.sharedInstance().userType!
        }else{
            searchUserType = globalObjects.shared.searchResultUserType!
        }
        
        
        
        allProjctsVw.layer.cornerRadius = 10.0
        allProjctsVw.clipsToBounds = true
        calenderVw.layer.cornerRadius = 10.0
        calenderVw.clipsToBounds = true
        serviceBTnVw.layer.cornerRadius = 10.0
        serviceBTnVw.clipsToBounds = true
        statsBtnVw.layer.cornerRadius = 10.0
        statsBtnVw.clipsToBounds = true
        
        
        btnAllProjects.layer.cornerRadius = 10.0
        btnAllProjects.clipsToBounds = true
        btnCalendar.layer.cornerRadius = 10.0
        btnCalendar.clipsToBounds = true
        btnService.layer.cornerRadius = 10.0
        btnService.clipsToBounds = true
        btnStats.layer.cornerRadius = 10.0
        btnStats.clipsToBounds = true
        
        allProjctsVw .backgroundColor = .white
        calenderVw.backgroundColor = .white
        serviceBTnVw.backgroundColor = .white
        statsBtnVw.backgroundColor = .white
        
        btnAllProjects.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnCalendar.backgroundColor = .white
        btnService.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnAllProjects.setTitleColor(.white, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if viewerId.isEmpty{
            viewerId = UserModel.sharedInstance().userId!
        }
        userSelection()
        
        if btnEdit.currentTitle == "+ Fav" || btnEdit.currentTitle == "+ unFav"{
            editImgeBtn.isHidden = true
            editImgeBtn.isUserInteractionEnabled = false
            if viewerId == UserModel.sharedInstance().userId{
                btnEdit.isUserInteractionEnabled = false
            }else{
                btnEdit.isUserInteractionEnabled = true
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        localizeElement()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "sidemenuProfilePresent"), object: nil)
        vwBlockReport.isHidden = true
        
        self.scrView.contentOffset = CGPoint(x: 0, y: 0)
        if UserModel.sharedInstance().appLanguage == "0"{
            //btnBack.setImage(UIImage(named: "back_arrow_arabic"), for: .normal)
        }else{
            //btnBack.setImage(UIImage(named: "back_arrow_english"), for: .normal)
        }
        
        if globalObjects.shared.buyViewConnect == true{
            videoBuyVerifyMedia()
        }
        if globalObjects.shared.offerViewConnect == true{
            videoOfferVerifyMedia()
        }
        if globalObjects.shared.dropCompleteConnect == true{
            dropCompleteMedia()
        }
        if globalObjects.shared.reviewConnect == true{
            reviewCompleteMedia()
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrView.isScrollEnabled = true
        scrView.contentSize = CGSize(width: self.view.frame.width, height: 1100)
        if viewAllProj.isHidden == false{
            isCurrentWeek = true
            intialContainerHeight()
        }
        if viewArtistService.isHidden == false{
            scrView.contentSize = CGSize(width: self.view.frame.width, height: 950)
        }
        if vwNewCalendarView.isHidden == false{
            isCurrentWeek = false
            intialContainerHeight()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if UserModel.sharedInstance().userId == nil{
            return
        }
        getWeekDate()
        callAlertApi()
        callArtistGetProfileWebService()
        if selectedButton == "all project"{
            projectList.removeAll()
            startIndexAllProj = 0
            callAllProjectWebService(start: 0)
        }
    }
    
    func setScrollView(){
        self.addChild(vc1)
        vc1.view.isHidden = false
        vc1.view.frame = CGRect(x: 0, y: 0, width: viewDummyVC.frame.width, height: view.frame.size.height)
        viewDummyVC!.addSubview(vc1.view)
        vc1.didMove(toParent: self)
    }
    
    //MARK: - OTHER METHODS
    func containerHeight() {
        if isCurrentWeek == true{
            self.tblVwAllProj.reloadData()
            let heightcustom = projectList.count * 220
            self.containerViewHeight.constant = CGFloat(heightcustom)
            self.tblVwAllProj.reloadData()
            scrView.layoutIfNeeded()
        }else{
            self.tableVw.reloadData()
            let heightcustom = weekProjectList.count * 220
            self.containerViewHeight.constant = CGFloat(heightcustom + 100)
            self.tableVw.reloadData()
            scrView.layoutIfNeeded()
        }
    }
    
    func intialContainerHeight(){
        if isCurrentWeek == true{
            self.tblVwAllProj.reloadData()
            let heightcustom = projectList.count * 220
            self.containerViewHeight.constant = CGFloat(heightcustom)
            scrView.contentSize = CGSize(width: self.view.frame.width, height: 777 + containerViewHeight.constant)
            scrView.layoutIfNeeded()
        }else{
            self.tableVw.reloadData()
            let heightcustom = weekProjectList.count * 220
            self.containerViewHeight.constant = CGFloat(heightcustom + 100)
            scrView.contentSize = CGSize(width: self.view.frame.width, height: 777 + containerViewHeight.constant)
            scrView.layoutIfNeeded()
        }
    }
    
    func localizeElement(){
        lblNoService.text = "no service".localize
        lblNoServiceAck.text = "no service detail".localize
        lablSpin.text = "Spin Limit - $1500".localize
//        btnAllProjects.setTitle("PROJECTS".localize, for: .normal)
        btnAllProjects.setTitle("Projects", for: .normal)
        btnCalendar.setTitle("CALENDAR".localize, for: .normal)
        btnService.setTitle("SERVICES".localize, for: .normal)
        btnStats.setTitle("STATS".localize, for: .normal)
        //lblRecent.text = "RECENT".localize
        lblVerified.text = "VERIFIED".localize
        lblVerifyAck.text = "AR_VERIFY_ACK".localize
        
        //vw service
        btnReport.setTitle("Report".localize, for: .normal)
        btnBlock.setTitle("Block".localize, for: .normal)
        
        //vw stats
        lblLo_TotProj.text = "# of Total Projects".localize
        lblLo_FavUser.text = "# of Users Faved You".localize
        lblLo_AvgTime.text = "Avg. Time on App".localize
        lblLo_ProfVw.text = "# of Profile Views".localize
        lblLo_TopUser1.text = "TOP USER".localize
        lblLo_TopUser2.text = "TOP USER".localize
        lblLo_TopUser3.text = "TOP USER".localize
        lblLo_TopUser4.text = "TOP USER".localize
        lblLo_LastMon1.text = "LAST MONTH".localize
        lblLo_LastMon2.text = "LAST MONTH".localize
        lblLo_LastMon3.text = "LAST MONTH".localize
        lblLo_LastMon4.text = "LAST MONTH".localize
    }
    
    func calendarview () {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: self.view .frame .width, height: 180))
        calendar.dataSource = self
        calendar.delegate = self
        vwCalendar.addSubview(calendar)
        self.calendar = calendar
        self.calendar.scope = .week
        self.calendar.appearance.weekdayTextColor = UIColor .white
        self.calendar.appearance.headerTitleColor = UIColor .white
        self.calendar.appearance.titleDefaultColor = UIColor .white
        self.calendar.appearance.headerMinimumDissolvedAlpha = -1
        self.calendar.appearance.titleTodayColor = UIColor .red
        self.calendar.appearance.todayColor = UIColor .white
        self.calendar.appearance.titleSelectionColor = UIColor.black
        self.calendar.appearance.selectionColor = UIColor.white
        
        let c = Calendar.current.firstWeekday
        
        switch c {
        case 1:
            self.calendar.firstWeekday = 1
            break
        case 2:
            self.calendar.firstWeekday = 2
            break
        case 3:
            self.calendar.firstWeekday = 3
            break
        case 4:
            self.calendar.firstWeekday = 4
            break
        case 5:
            self.calendar.firstWeekday = 5
            break
        case 6:
            self.calendar.firstWeekday = 6
            break
        case 7:
            self.calendar.firstWeekday = 7
            break
        default:
            self.calendar.firstWeekday = 7
        }
        
    }
    
    func userSelection() {
        
        if UserModel.sharedInstance().isSignup == false && UserModel.sharedInstance().isPin == false{
            btnEdit.isUserInteractionEnabled = true
            btnEdit.setTitle("Edit".localize, for: .normal)
            btnThreeDot.isHidden = true
            editImgeBtn.isHidden = false
            editImgeBtn.isUserInteractionEnabled = true
            
        }else {
            if UserModel.sharedInstance().isPin == true {
                editImgeBtn.isHidden = true
                editImgeBtn.isUserInteractionEnabled = false
                btnEdit.setTitle("+ Fav".localize, for: .normal)
                btnThreeDot.isHidden = false
            }else{
                editImgeBtn.isHidden = false
                editImgeBtn.isUserInteractionEnabled = true
                btnEdit.isUserInteractionEnabled = true
                btnEdit.setTitle("Edit".localize, for: .normal)
                btnThreeDot.isHidden = true
            }
        }
        
        if self.viewerId == UserModel.sharedInstance().userId{
            self.btnEdit.isUserInteractionEnabled = true
            self.btnEdit.setTitle("Edit".localize, for: .normal)
            self.btnThreeDot.isHidden = true
            editImgeBtn.isHidden = false
            editImgeBtn.isUserInteractionEnabled = true
        }else{
            editImgeBtn.isHidden = true
            editImgeBtn.isUserInteractionEnabled = false
            self.btnThreeDot.isHidden = false
            self.btnEdit.setTitle("+ Fav".localize, for: .normal)
        }
    }
    
    func ChangeRootUsingFlip() {
        let homeSB = UIStoryboard(name: "ArtistProfile", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationArtistProfile") as! UINavigationController
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
        desiredViewController.view.addSubview(snapshot);
        appdel.window?.rootViewController = desiredViewController;
        
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview();
        });
    }
    
    func generateDates(startDate :Date?, addbyUnit:Calendar.Component, value : Int) -> Date {
        var dates = [Date]()
        var date = startDate!
        let endDate = Calendar.current.date(byAdding: addbyUnit, value: value, to: date)!
        while date < endDate {
            date = Calendar.current.date(byAdding: addbyUnit, value: 1, to: date)!
            dates.append(date)
        }
        return endDate
    }
    
    func goToPlayer(_ VideoStatusStr : Int, _ alertIdStr : Int, _ senderIdStr : Int, _ mediaStr : Int){
        let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
        let destinationVC = homeSB.instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as! ArtistBambUserPlayerVC
        destinationVC.uri = resourceURI
        destinationVC.id = "\(mediaStr)"
        destinationVC.broadCastID = BroadcastId
        destinationVC.getVideoStatusStr = "\(VideoStatusStr)"
        destinationVC.getalertIdStr = "\(alertIdStr)"
        destinationVC.getSenderidStr = "\(senderIdStr)"
        destinationVC.backType = "profile"
        destinationVC.screenCnnect = "ArtistScreen"
        if self.videoType == "SongReviewLive"{
            destinationVC.videoType = "review"
        }
        if self.videoType == "project"{
            destinationVC.videoType = "project"
        }
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "push")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func formattedDaysInThisWeek() -> [String] {
        // create calendar
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        
        // today's date
        let today = NSDate()
        let todayComponent = calendar.components([.day, .month, .year], from: today as Date)
        
        // range of dates in this week
        let thisWeekDateRange = calendar.range(of: .day, in:.weekOfMonth, for:today as Date)
        
        // date interval from today to beginning of week
        let dayInterval = thisWeekDateRange.location - todayComponent.day!
        
        // date for beginning day of this week, ie. this week's Sunday's date
        let beginningOfWeek = calendar.date(byAdding: .day, value: dayInterval, to: today as Date, options: .matchNextTime)
        
        var formattedDays: [String] = []
        
        for i in 0 ..< thisWeekDateRange.length {
            let date = calendar.date(byAdding: .day, value: i, to: beginningOfWeek!, options: .matchNextTime)!
            formattedDays.append(formatDate(date: date as NSDate))
        }
        
        return formattedDays
    }
    
    func formatDate(date: NSDate) -> String {
        let format = "EEE MMMdd"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
    
    func getWeekDate(){
        let week = calendar.currentPage
        let monthOfWeek = Calendar.current.component(.weekOfMonth, from: week)
        
        myWeek = monthOfWeek
        
        let currentPageDate = calendar.currentPage
        let yearString = Calendar.current.component(.year, from: currentPageDate)
        let weekOfYearString = Calendar.current.component(.weekOfYear, from: currentPageDate)
        
        let year = Int(yearString)
        let components = DateComponents(weekOfYear: weekOfYearString, yearForWeekOfYear: year)
        guard let date = Calendar.current.date(from: components) else {return}
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        weekDate = df.string(from: date)
    }
    
    
    
    func videoBuyVerifyMedia(){
        selectedButton = "media"
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        setMediaSectionFontColor()
        vwNewCalendarView.isHidden = true
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        viewAllProj.isHidden = true
        scrView.layoutIfNeeded()
        globalObjects.shared.buyViewConnect = false
    }
    
    func videoOfferVerifyMedia(){
        selectedButton = "media"
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        setMediaSectionFontColor()
        vwNewCalendarView.isHidden = true
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        viewAllProj.isHidden = true
        scrView.layoutIfNeeded()
        globalObjects.shared.offerViewConnect = false
    }
    
    func dropCompleteMedia(){
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        setMediaSectionFontColor()
        vwNewCalendarView.isHidden = true
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        viewAllProj.isHidden = true
        
        scrView.layoutIfNeeded()
        globalObjects.shared.dropCompleteConnect = false
    }
    
    func reviewCompleteMedia(){
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        setMediaSectionFontColor()
        vwNewCalendarView.isHidden = true
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        viewAllProj.isHidden = true
        scrView.layoutIfNeeded()
        
        globalObjects.shared.reviewConnect = false
    }
    
    func startTimer(){
        if globalObjects.shared.isArProjStartTimer == true || globalObjects.shared.isArWeekTimer == true{
            if isCurrentWeek == true{
                for i in 0..<projectList.count{
                    let releaseDateString = "\(RemainingTimeArray[i])"
                    let releaseDateFormatter = DateFormatter()
                    releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    releaseDate.append(releaseDateFormatter.date(from: releaseDateString)! as NSDate)
                    countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                }
            }else{
                for i in 0..<weekProjectList.count{
                    let releaseDateString = "\(WeeklyRemainingTimeArray[i])"
                    let releaseDateFormatter = DateFormatter()
                    releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    releaseDate.append(releaseDateFormatter.date(from: releaseDateString)! as NSDate)
                    countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    func startMediaTimer() {
        if globalObjects.shared.isArVideoTimer == true{
            let releaseDateString = "\(mediaRemainingTime)"
            let releaseDateFormatter = DateFormatter()
            releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            mediaReleaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
            mediaCountDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMediaTime), userInfo: nil, repeats: true)
        }
    }
    
    func setMediaView(){
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        setMediaSectionFontColor()
        vwNewCalendarView.isHidden = true
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        viewAllProj.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first!
        if touch?.view != vwBlockReport {
            vwBlockReport.isHidden = true
        }
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func setMediaSectionFontColor(){
        btnAllProjects.setTitleColor(.lightGray, for: .normal)
        btnCalendar.setTitleColor(.lightGray, for: .normal)
        btnStats.setTitleColor(.lightGray, for: .normal)
        btnService.setTitleColor(.lightGray, for: .normal)
    }
    
    //MARK: - SELECTOR METHODS
    @objc func updateTime() {
        
        if globalObjects.shared.isArProjStartTimer == true || globalObjects.shared.isArWeekTimer == true{
            if isCurrentWeek == true{
                let currentDate = Date()
                let calendar = Calendar.current
                for i in 0..<projectList.count{
                    let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate[i]! as Date)
                    let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
                    let indexPath1 = IndexPath.init(row: i, section: 0)
                    let cell = tblVwAllProj.cellForRow(at: indexPath1) as? ArtistAllProjDetailCell
                    
                    if projectList[i].is_cancelled == 1{
                        countdownTimer.invalidate()
                        cell?.lblRemainingTime.text = "PROJECT CANCELLED".localize
                        cell?.lblRemainingTime.textColor = .red
                    }else if projectList[i].is_old == "1"{
                        countdownTimer.invalidate()
                        if(projectList[i].is_video_verify == 0){
                            cell?.lblRemainingTime.text = "IN PROGRESS".localize
                            cell?.lblRemainingTime.textColor = .green
                        }else{
                        cell?.lblRemainingTime.text = "Completed"
                        cell?.lblRemainingTime.textColor = .green
                        }
                    }else if projectList[i].project_status == "in_progress"{
                        cell?.lblRemainingTime.text = "IN PROGRESS".localize
                        cell?.lblRemainingTime.textColor = .green
                    }else {
                        if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
                            cell?.lblRemainingTime.text = "0 DAY 0 HR 0 MIN 0 SEC"
                            cell?.lblRemainingTime.textColor = .red
                            countdownTimer.invalidate()
                        }else{
                            cell?.lblRemainingTime.text = countdown
                            cell?.lblRemainingTime.textColor = .red
                        }
                    }
                }
            }else{
                let currentDate = Date()
                let calendar = Calendar.current
                for i in 0..<weekProjectList.count{
                    let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate[i]! as Date)
                    let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
                    let indexPath1 = IndexPath.init(row: i, section: 0)
                    let cell = tableVw.cellForRow(at: indexPath1) as! cellCalendar
                    if weekProjectList[i].project_status == "in_progress"{
                        cell.lblRemainingTime.text = "IN PROGRESS".localize
                        cell.lblRemainingTime.textColor = .green
                    }else {
                        cell.lblRemainingTime.text = countdown
                        cell.lblRemainingTime.textColor = .red
                    }
                }
            }
        }
    }
    
    @objc func updateMediaTime() {
        if globalObjects.shared.isArVideoTimer == true{
            let currentDate = Date()
            let calendar = Calendar.current
            let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: mediaReleaseDate! as Date)
            _ = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
            
        }
    }
    
    
    
    @objc func btnShareAllProjectAction(_ sender: UIButton){
//        let items = [URL(string: "https://djconnectapp.com/\(viewerId)/\(projectList[sender.tag].id!)/ar-project-detail-page")!]
//        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//        present(ac, animated: true)
        
        self.CreateDynamicLink(productId: "\(projectList[sender.tag].id!)")
    }
    
    private func CreateDynamicLink(productId:String) -> URL{
            var deeplinkurl:URL?
            guard let link = URL(string: "https://djconnectapp.com/DJJSON/getapp.php?projectId=\(productId)") else { return URL(string: "")! }
            print(link)
            let dynamicLinksDomainURIPrefix = "https://djconnectnew.page.link"
            let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
            
            linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.DjConnectApp")
            linkBuilder?.iOSParameters?.minimumAppVersion = "1.0"
            linkBuilder?.iOSParameters?.appStoreID = "1601360647"
            linkBuilder?.iTunesConnectParameters = DynamicLinkItunesConnectAnalyticsParameters()
            linkBuilder?.iTunesConnectParameters?.providerToken = "123456"
            linkBuilder?.iTunesConnectParameters?.campaignToken = "example-promo"
            
            linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
            linkBuilder?.socialMetaTagParameters?.title = title
            linkBuilder?.socialMetaTagParameters?.descriptionText = description
            //linkBuilder?.socialMetaTagParameters?.imageURL =
            linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.djconnectapp")
            
            
        guard let longDynamicLink = linkBuilder?.url else {  return URL(string: "")! }
        print("The long URL is: \(longDynamicLink)")
        let options = DynamicLinkComponentsOptions()
        options.pathLength = .short
        linkBuilder?.shorten() { url, warnings, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let shortLink = url {
                print(shortLink)
                deeplinkurl = shortLink
                self.openShareOption(dynamicLink: deeplinkurl!, vc: self)
            }
        }
        let url = URL(string: "https://djconnectnew.page.link/ZCg5")
        
        return deeplinkurl ?? url!
        }
    
    //MARK:- Sharelink
    func openShareOption(dynamicLink:URL,vc:UIViewController){
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [dynamicLink],
            applicationActivities: nil
            
        )
        vc.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @objc func btnShareCalendarProjAction(_ sender: UIButton){
        let items = [URL(string: "https://djconnectapp.com/\(viewerId)/\(weekProjectList[sender.tag].id!)/ar-project-detail-page")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
//_mediaId: self.recentArray[sender.tag].media_id ?? 0
    @objc func btnRecentPlay_Action(_ sender: UIButton){
        if self.recentArray[sender.tag].Broadcast_id!.isEmpty == false{
            let id = self.recentArray[sender.tag].Broadcast_id!
            let veriFySTatus = self.recentArray[sender.tag].verify_status ?? 0
            callArtistVideoWebService(id, _verifyStatus: veriFySTatus, _alertId: self.recentArray[sender.tag].id ?? 0, _senderId: self.recentArray[sender.tag].sender_id ?? 0, _mediaId: self.recentArray[sender.tag].media_id ?? 0 )
        }else{
            let file = self.recentArray[sender.tag].media_audio
            let videoURL = URL(string: "\(file!)")
            if(videoURL != nil){
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            }
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnBack_Action(_ sender: UIButton) {
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        globalObjects.shared.isArVideoTimer = false
        
        if !isFromMenu{
            navigationController?.popViewController(animated: true)
        }else{
            if UserModel.sharedInstance().userType == "DJ"{
                sideMenuController?.showLeftView()

            }else{
                sideMenuController?.showLeftView()

            }
        }
        
//        if !isFromMenu{
//            navigationController?.popViewController(animated: true)
//        }else{
//            if UserModel.sharedInstance().userType == "AR"{
//                let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
//                let next1 = homeSB.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
//                sideMenuController()?.setContentViewController(next1!)
//
//
//                                let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
//                                let viewController = storyBoard.instantiateViewController(withIdentifier: "NewArtistHomeVC") as! NewArtistHomeVC
//                                self.sideMenuController?.hideLeftView()
//                                self.sideMenuController?.rootViewController?.show(viewController, sender: self)
//                                self.navigationController?.pushViewController(viewController, animated: true)
//
//
//            }else{
//                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
//                let next1 = storyBoard.instantiateViewController(withIdentifier: "DJHomeVC") as? DJHomeVC
//                sideMenuController()?.setContentViewController(next1!)
//            }
//        }
    }
    
    @IBAction func btnAdd_Action(_ sender: UIButton) {
        let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "DJAddPostVC") as! DJAddPostVC
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType(rawValue: "fade")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(desiredViewController, animated: false)
    }
    
    @IBAction func btnAllProjAction(_ sender: UIButton) {
        globalObjects.shared.isArProjStartTimer = true
        globalObjects.shared.isArWeekTimer = false
        globalObjects.shared.isArVideoTimer = false
        isCurrentWeek = true
        projectList.removeAll()
        selectedButton = "all project"
        btnAllProjects.setTitleColor(.white, for: .normal)
//        btnCalendar.setTitleColor(.lightGray, for: .normal)
//        btnStats.setTitleColor(.lightGray, for: .normal)
//        btnService.setTitleColor(.lightGray, for: .normal)
        
        
        btnAllProjects.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnCalendar.backgroundColor = .white
        btnService.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnAllProjects.setTitleColor(.white, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
        
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblAllProjectActive.isHidden = false
        lblCalendarActive.isHidden = true
        
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        vwNewCalendarView.isHidden = true
        
        viewAllProj.isHidden = false
        viewAllProj.frame = CGRect(x: 0, y: 0, width:
                                    view.frame.width, height: self.vwGradient.frame.height)
        viewAllProj.alpha = 0.0
        
        UIView.animate(withDuration: 1) {
            self.viewAllProj.alpha = 1.0
            self.vwGradient.addSubview(self.viewAllProj)
            
            self .containerHeight()
            
        }
        startIndexAllProj = 0
        callAllProjectWebService(start : 0 )
    }
    
    
    @IBAction func btnCalendarAction(_ sender: UIButton) {
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = true
        globalObjects.shared.isArVideoTimer = false
        isCurrentWeek = false
        self.vwNewCalendarView.isHidden = false
        selectedButton = "calendar"
//        btnAllProjects.setTitleColor(.lightGray, for: .normal)
//        btnCalendar.setTitleColor(.white, for: .normal)
//        btnStats.setTitleColor(.lightGray, for: .normal)
//        btnService.setTitleColor(.lightGray, for: .normal)
        
        
        btnCalendar.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnAllProjects.backgroundColor = .white
        btnService.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnAllProjects.setTitleColor(.gray, for: .normal)
        btnCalendar.setTitleColor(.white, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblAllProjectActive.isHidden = true
        lblCalendarActive.isHidden = false
        
        viewAllProj.isHidden = true
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        
        vwNewCalendarView.frame = CGRect(x: 0, y: 0, width:
                                            view.frame.width, height: self.vwGradient.frame.height)
        vwNewCalendarView.alpha = 0.0
        
        UIView.animate(withDuration: 1) {
            self.vwNewCalendarView.alpha = 1.0
            self.vwGradient.addSubview(self.vwNewCalendarView)
            self .containerHeight()
        }
        callGetWeeeklyProjListWebService()
    }
    
    @IBAction func btnServiceAction(_ sender: UIButton) {
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        selectedButton = "service"
//        btnAllProjects.setTitleColor(.lightGray, for: .normal)
//        btnCalendar.setTitleColor(.lightGray, for: .normal)
//        btnStats.setTitleColor(.lightGray, for: .normal)
//        btnService.setTitleColor(.white, for: .normal)
        
        
        btnService.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnAllProjects.backgroundColor = .white
        btnCalendar.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnAllProjects.setTitleColor(.gray, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.white, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
        
        lblServiceActive.isHidden = false
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        
        viewAllProj.isHidden = true
        vwNewCalendarView.isHidden = true
        viewStats.isHidden = true
        
        self.viewArtistService.isHidden = false
        self.viewArtistService.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 280)
        self.viewArtistService.alpha = 0.0
        self.vwGradient.addSubview(self.viewArtistService)
        UIView.animate(withDuration: 1) {
            self.viewArtistService.alpha = 1.0
        }
        containerViewHeight.constant = 135
    }
    
    @IBAction func btnStatsAction(_ sender: UIButton) {
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        globalObjects.shared.isArVideoTimer = false
        callArtistStatsWebService()
        selectedButton = "stats"
        
//        btnAllProjects.setTitleColor(.lightGray, for: .normal)
//        btnCalendar.setTitleColor(.lightGray, for: .normal)
//        btnStats.setTitleColor(.white, for: .normal)
//        btnService.setTitleColor(.lightGray, for: .normal)
        
        
        btnStats.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnAllProjects.backgroundColor = .white
        btnCalendar.backgroundColor = .white
        btnService.backgroundColor = .white
        
        btnAllProjects.setTitleColor(.gray, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.white, for: .normal)
        
        
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = false
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        
        viewAllProj.isHidden = true
        vwNewCalendarView.isHidden = true
        viewArtistService.isHidden = true
        self.viewStats.isHidden = false
        self.viewStats.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 210)
        self.viewStats.alpha = 0.0
        self.vwGradient.addSubview(viewStats)
        UIView.animate(withDuration: 1) {
            self.viewStats.alpha = 1.0
        }
        containerViewHeight.constant = cnsStatsHeight.constant
    }
    
    @IBAction func btnMediaAction(_ sender: UIButton) {
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        
        selectedButton = "media"
        
        btnAllProjects.setTitleColor(.lightGray, for: .normal)
        btnCalendar.setTitleColor(.lightGray, for: .normal)
        btnStats.setTitleColor(.lightGray, for: .normal)
        btnService.setTitleColor(.lightGray, for: .normal)
        
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjectActive.isHidden = true
        
        vwNewCalendarView.isHidden = true
        viewStats.isHidden = true
        viewArtistService.isHidden = true
        viewAllProj.isHidden = true
        scrView.layoutIfNeeded()
        
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        globalObjects.shared.isArVideoTimer = false
        if sender.title(for: .normal) == "+ Fav"{
            callAddFavWebService()
        }else if sender.title(for: .normal) == "+ unFav"{
            callUnFavouriteWebService()
        }else{
            let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
            desiredViewController.screenTypeStr = "Artist"
            desiredViewController.buttonSelected = selectedButton
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType(rawValue: "flip")
            transition.subtype = CATransitionSubtype.fromLeft
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(desiredViewController, animated: true)
        }
    }
    
    @IBAction func editImgBtnTapped(_ sender: UIButton) {
        
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        globalObjects.shared.isArVideoTimer = false
        if sender.title(for: .normal) == "+ Fav"{
            callAddFavWebService()
        }else if sender.title(for: .normal) == "+ unFav"{
            callUnFavouriteWebService()
        }else{
            let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
            desiredViewController.screenTypeStr = "Artist"
            desiredViewController.buttonSelected = selectedButton
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType(rawValue: "flip")
            transition.subtype = CATransitionSubtype.fromLeft
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(desiredViewController, animated: true)
        }
    }
    
    @IBAction func btnClosePopUp(_ sender: buttonProperties) {
        
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
    }
    
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        //toggleSideMenuView()
        
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        globalObjects.shared.isArVideoTimer = false
        if sender.title(for: .normal) == "+ Fav"{
            callAddFavWebService()
        }else if sender.title(for: .normal) == "+ unFav"{
            callUnFavouriteWebService()
        }else{
            let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
            desiredViewController.screenTypeStr = "Artist"
            desiredViewController.buttonSelected = selectedButton
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType(rawValue: "flip")
            transition.subtype = CATransitionSubtype.fromLeft
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(desiredViewController, animated: true)
        }
    }
    
    @IBAction func btnOptionAction(_ sender: UIButton) {
        vwBlockReport.isHidden = !vwBlockReport.isHidden
    }
    
    @IBAction func btnBlockAction(_ sender: UIButton) {
        if viewerId == UserModel.sharedInstance().userId{
            vwBlockReport.isHidden = true
            self.view.makeToast("Cannot Block Your Own Profile")
        }else{
            if btnBlock.currentTitle == "UnBlock"{
                callUnBlockUserWebService()
            }else{
                callBlockUserWebService()
            }
        }
    }
    @IBAction func btnReportAction(_ sender: UIButton) {
        vwBlockReport.isHidden = true
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "pause_white"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "play_button_white"), for: .normal)
        }else{
            audioPlayer?.play()
            sender.setImage(UIImage(named: "pause_white"), for: .normal)
        }
    }
    
    @IBAction func btnFacebookAction(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://facebook.com/\(FacebookUrlLink)")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func btnInstagramAction(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://instagram.com/\(InstagramUrlLInk)")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func btnYoutubeAction(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://youtube.com/\(YoutubeUrlLink)")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func btnTwitterAction(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://twitter.com/\(TwitterUrlLink)")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func btnHideBlockVwAction(_ sender: UIButton) {
        if self.vwBlockReport.isHidden == false{
            self.vwBlockReport.isHidden = true
        }
    }
    
    @IBAction func btnVerifyAction(_ sender: UIButton) {
        vwVerify.isHidden = !vwVerify.isHidden
    }
    
    @IBAction func btnVi_Play_Action(_ sender: UIButton) {
        if viewerId == UserModel.sharedInstance().userId{
            let veriFySTatus = self.recentArray[sender.tag].verify_status ?? 0
            if self.videoType == "SongReviewLive"{
                callArtistVideoWebService("\(video_broadcastId)", _verifyStatus: veriFySTatus, _alertId: self.recentArray[sender.tag].id ?? 0, _senderId: self.recentArray[sender.tag].sender_id ?? 0, _mediaId: self.recentArray[sender.tag].media_id ?? 0)
            }
            if self.videoType == "SongReview"{
                let file = self.apiVideoData
                let videoURL = URL(string: "\(file)")
                let player = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                callVideoVerifyWebservice(audioId: "\(video_verify_Id)", type: "review")
            }
            if self.videoType == "project"{

                callArtistVideoWebService("\(video_broadcastId)", _verifyStatus: veriFySTatus, _alertId: self.recentArray[sender.tag].id ?? 0, _senderId: self.recentArray[sender.tag].sender_id ?? 0, _mediaId: self.recentArray[sender.tag].media_id ?? 0)
            }
        }
    }
    
    @IBAction func btnVideoDownload_Action(_ sender: UIButton) {
        callEmailVideoSongWebservice(audioId: "0")
    }
    
    @IBAction func btnReport_Action(_ sender: UIButton) {
        if  txtVwRe_ReportDetail.text?.isEmpty == false{
            callReportApi()
        }else{
            self.view.makeToast("Enter Report Detail")
        }
    }
    
    @IBAction func btnReportCancel_Action(_ sender: UIButton) {
        blurEffectView.removeFromSuperview()
        vwReport.removeFromSuperview()
    }
    
    @IBAction func btnShowReportVw_Action(_ sender: UIButton) {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.vwReport.layer.cornerRadius = 10
        self.vwReport.center = self.view.center
        self.view.addSubview(vwReport)
    }
    
    @IBAction func btnCalendarDeleteAction(_ sender: UIButton) {
//        self.viewDeletePost.isHidden = false
//        self.viewDeletePost.frame.size.width = self.view.frame.size.width
//        self.viewDeletePost.frame.size.height = self.view.frame.size.height
//        self.viewDeletePost.layer.cornerRadius = 12.0
//        self.viewDeletePost.center = self.view.center
//        self.viewDeletePost.alpha = 1.0
//        self.view.addSubview(viewDeletePost)
    }
    
    @IBAction func btnOkayDeleteAction(_ sender: UIButton) {
        self.viewDeletePost.removeFromSuperview()
    }
    
    func activityIndicator() {
                self.spinnerr.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
                self.spinnerr.center = CGPoint(x:self.imgProfileImage.bounds.size.width / 2, y:self.imgProfileImage.bounds.size.height / 2)

                self.imgProfileImage.addSubview(self.spinnerr)
                self.spinnerr.startAnimating()
    }
    
    func hideActivityIndicator() {
            self.spinnerr.stopAnimating()
            self.imgProfileImage.removeFromSuperview()
    }
    
    //MARK: - WEBSERVICES
    func callArtistGetProfileWebService(){
        if getReachabilityStatus(){
            //calendar date fetch
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print(dateFormatter.string(from: date))
            
            Loader.shared.show()
            activityIndicator()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&current_date=\(weekDate)&profileviewid=\(viewerId)&profileviewtype=\(searchUserType)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        Loader.shared.hide()
                        //self.hideActivityIndicator()
                        self.isCurrentWeek = true
                        
                        if(getProfile.Profiledata![0].username == ""){
                            if UserModel.sharedInstance().uniqueUserName != nil{
                                self.lblDJNAME.text = "@\(UserModel.sharedInstance().uniqueUserName!)"
                            }
                        }else{
                        self.lblDJNAME.text = "@\(getProfile.Profiledata![0].username!)"
                        }
                        self.userEmailNameLbl.text = "Email: " + (getProfile.Profiledata![0].email ?? "")
                        self.userPhoneNoLbl.text = "Phone no: " + (getProfile.Profiledata![0].phone_number ?? "")
                        if self.viewerId != UserModel.sharedInstance().userId!{
                            self.vwRecent.isHidden = true
                            self.lblRecent.isHidden = true
                            self.lblRecent.text =  ""
                            self.cnsRecentHeight.constant = 0
                            if self.viewerId == UserModel.sharedInstance().userId{
                                self.btnEdit.isUserInteractionEnabled = true
                                self.btnEdit.setTitle("Edit".localize, for: .normal)
                                self.btnThreeDot.isHidden = true
                                self.editImgeBtn.isHidden = false
                                self.editImgeBtn.isUserInteractionEnabled = true
                            }else{
                                self.editImgeBtn.isHidden = true
                                self.editImgeBtn.isUserInteractionEnabled = false
                                self.btnThreeDot.isHidden = false
                                if getProfile.Profiledata![0].is_favorite! == "false"{
                                    self.btnEdit.setTitle("+ Fav".localize, for: .normal)
                                }else{
                                    self.btnEdit.setTitle("+ unFav".localize, for: .normal)
                                }
                            }
                        }else{
                            self.vwRecent.isHidden = false
                            self.cnsRecentHeight.constant = 200
                            self.lblRecent.isHidden = false
                            self.lblRecent.text =  "Recent Media"
                        }
                        self.video_broadcastId = getProfile.Profiledata![0].media_broadcastID!
                        global.audioName = getProfile.Profiledata![0].media_audio_name!
                        self.video_verify_Id = "\(getProfile.Profiledata![0].media_video_id!)"
                        self.videoType = getProfile.Profiledata![0].media_video_project!
                        self.lblCurrentLocation.text = getProfile.Profiledata![0].city! + " Joined ".localize + getProfile.Profiledata![0].join_date!
                        self.lblGenreOfMusic.text = "Genre(s) ".localize + getProfile.Profiledata![0].genre!
                        
                        self.lblBIO.text = getProfile.Profiledata![0].bio ?? ""
                        self.spinnerr.stopAnimating()
                        self.spinnerr.hidesWhenStopped = true
                        let profileImageUrl = URL(string: getProfile.Profiledata![0].profile_picture!)
                        //self.imgProfileImage.kf.indicatorType = .activity
                        //imageView.kf.indicatorType = .activity
                        self.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "Image Avatar"),  completionHandler: nil)
                        
                        self.imgRe_UserImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "Image Avatar"),  completionHandler: nil)
                        let profileImageUr = URL(string: self.setImgStr ?? "")
                        if(self.setImgStr != ""){
//                        self.imgProfileImage.kf.setImage(with: profileImageUr, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
//
//                        self.imgRe_UserImage.kf.setImage(with: profileImageUr, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            self.imgProfileImage.image = self.getImage
                            self.imgRe_UserImage.image = self.getImage
                            print("imageGet")
                        }
                        
                        UserModel.sharedInstance().userProfileUrl = getProfile.Profiledata![0].profile_picture!
                         UserModel.sharedInstance().synchroniseData()
                        
                        
                        self.lblRe_UserName.text = getProfile.Profiledata![0].username!
                        self.FacebookUrlLink = getProfile.Profiledata![0].facebook_link ?? ""
                        self.InstagramUrlLInk = getProfile.Profiledata![0].instagram_link ?? ""
                        self.YoutubeUrlLink = getProfile.Profiledata![0].youtube_link ?? ""
                        self.TwitterUrlLink = getProfile.Profiledata![0].twitter_link ?? ""
                        
                        if let recentData = getProfile.Profiledata![0].dj_recentData{
                            for _ in 0..<recentData.count{
                                self.arrRecentImage.append(false)
                            }
                            
                            self.recentArray = recentData.reversed()
                            //self.recentArray = recentData
                            self.CVwRecent.reloadData()
                        }
//                        else{
//                            self.vwRecent.isHidden = true
//                            self.cnsRecentHeight.constant = 0
//                        }
                        if self.recentArray.count > 0{
                            self.vwRecent.isHidden = false
                            self.cnsRecentHeight.constant = 200
                            self.lblRecent.isHidden = false
                            self.lblRecent.text =  "Recent Media"
                        }else{
                            self.vwRecent.isHidden = true
                            self.cnsRecentHeight.constant = 0
                            self.lblRecent.isHidden = true
                            self.lblRecent.text =  ""
                        }
//                        self.spinnerr.stopAnimating()
//                        self.spinnerr.hidesWhenStopped = true
                    }else{
                        Loader.shared.hide()
                        if(getProfile.message == "You are not authorised. Please login again."){
                            self.view.makeToast(getProfile.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                            })
                        }
                        else{
                            self.view.makeToast(getProfile.message)
                        }
                        //self.hideActivityIndicator()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    //self.hideActivityIndicator()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            Loader.shared.hide()
            self.hideActivityIndicator()
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callBlockUserWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "block_by":"\(UserModel.sharedInstance().userId!)",
                "block_to":"\(viewerId)",
                "token":"\(UserModel.sharedInstance().token!)"
            ]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.blockUserAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let blockUserModel = response.result.value!
                    if blockUserModel.success == 1{
                        self.vwBlockReport.isHidden = true
                        self.btnBlock.setTitle("UnBlock", for: .normal)
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(blockUserModel.message)
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
    
    func callAddFavWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "favorite_by":"\(UserModel.sharedInstance().userId!)",
                "favorite_to":"\(viewerId)",
                "token":"\(UserModel.sharedInstance().token!)",
                "favorite_type":"user"
            ]
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addFavoriteAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let favUserModel = response.result.value!
                    if favUserModel.success == 1{
                        self.btnEdit.setTitle("+ unFav", for: .normal)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(favUserModel.message)
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
    
    func callGetWeeeklyProjListWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            isCurrentWeek = false
            weekProjectList.removeAll()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAllProjectsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&profileviewid=\(viewerId)&profileviewtype=\(searchUserType)&start=0&limit=30"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<getWeeklyProjectListModel>) in
                
                switch response.result{
                case .success(_):
                    let getWeekProjList = response.result.value!
                    if getWeekProjList.success == 1{
                        Loader.shared.hide()
                        if let projectLis = getWeekProjList.projectList{
                            self.weekProjectList.removeAll()
                            self.WeeklyRemainingTimeArray.removeAll()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let currentWeekDate = dateFormatter.date(from: self.weekDate)
                            let first = currentWeekDate?.firstWeekDay?.timeIntervalSince1970
                            let last = currentWeekDate?.lastWeekDay?.timeIntervalSince1970
                            dateFormatter.dateFormat = "MMMM dd, yyyy"
                            for i in 0..<projectLis.count{
                                let date = dateFormatter.date (from: projectLis[i].event_date!.UTCToLocal(incomingFormat: "MMMM dd, yyyy", outGoingFormat: "MMMM dd, yyyy"))
                                let current = date?.timeIntervalSince1970
                                
                                if current! <= last! && current! > first!{
                                    self.WeeklyRemainingTimeArray.append(projectLis[i].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))
                                    self.weekProjectList.append(projectLis[i])
                                }
                            }
                            globalObjects.shared.isWeekTimer = true
                            globalObjects.shared.isDjProjStartTimer = false
                            self.startTimer()
                            self.containerHeight()
                            
                        }
                    }else{
                        self.containerHeight()
                        Loader.shared.hide()
                        self.view.makeToast(getWeekProjList.message)
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
    
    func callArtistStatsWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getArtistStatsAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)&profile_view_id=\(viewerId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjStatsModel>) in
                
                switch response.result{
                case .success(_):
                    let djStatsProfile = response.result.value!
                    if djStatsProfile.success?.stringValue == "1"{
                        Loader.shared.hide()
                        self.lblProjectNumber.text = "\(djStatsProfile.projects![0].total_project!)"
                        self.lblProjTopUser.text = "\(djStatsProfile.projects![0].top_user!)"
                        self.lblProjLastMonth.text = "\(djStatsProfile.projects![0].last_month_project!)"
                        self.lblFavNumber.text = "\(djStatsProfile.favored![0].total_favored!)"
                        self.lblFavLastMonth.text = "\(djStatsProfile.favored![0].last_month_favored!)"
                        self.lblfavTopUser.text = "\(djStatsProfile.favored![0].top_user!)"
                        self.lblProfileViewNumber.text = "\(djStatsProfile.profile_viewer![0].total_viewer!)"
                        self.lblprofileTopUser.text = "\(djStatsProfile.profile_viewer![0].top_user!)"
                        self.lblprofileLastMonth.text = "\(djStatsProfile.profile_viewer![0].last_month_viewer!)"
                        if let avgTime = djStatsProfile.Avg_time![0].total_time{
                            if avgTime.isEmpty == false{
                                let x = avgTime.components(separatedBy: ":")
                                self.lblAverageTime.text = "\(x[0])h\(x[1])m\(x[2])s"
                            }
                        }
                        if let topAvgTime = djStatsProfile.Avg_time![0].top_user_time{
                            if topAvgTime.isEmpty == false{
                                let x = topAvgTime.components(separatedBy: ":")
                                self.lblTopUserTime.text = "\(x[0])h\(x[1])m\(x[2])s"
                            }
                        }
                        if let lastAvgTime = djStatsProfile.Avg_time![0].last_month_time{
                            if lastAvgTime.isEmpty == false{
                                let x = lastAvgTime.components(separatedBy: ":")
                                self.lblLastMonthTime.text = "\(x[0])h\(x[1])m\(x[2])s"
                            }
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(djStatsProfile.message)
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
    
    func callUnBlockUserWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "unblock_by":"\(UserModel.sharedInstance().userId!)",
                "unblock_to":"\(viewerId)",
                "token":"\(UserModel.sharedInstance().token!)"
            ]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.unblockUserAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let unBlockUserModel = response.result.value!
                    if unBlockUserModel.success == 1{
                        self.btnBlock.setTitle("Block", for: .normal)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(unBlockUserModel.message)
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
    
    func callUnFavouriteWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "removeid":"\(viewerId)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.removeFavoriteAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let removefavProfile = response.result.value!
                    if removefavProfile.success == 1{
                        self.btnEdit.setTitle("+ Fav", for: .normal)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(removefavProfile.message)
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
    
    func callAllProjectWebService(start: Int){
        if getReachabilityStatus(){
            Loader.shared.show()
         
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAllProjectsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&profileviewid=\(viewerId)&profileviewtype=\(searchUserType)&start=\(start)&limit=10"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<DjAllProjectModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide() // 1
                    let getAllProjectModel = response.result.value!
                    if getAllProjectModel.success == 1{
                        self.isCurrentWeek = true
                        if globalObjects.shared.searchResultUserType != nil{
                            globalObjects.shared.searchResultUserType!.removeAll()
                        }
                        if let projectLis = getAllProjectModel.projects{
                            for i in 0..<projectLis.count{
//                                self.RemainingTimeArray.append(projectLis[i].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))
                                self.RemainingTimeArray.append(projectLis[i].closing_time!)
                                self.projectList.append(projectLis[i])
                                
                            }
                            //self.spinnerr.stopAnimating()
                            //self.spinnerr.hidesWhenStopped = true
                            globalObjects.shared.isArProjStartTimer = true
                            self.startTimer()
                            self.containerHeight()
                        }
                    }else{
                        if globalObjects.shared.searchResultUserType != nil{
                            globalObjects.shared.searchResultUserType!.removeAll()
                        }
                        Loader.shared.hide() // 2
                        //self.view.makeToast("You have no projects.")
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
    
    func callCurrencyListWebService(){
        if let currencySymobol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymobol
        }
    }
    
    func callEmailVideoSongWebservice(audioId : String){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "audio_id":"\(audioId)",
                "type":"video"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.songEmailAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let sentMailModel = response.result.value!
                    if sentMailModel.success == 1{
                        self.view.makeToast(sentMailModel.message)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(sentMailModel.message)
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
    
    func callVideoVerifyWebservice(audioId : String, type: String){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audioid":"\(audioId)",
                "type":"\(type)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.videoVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let videoVerifyModel = response.result.value!
                    self.view.makeToast(videoVerifyModel.message)
                case .failure(let error):
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callAlertApi(){
        let notiCount = UserModel.sharedInstance().notificationCount
        if notiCount != nil {
            if notiCount! > 0 {
                self.lblMenuNotifyNumber.isHidden = false
                self.lblMenuNotifyNumber.text = "\(notiCount!)"
            }else{
                self.lblMenuNotifyNumber.isHidden = true
            }
        }
    }
    
    func callReportApi(){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "report_by":"\(UserModel.sharedInstance().userId!)",
                "report_to":"\(viewerId)",
                "report_reason":"\(txtVwRe_ReportDetail.text!)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.report_userAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let reportModelProfile = response.result.value!
                    if reportModelProfile.success == 1{
                        self.view.makeToast(reportModelProfile.message)
                        self.blurEffectView.removeFromSuperview()
                        self.vwReport.removeFromSuperview()
                    }else{
                        self.view.makeToast(reportModelProfile.message)
                    }
                case .failure(let error):
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callArtistVideoWebService(_ brodcastID : String, _verifyStatus : Int, _alertId : Int, _senderId : Int, _mediaId: Int){
        
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
                    let resourceUri = videoModelProfile.resourceUri
                    self.BroadcastId = brodcastID
                    self.resourceURI = resourceUri!
//                    self.goToPlayer(_verifyStatus)
                    self.goToPlayer(_verifyStatus, _alertId, _senderId, _mediaId)
                case .failure(let error):
                    Loader.shared.hide()
                    self.view.makeToast("This broadcast was removed by user")
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func getRecentImage(BroadCastID : String) -> String{
        if getReachabilityStatus(){
            var url = ""
            let headers = [
                "Content-Type":"application/json",
                "Accept":"application/vnd.bambuser.v1+json",
                "Authorization":"Bearer GMSWiinwYhbj81RcnuhpP7"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("https://api.bambuser.com/images/\(BroadCastID)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { (response:DataResponse<VideoVerifyModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let videoModelProfile = response.result.value!
                    let resourceUri = videoModelProfile.resourceUri
                    url = resourceUri!
                case .failure(let error):
                    Loader.shared.hide()
                    self.view.makeToast("This broadcast was removed by user")
                    debugPrint(error)
                    url = ""
                }
            }
            
            return url
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
            return ""
        }
    }
    
    func callDeleteProjectWebService(_ index: Int, _ id: NSNumber){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "song_review_id":"\(id)"
            ]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.deleteProjectArSideAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let deleteModel = response.result.value!
                    if deleteModel.success == 1{
                        self.view.makeToast(deleteModel.message)
                        self.projectList.remove(at: index)
                        self.containerViewHeight.constant = self.containerViewHeight.constant - 130
                        self.tblVwAllProj.reloadData()
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
}

//MARK: - EXTENSIONS
extension ArtistViewProfileVC : DummyViewDelegate {
    func dummyViewBtnMenuClicked() {
        toggleSideMenuView()
    }
    
    func dummyViewBtnCloseClicked() {
        UIView.animate(withDuration: 0.5, animations: {
            self.vc1.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) { (isCompleted) in
            self.vc1.willMove(toParent: nil)
            self.vc1.view.removeFromSuperview()
            self.vc1.removeFromParent()
            self.viewDummyVC .isHidden = true
        }
    }
}


extension ArtistViewProfileVC :  UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tableVw{
            return 200
        }else{
            return 200
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableVw{
            return weekProjectList.count
        }else{
            return projectList.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalObjects.shared.isArProjStartTimer = false
        globalObjects.shared.isArWeekTimer = false
        if weekProjectList.isEmpty == true{
            projectId = "\(projectList[indexPath.row].id!)"
        }else{
            projectId = "\(weekProjectList[indexPath.row].id!)"
        }
        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
        vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
        vc2.delegate = self
        vc2.projectId = projectId
        vc2.musicTypeId = "\(projectList[indexPath.row].music_type ?? 0)"
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc2, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblVwAllProj{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistAllProjDetailCell", for: indexPath) as! ArtistAllProjDetailCell
            
            cell.delegate = self
            let profileImageUrl = URL(string: "\(projectList[indexPath.row].project_image!)")
            cell.imgAlbumImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            
            let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.white]
            let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]
            
            let attributedString1 = NSMutableAttributedString(string:projectList[indexPath.row].title!, attributes:attrs1)
            
//            if projectList[indexPath.row].Applied_Status == "0"{
//                let attributedString2 = NSMutableAttributedString(string:"(Pending)", attributes:attrs2)
//                attributedString1.append(attributedString2)
//            }
            cell.projctTblBgVw.layer.cornerRadius = 15
            cell.projctTblBgVw.clipsToBounds = true
            cell.projctTblBgVw.backgroundColor = UIColor(red:185/255, green:167/255, blue:221/255, alpha:0.4)
            cell.lblProjName.attributedText = attributedString1
            cell.lblDjName.text = "By ".localize + projectList[indexPath.row].project_by!
            cell.lblDateTime.text = projectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "MMM dd, yyyy")
            //let a = projectList[indexPath.row].genre?.components(separatedBy: ", ")
            //print("a",a)
            cell.lblGenre.text = "Genre(s): ".localize + projectList[indexPath.row].genre!
            
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
            
            formatter.string(from: Int(projectList[indexPath.row].expected!)! as NSNumber)
            let string55 = formatter.string(from: Int(projectList[indexPath.row].expected!)! as NSNumber)
            cell.lblExpectedNum.text = "Expected attendance - ".localize + string55!
//            cell.lblExpectedNum.text = "Expected attendance - ".localize + projectList[indexPath.row].expected!
            
            cell.lblRemainingTime.text = projectList[indexPath.row].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
            if projectList[indexPath.row].is_old == "1"{
                cell.btnShare.isHidden = true
            }else{
                cell.btnShare.isHidden = false
            }
            cell.btnShare.tag = indexPath.row
            cell.btnShare.addTarget(self, action: #selector(btnShareAllProjectAction(_:)), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellCalendar", for: indexPath) as! cellCalendar
            let profileImageUrl = URL(string: "\(weekProjectList[indexPath.row].project_image!)")
            
            cell.calenderCellBgVw.layer.cornerRadius = 15
            cell.calenderCellBgVw.clipsToBounds = true
            cell.calenderCellBgVw.backgroundColor = UIColor(red:185/255, green:167/255, blue:221/255, alpha:0.4)
            cell.imgAlbumImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.lblProjName.text = weekProjectList[indexPath.row].title
            cell.lblDjName.text = "By ".localize + weekProjectList[indexPath.row].project_by!
            cell.lblDateTime.text = weekProjectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "MMM d,yyyy")
            cell.lblGenre.text = "Genre(s): ".localize + weekProjectList[indexPath.row].genre!
            
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
            
            formatter.string(from: Int(weekProjectList[indexPath.row].expected!)! as NSNumber)
            let string56 = formatter.string(from: Int(weekProjectList[indexPath.row].expected!)! as NSNumber)
            cell.lblExpectedNum.text = "Expected attendance - ".localize + string56!
            
            let formatterr = NumberFormatter()
            formatterr.groupingSeparator = "," // or possibly "." / ","
            formatterr.numberStyle = .decimal
            formatterr.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
            let string5 = formatterr.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
            
//            cell.lblCost.text = "COST | \(self.currentCurrency)" + string5! + " per project"
            cell.lblCost.text = "\(self.currentCurrency)" + string5!
            cell.lblRemainingTime.text = weekProjectList[indexPath.row].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
            cell.btnShare.tag = indexPath.row
            cell.btnShare.addTarget(self, action: #selector(btnShareCalendarProjAction(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.maximumButtonWidth = 90
        options.minimumButtonWidth = 90
        options.buttonSpacing = 8
        return options
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if projectList[indexPath.row].is_old == "1" || projectList[indexPath.row].is_cancelled == 1{
            guard orientation == .right else { return nil }
            projectId = "\(projectList[indexPath.row].id!)"
            let applied_id = projectList[indexPath.row].applied_id ?? 0
            if UserModel.sharedInstance().userId == viewerId {
                let profile = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                    self.callDeleteProjectWebService(indexPath.row, applied_id)
                    print("swiped")
                }
                profile.backgroundColor = UIColor .themeWhite
                profile.image = UIImage(named: "delete_post")
                profile.font = .boldSystemFont(ofSize: 10)
                profile.textColor = UIColor.red
                return [profile]
            }else {
                return nil
            }
        }else{
            return nil
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView.tag == 0 {
            print(projectList.count)
            if indexPath.row == projectList.count - 1{
                startIndexAllProj = 10 + startIndexAllProj
                callAllProjectWebService(start: startIndexAllProj)
            }
        }
    }
}
extension ArtistViewProfileVC : FSCalendarDataSource, FSCalendarDelegate {
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return date
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        globalObjects.shared.isArProjStartTimer = false
        WeeklyRemainingTimeArray.removeAll()
        getWeekDate()
        callGetWeeeklyProjListWebService()
    }
    
}
extension ArtistViewProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCell", for: indexPath) as! ArtistRecentDetails
        cell.lblAlbumName.text = recentArray[indexPath.row].project_name!
        cell.lblByName.text = "@\(recentArray[indexPath.row].dj_name!)"
        cell.cellBgrndVw.layer.cornerRadius = 15
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let dateDisplay = dateFormatter.date(from:recentArray[indexPath.row].created_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "MMM dd, yyyy"))
//        cell.lblTimeAgo.text = dateDisplay?.timeAgoSinceDate()
        
        let dateString = recentArray[indexPath.row].created_date
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter1.date(from: dateString ?? "")
        dateFormatter1.dateFormat = "MMM d, yyyy"
        let date2 = dateFormatter1.string(from: date!)
        cell.lblTimeAgo.text = date2
        
        if recentArray[indexPath.row].media_type == "audio"{
            cell.imgPlay.isHidden = false
            cell.imgRecentImage.image = UIImage(named: "DJConnectAudioLogo")
            
        }
        if recentArray[indexPath.row].media_type == "video"{
            cell.imgPlay.isHidden = true
            cell.imgRecentImage.kf.indicatorType = .activity
            if let video_url = recentArray[indexPath.row].media_image{
                if video_url.isEmpty == false{
                    let url = URL(string: "\(video_url)")
                    cell.imgRecentImage.contentMode = .scaleToFill
                    cell.imgRecentImage.kf.setImage(with: url, placeholder: UIImage(named: ""),  completionHandler: nil)
                }else{
                    cell.imgRecentImage.backgroundColor = .lightGray
                }
            }
            
            cell.btnRecentPlay.tag = indexPath.row
            cell.btnRecentPlay.addTarget(self, action: #selector(btnRecentPlay_Action(_:)), for: .touchUpInside)
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if recentArray[indexPath.row].media_type == "audio"{
//            return CGSize(width:157, height: 157)
//        }else{
//            return CGSize(width:180, height: 157)
//        }
//    }
}

extension ArtistViewProfileVC : artistDummyViewDelegate {
    func artistViewBtnCloseClicked() {
        toggleSideMenuView()
    }
    
    func artistViewBtnMenuClicked() {
        UIView.animate(withDuration: 0.5, animations: {
            self.vc2.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) { (isCompleted) in
            self.vc2.willMove(toParent: nil)
            self.vc2.view.removeFromSuperview()
            self.vc2.removeFromParent()
        }
    }
}
