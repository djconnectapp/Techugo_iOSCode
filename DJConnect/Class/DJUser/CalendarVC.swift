//
//  djCalendarVC.swift
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
import FirebaseDynamicLinks
import LGSideMenuController

class CalendarProjArtistConDetailCell : UITableViewCell{
    @IBOutlet weak var imgProfileImage: imageProperties!
    @IBOutlet weak var lblArtistSongName: UILabel!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblArtistMusicGenre: UILabel!
    @IBOutlet weak var btnArtistConnectedPlay: UIButton!
    @IBOutlet weak var lblArtistMinTime: UILabel!
    @IBOutlet weak var lblArtistMaxTime: UILabel!
    @IBOutlet weak var artistConnectedSlider: UISlider!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
}

class CalendarProjectStatusDetailCell : SwipeTableViewCell{
    @IBOutlet weak var imgProfileImage: imageProperties!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongBy: UILabel!
    @IBOutlet weak var lblSongGenre: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var SliderSong: UISlider!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblOffering: UILabel!
    @IBOutlet weak var lblCost: UILabel!
}

class AllProjectDetailCell : SwipeTableViewCell{
    
    @IBOutlet weak var projectCellBgVw: UIView!
    @IBOutlet weak var imgAlbumImage: imageProperties!
    @IBOutlet weak var lblProjName: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblExpectedNum: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var lblStarRating: UILabel!
    @IBOutlet weak var lblRatingNumber: UILabel!
    @IBOutlet weak var cnsLblRemainingTime: NSLayoutConstraint!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var vwNumberTab: UIView!
    @IBOutlet weak var lblWaitingNumber: UILabel!
    @IBOutlet weak var lblAcceptedNumber: UILabel!
    @IBOutlet weak var lblNotAcceptedNumber: UILabel!
   // @IBOutlet weak var cnsShareTrailing: NSLayoutConstraint!
}

class RecentDetails : UICollectionViewCell{
    @IBOutlet weak var imgRecentImage: UIImageView!
    @IBOutlet weak var btnRecentPlay: UIButton!
    @IBOutlet weak var lblAlbumName: UILabel!
    @IBOutlet weak var lblByName: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    @IBOutlet weak var imgPlay: UIImageView!
}

class calendarDetails : SwipeTableViewCell {
    @IBOutlet weak var imgAlbumImage: UIImageView!
    @IBOutlet weak var lblProjName: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblExpectedNum: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblWaitNo: UILabel!
    @IBOutlet weak var lblAcceptNo: UILabel!
    @IBOutlet weak var lblRejectNo: UILabel!
    @IBOutlet weak var VwNumberTab: UIView!
    @IBOutlet weak var calendrCellBgVw: UIView!
}

class CalendarVC: UIViewController{
    
    //MARK: - OUTLETS
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var vwCalendar: UIView!
    @IBOutlet weak var scrTutorial: UIScrollView!
    @IBOutlet weak var vwProfileComplete: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet var viewCalendar: UIView!
    @IBOutlet weak var viewAllProject: UIView!
    @IBOutlet var viewService: UIView!
    @IBOutlet var viewStats: UIView!
    @IBOutlet var viewDeletePost: UIView!
    @IBOutlet weak var viewDeletePostBlur: UIView!
    @IBOutlet weak var tblVwAllProj: UITableView!
    @IBOutlet weak var cnsServiceHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsStatsHeight: NSLayoutConstraint!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var btnYesCross: UIButton!
    @IBOutlet weak var btnNoCross: UIButton!
    @IBOutlet weak var btnCalendarDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet weak var btnThreeDot: UIButton!
    
    //height - constraints - outlet
    @IBOutlet weak var cnsRecentHeight: NSLayoutConstraint!
    @IBOutlet weak var CVwRecent: UICollectionView!
    
    // vw profile outlets
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
    
    //mainscreen localize outlets
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAllProject: UIButton!
    @IBOutlet weak var btnCalendar: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnStats: UIButton!
    @IBOutlet weak var lblRecent: UILabel!
    @IBOutlet weak var lblVerified: UILabel!
    @IBOutlet weak var lblVerifyAck: UILabel!
    
    //viewservice
    @IBOutlet weak var lblDjfeedback: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblDjdrops: UILabel!
    @IBOutlet weak var lblpricedjdrop: UILabel!
    @IBOutlet weak var lblFeedbackDetail: UILabel!
    @IBOutlet weak var lblDropDetail: UILabel!
    
    @IBOutlet weak var lblDJNAME: UILabel!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    @IBOutlet weak var lblBIO: UILabel!
    
    @IBOutlet weak var userEmailNameLbl: UILabel!
    @IBOutlet weak var userPhoneNoLbl: UILabel!
    
    
    //delete post - outlets
    @IBOutlet weak var lblDeletePost: UILabel!
    @IBOutlet weak var lblDeletePostDetail: UILabel!
    @IBOutlet weak var btnOkGotIt: buttonProperties!
    
    //other
    @IBOutlet weak var lblGenreOfMusic: UILabel!
    @IBOutlet weak var vwBlockReport: viewProperties!
    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var vwRecent: UIView!
    
    //stat screen outlet
    @IBOutlet weak var lblUserRatingCount: UILabel!
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
    @IBOutlet weak var lblTopAverageTime: UILabel!
    @IBOutlet weak var lblLastAvgTime: UILabel!
    
    //media/nomedia views
    @IBOutlet weak var vwMediaYes: UIView!
    @IBOutlet weak var vwMediaNo: UIView!
    
    //Active-line Layout
    @IBOutlet weak var lblCalendarActive: UILabel!
    @IBOutlet weak var lblServiceActive: UILabel!
    @IBOutlet weak var lblStatsActive: UILabel!
    @IBOutlet weak var lblAllProjActive: UILabel!
    
    @IBOutlet weak var tblSongStatus: UITableView!
    @IBOutlet weak var vwRating: HCSStarRatingView!
    @IBOutlet var vwProjectStatus: UIView!
    @IBOutlet weak var lblConnectSubmission: UILabel!
    @IBOutlet weak var lblSongStatusDetail: UILabel!
    @IBOutlet weak var lblSongStatus: UILabel!
    @IBOutlet var vwRejectReason: viewProperties!
    @IBOutlet var vwArtistConnected: UIView!
    @IBOutlet weak var lblArtistConnected: UILabel!
    @IBOutlet weak var tblArtistConnected: UITableView!
    
    @IBOutlet weak var lblReason1: UILabel!
    @IBOutlet weak var lblReason2: UILabel!
    @IBOutlet weak var lblReason3: UILabel!
    @IBOutlet weak var lblReason4: UILabel!
    @IBOutlet weak var lblReason5: UILabel!
    
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var vwVerify: viewProperties!
    
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    
    //localize stats
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
    @IBOutlet weak var lblLo_ArRating: UILabel!
    
    //localize sub views
    @IBOutlet weak var lblLo_ArtConDetail: UILabel!
    @IBOutlet weak var lblLo_ArtCon: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCANCEL: UIButton!
    
    //view report
    @IBOutlet var vwReport: UIView!
    @IBOutlet weak var imgRe_DjImage: imageProperties!
    @IBOutlet weak var lblRe_UserName: UILabel!
    @IBOutlet weak var txtVwRe_ReportDetail: UITextView!
    
    @IBOutlet weak var lblAutoDelete_video: UILabel!
    
    @IBOutlet weak var lblDjRemix: UILabel!
    @IBOutlet weak var lblRemixPrice: UILabel!
    @IBOutlet weak var lblRemixDetail: UILabel!
    //MARK: - ENUMS
    @IBOutlet weak var editImgBtn: UIButton!
    
    @IBOutlet weak var joinedDateLbl: UILabel!
    
    @IBOutlet weak var bioHdrLbl: UILabel!
    
    @IBOutlet weak var prjctVw: UIView!
    @IBOutlet weak var calendrBtnVw: UIView!
    @IBOutlet weak var serviceBtnVw: UIView!
    @IBOutlet weak var statsVw: UIView!
    
    @IBOutlet weak var serviceReactRevwBgVw: UIView!
    @IBOutlet weak var noserviceBgVw: UIView!
    @IBOutlet weak var serviceImgBgVw: UIView!

    
    enum swipeSelectedOption {
        case wait
        case accept
        case reject
        case connected
    }
    
    enum songStatus{
        case waiting
        case accepted
        case notAccepted
    }
    //MARK: - GLOBAL VARIABLES
    
    fileprivate weak var calendar: FSCalendar!
    
    var thisWeek : Int?
    var myWeek : Int?
    let startingIndex = 400
    var postDate = String()
    var date = Date()
    var selectedButton = "all project"
    var vc1 = DJProjectDetail()
    //var vc1 = PostDetailViewController()
    var vc2 = ArtistProjectDetailVC()
    var currentDateValue : String!
    var projectId = String()
    var viewerId = String()
    var currentWeek = true
    var projectUserId = String()
    var dropStatus = String()
    var feedBackStatus = String()
    var remixStatus = String()
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
    var yesNoData = String()
    var userSearched = String()
    var priceFeedback = String()
    var currencyFeedback = String()
    var priceDrop = String()
    var currencyDrop = String()
    var searchUserType = String()
    var FacebookUrlLink = String()
    var InstagramUrlLInk = String()
    var YoutubeUrlLink = String()
    var TwitterUrlLink = String()
    var userName = String()
    var priceDropwithSymbol = String()
    var priceReviewwithSymbol = String()
    var priceRemixwithSymbol = String()
    var releaseDate = [NSDate?]()
    var allProjReleaseDate = [NSDate?]()
    var mediaReleaseDate: NSDate?
    var countdownTimer = Timer()
    var mediaCountDownTimer = Timer()
    var remainingTime = String()
    var RemainingTimeArray = [String]()
    var WeeklyRemainingTimeArray = [String]()
    var indexPathRow = Int()
    var tutorialIsHide = String()
    var djImageUrl = String()
    var songStatusArray = [appliedAudioDataDetail]()
    var swipeOption = swipeSelectedOption.wait
    var SliderValue = [String]()
    var mintime = [String]()
    var maxtime = [String]()
    var projCost = String()
    var removeIndex = Int()
    var Audio_id = String()
    var selectedStatus = songStatus.waiting
    let blurEffectView = UIVisualEffectView(effect: globalObjects.shared.blurEffect)
    var RejectReason = String()
    var waitCount = String()
    var acceptCount = String()
    var rejectCount = String()
    var acceptArrayId = [String]()
    var stringArrayCleaned = String()
    var currentCurrency = String()
    var currList = [CurrencyDataDetail]()
    var recentArray = [recentDataDetail]()
    var apiVideoData = String()
    var videoType = String()
    var mediaRemainingTime = String()
    var count = Int()
    var startIndexAllProj = 0
    var startIndexWeekProj = 0
    var spinner = UIActivityIndicatorView(style: .gray)
    var artist_ID = String()
    var is_drop_type = String()
    var is_songReview_type = String()
    var is_remix_type = String()
    var video_broadcastId = String()
    var resourceURI = String()
    var video_verify_Id = String()
    var broadCastID = ""
    var isFromMenu = true
    
    var isProjOldSt = String()
    var isInProgressSt = String()
    
    var saveServiceCity = String()
    var saveServiceCountry = String()
    var saveServiceLat = String()
    var saveServiceLong = String()
    var zeroTimeStr = String()
    var TimeValueStr = String()
    
    @IBOutlet weak var deleteProjBtn: UIButton!

    
    var spinnerr = UIActivityIndicatorView(style: .whiteLarge)
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editImgBtn.isHidden = true
        btnEdit.isHidden = true
        
        tblVwAllProj.separatorStyle = .none
        tableVw.separatorStyle = .none
        
        prjctVw.layer.cornerRadius = 10.0
        prjctVw.clipsToBounds = true
        calendrBtnVw.layer.cornerRadius = 10.0
        calendrBtnVw.clipsToBounds = true
        serviceBtnVw.layer.cornerRadius = 10.0
        serviceBtnVw.clipsToBounds = true
        statsVw.layer.cornerRadius = 10.0
        statsVw.clipsToBounds = true
        btnAllProject.layer.cornerRadius = 10.0
        btnAllProject.clipsToBounds = true
        btnCalendar.layer.cornerRadius = 10.0
        btnCalendar.clipsToBounds = true
        btnService.layer.cornerRadius = 10.0
        btnService.clipsToBounds = true
        btnStats.layer.cornerRadius = 10.0
        btnStats.clipsToBounds = true
        
        serviceReactRevwBgVw.layer.cornerRadius = 10.0
        serviceReactRevwBgVw.clipsToBounds = true
        
        noserviceBgVw.layer.cornerRadius = 10.0
        noserviceBgVw.clipsToBounds = true
        
        serviceImgBgVw.layer.cornerRadius = 10.0
        serviceImgBgVw.clipsToBounds = true
        
        prjctVw.backgroundColor = .white
        calendrBtnVw.backgroundColor = .white
        serviceBtnVw.backgroundColor = .white
        statsVw.backgroundColor = .white
        
        btnAllProject.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnCalendar.backgroundColor = .white
        btnService.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnAllProject.setTitleColor(.white, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
        
        self.cnsRecentHeight.constant = 0
        self.vwRecent.isHidden = true
        
        
        deleteProjBtn.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        txtVwRe_ReportDetail.layer.borderWidth = 2
        txtVwRe_ReportDetail.layer.borderColor = UIColor.black.cgColor
        let placeholderString = "Enter Report Detail"
        txtVwRe_ReportDetail.placeholder = placeholderString
        count = 1
        
        self.calendarview()
        
        vwRating.value = 4.5
        vwRating.isUserInteractionEnabled = false
        
       // editImgBtn.setImageTintColor = .white
        let origImage = UIImage(named: "edit (3)")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        editImgBtn.setImage(tintedImage, for: .normal)
        editImgBtn.tintColor = .white
        
        if btnEdit.currentTitle == "+ Fav" || btnEdit.currentTitle == "+ unFav"{
            self.editImgBtn.isHidden = true
            self.editImgBtn.isUserInteractionEnabled = false
            if viewerId == UserModel.sharedInstance().userId{
                btnEdit.isUserInteractionEnabled = false
            }else{
                btnEdit.isUserInteractionEnabled = true
            }
        }
        if viewerId.isEmpty{
            viewerId = UserModel.sharedInstance().userId!
        }
        userSelection()
        viewService.isHidden = true
        viewStats.isHidden = true
        viewCalendar.isHidden = true
        
        self.viewAllProject.isHidden = false
        
        // api is not running
        if globalObjects.shared.searchResultUserType?.isEmpty == true || globalObjects.shared.searchResultUserType == nil{
            searchUserType = UserModel.sharedInstance().userType!
        }else{
            searchUserType = globalObjects.shared.searchResultUserType!
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        localizeElements()
        RemainingTimeArray.removeAll()
        WeeklyRemainingTimeArray.removeAll()
        //releaseDate.removeAll() //comnted by ashitesh  for crash
        //weekProjectList.count1 4
        //releaseDate.count1 0

        NotificationCenter.default.post(name: Notification.Name(rawValue: "sidemenuProfilePresent"), object: nil)
        vwBlockReport.isHidden = true
        
//        if UserModel.sharedInstance().appLanguage == "0"{
//            btnBack.setImage(UIImage(named: "back_arrow_arabic"), for: .normal)
//        }else{
//            btnBack.setImage(UIImage(named: "back_arrow_english"), for: .normal)
//        }
        
        if globalObjects.shared.dropCompleteConnect == true{
            dropCompleteMedia()
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrView.isScrollEnabled = true
        scrView.contentSize = CGSize(width: self.view.frame.width, height: 1100)
        if viewAllProject.isHidden == false{
            isCurrentWeek = true
            intialContainerHeight() //11
        }
        if viewCalendar.isHidden == false{
            isCurrentWeek = false
            intialContainerHeight()
        }
        
        if viewService.isHidden == false{
            scrView.contentSize = CGSize(width: self.view.frame.width, height: 1180)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        if UserModel.sharedInstance().userId == nil{
            return
        }
        
        getWeekDate()
        callCurrencyListWebService()
        if UserModel.sharedInstance().userId! == viewerId{
           // callGetDjTutorialWebService() ashitesh - hide instruction view
        }
        
       // callAlertApi()
        callGetProfileWebService()
        callAlertApi()
        callGetWeeeklyProjListWebService()
        print(selectedButton)
        
        if selectedButton == "all project"{
            btnAllProject.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
            btnCalendar.backgroundColor = .white
            btnService.backgroundColor = .white
            btnStats.backgroundColor = .white
            
            btnAllProject.setTitleColor(.white, for: .normal)
            btnCalendar.setTitleColor(.gray, for: .normal)
            btnService.setTitleColor(.gray, for: .normal)
            btnStats.setTitleColor(.gray, for: .normal)
            
            //btnAllProject.setTitleColor(.white, for: .normal)
            startIndexAllProj = 0
            projectList.removeAll()
            callAllProjectWebService(start: 0)
        }
        if selectedButton == "calendar" {
            
            btnCalendar.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
            btnCalendar.backgroundColor = .white
            btnService.backgroundColor = .white
            btnStats.backgroundColor = .white
            
            btnAllProject.setTitleColor(.gray, for: .normal)
            btnCalendar.setTitleColor(.white, for: .normal)
            btnService.setTitleColor(.gray, for: .normal)
            btnStats.setTitleColor(.gray, for: .normal)
            
            startIndexWeekProj = 0
            callGetWeeeklyProjListWebService()
        }
        if selectedButton == "media"{
            btnStats.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
            btnCalendar.backgroundColor = .white
            btnService.backgroundColor = .white
            btnAllProject.backgroundColor = .white
            
            btnAllProject.setTitleColor(.gray, for: .normal)
            btnCalendar.setTitleColor(.gray, for: .normal)
            btnService.setTitleColor(.gray, for: .normal)
            btnStats.setTitleColor(.white, for: .normal)
            setMediaView()
        }
        if selectedButton == "service"{
            
            btnService.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
            btnCalendar.backgroundColor = .white
            btnService.backgroundColor = .white
            btnStats.backgroundColor = .white
            
            btnAllProject.setTitleColor(.gray, for: .normal)
            btnCalendar.setTitleColor(.gray, for: .normal)
            btnService.setTitleColor(.white, for: .normal)
            btnStats.setTitleColor(.gray, for: .normal)
            
            setServiceView()
        }
    }
    
    //MARK: - OTHER METHODS
    func containerHeight() {
        if isCurrentWeek == true{
            self.tblVwAllProj.reloadData()
//            let heightcustom = projectList.count * 130 + 20
            let heightcustom = projectList.count * 167 + 20
            self.containerViewHeight.constant = CGFloat(heightcustom)
            self.tblVwAllProj.reloadData()
            scrView.layoutIfNeeded()
        }else{
            self.tableVw.reloadData()
            let heightcustom = weekProjectList.count * 130
            self.containerViewHeight.constant = CGFloat(heightcustom + 130)
            self.tableVw.reloadData()
            scrView.layoutIfNeeded()
        }
    }
    
    func intialContainerHeight(){
        if isCurrentWeek == true{
            self.tblVwAllProj.reloadData()
//            let heightcustom = projectList.count * 130 + 20
            let heightcustom = projectList.count * 167 + 20
            self.containerViewHeight.constant = CGFloat(heightcustom)
            scrView.contentSize = CGSize(width: self.view.frame.width, height: 845 + containerViewHeight.constant)
            self.tblVwAllProj.reloadData()
            scrView.layoutIfNeeded()
        }else{
            self.tableVw.reloadData()
            let heightcustom = weekProjectList.count * 130
            self.containerViewHeight.constant = CGFloat(heightcustom + 100)
            scrView.contentSize = CGSize(width: self.view.frame.width, height: 845 + containerViewHeight.constant)
            self.tableVw.reloadData()
            scrView.layoutIfNeeded()
        }
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
            //self.editImgBtn.isHidden = false // for new design it is hide
            self.editImgBtn.isHidden = true
            self.editImgBtn.isUserInteractionEnabled = true
        }else {
            if UserModel.sharedInstance().isPin == true {
            scrTutorial.isHidden = true
            }else{
                btnEdit.isUserInteractionEnabled = true
                btnEdit.setTitle("Edit".localize, for: .normal)
                btnThreeDot.isHidden = true
                //self.editImgBtn.isHidden = false // for new design it is hide
                self.editImgBtn.isHidden = true
                self.editImgBtn.isUserInteractionEnabled = true
            }
        }
        
        if viewerId == UserModel.sharedInstance().userId{
            btnEdit.isUserInteractionEnabled = true
            btnEdit.setTitle("Edit".localize, for: .normal)
            btnThreeDot.isHidden = true
            //self.editImgBtn.isHidden = false // for new design it is hide
            self.editImgBtn.isHidden = true
            self.editImgBtn.isUserInteractionEnabled = true
        }else{
            btnEdit.setTitle("+ Fav".localize, for: .normal)
//            btnThreeDot.isHidden = false
            btnThreeDot.isHidden = true
            btnThreeDot.isUserInteractionEnabled = false
            self.editImgBtn.isHidden = true
            self.editImgBtn.isUserInteractionEnabled = false
        }
        btnCalendarDelete.isHidden = false
    }
    
    
    func ChangeRootUsingFlip() {
        let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationProfile") as! UINavigationController
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
    
    func djPopUpShowHide(){
        if UserModel.sharedInstance().userType == "DJ"{
            if !Identity.isIntroSeen() {
                scrTutorial.isHidden = false
                if viewerId != UserModel.sharedInstance().userId{
                    scrTutorial.isHidden = true
                }
            }else{
                scrTutorial.isHidden = true
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCalendarDateclick" {
            let destinationVC = segue.destination as! DJSelectProjectTypeVC
            destinationVC.dateSelected = postDate
            destinationVC.postDate = date
        }
        if segue.identifier == "segueCalendarDjdrop"{
            let destinationVC = segue.destination as! DjDropVC
            destinationVC.projectUserId = projectUserId
            destinationVC.projBy = userName
            destinationVC.connectCost = priceDropwithSymbol
            destinationVC.userProfile = imgProfileImage.image!
            destinationVC.currentCurrency = currentCurrency
            destinationVC.dropType = self.is_drop_type
        }
        if segue.identifier == "segueCalendarDjSongReview"{
            let destinationVC = segue.destination as! DJSongReviewsVC
            destinationVC.djId = projectUserId
            destinationVC.projBy = userName
            destinationVC.connectCost = priceReviewwithSymbol
            destinationVC.userProfile = imgProfileImage.image!
            destinationVC.currentCurrency = currentCurrency
        }
        if segue.identifier == "segueVideoVerify" {
            let destinationVC = segue.destination as! VideoVerifyVC
            destinationVC.artist_id = artist_ID
            destinationVC.project_id = projectId
            destinationVC.liveType = "project"
        }
        if segue.identifier == "segueDJArtistBambuserPlayer" {
            let destinationVC = segue.destination as! ArtistBambUserPlayerVC
            destinationVC.uri = resourceURI
            destinationVC.backType = "profile"
            destinationVC.videoType = "project"
            destinationVC.broadCastID = self.broadCastID
            destinationVC.screenCnnect = "DJScreen"
        }
        if segue.identifier == "segueCalendarDjRemix"{
            let destinationVC = segue.destination as! DjRemixVC
            destinationVC.projectUserId = projectUserId
            destinationVC.artist_id = viewerId
            destinationVC.projBy = userName
            destinationVC.connectCost = priceRemixwithSymbol
            destinationVC.userProfile = imgProfileImage.image!
            destinationVC.currentCurrency = currentCurrency
        }
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
        print(weekDate)
    }
    
    
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.view.bounds
        
        self.viewMain.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func localizeElements(){
        lblDjfeedback.text = "DJ Feedback".localize
        lblDjdrops.text = "DJ Drops".localize
        
        lblprofileComplete.text = "PROFILE COMPLETE".localize
        lblNowythatyouhave.text = "Now that you have completed all steps. Below are instructions on how to add your project for artists to connect with you.".localize
        lbl1st.text = "1st - ADD CONNECT PROJECT".localize
        lblclicondate.text = "Click on the date from your calendar. Enter the details of your project and add the connect project. Then, wait for artists to submit their music.".localize
        lbl2nd.text = "2nd - ACCEPT/DON'T ACCEPT CONNECTS".localize
        lblonceartistsubmit.text = "Once artists submit their music to connect with your project, listen and accept or don't accept it.".localize
        lbl3rd.text = "3rd - COMPLETE PROJECT".localize
        lblwheneyouhave.text = "When you have enough artist submissions for your connect project,click on the complete project button to end the project and stop submissions.".localize
        lbl4th.text = "4th. - DOWNLOAD".localize
        lblgotoyourproject.text = "Go to your project page and download all artists songs you've accepted by clicking on the download button under each artist's .".localize
        lbl5th.text = "5th. - PLAY & VERIFY".localize
        lblAfterDownloading.text = "After downloading the songs,play them at your event. While playing each song click on the verify button and go live to show proof to the artists.".localize
        lbl6th.text = "6th. - GET PAID".localize
        lblaftereachconnect.text = "After each connect is verified, payment from the artist will be deposited into your account.".localize
        lblshowthisnext.text = "Show this next time?".localize
        lblyesvwprofile.text = "yes".localize
        lblnovwprofile.text = "no".localize
        btnclosepopup.setTitle("CLOSE".localize, for: .normal)
        lblDeletePost.text = "DELETE POST".localize
        lblDeletePostDetail.text = "Delete_Post_Detail".localize
        btnOkGotIt.setTitle("ok got it".localize, for: .normal)
        //vw service
        btnReport.setTitle("Report".localize, for: .normal)
        btnBlock.setTitle("Block".localize, for: .normal)
        btnAllProject.setTitle("Projects", for: .normal)
//        btnAllProject.setTitle("PROJECTS".localize, for: .normal)
//        btnCalendar.setTitle("CALENDAR".localize, for: .normal)
        btnService.setTitle("SERVICES".localize, for: .normal)
        btnStats.setTitle("STATS".localize, for: .normal)
       // lblRecent.text = "RECENT".localize // RECENT MEDIA
        lblVerified.text = "VERIFIED".localize
        lblVerifyAck.text = "DJ_VERIFY_ACK".localize
        lblLo_TotProj.text = "# of Total Projects".localize
        //lblLo_FavUser.text = "# of Users Favoured You".localize
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
        lblLo_ArRating.text = "Artist Rating".localize
        lblLo_ArtCon.text = "ARTIST CONNECTED".localize
        lblLo_ArtConDetail.text = "dj_connect_ack".localize
        btnOK.setTitle("Ok".localize, for: .normal)
        btnCANCEL.setTitle("Cancel".localize, for: .normal)
        lblReason1.text = "Reason_1".localize
        lblReason2.text = "Reason_2".localize
        lblReason3.text = "Reason_3".localize
        lblReason4.text = "Reason_4".localize
        lblReason5.text = "Reason_5".localize
        lblConnectSubmission.text = "CONNECT SUBMISSIONS".localize
    }
    
    func dropCompleteMedia(){
        selectedButton = "media"
        setMediaSectionFontColor()
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjActive.isHidden = true
        
        viewCalendar.isHidden = true
        viewStats.isHidden = true
        viewService.isHidden = true
        viewAllProject.isHidden = true
        
        if apiSongData.isEmpty{
            vwMediaYes.isHidden = true
            vwMediaNo.isHidden = false
        }else{
            vwMediaYes.isHidden = false
            vwMediaNo.isHidden = true
        }
        globalObjects.shared.dropCompleteConnect = false
    }
    
    func startTimer() {
        if globalObjects.shared.isDjProjStartTimer == true || globalObjects.shared.isWeekTimer == true{
            
            if isCurrentWeek == true{
                for i in 0..<projectList.count{
                    if(RemainingTimeArray.count > 0){
                    let releaseDateString = "\(RemainingTimeArray[i])"
                    let releaseDateFormatter = DateFormatter()
                    releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    allProjReleaseDate.append(releaseDateFormatter.date(from: releaseDateString)! as NSDate)
                    countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                    }
                }
            }else{
                for i in 0..<weekProjectList.count{
                    let releaseDateString = "\(WeeklyRemainingTimeArray[i])"
                    let releaseDateFormatter = DateFormatter()
                    releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    releaseDate.append(releaseDateFormatter.date(from: releaseDateString)! as NSDate)
                    countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                }
                print("weekProjectList.count",weekProjectList.count)
                print("releaseDate.count",releaseDate.count)
            }
        }
    }
    
    func startMediaTimer() {
        if globalObjects.shared.isDjVideoTimer == true{
            let releaseDateString = "\(mediaRemainingTime)"
            let releaseDateFormatter = DateFormatter()
            releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            mediaReleaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
            mediaCountDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMediaTime), userInfo: nil, repeats: true)
        }
    }
    
    func setMediaView(){
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        setMediaSectionFontColor()
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjActive.isHidden = true
        
        viewCalendar.isHidden = true
        viewStats.isHidden = true
        viewService.isHidden = true
        viewAllProject.isHidden = true
        
        if self.viewerId == UserModel.sharedInstance().userId!{
            if apiSongData.isEmpty{
                vwMediaYes.isHidden = true
                vwMediaNo.isHidden = false
            }else{
                vwMediaYes.isHidden = false
                vwMediaNo.isHidden = true
            }
        }else{
            vwMediaYes.isHidden = true
            vwMediaNo.isHidden = false
        }
    }
    
    func setServiceView(){
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        selectedButton = "service"
        setMediaSectionFontColor()
        lblServiceActive.isHidden = false
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        viewCalendar.isHidden = true
        viewStats.isHidden = true
        self.viewService.isHidden = false
        self.viewService.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400)
        self.viewService.alpha = 0.0
        self.viewMain.addSubview(self.viewService)
        UIView.animate(withDuration: 1) {
            self.viewService.alpha = 1.0
        }
        containerViewHeight.constant = cnsServiceHeight.constant
    }
    
    func OnGoingpreparePlayer(_ songurl: URL?) {
        guard let url = songurl else {
            print("Invalid URL")
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 0.7
            
            minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            print("TOTAL TIMER: \(minuteString):\(secondString)")
            let indexPath1 = IndexPath.init(row: indexPathRow, section: 0)
            let cell = tblSongStatus.cellForRow(at: indexPath1) as! CalendarProjectStatusDetailCell
            cell.SliderSong.maximumValue = Float(Double(self.audioPlayer!.duration))
            self.audioPlayer?.currentTime = Double(cell.SliderSong.value)
            cell.lblMinTime.text = String(cell.SliderSong.value)
            cell.lblMaxTime.text = "\(minuteString):\(secondString)"
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateStatusSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }
    
    func ArtistConpreparePlayer(_ songurl: URL?) {
        guard let url = songurl else {
            print("Invalid URL")
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 0.7
            
            minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            let indexPath1 = IndexPath.init(row: indexPathRow, section: 0)
            let cell = tblArtistConnected.cellForRow(at: indexPath1) as! CalendarProjArtistConDetailCell
            cell.artistConnectedSlider.maximumValue = Float(Double(self.audioPlayer!.duration))
            self.audioPlayer?.currentTime = Double(cell.artistConnectedSlider.value)
            cell.lblArtistMinTime.text = String(cell.artistConnectedSlider.value)
            cell.lblArtistMaxTime.text = "\(minuteString):\(secondString)"
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateArtistConnSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
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
        btnAllProject.setTitleColor(.lightGray, for: .normal)
        btnCalendar.setTitleColor(.lightGray, for: .normal)
        btnStats.setTitleColor(.lightGray, for: .normal)
        btnService.setTitleColor(.lightGray, for: .normal)
    }
    //MARK: - SELECTOR METHODS
    
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
    }
    @objc func UpdateStatusSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        let indexPath1 = IndexPath(row: indexPathRow, section: 0)
        if self.songStatusArray.count > 0{
            let cell = tblSongStatus.cellForRow(at: indexPath1) as! CalendarProjectStatusDetailCell
            cell.lblMaxTime.text = "\(remMin):\(remSec)"
            cell.lblMinTime.text = "\(minCurrent):\(secCurrent)"
            cell.SliderSong.value = Float(Double((audioPlayer?.currentTime)!))
        }
    }
    
    @objc func UpdateArtistConnSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        let indexPath1 = IndexPath(row: indexPathRow, section: 0)
        if self.songStatusArray.count > 0{
            let cell = tblArtistConnected.cellForRow(at: indexPath1) as! CalendarProjArtistConDetailCell
            cell.lblArtistMaxTime.text = "\(remMin):\(remSec)"
            cell.lblArtistMinTime.text = "\(minCurrent):\(secCurrent)"
            cell.artistConnectedSlider.value = Float(Double((audioPlayer?.currentTime)!))
        }
    }
    
    @objc func updateTime() {
        
        if globalObjects.shared.isDjProjStartTimer == true || globalObjects.shared.isWeekTimer == true{
            if isCurrentWeek == true{
                let currentDate = Date()
                let calendar = Calendar.current
                for i in 0..<projectList.count{
                    let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: allProjReleaseDate[i]! as Date)
                    let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
                    
                    let indexPath1 = IndexPath.init(row: i, section: 0)
                    guard let cell = tblVwAllProj.cellForRow(at: indexPath1) as? AllProjectDetailCell else{
                        return
                    }
                    /*
                    if(status == finished){
                        uicolor = UIColor(red: 230 / 255, green: 204 / 255, blue: 69 / 255, alpha: 1)
                    } */
                    var projectOld = ""
                    var projectProgress = ""
                    if projectList[i].is_old != nil {
                        projectOld = projectList[i].is_old!
                    }
                    if projectList[i].project_status != nil && projectList[i].project_status != ""{
                        projectProgress = projectList[i].project_status!
                    }
                    
                    if projectList[i].is_cancelled == 1{
                        cell.lblRemainingTime.text = "PROJECT CANCELLED".localize
                        cell.lblRemainingTime.textColor = .red
                        self.countdownTimer.invalidate()
                    }
                    else if projectOld == "1"{

                        if(projectList[i].is_video_verify == 0){
//                            if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
//                                cell.lblRemainingTime.text = "Finished"
//                                cell.lblRemainingTime.textColor = .green
//                                zeroTimeStr = cell.lblRemainingTime.text!
//                                TimeValueStr = "PROJECT FINISHED"
//                                self.countdownTimer.invalidate()
//                            }
//                            else{
                            TimeValueStr = ""
                            cell.lblRemainingTime.text = "IN PROGRESS".localize
                            cell.lblRemainingTime.textColor = .green
                            cell.lblStarRating.isHidden = true
                            cell.lblRatingNumber.isHidden = true
                            cell.imgStar.isHidden = true
                            cell.cnsLblRemainingTime.constant = 13
                            cell.btnShare.isHidden = false
                            if UserModel.sharedInstance().userId == viewerId {
                                cell.vwNumberTab.isHidden = false
                            }else{
                                cell.vwNumberTab.isHidden = true
                            }
                            //}
                        }
                        else{
                            
                        if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
                            cell.lblRemainingTime.text = "Completed"
                            cell.lblRemainingTime.textColor = .green
                            zeroTimeStr = cell.lblRemainingTime.text!
                            TimeValueStr = "Completed"
                            countdownTimer.invalidate()

                            cell.lblStarRating.isHidden = true
                                            //cell.lblRatingNumber.isHidden = false
                                            cell.lblStarRating.isHidden = true
                                            cell.lblRatingNumber.isHidden = true
                                            cell.imgStar.isHidden = true
                                            cell.cnsLblRemainingTime.constant = 13
                                            cell.btnShare.isHidden = false
                                            cell.vwNumberTab.isHidden = true
                            
                            
                        }
                        else{
                            TimeValueStr = ""
                            cell.lblRemainingTime.text = "IN PROGRESS".localize
                            cell.lblRemainingTime.textColor = .green
                            cell.lblStarRating.isHidden = true
                            cell.lblRatingNumber.isHidden = true
                            cell.imgStar.isHidden = true
                            cell.cnsLblRemainingTime.constant = 13
                            cell.btnShare.isHidden = false
                            if UserModel.sharedInstance().userId == viewerId {
                                cell.vwNumberTab.isHidden = false
                            }else{
                                cell.vwNumberTab.isHidden = true
                            }
                        }
                    }

                    }
                    else if projectProgress == "in_progress"{
                        cell.lblRemainingTime.text = "IN PROGRESS".localize
                        cell.lblRemainingTime.textColor = .green
                    }else{
                        if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
                            cell.lblRemainingTime.text = "0 DAY 0 HR 0 MIN 0 SEC"
                            cell.lblRemainingTime.textColor = .red
                            zeroTimeStr = cell.lblRemainingTime.text!
                            TimeValueStr = "PROJECT ENDED"
                            self.countdownTimer.invalidate()
                        }else{
                            TimeValueStr = ""
                            cell.lblRemainingTime.text = countdown
                            cell.lblRemainingTime.textColor = .green
                            
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
                    
                    guard let cell = tableVw.cellForRow(at: indexPath1) as? calendarDetails else{
                        return
                        
                    }
                        cell.lblRemainingTime.text = ""
                        cell.lblRemainingTime.textColor = .green
                    
                    if i == weekProjectList.count-1{
                    self.countdownTimer.invalidate()
                    }
//                    if(weekProjectList.count == releaseDate.count){
//                        self.countdownTimer.invalidate()
//                    }
                }
            }
        }
    }
    
    @objc func updateMediaTime() {
        if globalObjects.shared.isDjVideoTimer == true{
            let currentDate = Date()
            let calendar = Calendar.current
            let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: mediaReleaseDate! as Date)
            let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
            //lblAutoDelete_video.text = countdown //ashitesh
            
            if((diffDateComponents.day ?? 0) <= 0 && (diffDateComponents.hour ?? 0) <= 0 && (diffDateComponents.minute ?? 0) <= 0 && (diffDateComponents.hour ?? 0) <= 0){
                mediaCountDownTimer.invalidate()
                
                lblAutoDelete_video.text = "0 DAY 0 HR 0 MIN 0 SEC"
                lblAutoDelete_video.isHidden = true
                
            }
            else{
                lblAutoDelete_video.isHidden = false
                lblAutoDelete_video.text = countdown // "-18906 DAY -10 HR -23 MIN -21 SEC"
            }
        }
    }
    
    @objc func btnPlayStatusSongAction(_ sender: UIButton) {
        indexPathRow = sender.tag
        print(indexPathRow)
        OnGoingpreparePlayer(URL(string: songStatusArray[sender.tag].audiofile!))
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateStatusSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @objc func btnSlideStatusSongAction(_ sender: UISlider) {
        indexPathRow = sender.tag
        let indexPath1 = IndexPath(row: indexPathRow, section: 0)
        let cell = tblSongStatus.cellForRow(at: indexPath1) as! CalendarProjectStatusDetailCell
        audioPlayer?.currentTime = TimeInterval(cell.SliderSong.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    @objc func btnShareAllProjectAction(_ sender: UIButton){
        indexPathRow = sender.tag
        print("indexPathRow",print(indexPathRow))
        
        self.CreateDynamicLink(productId: "\(projectList[sender.tag].id!)")
       
//        let shareUr = "https://djconnectapp.com/DJJSON/getapp.php?projectId=" + "\(projectList[sender.tag].id!)"
//        print("shareUr",shareUr)
//
//        if let name = URL(string: "\(shareUr)"), !name.absoluteString.isEmpty {
//          let objectsToShare = [name]
//
//            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView = self.view
//            self.present(activityViewController, animated: true, completion: nil)
//        }
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
        let text = "DJConnect"
        let items = [NSURL(string: "https://djconnectapp.com/\(viewerId)/\(weekProjectList[sender.tag].id!)/ar-project-detail-page")!]
        let ac = UIActivityViewController(activityItems: [text, items], applicationActivities: nil)
        ac.popoverPresentationController?.sourceView = self.view
        present(ac, animated: true)
    }
    
    @objc func btnArtistSongDownload_Action(_ sender: UIButton){
        let stringValue = "The song will be sent to \(UserModel.sharedInstance().email!)"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColorForText(textForAttribute: "The song will be sent to ", withColor: UIColor.black)
        attributedString.setColorForText(textForAttribute: "\(UserModel.sharedInstance().email!)", withColor: UIColor.blue)
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.setValue(attributedString, forKey: "attributedMessage")
        let email =  UIAlertAction(title: "Email Song", style: .default) { (ACTION) in
            let song_id = self.songStatusArray[sender.tag].audioid!
            self.callEmailSongWebservice(songId: "\(song_id)")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (ACTION) in
            
        }
        alert.addAction(email)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func btnArtistAcceptPlay_Action(_ sender: UIButton){
        indexPathRow = sender.tag
        ArtistConpreparePlayer(URL(string: songStatusArray[sender.tag].audiofile!))
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @objc func btnRecentPlay_Action(_ sender: UIButton){
        if self.recentArray[sender.tag].Broadcast_id!.isEmpty == false{
            let id = self.recentArray[sender.tag].Broadcast_id!
            callArtistVideoWebService(id)
        }else{
            let file = self.recentArray[sender.tag].media_audio
            print("mediaFile:",self.recentArray[sender.tag].media_audio)
            let videoURL = URL(string: "\(file!)")
//            let player = AVPlayer(url: videoURL!)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            self.present(playerViewController, animated: true) {
//                playerViewController.player!.play()
//            }
            
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
    
    @objc func btnGoLive_Action(_ sender: UIButton){
        artist_ID = "\(songStatusArray[sender.tag].artistid!)"
        performSegue(withIdentifier: "segueVideoVerify", sender: nil)
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
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
    
    @IBAction func btnBack_Action(_ sender: UIButton) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        if !isFromMenu{
            navigationController?.popViewController(animated: true)
        }else{
            if UserModel.sharedInstance().userType == "DJ"{
                sideMenuController?.showLeftView()
//                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
//                let next1 = storyBoard.instantiateViewController(withIdentifier: "DJHomeVC") as? DJHomeVC
//                sideMenuController()?.setContentViewController(next1!)
            }else{
                sideMenuController?.showLeftView()
//                let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
//                let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
//                sideMenuController()?.setContentViewController(next1!)
            }
        }
    }
    
    @IBAction func btnAllProjectAction(_ sender: UIButton) {
        
        btnAllProject.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnCalendar.backgroundColor = .white
        btnService.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnAllProject.setTitleColor(.white, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
        globalObjects.shared.isDjProjStartTimer = true
        globalObjects.shared.isWeekTimer = false
        allProjReleaseDate.removeAll()
        projectList.removeAll()
        isCurrentWeek = true
        viewAllProject.isHidden = false
        selectedButton = "all project"
        btnAllProject.setTitleColor(.white, for: .normal)
        btnCalendar.setTitleColor(.lightGray, for: .normal)
        btnStats.setTitleColor(.lightGray, for: .normal)
        btnService.setTitleColor(.lightGray, for: .normal)
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjActive.isHidden = false
        viewService.isHidden = true
        viewStats.isHidden = true
        viewCalendar.isHidden = true
        viewAllProject.isHidden = false
        
        viewAllProject.frame = CGRect(x: 0, y: 0, width:
                                        view.frame.width, height: self.viewMain.frame.height)
        viewAllProject.alpha = 0.0
        UIView.animate(withDuration: 1) {
            self.viewAllProject.alpha = 1.0
            self.viewMain.addSubview(self.viewAllProject)
            self.containerHeight()
        }
        startIndexAllProj = 0
        callAllProjectWebService(start: startIndexAllProj)
    }
    
    @IBAction func btnCalendarAction(_ sender: UIButton) {
        
        btnCalendar.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnAllProject.backgroundColor = .white
        btnService.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnCalendar.setTitleColor(.white, for: .normal)
        btnAllProject.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = true
        releaseDate.removeAll()
        weekProjectList.removeAll()
        isCurrentWeek = false
        self.viewCalendar.isHidden = false
        selectedButton = "calendar"
        btnAllProject.setTitleColor(.lightGray, for: .normal)
        btnCalendar.setTitleColor(.white, for: .normal)
        btnStats.setTitleColor(.lightGray, for: .normal)
        btnService.setTitleColor(.lightGray, for: .normal)
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblAllProjActive.isHidden = true
        lblCalendarActive.isHidden = false
        viewService.isHidden = true
        viewStats.isHidden = true
        
        viewAllProject.isHidden = true
        viewCalendar.isHidden = false
        
        viewCalendar.frame = CGRect(x: 0, y: 0, width:
                                        view.frame.width, height: self.viewMain.frame.height)
        viewCalendar.alpha = 0.0
        UIView.animate(withDuration: 1) {
            self.viewCalendar.alpha = 1.0
            self.viewMain.addSubview(self.viewCalendar)
            self.containerHeight()
        }
        startIndexWeekProj = 0
        callGetWeeeklyProjListWebService()
    }
    
    @IBAction func btnServiceAction(_ sender: UIButton) {
        
        btnService.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnAllProject.backgroundColor = .white
        btnCalendar.backgroundColor = .white
        btnStats.backgroundColor = .white
        
        btnService.setTitleColor(.white, for: .normal)
        btnAllProject.setTitleColor(.gray, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        btnStats.setTitleColor(.gray, for: .normal)
        
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        selectedButton = "service"
        btnAllProject.setTitleColor(.lightGray, for: .normal)
        btnCalendar.setTitleColor(.lightGray, for: .normal)
        btnStats.setTitleColor(.lightGray, for: .normal)
        btnService.setTitleColor(.white, for: .normal)
        
        lblServiceActive.isHidden = false
        lblStatsActive.isHidden = true
        lblCalendarActive.isHidden = true
        lblAllProjActive.isHidden = true
        
        viewCalendar.isHidden = true
        viewStats.isHidden = true
        
        viewAllProject.isHidden = true
        
        self.viewService.isHidden = false
        self.viewService.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400)
        self.viewService.alpha = 0.0
        self.viewMain.addSubview(self.viewService)
        UIView.animate(withDuration: 1) {
            self.viewService.alpha = 1.0
        }
        containerViewHeight.constant = cnsServiceHeight.constant
        print(containerViewHeight.constant)
        
    }
    
    @IBAction func btnStatsAction(_ sender: UIButton) {
        
        btnStats.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        btnAllProject.backgroundColor = .white
        btnService.backgroundColor = .white
        btnCalendar.backgroundColor = .white
        
        btnStats.setTitleColor(.white, for: .normal)
        btnAllProject.setTitleColor(.gray, for: .normal)
        btnService.setTitleColor(.gray, for: .normal)
        btnCalendar.setTitleColor(.gray, for: .normal)
        
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        callDjStatsWebService()
        selectedButton = "stats"
        btnAllProject.setTitleColor(.lightGray, for: .normal)
        btnCalendar.setTitleColor(.lightGray, for: .normal)
        btnStats.setTitleColor(.white, for: .normal)
        btnService.setTitleColor(.lightGray, for: .normal)
        
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = false
        lblCalendarActive.isHidden = true
        lblAllProjActive.isHidden = true
        
        viewCalendar.isHidden = true
        viewService.isHidden = true
        viewAllProject.isHidden = true
        
        self.viewStats.isHidden = false
        self.viewStats.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.viewStats.frame.height)
        self.viewStats.alpha = 0.0
        self.viewMain.addSubview(viewStats)
        UIView.animate(withDuration: 1) {
            self.viewStats.alpha = 1.0
        }
        containerViewHeight.constant = cnsStatsHeight.constant
        print(containerViewHeight.constant)
    }
    
    @IBAction func btnMediaAction(_ sender: UIButton) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        selectedButton = "media"
        setMediaSectionFontColor()
        lblServiceActive.isHidden = true
        lblStatsActive.isHidden = true
        lblAllProjActive.isHidden = true
        viewCalendar.isHidden = true
        viewStats.isHidden = true
        viewService.isHidden = true
        viewAllProject.isHidden = true
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        if sender.title(for: .normal) == "+ Fav"{
            callAddFavWebService()
        }else if sender.title(for: .normal) == "+ unFav"{
            callUnFavouriteWebService()
        }else{
            let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
            
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
            desiredViewController.buttonSelected = selectedButton
                        
            desiredViewController.saveServiceCity = saveServiceCity
            desiredViewController.saveServiceCountry = saveServiceCountry
            desiredViewController.saveServiceLat = saveServiceLat
            desiredViewController.saveServiceLong = saveServiceLong
            desiredViewController.saveImgStr = self.djImageUrl
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType(rawValue: "flip")
            transition.subtype = CATransitionSubtype.fromLeft
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(desiredViewController, animated: true)
        }
    }
    
    @IBAction func editImgBtnTapped(_ sender: UIButton) {  // ashitesh - open video screen
        
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        if sender.title(for: .normal) == "+ Fav"{
            callAddFavWebService()
        }else if sender.title(for: .normal) == "+ unFav"{
            callUnFavouriteWebService()
        }else{
            let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
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
        if yesNoSelected == true{
            callSetDjTutorialWebService()
            scrTutorial.isHidden = true
        }else{
            self.view.makeToast("Please select yes or no.".localize)
        }
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        //toggleSideMenuView()
        
//        sideMenuController?.showLeftView()
        
        let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
        desiredViewController.buttonSelected = selectedButton
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "flip")
        transition.subtype = CATransitionSubtype.fromLeft
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(desiredViewController, animated: true)
        
    }
    
    @IBAction func btnCalendarDeleteAction(_ sender: UIButton) {
        self.viewDeletePostBlur.isHidden = false
        self.viewDeletePost.isHidden = false
        self.viewDeletePost.frame.size.width = self.view.frame.size.width * 0.8
        self.viewDeletePost.frame.size.height = self.view.frame.size.height * 0.6
        self.viewDeletePost.layer.cornerRadius = 12.0
        self.viewDeletePost.center = self.view.center
        self.viewDeletePost.alpha = 1.0
        self.view.addSubview(viewDeletePost)
    }
    
    @IBAction func btnOkayDeleteAction(_ sender: UIButton) {
        self.viewDeletePostBlur.isHidden = true
        self.viewDeletePost.removeFromSuperview()
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
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "pause_white"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "play_button_white"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            
            sender.setImage(UIImage(named: "pause_white"), for: .normal)
        }
    }
        
    @IBAction func btnDjDropAction(_ sender: UIButton) {
        if  self.dropStatus == "on"{
            if UserModel.sharedInstance().userId != viewerId{
                performSegue(withIdentifier: "segueCalendarDjdrop", sender: nil)
            }
        }else{
            self.view.makeToast("Dj Drop service is turned off by Dj")
        }
    }
    
    @IBAction func btnDjSongReviewAction(_ sender: UIButton) {
        if self.feedBackStatus == "on"{
            if UserModel.sharedInstance().userId != viewerId && UserModel.sharedInstance().userType == "AR"{
                performSegue(withIdentifier: "segueCalendarDjSongReview", sender: nil)
            }
        }else{
            self.view.makeToast("Dj Song Review service is turned off by Dj")
        }
    }
    
    @IBAction func btnDjRemixAction(_ sender: UIButton) {
        if self.remixStatus == "on"{
            if UserModel.sharedInstance().userId != viewerId && UserModel.sharedInstance().userType == "AR"{
                performSegue(withIdentifier: "segueCalendarDjRemix", sender: nil)
            }
        }else{
            self.view.makeToast("Dj Remix service is turned off by Dj")
        }
    }
    
    @IBAction func btnFacebookAction(_ sender: UIButton) {
        
        let fbStringg = FacebookUrlLink
        print("FacebookUrlLink, \(FacebookUrlLink)")
        
        
        var newfbString = ""
        var getfbStr = ""
        if(fbStringg.contains("facebook.com/")){
            newfbString = fbStringg.replacingOccurrences(of: "facebook.com/", with: "", options: .literal, range: nil)
            print("\(newfbString)")
            if ((newfbString.contains("/")) != nil){
                getfbStr = newfbString.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
                print("\(getfbStr)")
            }
            
            UIApplication.shared.open(URL(string: "https://facebook.com/\(getfbStr)")! as URL, options: [:], completionHandler: nil)
        }
        else{
            if ((FacebookUrlLink.contains(" ")) != nil){
             let fbSTring = FacebookUrlLink.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                print("\(fbSTring)")
                
                UIApplication.shared.open(URL(string: "https://facebook.com/\(fbSTring)")! as URL, options: [:], completionHandler: nil)
            }
            
            else{
                UIApplication.shared.open(URL(string: "https://facebook.com/\(FacebookUrlLink)")! as URL, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    @IBAction func btnInstagramAction(_ sender: UIButton) {
        
        let instaString = InstagramUrlLInk
        print("\(InstagramUrlLInk)")
        var newInstaString = ""
        var getInstaStr = ""
        if(instaString.contains("instagram.com/")){
            newInstaString = instaString.replacingOccurrences(of: "instagram.com/", with: "", options: .literal, range: nil)
            print("\(newInstaString)")
            if ((newInstaString.contains("/")) != nil){
                getInstaStr = newInstaString.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
                print("\(getInstaStr)")
            }
            
            UIApplication.shared.open(URL(string: "https://instagram.com/\(getInstaStr)")! as URL, options: [:], completionHandler: nil)
        }
        else{
        
        UIApplication.shared.open(URL(string: "https://instagram.com/\(InstagramUrlLInk)")! as URL, options: [:], completionHandler: nil)
        }
        print("https://instagram.com/\(getInstaStr)")
        print("https://instagram.com/\(InstagramUrlLInk)")
        
        //https://instagram.com/ashi_ios

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
    @IBAction func btnCloseProjectStatusAction(_ sender: UIButton) {
        audioPlayer?.pause()
        if selectedButton == "calendar"{
            vwProjectStatus.removeFromSuperview()
            startIndexWeekProj = 0
            callGetWeeeklyProjListWebService()
        }else if selectedButton == "all project"{
            vwProjectStatus.removeFromSuperview()
            startIndexAllProj = 0
            projectList.removeAll()
            callAllProjectWebService(start: startIndexAllProj)
        }else{
            vwProjectStatus.removeFromSuperview()
        }
    }
    
    @IBAction func btnReason1Action(_ sender: UIButton) {
        RejectReason = "Offer too low. Resubmit with a higher price."
        lblReason1.backgroundColor = .lightGray
        lblReason2.backgroundColor = .themeWhite
        lblReason3.backgroundColor = .themeWhite
        lblReason4.backgroundColor = .themeWhite
        lblReason5.backgroundColor = .themeWhite
    }
    
    @IBAction func btnReason2Action(_ sender: UIButton) {
        RejectReason = "Song quality too low. Resubmit the song in a better quality."
        lblReason1.backgroundColor = .themeWhite
        lblReason2.backgroundColor = .lightGray
        lblReason3.backgroundColor = .themeWhite
        lblReason4.backgroundColor = .themeWhite
        lblReason5.backgroundColor = .themeWhite
    }
    
    @IBAction func btnReason3Action(_ sender: UIButton) {
        RejectReason = "Song is not for all audiences. Resubmit the song edited."
        lblReason1.backgroundColor = .themeWhite
        lblReason2.backgroundColor = .themeWhite
        lblReason3.backgroundColor = .lightGray
        lblReason4.backgroundColor = .themeWhite
        lblReason5.backgroundColor = .themeWhite
    }
    
    @IBAction func btnReason4Action(_ sender: UIButton) {
        RejectReason = "The song is not a fit for this event."
        lblReason1.backgroundColor = .themeWhite
        lblReason2.backgroundColor = .themeWhite
        lblReason3.backgroundColor = .themeWhite
        lblReason4.backgroundColor = .lightGray
        lblReason5.backgroundColor = .themeWhite
    }
    
    @IBAction func btnReason5Action(_ sender: UIButton) {
        RejectReason = "No reason."
        lblReason1.backgroundColor = .themeWhite
        lblReason2.backgroundColor = .themeWhite
        lblReason3.backgroundColor = .themeWhite
        lblReason4.backgroundColor = .themeWhite
        lblReason5.backgroundColor = .lightGray
    }
    
    @IBAction func btnOkReasonAction(_ sender: UIButton) {
        lblReason1.backgroundColor = .themeWhite
        lblReason2.backgroundColor = .themeWhite
        lblReason3.backgroundColor = .themeWhite
        lblReason4.backgroundColor = .themeWhite
        lblReason5.backgroundColor = .themeWhite
        if RejectReason.isEmpty == false{
            selectedStatus = .notAccepted
            callAcceptRejectSongWebService(audioStatus: "2", removeId: removeIndex)
            blurEffectView.removeFromSuperview()
            vwRejectReason.removeFromSuperview()
        }else{
            self.view.makeToast("Please select any one of above reason.")
        }
        
    }
    @IBAction func btnCancelReasonAction(_ sender: UIButton) {
        lblReason1.backgroundColor = .themeWhite
        lblReason2.backgroundColor = .themeWhite
        lblReason3.backgroundColor = .themeWhite
        lblReason4.backgroundColor = .themeWhite
        lblReason5.backgroundColor = .themeWhite
        blurEffectView.removeFromSuperview()
        vwRejectReason.removeFromSuperview()
    }
    
    @IBAction func btnChangeOrderAction(_ sender: UIButton) {
        tblArtistConnected.isEditing = !tblArtistConnected.isEditing
        if tblArtistConnected.isEditing == false{
            callSetOrderWebservice()
        }
    }
    
    @IBAction func btnVerifyAction(_ sender: UIButton) {
        vwVerify.isHidden = !vwVerify.isHidden
    }
    
    @IBAction func btnVi_Play_Action(_ sender: UIButton) {
        if viewerId == UserModel.sharedInstance().userId{
            if self.videoType == "project"{
                callArtistVideoWebService("\(video_broadcastId)")
            }
        }
    }
    
    @IBAction func btnVideoDownload_Action(_ sender: UIButton) {
        callEmailVideoSongWebservice(audioId: "0")
    }
    
    @IBAction func btnReportAction(_ sender: UIButton) {
        callReportApi()
    }
    
    @IBAction func btnReportCancelAction(_ sender: UIButton) {
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
    func callGetProfileWebService(){
        if getReachabilityStatus(){
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            Loader.shared.show()
            activityIndicator()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&current_date=\(weekDate)&profileviewid=\(viewerId)&profileviewtype=\(searchUserType)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let getProfile = response.result.value!
                    print(getProfile.Profiledata)
                    if getProfile.success == 1{
                        
                        let formatter = NumberFormatter()
                        formatter.groupingSeparator = "," // or possibly "." / ","
                        formatter.numberStyle = .decimal
                        
                        self.isCurrentWeek = true
                        self.lblDJNAME.text = "@\(getProfile.Profiledata![0].username!)"
                        print("serviceCountry",getProfile.Profiledata![0].serviceCountry)
                       
                        let profileImageUrl = URL(string: getProfile.Profiledata![0].profile_picture!)
                        self.djImageUrl = getProfile.Profiledata![0].profile_picture!
                        self.userEmailNameLbl.text = "Email: " + (getProfile.Profiledata![0].email ?? "")
                        self.userPhoneNoLbl.text = "Phone no: " + (getProfile.Profiledata![0].phone_number ?? "")
                        
                        //self.hideActivityIndicator()
                        self.spinnerr.stopAnimating()
                        self.spinnerr.hidesWhenStopped = true
                        self.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "Image Avatar"),  completionHandler: nil)
                        self.imgRe_DjImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "Image Avatar"),  completionHandler: nil)
                        UserModel.sharedInstance().userProfileUrl = getProfile.Profiledata![0].profile_picture!
                         UserModel.sharedInstance().synchroniseData()
                        
                        self.userName = getProfile.Profiledata![0].username!
                        if self.viewerId != UserModel.sharedInstance().userId!{
                            self.vwRecent.isHidden = true
                            self.lblRecent.isHidden = true
                            self.lblRecent.text =  ""
                            self.cnsRecentHeight.constant = 0
                            if self.viewerId == UserModel.sharedInstance().userId{
                                self.btnEdit.isUserInteractionEnabled = true
                                self.btnEdit.setTitle("Edit".localize, for: .normal)
                                self.btnThreeDot.isHidden = true
//                                self.editImgBtn.isHidden = false // for new design it is hide
                                self.editImgBtn.isHidden = true
                                self.editImgBtn.isUserInteractionEnabled = true
                            }else{
                               // self.btnThreeDot.isHidden = false
                                self.btnThreeDot.isHidden = true
                                self.btnThreeDot.isUserInteractionEnabled = false
                                self.editImgBtn.isHidden = true
                                self.editImgBtn.isUserInteractionEnabled = false
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
                        self.saveServiceCity = getProfile.Profiledata![0].servciceCity ?? ""
                        self.saveServiceCountry = getProfile.Profiledata![0].serviceCountry ?? ""
                        self.saveServiceLat = getProfile.Profiledata![0].serviceLat ?? ""
                        self.saveServiceLong = getProfile.Profiledata![0].ServiceLong ?? ""
                        
                        global.audioName = getProfile.Profiledata![0].media_audio_name!
                        self.video_broadcastId = getProfile.Profiledata![0].media_broadcastID!
                        self.videoType = getProfile.Profiledata![0].media_video_project!
                        self.projectUserId = "\(getProfile.Profiledata![0].userid!)"
                        self.lblCurrentLocation.text = getProfile.Profiledata![0].city!
                        self.joinedDateLbl.text = "Joined ".localize + getProfile.Profiledata![0].join_date!
                        self.userSearched = getProfile.Profiledata![0].user_type!
                        self.lblGenreOfMusic.text = "Genre(s): ".localize + getProfile.Profiledata![0].genre!
                        self.lblBIO.text = getProfile.Profiledata![0].bio ?? ""
                        if getProfile.Profiledata![0].bio ?? "" == ""{
                        //self.bioHdrLbl.isHidden = true
                        }
                        //self.lblBIO.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard."
                        
                        self.lblRe_UserName.text = getProfile.Profiledata![0].username!
                        self.FacebookUrlLink = getProfile.Profiledata![0].facebook_link ?? ""
                        self.InstagramUrlLInk = getProfile.Profiledata![0].instagram_link ?? ""
                        self.YoutubeUrlLink = getProfile.Profiledata![0].youtube_link ?? ""
                        self.TwitterUrlLink = getProfile.Profiledata![0].twitter_link ?? ""
                        if let feedbackDrop = getProfile.Profiledata![0].dj_feedback_drops{
                            if feedbackDrop.count > 0{
                                
                                if let feedbackDetail = getProfile.Profiledata![0].dj_feedback_drops![0].dj_feedback{
                                    self.lblFeedbackDetail.text = feedbackDetail
                                }
                                if let feedback_vary = getProfile.Profiledata![0].dj_feedback_drops![0].is_dj_feedback_varying{
                                    if var feedbackPrice = getProfile.Profiledata![0].dj_feedback_drops![0].dj_feedback_price{
                                        if feedback_vary == 0{
                                            self.is_songReview_type = "0"
                                            _ = feedbackPrice.removeFirst()
                                            if(feedbackPrice != ""){
                                            formatter.string(from: Int(feedbackPrice) as! NSNumber)
                                            let string2 = formatter.string(from: Int(feedbackPrice) as! NSNumber)
                                            self.lblprice.text = "Price - ".localize + self.currentCurrency + string2!
                                            }
                                            self.priceReviewwithSymbol = feedbackPrice
                                        }else{
                                            self.is_songReview_type = "1"
                                            let range1 = getProfile.Profiledata![0].dj_feedback_drops![0].dj_feedback_range1!
                                            formatter.string(from: range1 as NSNumber)
                                            let string21 = formatter.string(from: range1 as NSNumber)
                                            
                                            let range2 = getProfile.Profiledata![0].dj_feedback_drops![0].dj_feedback_range2!
                                            formatter.string(from: range2 as NSNumber)
                                            let string22 = formatter.string(from: range2 as NSNumber)
                                            
                                            _ = feedbackPrice.removeFirst()
                                            let txtPrice = "price - ".localize
                                            self.lblprice.text = "\(txtPrice) \(self.currentCurrency)" + string21! + "-" + "\(self.currentCurrency)" + string22!
//                                            self.lblprice.text = "\(txtPrice) \(self.currentCurrency)\(range1) - \(self.currentCurrency)\(range2)"
                                            let rangePrice = "\(range1) - \(self.currentCurrency) - \(range2)"
                                            self.priceReviewwithSymbol = rangePrice
                                        }
                                    }
                                }
                                
                                if getProfile.Profiledata![0].dj_feedback_drops![0].dj_feedback_status ?? "" == "off"{
                                    self.noserviceBgVw.isHidden = false
                                    self.serviceReactRevwBgVw.isHidden = true
                                    self.feedBackStatus = "off"
                                    self.lblprice.text = "price - ".localize + "OFF"
                                }else{
                                    self.feedBackStatus = "on"
                                    self.noserviceBgVw.isHidden = true
                                    self.serviceReactRevwBgVw.isHidden = false
                                }
                                
                                if let dropDetail = getProfile.Profiledata![0].dj_feedback_drops![0].dj_drops{
                                    self.lblDropDetail.text = dropDetail
                                }
                                
                                if let drop_vary = getProfile.Profiledata![0].dj_feedback_drops![0].is_dj_drop_varying{
                                    if var dropPrice = getProfile.Profiledata![0].dj_feedback_drops![0].dj_drops_price{
                                        if drop_vary == 0{
                                            self.is_drop_type = "0"
                                            _ = dropPrice.removeFirst()
                                            let txtPrice = "price - ".localize
                                            if(dropPrice != ""){
                                                formatter.string(from: Int(dropPrice)! as NSNumber)
                                                let strings = formatter.string(from: Int(dropPrice)! as NSNumber)
                                                self.lblpricedjdrop.text = "\(txtPrice) \(self.currentCurrency)" + strings!
                                            }
//                                            formatter.string(from: Int(dropPrice)! as NSNumber)
//                                            let strings = formatter.string(from: Int(dropPrice)! as NSNumber)
//                                            self.lblpricedjdrop.text = "\(txtPrice) \(self.currentCurrency)" + strings!
                                            
//                                            self.lblpricedjdrop.text = "\(txtPrice) \(self.currentCurrency)\(dropPrice)"
                                            self.priceDropwithSymbol = dropPrice
                                        }else{
                                            self.is_drop_type = "1"
                                            let range1 = getProfile.Profiledata![0].dj_feedback_drops![0].dj_drop_range1!
                                            formatter.string(from: range1 as NSNumber)
                                            let strings1 = formatter.string(from: Int(range1) as NSNumber)
                                            
                                            let range2 = getProfile.Profiledata![0].dj_feedback_drops![0].dj_drop_range2!
                                            formatter.string(from: range2 as NSNumber)
                                            let strings2 = formatter.string(from: Int(range2) as NSNumber)
                                            
                                            _ = dropPrice.removeFirst()
                                            let txtPrice = "price - ".localize
                                            
                                            self.lblpricedjdrop.text = "\(txtPrice) \(self.currentCurrency)" + strings1! + "-" + "\(self.currentCurrency)" + strings2!
                                            
//                                            self.lblpricedjdrop.text = "\(txtPrice) \(self.currentCurrency)\(range1) - \(self.currentCurrency)\(range2)"
                                            let rangePrice = "\(range1) - \(self.currentCurrency)\(range2)"
                                            self.priceDropwithSymbol = rangePrice
                                        }
                                    }
                                }
                                if getProfile.Profiledata![0].dj_feedback_drops![0].dj_drops_status ?? "" == "off"{
                                    self.dropStatus = "off"
                                    self.lblpricedjdrop.text = "price - ".localize + "OFF"
                                }else{
                                    self.dropStatus = "on"
                                }
                                
                                if var remixPrice = getProfile.Profiledata![0].dj_feedback_drops![0].dj_remix_price{
                                    self.is_remix_type = "0"
                                    _ = remixPrice.removeFirst()
                                    
                                    if(remixPrice != ""){
                                        formatter.string(from: Int(remixPrice)! as NSNumber)
                                        let strings2 = formatter.string(from: Int(remixPrice)! as NSNumber)
                                        self.lblRemixPrice.text = "price - ".localize + self.currentCurrency + remixPrice
                                        
    //                                    self.lblRemixPrice.text = "price - ".localize + self.currentCurrency + remixPrice
                                    }
                                    
                                    self.priceRemixwithSymbol = remixPrice
                                }
                                
                                if let remixDetail = getProfile.Profiledata![0].dj_feedback_drops![0].dj_remix{
                                    self.lblRemixDetail.text = remixDetail
                                }
                                
                                if getProfile.Profiledata![0].dj_feedback_drops![0].dj_remix_status ?? "" == "off"{
                                    self.remixStatus = "off"
                                    self.lblRemixPrice.text = "price - ".localize + "OFF"
                                }else{
                                    self.remixStatus = "on"
                                }
                            }
                            
                        }
                        
                        if let isVerify = getProfile.Profiledata![0].is_verified{
                            if isVerify == "0"{
                                self.vwVerify.isHidden = true
                                self.btnVerify.isHidden = true
                            }else{
                                self.vwVerify.isHidden = true
                                self.btnVerify.isHidden = false
                            }
                        }
                        
                        if self.selectedButton == "media"{
                            self.setMediaView()
                        }
                        
                        if let recentData = getProfile.Profiledata![0].dj_recentData{
                            self.recentArray = recentData.reversed()
                            self.CVwRecent.reloadData()
                        }
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
                        self.containerHeight() //22
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
    
    func callGetWeeeklyProjListWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            weekProjectList.removeAll()
            releaseDate.removeAll()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAllProjectsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&profileviewid=\(viewerId)&profileviewtype=\(searchUserType)&start=0&limit=30"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<getWeeklyProjectListModel>) in
                
                switch response.result{
                case .success(_):
                    let getWeekProjList = response.result.value!
                    if getWeekProjList.success == 1{
                        self.isCurrentWeek = false
                        Loader.shared.hide()
                        if let projectLis = getWeekProjList.projectList{
                            self.weekProjectList.removeAll()
                            self.releaseDate.removeAll()
                            self.WeeklyRemainingTimeArray.removeAll()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let currentWeekDate = dateFormatter.date(from: self.weekDate)
                            let first = currentWeekDate?.firstWeekDay?.timeIntervalSince1970
                            let last = currentWeekDate?.lastWeekDay?.timeIntervalSince1970
                            dateFormatter.dateFormat = "MMMM dd, yyyy"
                            for i in 0..<projectLis.count{
                                let date = dateFormatter.date (from: projectLis[i].event_date!.UTCToLocal(incomingFormat: "MMM dd, yyyy", outGoingFormat: "MMM dd, yyyy"))
                                let current = date?.timeIntervalSince1970
                                
                                if current! <= last! && current! > first!{
                                    self.WeeklyRemainingTimeArray.append(projectLis[i].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))
                                    self.weekProjectList.append(projectLis[i])
                                }
                            }
                            print("self.weekProjectList", self.weekProjectList)
                            globalObjects.shared.isWeekTimer = true
                            globalObjects.shared.isDjProjStartTimer = false
                            self.startTimer()
                            self.tableVw.reloadData()
                            self.containerHeight()
                            
                        }
                    }else{
                        Loader.shared.hide()
//                        self.view.makeToast(getWeekProjList.message)
                        self.view.makeToast("You have no projects.")
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
    
    func callDeleteProjectWebService(_ index: Int){
        if getReachabilityStatus(){
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "projectid":"\(projectId)"
            ]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.deleteProjectAPI)?"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
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
    
    func callDjStatsWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getDjStatsAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)&profile_view_id=\(viewerId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjStatsModel>) in
                
                switch response.result{
                case .success(_):
                    let djStatsProfile = response.result.value!
                    if djStatsProfile.success == 1{
                        Loader.shared.hide()
                        self.lblUserRatingCount.text = "\(djStatsProfile.rating_count!)/5.0 from \(djStatsProfile.total_user!) users"
                        self.lblProjectNumber.text = djStatsProfile.projects![0].total_project?.stringValue
                        self.lblProjTopUser.text = djStatsProfile.projects![0].top_user?.stringValue
                        self.lblProjLastMonth.text = djStatsProfile.projects![0].last_month_project?.stringValue
                        self.lblFavNumber.text = djStatsProfile.favored![0].total_favored?.stringValue
                        self.lblFavLastMonth.text = djStatsProfile.favored![0].last_month_favored?.stringValue
                        self.lblfavTopUser.text = djStatsProfile.favored![0].top_user?.stringValue
                        self.lblProfileViewNumber.text = djStatsProfile.profile_viewer![0].total_viewer?.stringValue
                        self.lblprofileTopUser.text = djStatsProfile.profile_viewer![0].top_user?.stringValue
                        self.lblprofileLastMonth.text = djStatsProfile.profile_viewer![0].last_month_viewer?.stringValue
                        let rate = djStatsProfile.rating_count!
                        if let n = NumberFormatter().number(from: rate) {
                            let f = CGFloat(truncating: n)
                            self.vwRating.value = f
                        }
                        if let avgTime = djStatsProfile.Avg_time![0].total_time{
                            if avgTime.isEmpty == false{
                                let x = avgTime.components(separatedBy: ":")
                                self.lblAverageTime.text = "\(x[0])h\(x[1])m\(x[2])s"
                            }
                        }
                        if let topAvgTime = djStatsProfile.Avg_time![0].top_user_time{
                            if topAvgTime.isEmpty == false{
                                let x = topAvgTime.components(separatedBy: ":")
                                self.lblTopAverageTime.text = "\(x[0])h\(x[1])m\(x[2])s"
                            }
                        }
                        if let lastAvgTime = djStatsProfile.Avg_time![0].last_month_time{
                            if lastAvgTime.isEmpty == false{
                                let x = lastAvgTime.components(separatedBy: ":")
                                self.lblLastAvgTime.text = "\(x[0])h\(x[1])m\(x[2])s"
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
    
    func callAddFavWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "favorite_by":"\(UserModel.sharedInstance().userId!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
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
    
    func callUnFavouriteWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "removeid":"\(viewerId)",
                "favorites_type" : "user"
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
    
    func callBlockUserWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "block_by":"\(UserModel.sharedInstance().userId!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
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
    
    func callUnBlockUserWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "unblock_by":"\(UserModel.sharedInstance().userId!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
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
    
    func callCurrencyListWebService(){
        
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
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
    
    func callDjSongStatusWebService(status: String){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAppliedartistAudioAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)&audio_status=\(status)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SongStatusModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let songStatusProfile = response.result.value!
                    if songStatusProfile.success == 1{
                        // self.view.makeToast(songStatusProfile.message)
                        self.tblSongStatus.isHidden = false
                        self.songStatusArray = songStatusProfile.appliedAudioData!
                        self.tblSongStatus.reloadData()
                        
                        if status == "0"{
                            self.lblSongStatus.text = "\(self.songStatusArray.count) " + "dj_wait".localize
                            self.lblSongStatusDetail.text = "dj_wait_ack".localize
                        }else if status == "1"{
                            self.lblSongStatus.text = "\(self.songStatusArray.count) " + "dj_accept".localize
                            self.lblSongStatusDetail.text = "dj_accept_ack".localize
                        }else{
                            self.lblSongStatus.text = "\(self.songStatusArray.count) " + "dj_reject".localize
                            self.lblSongStatusDetail.text = "dj_reject_ack".localize
                        }
                    }else{
                        if status == "0"{
                            self.lblSongStatus.text = "0 " + "dj_wait".localize
                            self.lblSongStatusDetail.text = "dj_wait_ack".localize
                        }else if status == "1"{
                            self.lblSongStatus.text = "0 " + "dj_accept".localize
                            self.lblSongStatusDetail.text = "dj_accept_ack".localize
                        }else{
                            self.lblSongStatus.text = "0 " + "dj_reject".localize
                            self.lblSongStatusDetail.text = "dj_reject_ack".localize
                        }
                        self.tblSongStatus.isHidden = true
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
    
    func callAcceptRejectSongWebService(audioStatus: String, removeId : Int){
        if getReachabilityStatus(){
            Loader.shared.show()
            var reason = String()
            if audioStatus == "1"{
                reason = ""
            }else{
                reason = RejectReason
            }
            
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "projectid":"\(projectId)",
                "audioid":"\(Audio_id)",
                "audio_status":"\(audioStatus)",
                "reason":"\(reason)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.acceptRejectArtistAudioAPI)?"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let acceptRejectProfile = response.result.value!
                    if acceptRejectProfile.success == 1{
                        if self.selectedStatus == .accepted{
                            self.songStatusArray.remove(at: removeId)
                            self.tblSongStatus.reloadData()
                            self.lblSongStatus.text = "\(self.songStatusArray.count) " + "dj_wait".localize
                        }
                        if self.selectedStatus == .notAccepted{
                            self.songStatusArray.remove(at: removeId)
                            self.tblSongStatus.reloadData()
                            self.lblSongStatus.text = "\(self.songStatusArray.count) " + "dj_wait".localize
                        }
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
    
    func callArtistConnectedStatusWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAppliedartistAudioAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)&audio_status=1"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SongStatusModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let songStatusProfile = response.result.value!
                    if songStatusProfile.success == 1{
                        self.songStatusArray = songStatusProfile.appliedAudioData!
                        self.tblArtistConnected.isHidden = false
                        self.tblArtistConnected.reloadData()
                        self.lblArtistConnected.text = "\(self.songStatusArray.count) " + "dj_connect".localize
                    }else{
                        self.tblArtistConnected.isHidden = true
                        self.lblArtistConnected.text = "0 " + "dj_connect".localize
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
    
    func callSetOrderWebservice(){
        if getReachabilityStatus(){
            
            for i in 0..<songStatusArray.count{
                acceptArrayId.append("\(songStatusArray[i].audioid!)")
            }
            
            stringArrayCleaned = acceptArrayId.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
            print(stringArrayCleaned)
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "project_id":"\(projectId)",
                "id_order":"\(stringArrayCleaned)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.setAppliedAudioOrderAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let setOrderModel = response.result.value!
                    if setOrderModel.success == 1{
                        self.view.makeToast(setOrderModel.message)
                        self.stringArrayCleaned.removeAll()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(setOrderModel.message)
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
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAllProjectsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&profileviewid=\(viewerId)&profileviewtype=\(searchUserType)&start=\(start)&limit=1000"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<DjAllProjectModel>) in
                
                switch response.result {
                case .success(_):
                    let getAllProjectModel = response.result.value!
                    if getAllProjectModel.success == 1{
                        Loader.shared.hide()
                        self.isCurrentWeek = true
                        if globalObjects.shared.searchResultUserType != nil{
                            globalObjects.shared.searchResultUserType!.removeAll()
                        }
                        if let projectLis = getAllProjectModel.projects{
                            for i in 0..<projectLis.count{
                                //self.RemainingTimeArray.append(projectLis[i].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")) // ashitesh to make date correct
                                
                                self.RemainingTimeArray.append(projectLis[i].closing_time!)
                                
                                print("self.RemainingTimeArray",self.RemainingTimeArray)
                                self.projectList.append(projectLis[i])
                                
                            }
                            if(self.projectList.count > 0){
                                self.deleteProjBtn.isHidden = false
                            }
                            self.count = self.count + 1
                            globalObjects.shared.isDjProjStartTimer = true
                            self.startTimer()
                            self.tblVwAllProj.reloadData()
                            self.containerHeight()
                        }
                    }else{
                        if globalObjects.shared.searchResultUserType != nil{
                            globalObjects.shared.searchResultUserType!.removeAll()
                        }
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
    
    
    func GetBuyProjectDataWebService(id: String, musicTypeId: Int){
        
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getStepsProjectAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(id)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetBuyProjStepsModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStepModel = response.result.value!
                    if buyStepModel.success == 0{
                        if(buyStepModel.message == "You had cancelled verification for this project." || buyStepModel.message ==  ".لقد ألغيت التحقق لهذا المشروع" ){
                            self.view.makeToast(buyStepModel.message)
                        }
                        
                    }
                    else if(buyStepModel.success == 1){
                        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
                        self.vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
                        self.vc2.delegate = self
                        self.vc2.projectId = self.projectId
                        //if tableView.tag == 0{
                        self.vc2.isProjOld = self.isProjOldSt
                        self.vc2.isInProgress = self.isInProgressSt
                        //}
                        self.vc2.musicTypeId = String(musicTypeId)
                        self.vc2.djImageUrl = self.djImageUrl
                        let transition = CATransition()
                        transition.duration = 0.5
                        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                        transition.type = CATransitionType.moveIn
                        transition.subtype = CATransitionSubtype.fromTop
                        self.navigationController?.view.layer.add(transition, forKey: nil)
                        self.navigationController?.pushViewController(self.vc2, animated: false)
                    }
                    else{
                        Loader.shared.hide()
                        
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please Check your Internet Connection")
        }
    }
    
    func callEmailSongWebservice(songId : String){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "audioid":"\(songId)",
                "type":"project"
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
    
    func callArtistVideoWebService(_ brodcastID : String){
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
                    self.resourceURI = uri!
                    self.broadCastID = brodcastID
                    self.performSegue(withIdentifier: "segueDJArtistBambuserPlayer", sender: nil)
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
}

//MARK: - EXTENSIONS
extension CalendarVC : DummyViewDelegate {
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
        }
    }
}
extension CalendarVC : artistDummyViewDelegate {
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


extension CalendarVC :  UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0 || tableView.tag == 1{
            return 167
        }else{
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return projectList.count
        }else if tableView.tag == 1{
            return weekProjectList.count
        }else if tableView.tag == 2{
            return songStatusArray.count
        }else{
            return songStatusArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        if tableView.tag == 0{
            projectId = "\(projectList[indexPath.row].id!)"
        }else{
            projectId = "\(weekProjectList[indexPath.row].id!)"
        }
        if viewerId == UserModel.sharedInstance().userId!{
                        
            let storyboard = UIStoryboard(name: "DJProfile", bundle: Bundle.main)
            vc1 = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
            
            //vc1 = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
            vc1.delegate = self
            vc1.projectId = projectId
            vc1.getZeroTime = zeroTimeStr
            vc1.videoVerified = projectList[indexPath.row].is_video_verify ?? 0
            if tableView.tag == 0{
                vc1.isProjOld = projectList[indexPath.row].is_old!
                vc1.isInProgress = projectList[indexPath.row].project_status!
            }
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromTop
            navigationController?.view.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(vc1, animated: false)
        }else{
            if tableView.tag == 0{
                //self.vc2.isProjOld = projectList[indexPath.row].is_old!
                //self.vc2.isInProgress = projectList[indexPath.row].project_status!
                
                isProjOldSt = projectList[indexPath.row].is_old!
                isInProgressSt = projectList[indexPath.row].project_status!
                
                print("isProjOldSt",isProjOldSt)
                
            }
            //GetBuyProjectDataWebService(id: projectId)
            GetBuyProjectDataWebService(id: projectId, musicTypeId: projectList[indexPath.row].music_type ?? 0)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllProjectDetailCell", for: indexPath) as! AllProjectDetailCell
            
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
            cell.delegate = self
            cell.projectCellBgVw.layer.cornerRadius = 15
            cell.projectCellBgVw.backgroundColor = UIColor(red:185/255, green:167/255, blue:221/255, alpha:0.4)
            cell.projectCellBgVw.clipsToBounds = true
            if(projectList.count > 0){
            let profileImageUrl = URL(string: "\(projectList[indexPath.row].project_image!)")
            cell.imgAlbumImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.lblProjName.text = projectList[indexPath.row].title
            cell.lblDjName.text = "By ".localize + projectList[indexPath.row].project_by!
            cell.btnShare.tag = indexPath.row
            cell.btnShare.layer.cornerRadius = 5
            cell.btnShare.clipsToBounds = true
            cell.btnShare.addTarget(self, action: #selector(btnShareAllProjectAction(_:)), for: .touchUpInside)
//            cell.lblDateTime.text = projectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MMMM dd, yyyy", outGoingFormat: "MMMM dd, yyyy")
            
            let getEventDateStr = projectList[indexPath.row].event_date
            
            let edateFormatter = DateFormatter()
            edateFormatter.dateFormat = "MMMM dd, yyyy"
            let convrtdate = edateFormatter.date(from: getEventDateStr!) //to check crashlytics
            //let convrtdate = edateFormatter.date(from: "")
            edateFormatter.dateFormat = "MM/dd/yyyy"
            cell.lblDateTime.text = edateFormatter.string(from: convrtdate!)
            
            //cell.lblDateTime.text = projectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MMMM dd, yyyy", outGoingFormat: "MMM dd, yyyy")
            
            print("GenreValue :",projectList[indexPath.row].genre!)
            cell.lblGenre.text = "Genre(s): ".localize + projectList[indexPath.row].genre!
            
//            formatter.string(from: Int(projectList[indexPath.row].expected!)! as NSNumber)
//            let string = formatter.string(from: Int(projectList[indexPath.row].expected!)! as NSNumber)
//            cell.lblExpectedNum.text = "Expected attendance - ".localize + string!
            cell.lblExpectedNum.text = "Expected attendance - ".localize + projectList[indexPath.row].expected!
            
            formatter.string(from: Int(projectList[indexPath.row].price!)! as NSNumber)
            let string2 = formatter.string(from: Int(projectList[indexPath.row].price!)! as NSNumber)
            cell.lblCost.text = self.currentCurrency + string2!
//            cell.lblCost.text = self.currentCurrency + "\(projectList[indexPath.row].price!)"
            
            cell.lblStarRating.isHidden = true
            cell.lblRatingNumber.isHidden = true
            cell.imgStar.isHidden = true
            cell.cnsLblRemainingTime.constant = 13
            
            print("cell.lblCost.text",cell.lblCost.text)
            if "\(projectList[indexPath.row].is_cancelled!)" == "1"{
                cell.lblStarRating.isHidden = true
                cell.lblRatingNumber.isHidden = true
                cell.imgStar.isHidden = true
                cell.cnsLblRemainingTime.constant = 13
                //cell.btnShare.isHidden = true // yet comnted to match with android - ashitesh
                cell.vwNumberTab.isHidden = true
            }
            else if projectList[indexPath.row].is_old! == "1"{
//                cell.lblStarRating.isHidden = false
//                cell.lblRatingNumber.isHidden = false
//                cell.lblStarRating.text = "\(projectList[indexPath.row].rate!)"
//                cell.lblRatingNumber.text = " (\(projectList[indexPath.row].avg_rate!))"
//                cell.imgStar.isHidden = false
//                cell.cnsLblRemainingTime.constant = 80
//                cell.btnShare.isHidden = true
//                cell.vwNumberTab.isHidden = true
                }
                else{
//                    cell.lblStarRating.isHidden = true
//                    cell.lblRatingNumber.isHidden = true
//                    cell.imgStar.isHidden = true
//                    cell.cnsLblRemainingTime.constant = 0
//                    cell.btnShare.isHidden = false
//                    if UserModel.sharedInstance().userId == viewerId {
//                        cell.vwNumberTab.isHidden = false
//                       // cell.cnsShareTrailing.constant = 30
//                    }else{
//                        cell.vwNumberTab.isHidden = true
//                       // cell.cnsShareTrailing.constant = 5
//                    }
                }
//            }
//            else{
//                cell.lblStarRating.isHidden = true
//                cell.lblRatingNumber.isHidden = true
//                cell.imgStar.isHidden = true
//                cell.cnsLblRemainingTime.constant = 0
//                cell.btnShare.isHidden = false
//                if UserModel.sharedInstance().userId == viewerId {
//                    cell.vwNumberTab.isHidden = false
//                    cell.cnsShareTrailing.constant = 30
//                }else{
//                    cell.vwNumberTab.isHidden = true
//                    cell.cnsShareTrailing.constant = 5
//                }
//            }
            let isComp = projectList[indexPath.row].is_completed as? Int ?? 0
            if isComp == 0{
                cell.lblWaitingNumber.text = "\(projectList[indexPath.row].waiting_count!)"
                cell.lblAcceptedNumber.text = "\(projectList[indexPath.row].accepted_count!)"
                cell.lblNotAcceptedNumber.text = "\(projectList[indexPath.row].nonaccepted_count!)"
                print("completed nmbr")
            }else{
//                if(projectList[indexPath.row].accepted_count == 0){
//                    cell.lblWaitingNumber.text = "\(projectList[indexPath.row].waiting_count!)"
//                    cell.lblAcceptedNumber.text = "\(projectList[indexPath.row].accepted_count!)"
//                    cell.lblNotAcceptedNumber.text = "\(projectList[indexPath.row].nonaccepted_count!)"
//                }else{
                cell.lblWaitingNumber.text = ""
                cell.lblAcceptedNumber.text = "\(projectList[indexPath.row].accepted_count!)"
                cell.lblNotAcceptedNumber.text = ""
                print("no number")
                //}
            }
            }
            return cell
        }else if tableView.tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarDetails", for: indexPath) as! calendarDetails
            
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
            
            cell.delegate = self
            if(weekProjectList.count > 0){
            if weekProjectList[indexPath.row].is_cancelled! == 1{
                //cell.btnShare.isHidden = true // yet comnted to match with android - ashitesh
                cell.VwNumberTab.isHidden = true
            }
            //ashitesh
            //else if projectList[indexPath.row].is_old! == "1"{
            else if weekProjectList[indexPath.row].is_old! == "1"{
                // cell.btnShare.isHidden = true // yet comnted to match with android - ashitesh
                cell.VwNumberTab.isHidden = true
            }else{
                cell.btnShare.isHidden = false
                if UserModel.sharedInstance().userId == viewerId {
                    cell.VwNumberTab.isHidden = false
                }else{
                    cell.VwNumberTab.isHidden = true
                }
            }
                cell.btnShare.layer.cornerRadius = 5
                cell.btnShare.clipsToBounds = true
                cell.calendrCellBgVw.layer.cornerRadius = 15
                cell.calendrCellBgVw.backgroundColor = UIColor(red:185/255, green:167/255, blue:221/255, alpha:0.4)
                cell.calendrCellBgVw.clipsToBounds = true
            let profileImageUrl = URL(string: "\(weekProjectList[indexPath.row].project_image!)")
            cell.imgAlbumImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.lblProjName.text = weekProjectList[indexPath.row].title
            cell.lblDjName.text = "By ".localize + weekProjectList[indexPath.row].project_by!
//            cell.lblDateTime.text = weekProjectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MMMM dd, yyyy", outGoingFormat: "MMMM dd, yyyy")
                cell.lblDateTime.text = weekProjectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MMMM dd, yyyy", outGoingFormat: "MM/dd/yyyy")
            cell.lblGenre.text = "Genre(s): ".localize + weekProjectList[indexPath.row].genre!
                
                formatter.string(from: Int(weekProjectList[indexPath.row].expected!)! as NSNumber)
                let string11 = formatter.string(from: Int(weekProjectList[indexPath.row].expected!)! as NSNumber)
                
            cell.lblExpectedNum.text = "Expected attendance - ".localize + string11!
                
                formatter.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
                let string23 = formatter.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
            cell.lblCost.text = self.currentCurrency + string23!
                
            if weekProjectList[indexPath.row].is_completed! == 0{
                cell.lblWaitNo.text = "\(weekProjectList[indexPath.row].waiting_count!)"
                cell.lblAcceptNo.text = "\(weekProjectList[indexPath.row].accepted_count!)"
                cell.lblRejectNo.text = "\(weekProjectList[indexPath.row].nonaccepted_count!)"
            }else{
                cell.lblWaitNo.text = ""
                cell.lblAcceptNo.text = "\(weekProjectList[indexPath.row].accepted_count!)"
                cell.lblRejectNo.text = ""
            }
            }
            cell.btnShare.tag = indexPath.row
            cell.btnShare.addTarget(self, action: #selector(btnShareCalendarProjAction(_:)), for: .touchUpInside)
            return cell
        }else if tableView.tag == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarProjectStatusDetailCell", for: indexPath) as! CalendarProjectStatusDetailCell
            cell.delegate = self
            
            cell.SliderSong.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
            cell.btnPlay.tag = indexPath.row
            print(indexPath.row)
            cell.btnPlay.addTarget(self, action: #selector(btnPlayStatusSongAction(_:)), for: .touchUpInside)
            cell.SliderSong.tag = indexPath.row
            cell.SliderSong.addTarget(self, action: #selector(btnSlideStatusSongAction(_:)), for: .valueChanged)
            let profileImageUrl = URL(string: "\(songStatusArray[indexPath.row].profilepicture!)")
            cell.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.lblSongName.text = songStatusArray[indexPath.row].audioname
            cell.lblSongBy.text = songStatusArray[indexPath.row].artistname
            cell.lblSongGenre.text = songStatusArray[indexPath.row].genre!
            
            if swipeOption == .wait{
                cell.lblReason.isHidden = true
                cell.lblCost.isHidden = false
                cell.lblOffering.isHidden = false
                if songStatusArray[indexPath.row].cost!.isEmpty == false{
                    cell.lblCost.isHidden = false
                    cell.lblOffering.isHidden = false
                    cell.lblCost.text = "Cost: \(self.projCost)"
                    cell.lblOffering.text = " Offerings: $\(songStatusArray[indexPath.row].offering!)"
                }else{
                    cell.lblCost.isHidden = true
                    cell.lblOffering.isHidden = true
                }
                
            }else if swipeOption == .accept{
                cell.lblReason.isHidden = true
                cell.lblCost.isHidden = true
                cell.lblOffering.isHidden = true
            }else{
                cell.lblReason.isHidden = false
                cell.lblCost.isHidden = true
                cell.lblOffering.isHidden = true
                cell.lblReason.text = songStatusArray[indexPath.row].reason!
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarProjArtistConDetailCell", for: indexPath) as! CalendarProjArtistConDetailCell
            let profileImageUrl = URL(string: "\(songStatusArray[indexPath.row].profilepicture!)")
            cell.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.artistConnectedSlider.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
            cell.btnArtistConnectedPlay.tag = indexPath.row
            cell.btnArtistConnectedPlay.addTarget(self, action: #selector(btnArtistAcceptPlay_Action(_:)), for: .touchUpInside)
            cell.btnDownload.tag = indexPath.row
            cell.btnDownload.addTarget(self, action: #selector(btnArtistSongDownload_Action(_:)), for: .touchUpInside)
            cell.lblArtistSongName.text = songStatusArray[indexPath.row].audioname!
            cell.lblArtistName.text = songStatusArray[indexPath.row].artistname!
            cell.lblArtistMusicGenre.text = songStatusArray[indexPath.row].genre!
            cell.artistConnectedSlider.maximumValue = Float(SliderValue[indexPath.row])!
            cell.lblArtistMinTime.text = String(cell.artistConnectedSlider.value)
            cell.lblArtistMaxTime.text = maxtime[indexPath.row]
            cell.btnVerify.tag = indexPath.row
            cell.btnVerify.addTarget(self, action: #selector(btnGoLive_Action(_:)), for: .touchUpInside)
            
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
        if tableView.tag == 2{
            if swipeOption == .wait{
                if orientation == .right {
                    let profile = SwipeAction(style: .destructive, title: "") { action, indexPath in
                        self.removeIndex = indexPath.row
                        self.Audio_id = "\(self.songStatusArray[indexPath.row].audioid!)"
                        self.selectedStatus = .accepted
                        self.callAcceptRejectSongWebService(audioStatus: "1", removeId: self.removeIndex)
                        
                        self.tblSongStatus.reloadData()
                    }
                    profile.backgroundColor = UIColor .themeWhite
                    profile.image = UIImage(named: "like")
                    profile.font = .boldSystemFont(ofSize: 10)
                    profile.textColor = UIColor.red
                    return [profile]
                }
                if orientation == .left {
                    
                    let profile = SwipeAction(style: .destructive, title: "") { action, indexPath in
                        self.removeIndex = indexPath.row
                        self.Audio_id = "\(self.songStatusArray[indexPath.row].audioid!)"
                        self.blurEffectView.frame = self.view.bounds
                        self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        self.view.addSubview(self.blurEffectView)
                        self.vwRejectReason.center = self.view.center
                        self.view.addSubview(self.vwRejectReason)
                        
                    }
                    profile.backgroundColor = UIColor .themeWhite
                    profile.image = UIImage(named: "dis-like")
                    profile.font = .boldSystemFont(ofSize: 10)
                    profile.textColor = UIColor.red
                    return [profile]
                }
            }
        }
        
        // delete functionality all proj STATUS - COMPLETED/CANCEL code
        if tableView.tag == 0{
            if projectList[indexPath.row].is_old == "1" || projectList[indexPath.row].is_cancelled == 1{
                guard orientation == .right else { return nil }
                projectId = "\(projectList[indexPath.row].id!)"
                if UserModel.sharedInstance().userId == viewerId {
                    let profile = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                        self.callDeleteProjectWebService(indexPath.row)
                    }
                    profile.backgroundColor = UIColor .themeWhite
                    
                    profile.image = UIGraphicsImageRenderer(size: CGSize(width: 35, height: 35)).image { _ in
                                    UIImage(named: "delete_post")?.draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))
                                }
                    
                   // profile.image = UIImage(named: "delete_post")
                    profile.font = .boldSystemFont(ofSize: 15)
                    profile.textColor = UIColor.red
                    return [profile]
                }else {
                    return nil
                }
                // acc/notacc/wait view of all proj STATUS - ACTIVE/INPROGRESS code
            }else{
                
                let formatter = NumberFormatter()
                formatter.groupingSeparator = "," // or possibly "." / ","
                formatter.numberStyle = .decimal
                
                guard orientation == .right else { return nil }
                if projectList[indexPath.row].is_completed! == 0{
                    waitCount = "\(projectList[indexPath.row].waiting_count!)"
                    acceptCount = "\(projectList[indexPath.row].accepted_count!)"
                    rejectCount = "\(projectList[indexPath.row].nonaccepted_count!)"
                    projectId = "\(projectList[indexPath.row].id!)"
                    
                    formatter.string(from: Int(projectList[indexPath.row].price!)! as NSNumber)
                    let string14 = formatter.string(from: Int(projectList[indexPath.row].price!)! as NSNumber)
                    
                    self.projCost = self.currentCurrency + string14!
                    if UserModel.sharedInstance().userId == viewerId {
                        let wait = SwipeAction(style: .destructive, title: """
                        \(waitCount)
                        waiting
                        """) { action, indexPath in
                            self.swipeOption = swipeSelectedOption.wait
                            self.vwProjectStatus.frame = self.view.bounds
                            self.vwProjectStatus.isHidden = false
                            self.view.addSubview(self.vwProjectStatus)
                            self.callDjSongStatusWebService(status: "0")
                        }
                        wait.backgroundColor = UIColor.themeWhite
                        wait.font = .boldSystemFont(ofSize: 15)
                        wait.textColor = UIColor.lightGray
                        
                        let accept = SwipeAction(style: .destructive, title: """
                        \(acceptCount)
                        accepted
                        """) { action, indexPath in
                            print("accept")
                            if self.projectList[indexPath.row].is_completed! == 0{
                                self.swipeOption = swipeSelectedOption.accept
                                self.vwProjectStatus.frame = self.view.bounds
                                self.vwProjectStatus.isHidden = false
                                self.view.addSubview(self.vwProjectStatus)
                                self.callDjSongStatusWebService(status: "1")
                            }else{
                                self.swipeOption = swipeSelectedOption.connected
                                self.vwProjectStatus.frame = self.view.bounds
                                self.vwProjectStatus.isHidden = false
                                self.view.addSubview(self.vwProjectStatus)
                                self.callArtistConnectedStatusWebService()
                            }
                        }
                        accept.backgroundColor = UIColor.themeWhite
                        accept.font = .boldSystemFont(ofSize: 15)
                        accept.textColor = UIColor.green
                        
                        let reject = SwipeAction(style: .destructive, title: """
                        \(rejectCount)
                        rejected
                        """) { action, indexPath in
                            self.swipeOption = swipeSelectedOption.reject
                            self.vwProjectStatus.frame = self.view.bounds
                            self.vwProjectStatus.isHidden = false
                            self.view.addSubview(self.vwProjectStatus)
                            self.callDjSongStatusWebService(status: "2")
                        }
                        reject.backgroundColor = UIColor.themeWhite
                        reject.font = .boldSystemFont(ofSize: 15)
                        reject.textColor = UIColor.red
                        
                        return [reject,accept,wait]
                    }else{
                        return nil
                    }
                    
                }else{
                    
                    let formatter = NumberFormatter()
                    formatter.groupingSeparator = "," // or possibly "." / ","
                    formatter.numberStyle = .decimal
                    
                    waitCount = ""
                    acceptCount = "\(projectList[indexPath.row].accepted_count!)"
                    rejectCount = ""
                    projectId = "\(projectList[indexPath.row].id!)"
                    
                    formatter.string(from: Int(projectList[indexPath.row].price!)! as NSNumber)
                    let string14 = formatter.string(from: Int(projectList[indexPath.row].price!)! as NSNumber)
                    
                    self.projCost = self.currentCurrency + string14!
                    if UserModel.sharedInstance().userId == viewerId {
                        let wait = SwipeAction(style: .destructive, title: "") { action, indexPath in
                            
                        }
                        wait.backgroundColor = UIColor.themeWhite
                        
                        let accept = SwipeAction(style: .destructive, title: """
                        \(acceptCount)
                        accepted
                        """) { action, indexPath in
                            self.swipeOption = swipeSelectedOption.connected
                            let storyboard = UIStoryboard(name: "DJProfile", bundle: Bundle.main)
                            self.vc1 = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
//                            let storyboard = UIStoryboard(name: "DJHome", bundle: Bundle.main)
//                            self.vc1 = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
                            
                            self.vc1.delegate = self
                            self.vc1.projectId = self.projectId
                            self.vc1.isCompleteFromViewProfile = true
                            if tableView.tag == 0{
                                self.vc1.isProjOld = self.projectList[indexPath.row].is_old!
                                self.vc1.isInProgress = self.projectList[indexPath.row].project_status!
                            }
                            let transition = CATransition()
                            transition.duration = 0.5
                            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                            transition.type = CATransitionType.moveIn
                            transition.subtype = CATransitionSubtype.fromTop
                            self.navigationController?.view.layer.add(transition, forKey: nil)
                            self.navigationController?.pushViewController(self.vc1, animated: false)
                        }
                        accept.backgroundColor = UIColor.themeWhite
                        accept.font = .boldSystemFont(ofSize: 15)
                        accept.textColor = UIColor.green
                        
                        let reject = SwipeAction(style: .destructive, title: "") { action, indexPath in
                            print("reject")
                        }
                        reject.backgroundColor = UIColor.themeWhite
                        
                        return [reject,accept,wait]
                    }else{
                        return nil
                    }
                    
                }
            }
        }
        if tableView.tag == 1{
            guard orientation == .right else { return nil }
            if weekProjectList[indexPath.row].is_old == "1" || weekProjectList[indexPath.row].is_cancelled == 1{
                guard orientation == .right else { return nil }
                projectId = "\(weekProjectList[indexPath.row].id!)"
                if UserModel.sharedInstance().userId == viewerId {
                    let profile = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                        self.callDeleteProjectWebService(indexPath.row)
                    }
                    profile.backgroundColor = UIColor .themeWhite
                    //profile.image = UIImage(named: "delete_post")
                    profile.image = UIGraphicsImageRenderer(size: CGSize(width: 35, height: 35)).image { _ in
                                    UIImage(named: "delete_post")?.draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))
                                }
                    profile.font = .boldSystemFont(ofSize: 15)
                    profile.textColor = UIColor.red
                    return [profile]
                }else {
                    return nil
                }
                // acc/notacc/wait view of all proj STATUS - ACTIVE/INPROGRESS code
            }else if weekProjectList[indexPath.row].is_completed! == 0{
                
                let formatter = NumberFormatter()
                formatter.groupingSeparator = "," // or possibly "." / ","
                formatter.numberStyle = .decimal
                
                waitCount = "\(weekProjectList[indexPath.row].waiting_count!)"
                acceptCount = "\(weekProjectList[indexPath.row].accepted_count!)"
                rejectCount = "\(weekProjectList[indexPath.row].nonaccepted_count!)"
                projectId = "\(weekProjectList[indexPath.row].id!)"
                
                formatter.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
                let string14 = formatter.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
                
                self.projCost = self.currentCurrency + string14!
                if UserModel.sharedInstance().userId == viewerId {
                    let wait = SwipeAction(style: .destructive, title: """
                \(waitCount)
                waiting
                """) { action, indexPath in
                        self.swipeOption = swipeSelectedOption.wait
                        self.vwProjectStatus.frame = self.view.bounds
                        self.vwProjectStatus.isHidden = false
                        self.view.addSubview(self.vwProjectStatus)
                        self.callDjSongStatusWebService(status: "0")
                    }
                    wait.backgroundColor = UIColor.themeWhite
                    wait.font = .boldSystemFont(ofSize: 15)
                    wait.textColor = UIColor.lightGray
                    
                    let accept = SwipeAction(style: .destructive, title: """
                \(acceptCount)
                accepted
                """) { action, indexPath in
                        if self.weekProjectList[indexPath.row].is_completed! == 0{
                            self.swipeOption = swipeSelectedOption.accept
                            self.vwProjectStatus.frame = self.view.bounds
                            self.vwProjectStatus.isHidden = false
                            self.view.addSubview(self.vwProjectStatus)
                            self.callDjSongStatusWebService(status: "1")
                        }else{
                            self.swipeOption = swipeSelectedOption.connected
                            self.vwProjectStatus.frame = self.view.bounds
                            self.vwProjectStatus.isHidden = false
                            self.view.addSubview(self.vwProjectStatus)
                            self.callArtistConnectedStatusWebService()
                        }
                    }
                    accept.backgroundColor = UIColor.themeWhite
                    accept.font = .boldSystemFont(ofSize: 15)
                    accept.textColor = UIColor.green
                    
                    let reject = SwipeAction(style: .destructive, title: """
                \(rejectCount)
                rejected
                """) { action, indexPath in
                        self.swipeOption = swipeSelectedOption.reject
                        self.vwProjectStatus.frame = self.view.bounds
                        self.vwProjectStatus.isHidden = false
                        self.view.addSubview(self.vwProjectStatus)
                        self.callDjSongStatusWebService(status: "2")
                    }
                    reject.backgroundColor = UIColor.themeWhite
                    reject.font = .boldSystemFont(ofSize: 15)
                    reject.textColor = UIColor.red
                    
                    return [reject,accept,wait]
                }else{
                    return nil
                }
                
            }else{
                
                let formatter = NumberFormatter()
                formatter.groupingSeparator = "," // or possibly "." / ","
                formatter.numberStyle = .decimal
                
                waitCount = ""
                acceptCount = "\(weekProjectList[indexPath.row].accepted_count!)"
                rejectCount = ""
                projectId = "\(weekProjectList[indexPath.row].id!)"
                
                formatter.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
                let string14 = formatter.string(from: Int(weekProjectList[indexPath.row].price! as! String)! as NSNumber)
                self.projCost = self.currentCurrency + string14!
//                self.projCost = self.currentCurrency + "\(weekProjectList[indexPath.row].price!)"
                if UserModel.sharedInstance().userId == viewerId {
                    let wait = SwipeAction(style: .destructive, title: "") { action, indexPath in
                        
                    }
                    wait.backgroundColor = UIColor.themeWhite
                    
                    let accept = SwipeAction(style: .destructive, title: """
                \(acceptCount)
                accepted
                """) { action, indexPath in
                        self.swipeOption = swipeSelectedOption.connected
                        let storyboard = UIStoryboard(name: "DJProfile", bundle: Bundle.main)
                        self.vc1 = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
//                        let storyboard = UIStoryboard(name: "DJHome", bundle: Bundle.main)
//                        self.vc1 = storyboard.instantiateViewController(withIdentifier: "PostDetailViewController") as! PostDetailViewController
                        
                        self.vc1.delegate = self
                        self.vc1.projectId = self.projectId
                        self.vc1.isCompleteFromViewProfile = true
                        if tableView.tag == 0{
                            self.vc1.isProjOld = self.projectList[indexPath.row].is_old!
                            self.vc1.isInProgress = self.projectList[indexPath.row].project_status!
                        }
                        let transition = CATransition()
                        transition.duration = 0.5
                        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                        transition.type = CATransitionType.moveIn
                        transition.subtype = CATransitionSubtype.fromTop
                        self.navigationController?.view.layer.add(transition, forKey: nil)
                        self.navigationController?.pushViewController(self.vc1, animated: false)
                    }
                    accept.backgroundColor = UIColor.themeWhite
                    accept.font = .boldSystemFont(ofSize: 15)
                    accept.textColor = UIColor.green
                    
                    let reject = SwipeAction(style: .destructive, title: "") { action, indexPath in
                        print("reject")
                    }
                    reject.backgroundColor = UIColor.themeWhite
                    
                    return [reject,accept,wait]
                }else{
                    return nil
                }
                
            }
            
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = songStatusArray[sourceIndexPath.row]
        songStatusArray.remove(at: sourceIndexPath.row)
        songStatusArray.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            print(projectList.count)
//            if indexPath.row == projectList.count - 1{
//                startIndexAllProj = 10 + startIndexAllProj
//                callAllProjectWebService(start: startIndexAllProj)
//            }
        }
    }
}
extension CalendarVC : FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        let dateCurr = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let endDate = generateDates(startDate: dateCurr, addbyUnit: .day, value: 7)
        if date > endDate{
            self.view.makeToast("The maximum you can add a project is 7 days from today. Please select a date within this range.".localize)
        }else{
            print("did select date \(self.dateFormatter.string(from: date))")
            let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
            print("selected dates is \(selectedDates)")
            if monthPosition == .next || monthPosition == .previous {
                calendar.setCurrentPage(date, animated: true)
            }
//            dateFormatter.dateFormat = "MMMM dd, yyyy"
            dateFormatter.dateFormat = "MMM dd, yyyy"
            postDate = dateFormatter.string(from: calendar.selectedDate!)
            self.date = calendar.selectedDate!
            if viewerId == UserModel.sharedInstance().userId!{
                performSegue(withIdentifier: "segueCalendarDateclick", sender: nil)
            }
        }
        calendar.appearance.eventSelectionColor = .clear
        
    }
    
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return date
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        WeeklyRemainingTimeArray.removeAll()
        RemainingTimeArray.removeAll()
        getWeekDate()
        releaseDate.removeAll()
        weekProjectList.removeAll()
        startIndexWeekProj = 0
        callGetWeeeklyProjListWebService()
    }
}
extension CalendarVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentArray.count
        //return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recentCell", for: indexPath) as! ArtistRecentDetails
        cell.lblAlbumName.text = "DJ Live"
        cell.lblByName.text = recentArray[indexPath.row].project_name!
        cell.thirdNameLbl.text = "@\(recentArray[indexPath.row].ar_name!)"
        //cell.lblAlbumName.text = "project_name!"
        //cell.lblByName.text = "@ar_name!"
        cell.cellBgVw.layer.cornerRadius = 15
        cell.imgRecentImage.layer.cornerRadius = 15
        
        let dateString = recentArray[indexPath.row].created_date
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter1.date(from: dateString ?? "")
        dateFormatter1.dateFormat = "MMM d, yyyy"
        let date2 = dateFormatter1.string(from: date!)
        cell.projectTimeLbl.text = date2
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let dateDisplay = dateFormatter.date(from:recentArray[indexPath.row].created_date!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "MMM dd, yyyy"))
//        cell.projectTimeLbl.text = dateDisplay?.timeAgoSinceDate()
        
        
       // if recentArray[indexPath.row].media_type == "audio"{
            cell.imgPlay.isHidden = false
            cell.imgRecentImage.image = UIImage(named: "DJConnectAudioLogo")
            cell.btnRecentPlay.tag = indexPath.row
            cell.btnRecentPlay.addTarget(self, action: #selector(btnRecentPlay_Action(_:)), for: .touchUpInside)
//        }
//        if recentArray[indexPath.row].media_type == "video"{
//            cell.imgPlay.isHidden = true
//            let video_url = recentArray[indexPath.row].media_image!
//            if video_url.isEmpty == false{
//                let url = URL(string: "\(video_url)")
//                cell.imgRecentImage.contentMode = .scaleAspectFill
//                cell.imgRecentImage.kf.indicatorType = .activity
//                cell.imgRecentImage.kf.setImage(with: url, placeholder: UIImage(named: ""),  completionHandler: nil)
//            }else{
//                cell.imgRecentImage.backgroundColor = .lightGray
//            }
//        }
        
        cell.btnRecentPlay.tag = indexPath.row
        cell.btnRecentPlay.addTarget(self, action: #selector(btnRecentPlay_Action(_:)), for: .touchUpInside)
        
        return cell
    }
    
    //func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if recentArray[indexPath.row].media_type == "audio"{
            //return CGSize(width:157, height: 157)
//        }else{
//            return CGSize(width:180, height: 157)
//        }
    //}
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
}
