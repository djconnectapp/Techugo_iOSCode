//
//  dummyVC.swift
//  DJConnect
//
//  Created by mac on 21/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
//import MapKit
import AlamofireObjectMapper
import Alamofire
import AVFoundation
import SwipeCellKit
import Photos
import SwiftyGif
import FBSDKCoreKit
import FBSDKLoginKit

import CoreLocation
import MapKit
import FirebaseDynamicLinks
import LGSideMenuController

struct GlobalId {
    static var id = "0"
    static var ProjectDetailsId = "0"
    static var locationid = "0"
}

//.... other artist connected
class connectedArtistDetails : UITableViewCell {
    
    @IBOutlet weak var imgArtistProfile: imageProperties!
    @IBOutlet weak var lblArtistSongName: UILabel!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblArtistMusicGenre: UILabel!
    @IBOutlet weak var btnArtistConnectPlay: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var lblVideoSongStatus: UILabel!
    @IBOutlet weak var lblProjectAmount: UILabel!
    @IBOutlet weak var imgVideoThumbnail: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnKeep: UIButton!
    @IBOutlet weak var vwBackKeep: UIView! // ashitesh
    
    @IBOutlet weak var imageLoadingLbl: UILabel!
    @IBOutlet weak var btnViewVideo: UIButton!
    @IBOutlet weak var imgEqualizer: UIImageView!
   
    
    @IBOutlet weak var dashLbl: UILabel!
}

class projectControlButtons : UICollectionViewCell{
    @IBOutlet weak var imgControl: UIImageView!
    @IBOutlet weak var lblButtonName: UILabel!
    @IBOutlet weak var cellBgVw: UIView!
    @IBOutlet weak var btnProjControl: UIButton!
}

class acceptRequestDetails : UITableViewCell,AVAudioPlayerDelegate {
    
    @IBOutlet weak var imgAcceptProfile: UIImageView!
    @IBOutlet weak var lblAcProjName: UILabel!
    @IBOutlet weak var lblAcDjName: UILabel!
    @IBOutlet weak var lblAcGenre: UILabel!
    @IBOutlet weak var lblAcMinTime: UILabel!
    @IBOutlet weak var lblAcMaxTime: UILabel!
    @IBOutlet weak var acceptSlider: UISlider!
    @IBOutlet weak var btnAcceptPlay: UIButton!
    
    
    
    var url : String!
    var audioPlayer : AVAudioPlayer?
    var playTimer = Timer()
    
    
    
    
    // MARK:- Deinit varibles
    deinit {
        self.audioPlayer?.stop()
        //self.audioPlayer = nil
    }
    
    func setupAudioPlayerWithFile()  {
        
        let nurl = URL(string: "\(url!)")!
        do {
            let soundData = try Data(contentsOf:nurl)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 1.0
            audioPlayer?.currentTime = 0
            audioPlayer!.delegate = self
            

            let remMin = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            let remSec = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
//            //ashitesh
            lblAcMinTime.text = String(self.acceptSlider.value)
            lblAcMaxTime.text = "\(remMin):\(remSec)"
            self.audioPlayer?.currentTime = Double(self.acceptSlider.value)
            self.acceptSlider.maximumValue = Float(Double(self.audioPlayer!.duration))
            
        } catch {
            print("Player not available")
        }
    }
    override func awakeFromNib() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerStoppedCall), name:
                                                            Notification.Name("playerStopped"), object: nil)
    }
    
    @objc private func playerStoppedCall() {
        audioPlayer?.stop()
        }
    
    @IBAction func acceptPlayButtonAction(_ sender: UIButton) {

        
        if audioPlayer != nil{
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "Button - Play"), for: .normal)
        }else{
            audioPlayer?.play()
            playTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
            
        }else{
            setupAudioPlayerWithFile()
        }
        
        
    }
    

    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        
        lblAcMaxTime.text = "\(remMin):\(remSec)"
        lblAcMinTime.text = "\(minCurrent):\(secCurrent)"
        acceptSlider.value = Float(Double((audioPlayer?.currentTime)!))
        //acceptSlider.value = Float(Double(secCurrent)!)
        
    }
    
    @IBAction func slider_Action(_ sender: UISlider){
        audioPlayer?.currentTime = TimeInterval(acceptSlider.value)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnAcceptPlay.setImage(UIImage(named:"Button - Play"),for: .normal)
        audioPlayer?.stop()
    }
}

class notAcceptRequestDetails : UITableViewCell,AVAudioPlayerDelegate {
    
    @IBOutlet weak var imgNAcProfile: UIImageView!
    @IBOutlet weak var lblNAcProName: UILabel!
    @IBOutlet weak var lblNAcDjName: UILabel!
    @IBOutlet weak var lblNAcGenre: UILabel!
    @IBOutlet weak var lblNAcMInTime: UILabel!
    @IBOutlet weak var lblNAcMaxTime: UILabel!
    @IBOutlet weak var lblDjReason: UILabel!
    @IBOutlet weak var notAcceptSlider: UISlider!
    @IBOutlet weak var btnNotAcceptPlay: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var url  : URL?
    func setupAudioPlayerWithFile(){
        do {
            let soundData = try Data(contentsOf:url!)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 1.0
            audioPlayer!.delegate = self
            
            
        } catch {
            print("Player not available")
        }
    }
    
    @IBAction func acceptPlayButtonAction(_ sender: UIButton) {
//        if audioPlayer != nil{
//            if sender.currentImage == UIImage(named: "audio_pause"){
//                audioPlayer?.pause()
//                sender.setImage(UIImage(named: "audio-play"), for: .normal)
//            }else{
//                audioPlayer?.play()
//                _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
//                sender.setImage(UIImage(named: "audio_pause"), for: .normal)
//            }
//        }else{
//            setupAudioPlayerWithFile()
//        }
    }
    
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        
        lblNAcMaxTime.text = "\(remMin):\(remSec)"
        lblNAcMInTime.text = "\(minCurrent):\(secCurrent)"
        notAcceptSlider.value = Float(Double((audioPlayer?.currentTime)!))
    }
    
    @IBAction func slider_Action(_ sender: UISlider){
        audioPlayer?.currentTime = TimeInterval(notAcceptSlider.value)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnNotAcceptPlay.setImage(UIImage(named:"audio-play"),for: .normal)
    }
}

class artistConnectedDetails: UITableViewCell {
    
    @IBOutlet weak var imgProfileImage: imageProperties!
    @IBOutlet weak var lblArtistSongName: UILabel!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var lblArtistMusicGenre: UILabel!
    @IBOutlet weak var lblArtistMinTime: UILabel!
    @IBOutlet weak var lblArtistMaxTime: UILabel!
    @IBOutlet weak var artistConnectedSlider: UISlider!
    @IBOutlet weak var btnArtistConnectedPlay: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
}

protocol DummyViewDelegate: class {
    func dummyViewBtnCloseClicked()
    func dummyViewBtnMenuClicked()
}

class DJProjectDetail: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, AVAudioPlayerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FileUploaderDelegate{
    
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .dark)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.3)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            //dimmedView.backgroundColor = .white.withAlphaComponent(0.4)
        dimmedView.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 0.4)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
    //MARK: - OUTLETS
    
    
    
       
    @IBOutlet var viewProjectDetailPopUp: UIView!
    @IBOutlet var viewAcceptedReq: UIView!
    @IBOutlet var viewNotAcceptedReq: UIView!
    @IBOutlet var viewWaitRequest: UIView!
    
    @IBOutlet weak var waitShadowBgVw: UIView!
    @IBOutlet weak var waitTableBgVw: UIView! // ashi
    @IBOutlet weak var tableBgVw: UIView!
    
    @IBOutlet var viewArtistConnected: UIView!
    
    
    @IBOutlet weak var accptTBgVw: viewProperties!
    @IBOutlet weak var acptShadowBgVw: UIView!
    @IBOutlet weak var acptTbleBgVw: UIView!
    
    @IBOutlet weak var notConctedTbleBgVw: viewProperties!
    @IBOutlet weak var notCnctdShadowBgVw: UIView!
    @IBOutlet weak var notCnctedTbInsideBgVw: UIView!
    
    @IBOutlet weak var tableAccept: UITableView!
    @IBOutlet weak var tableWait: UITableView!
    @IBOutlet weak var tableNotAccept: UITableView!
    @IBOutlet weak var lblNotAccept: UILabel!
    @IBOutlet weak var lblAccept: UILabel!
    @IBOutlet weak var lblWait: UILabel!
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblProgressDownload: UILabel!
    
    @IBOutlet weak var sliderOutlet: MySlide!
    weak var delegate: DummyViewDelegate?
    //project detail - artist
    @IBOutlet weak var lblEndIn: UILabel!
    @IBOutlet weak var btnViewFullImage: UIButton!
    @IBOutlet weak var lblConnect: UILabel!
    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var lblShare: UILabel!
    @IBOutlet weak var lblprojectType: UILabel!
    @IBOutlet weak var lblProjectInfo: UILabel!
    @IBOutlet weak var lblVenuInfo: UILabel!
    @IBOutlet weak var lblConnectInfo: UILabel!
    @IBOutlet weak var lblSpecialInformation: UILabel!
    
    @IBOutlet var vwDownload: UIView!
    //project detail - dj
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblProjectEndIn: UILabel!
    @IBOutlet weak var btnProjectViewFullimage: UIButton!
    @IBOutlet weak var lblProjectDirections: UILabel!
    @IBOutlet weak var lblProjectCompleteProject: UILabel!
    @IBOutlet weak var lblProjectCancelProject: UILabel!
    @IBOutlet weak var lblProjectShare: UILabel!
    @IBOutlet weak var lblProjectProjectType: UILabel!
    @IBOutlet weak var lblProjectProjectInfo: UILabel!
    @IBOutlet weak var lblProjectVenuInfo: UILabel!
    @IBOutlet weak var lblProjectConnectInfo: UILabel!
    @IBOutlet weak var lblProjectSpecialInformation: UILabel!
    @IBOutlet weak var lblConnectSubmissions: UILabel!
    @IBOutlet weak var btnWait: UIButton!
    @IBOutlet weak var btnAccepted: UIButton!
    @IBOutlet weak var btnNotAccepted: UIButton!
    
    @IBOutlet weak var viewConctBtn: UIButton!
    @IBOutlet weak var lbldjProjName: UILabel!
    @IBOutlet weak var lbldjByName: UILabel!
    @IBOutlet weak var lbldjBio: UILabel!
    @IBOutlet weak var lbldjSpinProject: UILabel!
    @IBOutlet weak var lbldjProjType: UILabel!
    @IBOutlet weak var lbldjAudience: UILabel!
    @IBOutlet weak var lbldjVenueName: UILabel!
    @IBOutlet weak var lbldjVenueDate: UILabel!
    @IBOutlet weak var lbldjVenueTime: UILabel!
    @IBOutlet weak var lbldjVenueAdd: UILabel!
    @IBOutlet weak var lbldjConnectCost: UILabel!
    @IBOutlet weak var lbldjConnectGenre: UILabel!
    @IBOutlet weak var lbldjConnectRegulation: UILabel!
    @IBOutlet weak var lbldjSpecialNone: UILabel!
    @IBOutlet weak var imgDjProfImage: UIImageView!
    @IBOutlet weak var imgDjProjImage: UIImageView!
    @IBOutlet weak var lbldjRemainingTime: UILabel!
    @IBOutlet weak var lbldjTopTime: UILabel!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var lblDayandDateTop: UILabel!
    @IBOutlet var vwFullImage: UIView!
    @IBOutlet weak var imgFullImage: UIImageView!
    @IBOutlet var vwRejectReason: viewProperties!
    @IBOutlet weak var txtViewReason: UITextView!
    @IBOutlet weak var vwWaitButton: UIView!
    @IBOutlet weak var vwRejectButton: UIView!
    @IBOutlet weak var vwAccptButtonv: UIView!
    
    @IBOutlet weak var lblTopCurrentTime: UILabel!
    @IBOutlet weak var btnReason: UIButton!
    @IBOutlet weak var btnEdit: buttonProperties!
    
    // constraints outlets
    @IBOutlet weak var cnsTopScrollView: NSLayoutConstraint!
    @IBOutlet weak var cnsConnectSubmissionHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsTableWaitHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsTableAcceptHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsTableNotAcceptHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cnsTableArtistConHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsViewStatusButtonsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var dateTimeVw: UIView!
    @IBOutlet weak var vwProjControl: UIView!
    @IBOutlet weak var collectionVwControls: UICollectionView!
    @IBOutlet weak var lblNotAcceptArtistCount: UILabel!
    @IBOutlet weak var lblArtistAcceptCount: UILabel!
    @IBOutlet weak var lblWaitArtistCount: UILabel!
    @IBOutlet weak var lblArtistConnectedCount: UILabel!
    @IBOutlet weak var cnsStatusButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsVwProjectControlHeight: NSLayoutConstraint!
    @IBOutlet weak var lblProjectPrice: UILabel!
    @IBOutlet weak var lblReason1: UILabel!
    @IBOutlet weak var lblReason2: UILabel!
    @IBOutlet weak var lblReason3: UILabel!
    @IBOutlet weak var lblReason4: UILabel!
    @IBOutlet weak var lblReason5: UILabel!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    
    //localize
    @IBOutlet weak var lblLo_ConSubWait: UILabel!
    @IBOutlet weak var lblLo_WaitDetail: UILabel!
    @IBOutlet weak var lblLo_ConSubAccept: UILabel!
    @IBOutlet weak var lblLo_AccDetail: UILabel!
    @IBOutlet weak var lblLo_ConSubNotAcc: UILabel!
    @IBOutlet weak var lblLo_RejDetail: UILabel!
    @IBOutlet weak var lblLo_ConConnec: UILabel!
    @IBOutlet weak var lblLo_ConnDetail: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCANCEL: UIButton!
    
    //OTHER ARTIST CONNECTED
    
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblNoOfArtistConnected: UILabel!
    @IBOutlet weak var tblArtistConnected: UITableView!
    @IBOutlet weak var cnsArtistConnectTop: NSLayoutConstraint!
    @IBOutlet weak var vwArtConn: viewProperties!
    
    @IBOutlet weak var mapVenuInfoLbl: UILabel!
    @IBOutlet weak var mapBgVw: UIView!
    @IBOutlet weak var venuMapvw: MKMapView!
    var locationManager:CLLocationManager!

    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var scrlVwHght: NSLayoutConstraint!
    var lineHeight = Int()
    
    @IBOutlet weak var lblDescrHght: NSLayoutConstraint!
    var getZeroTime = String()
    var projectId = String()
    var isProjOld = String()
    var isInProgress = String()
    
    var window: UIWindow?
    var artistIDInt = String()
    var audioIDInt = String()
    var videoVerified = Int()
    
    var playSongTapped = Bool()
    //MARK: - ENUMS
    enum songStatus{
        case waiting
        case accepted
        case notAccepted
    }
    
    //MARK: - GLOBAL VARIABLES
    var isFromNotification = false
    var isFromAlert = false
    var popupHeight = ""
    
    var removeIndex = Int()
    var selectedStatus = songStatus.waiting
    var audio_status = String()
    var waitArray = [appliedAudioDataDetail]()
    var acceptArray = [appliedAudioDataDetail]()
    var rejectArray = [appliedAudioDataDetail]()
    var Audio_id = String()
    // for initial data , use spin_submission model
    var GetProfileWaitList = [spin_submissionDetail]()
    var directionWidth = CGFloat()
    var shareWidth = CGFloat()
    var completeWidth = CGFloat()
    var cancelWidth = CGFloat()
    var lblControlArray = ["Directions","Start","Cancel", "Share"]
    var imgControlArray = ["Icon feather-map-pin","Icon feather-check-circle","Icon metro-cancel","Icon feather-share-2"]
    var buttonId = Int()
    var isComplete = Bool()
    var isCancelled = Bool()
    var isEnd = Bool()
    var noOfControl = Int()
    let blurEffectView = UIVisualEffectView(effect: globalObjects.shared.blurEffect)
    let blurButton = UIButton()
    var waitArrayCount = Int()
    var acceptArrayCount = Int()
    var notAcceptArrayCount = Int()
    var currList = [CurrencyDataDetail]()
    var currency = String()
    var symbol = String()
    var projPrice = String()
    var getWait = Bool()
    
    var indexPathRow = Int()
    var minuteString = String()
    var secondString = String()
    var mintime = [String]()
    var maxtime = [String]()
    var SliderValue = [String]()
    var isLoaded = Bool()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var remainingTime = String()
    var acceptMax = [String]()
    var notAcceptMax = [String]()
    var artistConnectedMax = [String]()
    var waitbgView = UIView()
    var acceptbgView = UIView()
    var notacceptbgView = UIView()
    var artistConnected = Bool()
    var projLat = String()
    var projLong = String()
    var projCost = String()
    var RejectReason = String()
    var isOfferAudio = Bool()
    var stringArrayCleaned = String()
    var acceptArrayId = [String]()
    var artist_ID = String()
    var audioID = String()
    var is_CancelStatus = String()
    var projTimezone = String()
    var currentCurrency = String()
    var isCompleteFromViewProfile = false
    var currentIndex = Int()
    var BroadcastID = String()
    var playList = [String]()
    var userDetail = [String]()
    var albumDetail = [String]()
    var isFromBackLive = false
    var iscompletedID = String()
    var getSucStr = ""
    var getBroadCastIdSt = String()
    
    var saveResourceUri = String()
    var savepreviewImage = String()
    
    var audioPlayer1: AVAudioPlayer?
    var minuteString1 = String()
    var secondString1 = String()
    
    let picker = UIImagePickerController()
    
    var fileUploader: FileUploader?
    var uploadDialog: UIAlertController?
    var progressBarr: UIProgressView?
    var thumbnaill = UIImage()
    var thumbnaillStr = String()
    
    @IBOutlet weak var songLoadingLbl: UILabel!
    
  
    //MARK: - UI VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        playSongTapped = false
        songLoadingLbl.isHidden = true
       // self.view.bringSubviewToFront(songLoadingLbl)
        songLoadingLbl.isHidden = true
        
        lineHeight = 20
        self.scrlVwHght.constant = 1386
        self.scrView.isScrollEnabled = true
        picker.delegate = self
        viewConctBtn.isHidden = true
        viewConctBtn.backgroundColor = UIColor(red: 210 / 255, green: 80 / 255, blue: 222 / 255, alpha: 0.4)
            viewConctBtn.layer.cornerRadius = viewConctBtn.frame.size.height/2
        viewConctBtn.clipsToBounds = true
        
        vwWaitButton.layer.cornerRadius = vwWaitButton.frame.size.height/2
        vwWaitButton.clipsToBounds = true
        vwRejectButton.layer.cornerRadius = vwRejectButton.frame.size.height/2
        vwRejectButton.clipsToBounds = true
        vwAccptButtonv.layer.cornerRadius = vwAccptButtonv.frame.size.height/2
        vwAccptButtonv.clipsToBounds = true
        
        imgDjProfImage.layer.cornerRadius = imgDjProfImage.frame.size.height/2
        imgDjProfImage.clipsToBounds = true
        
        if(waitArray.count > 0){
            vwWaitButton.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        }
        else{
            vwWaitButton.backgroundColor = .clear
        }
        if(acceptArray.count > 0){
            vwAccptButtonv.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        }
        else{
            vwAccptButtonv.backgroundColor = .clear
        }
        if(rejectArray.count > 0){
            vwRejectButton.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        }
        else{
            vwRejectButton.backgroundColor = .clear
        }

        audioPlayer1?.delegate = self
        //playTimer.invalidate()
        btnProjectViewFullimage.backgroundColor =  .black
//        btnProjectViewFullimage.backgroundColor =  UIColor.black.withAlphaComponent(0.7)
//        btnProjectViewFullimage.layer.cornerRadius = btnProjectViewFullimage.frame.size.height/2
        
        localizeElements()
        self.callCurrencyListWebService()
        isComplete = false
        btnEdit.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(getStatus(_:)), name: Notification.Name(rawValue: "equalizer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(backFromLive), name: Notification.Name(rawValue: "BackLive"), object: nil)
        
        self.tableAccept.tableFooterView = UIView()
        self.tableWait.tableFooterView = UIView()
        self.tableNotAccept.tableFooterView = UIView()
        self.tblArtistConnected.tableFooterView = UIView()
        //vwProjControl.layer.cornerRadius = vwProjControl.frame.size.height/2
        dateTimeVw.layer.cornerRadius = dateTimeVw.frame.size.height/2
        
        
        fileUploader = FileUploader(_delegate: self)
              // replace with your own applicationId from https://dashboard.bambuser.com/developer
              fileUploader?.applicationId = "dbJx8NwoMFA0kCSbCjXAlQ"
      
        waitTableBgVw.addSubview(blurredView)
        waitTableBgVw.sendSubviewToBack(blurredView)
        waitShadowBgVw.layer.cornerRadius = 30
        waitShadowBgVw.clipsToBounds = true
        tableBgVw .layer.cornerRadius = 30
        tableBgVw.clipsToBounds = true
        
        accptTBgVw.addSubview(blurredView)
        accptTBgVw.sendSubviewToBack(blurredView)
        acptShadowBgVw.layer.cornerRadius = 30
        acptShadowBgVw.clipsToBounds = true
        acptTbleBgVw.layer.cornerRadius = 30
        acptTbleBgVw.clipsToBounds = true
               
        notConctedTbleBgVw.addSubview(blurredView)
        notConctedTbleBgVw.sendSubviewToBack(blurredView)
        notCnctdShadowBgVw.layer.cornerRadius = 30
        notCnctdShadowBgVw.clipsToBounds = true
        notCnctedTbInsideBgVw.layer.cornerRadius = 30
        notCnctedTbInsideBgVw.clipsToBounds = true
        
        vwRejectReason.layer.cornerRadius = 30
        vwRejectReason.clipsToBounds = true
        
        btnOK.layer.cornerRadius = btnOK.frame.size.height/2
        btnOK.clipsToBounds = true
        btnCANCEL.layer.cornerRadius = btnCANCEL.frame.size.height/2
        btnCANCEL.clipsToBounds = true
        
    }
    
    @IBAction func viewConectBtnTapped(_ sender: Any) {
        UIView.animate(withDuration: 1) {
//            self.vwArtConn.addSubview(self.blurredView)
//            self.vwArtConn.sendSubviewToBack(self.blurredView)
            self.vwArtConn.backgroundColor = .gray
            self.vwArtConn.isHidden = false
            self.cnsArtistConnectTop.constant = 80
            self.callNewArtistConnectedStatusWebService()
            self.view.layoutIfNeeded()
            self.scrView.isScrollEnabled = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        locationManager = CLLocationManager()
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        vwArtConn.addSubview(blurredView)
        vwArtConn.sendSubviewToBack(blurredView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        self.cnsArtistConnectTop.constant = self.view.frame.size.height + 1
        self.lbldjSpinProject.text = "Open (for all artists)"
        self.lbldjConnectRegulation.text = "REGULATIONS: Un-edited (all song content allowed)"
        let date = Date()
        let formatter = DateFormatter()
//        formatter.dateFormat =  "MM/dd/yyyy"
        formatter.dateFormat =  "MMM d, yyyy"
        lblTopCurrentTime.text = "Today's Date : \(formatter.string(from: date))"
        if UserModel.sharedInstance().userId == nil{
            return
        }
        callGetProjectDetailWebService()
        callAlertApi()
        NotificationCenter.default.addObserver(self, selector: #selector(setRecordedView(_:)), name: Notification.Name(rawValue: "isBroadcast"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            determineCurrentLocation()
        }
    
    func determineCurrentLocation()
        {
            locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                //locationManager.startUpdatingHeading()
                locationManager.startUpdatingLocation()
            }
        }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation:CLLocation = locations[0] as CLLocation
            print("Updating location")
            // Call stopUpdatingLocation() to stop listening for location updates,
            // other wise this function will be called every time when user location changes.
           // manager.stopUpdatingLocation()
            
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            venuMapvw.setRegion(region, animated: true)
            
            // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            myAnnotation.title = "Current location"
        venuMapvw.addAnnotation(myAnnotation)
        }
        
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
        {
            print("Error \(error)")
        }
        
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
        {
            if !(annotation is MKPointAnnotation) {
                return nil
            }
            
            let annotationIdentifier = "AnnotationIdentifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView!.canShowCallout = true
            }
            else {
                annotationView!.annotation = annotation
            }
            
            let pinImage = UIImage(named: "customPinImage")
            annotationView!.image = pinImage
            return annotationView
        }
    
    //MARK: - OTHER METHODS
    func localizeElements(){
//        lblProjectEndIn.text = "ENDS IN".localize
        lblProjectEndIn.text = ""
        btnProjectViewFullimage.setTitle("View Full Image".localize, for: .normal)
        lblProjectProjectType.text = "PROJECT TYPE".localize
        lblProjectProjectInfo.text = "PROJECT INFO".localize
        lblProjectVenuInfo.text = "VENU INFO".localize
        lblProjectConnectInfo.text = "CONNECT INFO".localize
        lblProjectSpecialInformation.text = "SPECIAL INFORMATION".localize
        lblConnectSubmissions.text = "Connect Submissions"
        lblLo_ConSubWait.text = "Connect Submissions"
        //lblLo_WaitDetail.text = "dj_wait_ack".localize
        lblLo_ConSubAccept.text = "Connect Submissions"
        lblLo_AccDetail.text = "dj_accept_ack".localize
        lblLo_ConSubNotAcc.text = "Connect Submissions"
        lblLo_RejDetail.text = "dj_reject_ack".localize
        lblLo_ConConnec.text = "ARTIST CONNECTED".localize
        lblLo_ConnDetail.text = "dj_connect_ack".localize
        btnOK.setTitle("Ok".localize, for: .normal)
        btnCANCEL.setTitle("Cancel".localize, for: .normal)
        lblReason1.text = "Reason_1".localize
        lblReason2.text = "Reason_2".localize
        lblReason3.text = "Reason_3".localize
        lblReason4.text = "Reason_4".localize
        lblReason5.text = "Reason_5".localize
    }
    
    func projectCompleteAction(){
        lblControlArray = ["Directions","Cancel", "Share"]
        imgControlArray = ["Icon feather-map-pin","Icon metro-cancel","Icon feather-share-2"]
        collectionVwControls.reloadData()
        cnsStatusButtonHeight.constant = 20
        callGetProjectStatusWebService("complete")
    }
    
    func callProjectCompleted(){
        lblControlArray = ["Directions","Cancel", "Share"]
        imgControlArray = ["Icon feather-map-pin","Icon metro-cancel","Icon feather-share-2"]
        collectionVwControls.reloadData()
        artistConnected = true
        //lblConnectSubmissions.isHidden = true
        cnsStatusButtonHeight.constant = 20
        btnAccepted.isHidden = false
        vwWaitButton.isHidden = true
        vwRejectButton.isHidden = true
        //btnAccepted.setTitle("VIEW CONNECTS", for: .normal)
        //btnAccepted.setTitleColor(.white, for: .normal)
        btnAccepted.setTitle("", for: .normal)
        btnAccepted.setTitleColor(.clear, for: .normal)
        self.vwAccptButtonv.backgroundColor = .clear
        viewConctBtn.isHidden = false
        btnEdit.isHidden = true
        viewConctBtn.setTitleColor(.white, for: .normal)
        btnNotAccepted.isHidden = true
        btnWait.isHidden = true
    }
    
    func cancelProject(){
        cnsVwProjectControlHeight.constant = 0
        //lblConnectSubmissions.isHidden = true
        cnsStatusButtonHeight.constant = 0
        btnAccepted.isHidden = true
        btnNotAccepted.isHidden = true
        btnWait.isHidden = true
    }
    
    func setPlayer(index: Int){
        songLoadingLbl.isHidden = false
        let indexPath1 = IndexPath.init(row: index, section: 0)
        let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
        cell.imgEqualizer.isHidden = false
        cell.imgEqualizer.alpha = 0.5
        let jeremyGif = UIImage.gifImageWithName("EQ5")
        cell.imgEqualizer.image = jeremyGif
        //Loader.shared.hide()
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MusicPlayerVC") as! MusicPlayerVC
        controller.playList = playList
        controller.index = index
        controller.userDetail = userDetail
        controller.albumDetail = albumDetail
       // songLoadingLbl.isHidden = true
        backBtn.isHidden = true
        backBtn.isUserInteractionEnabled = false
        controller.mediaCancelCallback = { selected in
            self.backBtn.isHidden = false
            self.backBtn.isUserInteractionEnabled = true
            self.playSongTapped = false
            controller.view .removeFromSuperview()
                    }
       

        self.view.addSubview(controller.view)
        controller.view.frame = CGRect(x: 0, y: (UIScreen.main.bounds.size.height - 190.0), width: UIScreen.main.bounds.size.width, height: 190.0)
        
        
        controller.mediaSongPlayback = { songPlay in
           // self.songLoadingLbl.isHidden = true
            print("hello")
            self.songLoadingLbl.isHidden = true
        }
//        self.present(controller, animated: true, completion: {
//        })
    }
    
    //MARK: - SELECTOR METHODS
    @objc func btnArtistAcceptPlay_Action(_ sender: UIButton){
       // Loader.shared.show()
        songLoadingLbl.isHidden = false
        if playSongTapped == false{
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.setPlayer(index: sender.tag)
        })
            playSongTapped = true
        }
    }
    
    @objc func btnLikeWait_Action(_ sender: UIButton){
        
           // self.setPlayer(index: sender.tag)
        self.removeIndex = sender.tag
        self.Audio_id = "\(self.waitArray[sender.tag].audioid!)"
        self.selectedStatus = .accepted
        self.callAcceptRejectSongWebService(audioStatus: "1", removeId: self.removeIndex)
        
    }
    
    @objc func btnDislikeWait_Action(_ sender: UIButton){
        
           // self.setPlayer(index: sender.tag)
        self.removeIndex = sender.tag
        self.Audio_id = "\(self.waitArray[sender.tag].audioid!)"
        //self.viewWaitRequest.removeFromSuperview()
        self.waitTableBgVw.isHidden = true
        self.waitShadowBgVw.isHidden = true
        self.tableBgVw.isHidden = true
        self.blurEffectView.frame = self.view.bounds
        self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.blurredView)
        self.vwRejectReason.center = self.view.center
        self.view.addSubview(self.vwRejectReason)
        
    }
    
    @objc func btnArtistSongDownload_Action(_ sender: UIButton) {
        
        
        print("sender.tag",sender.tag)
            let song_id = self.acceptArray[sender.tag].audioid!
        let song_FileUrl = self.acceptArray[sender.tag].audiofile
        print("song_FileUrl",song_FileUrl)
        
        
        let audioUrl = URL(string: song_FileUrl!)
        
        self.shareLink(songUrlData: song_FileUrl!)
        
        /// this commented code was running previously //// ashitesh
//        let urlString = song_FileUrl!
//            let url = URL(string: urlString)
//            let fileName = String((url!.lastPathComponent)) as NSString
//            //Mark:  Create destination URL
//            let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
//            let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
//            //Mark: Create URL to the source file you want to download
//            let fileURL = URL(string: urlString)
//            let sessionConfig = URLSessionConfiguration.default
//            let session = URLSession(configuration: sessionConfig)
//            let request = URLRequest(url:fileURL!)
//            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//                if let tempLocalUrl = tempLocalUrl, error == nil {
//                    //Mark: Success
//                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                        print("Successfully downloaded. Status code: \(statusCode)")
//                        self.getSucStr = ""
//                    }
//                    do {
//                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                        do {
//                            //Mark: Show UIActivityViewController to save the downloaded file
//                            let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
//                            for indexx in 0..<contents.count {
//                                if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
//                                    let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
//                                    self.present(activityViewController, animated: true, completion: nil)
//                                }
//                            }
//                            self.getSucStr = ""
//                            //self.view.makeToast("Your audio files is save to your device")
//                        }
//                        catch (let err) {
//                            print("error: \(err)")
//
//                        }
//                    }
//                    catch (let writeError) {
//                        self.getSucStr = "This files is already exist in your device"
//                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
//
//                    }
//                    //self.view.makeToast("This files is already exist in your device")
//                } else {
//                    print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
//                }
//            }
//            task.resume()
//        if(getSucStr == ""){
//            self.view.makeToast("Your audio files is save to your device")
//        }
//        else if(getSucStr == "This files is already exist in your device"){
//            self.view.makeToast("This files is already exist in your device")
//        }
//
//        else {
//            self.view.makeToast("Something error")
//        }
        
        ////////// uper commented code was running previously //// ashitesh
        
        
        
            //self.view.makeToast("Your audio files is save to your device")
        //}
        
        // 1 - start
//        if song_FileUrl != ""{
//            checkBookFileExists(withLink: song_FileUrl!){ [weak self] downloadedURL in
//                    guard let self = self else{
//                        return
//                    }
//                }
//            }
//           // self.callEmailSongWebservice(songId: "\(song_id)")
        // 1- end
        
        
        // 2 - start
//        // Create destination URL
//        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFileAs.mp3")
//
//        //Create URL to the source file you want to download
//        let fileURL = URL(string: song_FileUrl!)
//
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        let request = URLRequest(url:fileURL!)
//
//        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//            if let tempLocalUrl = tempLocalUrl, error == nil {
//                // Success
//                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                    print("Successfully downloaded. Status code: \(statusCode)")
//                }
//
//                do {
//                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                } catch (let writeError) {
//                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                }
//
//            } else {
//                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
//            }
//        }
//        task.resume()
    // 2 - end

    }
    
    func shareLink(songUrlData:String){
        let urlData = NSData(contentsOf: URL(string:"\(songUrlData)")!)
        
        if ((urlData) != nil){
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyyMMdd_HHmmss"
            let timestamp = format.string(from: date)
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let docDirectory = paths[0]
            let filePath = "\(docDirectory)/Audio_\(timestamp).mp3"
            urlData?.write(toFile: filePath, atomically: true)
            // file saved
            let videoLink = NSURL(fileURLWithPath: filePath)
            
            let objectsToShare = [videoLink] //comment!, imageData!, myWebsite!]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func checkBookFileExists(withLink link: String, completion: @escaping ((_ filePath: URL)->Void)){
        let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        if let url  = URL.init(string: urlString ?? ""){
            let fileManager = FileManager.default
            if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){

                let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)
                
                downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                self.view.makeToast("Your audio files is save to your device")

//                do {
//                    if try filePath.checkResourceIsReachable() {
//                        print("file exist")
//                        completion(filePath)
//
//                    } else {
//                        print("file doesnt exist")
//                        downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
//                    }
//                } catch {
//                    print("file doesnt exist")
//                    downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
//                }
            }
            else{
                 print("file doesnt exist")
            }
        }else{
                print("file doesnt exist")
        }
    }
    
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                
                print("saved at \(filePath.absoluteString)")
                DispatchQueue.main.async {
                    completion(filePath)
                }
            } catch {
                print("an error happened while downloading or saving the file")
            }
            
            
        }
    }
    
    
    func startTimer() {
        let releaseDateString = "\(remainingTime)"
        let releaseDateFormatter = DateFormatter()
        var timeZone = String()
        if projTimezone.isEmpty == false{
            timeZone = projTimezone
        }
        releaseDateFormatter.timeZone = NSTimeZone(name: timeZone) as TimeZone?
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)

        
//        let releaseDateString = "\(remainingTime)"
//        let releaseDateFormatter = DateFormatter()
//        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
//        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        if is_CancelStatus == "1"{
            self.countdownTimer.invalidate()
            self.lblProjectEndIn.text = ""
            self.lbldjRemainingTime.text = "PROJECT CANCELLED".localize
            self.lbldjRemainingTime.textColor = .red
        }else if isInProgress == "in_progress"{
            if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
                self.lblProjectEndIn.text = ""
//                self.lbldjRemainingTime.text = "PROJECT IN PROGRESS".localize
                self.lbldjRemainingTime.text = ""
                self.lbldjRemainingTime.textColor = .green
            }else{
//                self.lblProjectEndIn.text = "ENDS IN"
//                self.lbldjRemainingTime.text = countdown
//                self.lbldjRemainingTime.textColor = .red
                self.lblProjectEndIn.text = ""
                self.lbldjRemainingTime.text = ""
                self.lbldjRemainingTime.textColor = .clear
            }
        }else if isProjOld == "1"{
            self.countdownTimer.invalidate()
            self.lblProjectEndIn.text = ""
            self.lbldjRemainingTime.text = "PROJECT COMPLETED".localize
            self.lbldjRemainingTime.textColor = .red
        }

        else{
            if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
//                self.lbldjRemainingTime.text = "0 DAY 0 HR 0 MIN 0 SEC"
//                self.lbldjRemainingTime.textColor = .red
                self.lbldjRemainingTime.text = ""
                self.lbldjRemainingTime.textColor = .clear
            }else{
                self.lblProjectEndIn.text = "ENDS IN"
                self.lbldjRemainingTime.text = countdown
                self.lbldjRemainingTime.textColor = .red
//                self.lblProjectEndIn.text = ""
//                self.lbldjRemainingTime.text = ""
//                self.lbldjRemainingTime.textColor = .clear
            }
        }
    }
    
    @objc func btnBlur_Action(_ sender: UIButton){
        blurButton.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        vwFullImage.removeFromSuperview()
    }
    
    @objc func btnProjControl_Action(_ sender:UIButton){
        buttonId = sender.tag
        if lblControlArray.count == 4{
            if buttonId == 0{
                
                if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com/")!)) {
                    UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?daddr=\(projLat),\(projLong)&dirflg=d")!, options: [:], completionHandler: nil)
                } else {
                    print("Can't use http://maps.apple.com/")
                }
            }
            
            if buttonId == 1{
                if(acceptArray.count > 0){
                self.showAlertView("Are you sure, you want to start the project?", "Start?", defaultTitle: "OK", cancelTitle: "Cancel", completionHandler: { (ACTION) in
                    if ACTION{
                        self.isComplete = true
                        self.projectCompleteAction()
                    }
                })
                }
                else{
                    self.view.makeToast("No artist has connected yet in the project.")
                    
                }
            }
            if buttonId == 2{
                self.showAlertView("Are you sure, you want to cancel the project?", "Cancel?", defaultTitle: "OK", cancelTitle: "Cancel", completionHandler: { (ACTION) in
                    if ACTION{
                        self.isCancelled = true
                        self.cancelProject()
                        self.callGetProjectStatusWebService("cancel")
                    }
                })
            }
            if buttonId == 3{
//                let items = [URL(string: "https://djconnectapp.com/\(globalObjects.shared.djProjId!)/ar-project-detail-page")!]
//                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//                present(ac, animated: true)
                
                self.CreateDynamicLink(productId: "\(globalObjects.shared.djProjId!)")
            }
        }else if lblControlArray.count == 3{
            if buttonId == 0{
                if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com/")!)) {
                    UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?daddr=\(projLat),\(projLong)&dirflg=d")!, options: [:], completionHandler: nil)
                } else {
                    print("Can't use http://maps.apple.com/")
                }
                print("Directions")
            }
            if buttonId == 1{
                self.showAlertView("Are you sure, you want to cancel the project?", "Cancel?", defaultTitle: "OK", cancelTitle: "Cancel", completionHandler: { (ACTION) in
                    if ACTION{
                        self.isCancelled = true
                        self.cancelProject()
                        self.callGetProjectStatusWebService("cancel")
                    }
                })
            }
            if buttonId == 2{
                
                self.CreateDynamicLink(productId: "\(globalObjects.shared.djProjId!)")
//                let items = [URL(string: "https://djconnectapp.com/\(globalObjects.shared.djProjId!)/ar-project-detail-page")!]
//                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//                present(ac, animated: true)
            }
        }else if lblControlArray.count == 2{
            if buttonId == 0{
                if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com/")!)) {
                    UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?daddr=\(projLat),\(projLong)&dirflg=d")!, options: [:], completionHandler: nil)
                } else {
                    print("Can't use http://maps.apple.com/")
                }
                print("Directions")
            }
            if buttonId == 1{
                print("Share")
//                let items = [URL(string: "https://djconnectapp.com/\(globalObjects.shared.djProjId!)/ar-project-detail-page")!]
//                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//                present(ac, animated: true)
                
                self.CreateDynamicLink(productId: "\(globalObjects.shared.djProjId!)")
            }
        }else{
            if buttonId == 0{
                self.showAlertView("Are you sure, you want to delete the project?", "Delete?", defaultTitle: "OK", cancelTitle: "Cancel", completionHandler: { (ACTION) in
                    if ACTION{
                        self.callDeleteProjectWebService()
                    }
                })
            }
        }
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
    
    @objc func btnGoLive_Action(_ sender: UIButton){
        currentIndex = sender.tag
        openForToTakeVideo(artistID: acceptArray[sender.tag].artistid!, audioID: acceptArray[sender.tag].audioid!)
    }
    
    func makeLiveVideo(artistID:Int, audioID:Int){
        print("artistID",artistID)
        print("audioID",audioID)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "VideoVerifyVC") as! VideoVerifyVC
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        vc1.artist_id = "\(artistID)"
        vc1.media_Id = "\(audioID)"
        vc1.project_id = projectId
        vc1.liveType = "project"
        for i in 0..<acceptArray.count{
            let indexPath1 = IndexPath.init(row: i, section: 0)
        let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
        cell.imageLoadingLbl.isHidden = false
        }
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc1, animated: false)
    }
    
    @objc func setRecordedView(_ notification: Notification){
        self.callNewArtistConnectedStatusWebService()
        UIView.animate(withDuration: 1.0) {
            self.vwArtConn.isHidden = false
            self.cnsArtistConnectTop.constant = 80
            self.view.layoutIfNeeded()
            self.scrView.isScrollEnabled = false
        }
        
        if let isBroadcast = notification.userInfo!["isBroadcast"] as? Bool{
            if isBroadcast == true{
                self.callNewArtistConnectedStatusWebService()
                getBroadCastIdSt = notification.userInfo!["broadcastId"] as? String ?? ""
                saveResourceUri = notification.userInfo!["videoURLSt"] as? String ?? ""
                savepreviewImage = notification.userInfo!["VideoImagSt"] as? String ?? ""
                artistIDInt = notification.userInfo!["artsistIdInt"] as? String ?? ""
                audioIDInt = notification.userInfo!["mediaIdInt"] as? String ?? ""
                for i in 0..<acceptArray.count{
                    if i == currentIndex{
                        let indexPath1 = IndexPath.init(row: i, section: 0)
                        let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                        cell.vwBackKeep.isHidden = false//1 brd twwwww n3  k1
                        cell.btnViewVideo.isUserInteractionEnabled = true
                        cell.btnVerify.isUserInteractionEnabled = false
                        cell.imgVideoThumbnail.isHidden = false
                        cell.lblVideoSongStatus.isHidden = true
                        let image = acceptArray[i].previewImg ?? ""
//                        if(getBroadCastIdSt != "" && image == ""){
                        if(getBroadCastIdSt != ""){
                            cell.imageLoadingLbl.isHidden = false
                        }
                        else{
                            cell.imageLoadingLbl.isHidden = true
                        }
                    }else{
                        let indexPath1 = IndexPath.init(row: i, section: 0)
                        let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                        cell.vwBackKeep.isHidden = true
                        cell.btnViewVideo.isUserInteractionEnabled = false
                        cell.btnVerify.isUserInteractionEnabled = true
                        cell.lblVideoSongStatus.isHidden = false
                    }
                }
            }
        }
        if let id = notification.userInfo!["broadcastId"] as? String{
            self.BroadcastID = id // k2
        }
    }
    
    @objc func btnKeepAction(_ sender: UIButton){
        let mediaId = acceptArray[sender.tag].audioid!
        artist_ID = "\(acceptArray[sender.tag].artistid!)"
        thumbnaillStr = ""
        
        callDJLiveWebservice(videoURL: saveResourceUri, VideoImag: savepreviewImage)
        callKeepWebservice(b_Id: BroadcastID, senderId: sender.tag)
    }
    
    //MARK: - WEBSERVICES
    func callDJLiveWebservice(videoURL : String, VideoImag : String){
        
        if getReachabilityStatus(){
            Loader.shared.show()
//            var project_ID = "0"
//                        if project_id != "null"{
//                            project_ID = "\(project_id)"
//                        }
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "dj_id":"\(UserModel.sharedInstance().userId!)",
                "artist_id":artistIDInt,
                "project_id":"\(projectId)",
                "broadcastID":"\(getBroadCastIdSt)",
                "id_for_verify":audioIDInt,
                "videoURL":"\(videoURL)",
                "videoImg":"\(VideoImag)",
                "type":"project"
            ]
            print("making live video parameter",parameters)
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addDjLiveAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                   // Loader.shared.hide()//
                    Loader.shared.show()
                    let addLiveModel = response.result.value!
                    if addLiveModel.success == 1{
                        Loader.shared.hide()
                    }else{
                        Loader.shared.hide()
//                        self.isBroadcasted = false
//                        self.navigationController?.popViewController(animated: true)
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
    
    
    @objc func btnGoBackAction(_ sender: UIButton){
        
        //self.acceptArray.removeAll()
        //let indexPath1 = sender.tag
        let indexPath1 = IndexPath.init(row: sender.tag, section: 0)
        let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
        cell.btnViewVideo.isUserInteractionEnabled = false
        cell.btnVerify.isUserInteractionEnabled = true
        thumbnaillStr = ""
        cell.imgVideoThumbnail.image = UIImage(named: "verifyCenterLogo")
        //callDeleteWebservice(b_Id: "\(BroadcastID)") // ashitesh
    }
    
    @objc func btnViewVideoAction(_ sender: UIButton){
        let broadCast = acceptArray[sender.tag].applied_broadcast_id
        callViewVideoWebService("\(broadCast!)")
    }
    
    @objc func backFromLive(){
        isFromBackLive = true
    }
    
    func toHome(){
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
    
    @objc func getStatus(_ notification: Notification){
        let status = notification.userInfo!["status"] as? Bool
        if status == true{
            if let index = notification.userInfo!["index"] as? Int{
                let indexPath1 = IndexPath.init(row: index, section: 0)
                let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                cell.imgEqualizer.isHidden = true
                tblArtistConnected.reloadData()
            }
        }
        else {
            if let index = notification.userInfo!["index"] as? Int{
                for i in 0..<acceptArray.count{
                    if i == index{
                        let indexPath1 = IndexPath.init(row: i, section: 0)
                        let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                        cell.imgEqualizer.isHidden = false
                        cell.imgEqualizer.alpha = 0.5
                        let jeremyGif = UIImage.gifImageWithName("EQ5")
                        cell.imgEqualizer.image = jeremyGif
                    }else{
                        let indexPath1 = IndexPath.init(row: i, section: 0)
                        let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                        cell.imgEqualizer.isHidden = true
                        cell.imgEqualizer.backgroundColor = .themeBlack
                    }
                }
            }
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnMenu_Action(_ sender: UIButton) {
        delegate?.dummyViewBtnMenuClicked()
        
    }
    @IBAction func btnWaitAction(_ sender: UIButton) {
        
        if(self.waitArray.count >= 1){
            viewWaitRequest.frame = view.bounds
            view.addSubview(viewWaitRequest)
            viewWaitRequest.isHidden = false
            selectedStatus = .waiting
        waitTableBgVw.addSubview(blurredView)
        waitTableBgVw.sendSubviewToBack(blurredView)
        waitShadowBgVw.layer.cornerRadius = 30
        waitShadowBgVw.clipsToBounds = true
        tableBgVw .layer.cornerRadius = 30
        tableBgVw.clipsToBounds = true
        }
        
    }
    
//    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//        // handling code
//        viewWaitRequest.removeFromSuperview()
//    }
    
    @IBAction func btnProfile_Actiom(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "CalendarVC") as? CalendarVC
        sideMenuController()?.setContentViewController(next1!)
    }

    @IBAction func btnAcceptedAction(_ sender: UIButton) {
        if artistConnected == false{
            
            if(self.acceptArray.count > 0){
                viewAcceptedReq.frame = view.bounds
                view.addSubview(viewAcceptedReq)
                viewAcceptedReq.isHidden = false
                selectedStatus = .accepted
            accptTBgVw.addSubview(blurredView)
            accptTBgVw.sendSubviewToBack(blurredView)
            acptShadowBgVw.layer.cornerRadius = 30
            acptShadowBgVw.clipsToBounds = true
            acptTbleBgVw.layer.cornerRadius = 30
            acptTbleBgVw.clipsToBounds = true
            }
            
        }else{
            UIView.animate(withDuration: 1) {
                self.vwArtConn.isHidden = false
                self.cnsArtistConnectTop.constant = 80
                self.callNewArtistConnectedStatusWebService()
                self.view.layoutIfNeeded()
                self.scrView.isScrollEnabled = false
            }
        }
    }
    
    
    @IBAction func btnNotAcceptAction(_ sender: UIButton) {
        
        if(rejectArray.count > 0){
        
        viewNotAcceptedReq.frame = view.bounds
        view.addSubview(viewNotAcceptedReq)
        viewNotAcceptedReq.isHidden = false
        selectedStatus = .notAccepted
        
        notConctedTbleBgVw.addSubview(blurredView)
        notConctedTbleBgVw.sendSubviewToBack(blurredView)
        notCnctdShadowBgVw.layer.cornerRadius = 30
        notCnctdShadowBgVw.clipsToBounds = true
        notCnctedTbInsideBgVw.layer.cornerRadius = 30
        notCnctedTbInsideBgVw.clipsToBounds = true
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
//        if isFromAlert == true{
//            toHome()
//        }else if isFromNotification == true{
//            toHome()
////            backNotificationView()
//        }else{
        if(navigationController == nil){
            UserDefaults.standard.removeObject(forKey: "linkProjectid")
            setUpDrawer()
        }
        else{
            let getProjectIdStr = UserDefaults.standard.string(forKey: "linkProjectid")
            if(getProjectIdStr != "" && getProjectIdStr != nil){
                UserDefaults.standard.removeObject(forKey: "linkProjectid")
                setUpDrawer()
            }
            else{
            UserDefaults.standard.removeObject(forKey: "linkProjectid")
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromBottom
            navigationController?.view.layer.add(transition, forKey: nil)

            navigationController?.popViewController(animated: false)
            }
            
        }
    }
    
    func setUpDrawer() {
       
       guard let centerController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "NewDJHomeVC") as? NewDJHomeVC else { return }
       guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
   
           let navigation = UINavigationController.init(rootViewController: centerController)
           navigation.setNavigationBarHidden(true, animated: false)
           let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                         leftViewController: sideController,
                                                         rightViewController: nil)
       sideMenuController.leftViewPresentationStyle = .scaleFromLittle
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = sideMenuController
        
        
     //self.window?.rootViewController = sideMenuController
        appDelegate.window?.makeKeyAndVisible()
      // }
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
                        self.logout()
                        
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
            if UserModel.sharedInstance().RememberUserType == "AR"{
                UserModel.sharedInstance().arname = arname
                UserModel.sharedInstance().arpassword = arpassword
                UserModel.sharedInstance().isRemembered = isRemember
                UserModel.sharedInstance().RememberUserType = rememberType
                UserModel.sharedInstance().synchroniseData()
                
            }else{
                UserModel.sharedInstance().userName = username
                UserModel.sharedInstance().password = password
                UserModel.sharedInstance().isRemembered = isRemember
                UserModel.sharedInstance().RememberUserType = rememberType
                UserModel.sharedInstance().synchroniseData()
                
            }
        }else{
            UserModel.sharedInstance().isRemembered = isRemember
        }
        self.ChangeRoot()
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
    
    @IBAction func btnViewImageAction(_ sender: UIButton) {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurButton.frame = view.bounds
        view.addSubview(blurButton)
        blurButton.addTarget(self, action: #selector(btnBlur_Action(_:)), for: .touchUpInside)
        self.vwFullImage.frame = view.bounds
        self.vwFullImage.center = self.view.center
        self.view.addSubview(vwFullImage)
        imgFullImage.image = imgDjProjImage.image
    }
    
    @IBAction func btnCloseImageViewAction(_ sender: UIButton) {
        blurButton.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        vwFullImage.removeFromSuperview()
    }
    
    @IBAction func btnWaitClose_Action(_ sender: UIButton) {
        self.callArtistSongStatusWebService(status: "0")
        self.callArtistSongStatusWebService(status: "1")
        self.callArtistSongStatusWebService(status: "2")
        viewWaitRequest.removeFromSuperview()
    }
    
    @IBAction func btnAction_Edit(_ sender: buttonProperties) {
//        GlobalId.id = "1"
//        GlobalId.ProjectDetailsId = projectId
//
//        let homeSB1 = UIStoryboard(name: "AddProject", bundle: nil)
//        let desiredViewController1 = homeSB1.instantiateViewController(withIdentifier: "DJAddPostVC") as! DJAddPostVC
//        let transition1 = CATransition()
//        transition1.duration = 0.3
//        transition1.type = CATransitionType(rawValue: "fade")
//        transition1.subtype = CATransitionSubtype.fromLeft
//        self.navigationController?.view.layer.add(transition1, forKey: kCATransition)
//        self.navigationController?.pushViewController(desiredViewController1, animated: false)
        
        GlobalId.id = "1"
        GlobalId.ProjectDetailsId = projectId
        
        let homeSB = UIStoryboard(name: "DJHome", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "PostConnectVC") as! PostConnectVC
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType(rawValue: "fade")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(desiredViewController, animated: false)
        
    }
    
    @IBAction func btnAcceptClose_Action(_ sender: UIButton) {
//        if(self.acceptArray.count > 0){
//        for i in 0..<self.acceptArray.count{
//            let indexPath1 = IndexPath.init(row: i, section: 0)
//            let cell = self.tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
//            cell.
//
//        }
//        }
//        audioPlayer?.stop()
        NotificationCenter.default.post(name: Notification.Name("playerStopped"), object: nil)
        viewAcceptedReq.removeFromSuperview()
    }
    
    @IBAction func btnNotAcceptClose_Action(_ sender: UIButton) {
        viewNotAcceptedReq.removeFromSuperview()
    }
    
    @IBAction func btnArtistConnectedClose_Action(_ sender: UIButton) {
        viewArtistConnected.removeFromSuperview()
    }
    
    @IBAction func btnChangeOrderAction(_ sender: UIButton) {
        
    }
    @IBAction func btnChangeOrder(_ sender: UIButton) {
        tblArtistConnected.isEditing = !tblArtistConnected.isEditing
        if tblArtistConnected.isEditing == false{
            callSetOrderWebservice()
        }
    }
    
    @IBAction func btnOkReasonAction(_ sender: UIButton) {
        lblReason1.backgroundColor = .white
        lblReason2.backgroundColor = .white
        lblReason3.backgroundColor = .white
        lblReason4.backgroundColor = .white
        lblReason5.backgroundColor = .white
        if RejectReason.isEmpty == false{
            selectedStatus = .notAccepted
            callAcceptRejectSongWebService(audioStatus: "2", removeId: removeIndex)
            viewWaitRequest.removeFromSuperview()
            blurEffectView.removeFromSuperview()
            blurredView.removeFromSuperview()
            vwRejectReason.removeFromSuperview()
        }else{
            self.view.makeToast("Please select any one of above reason.")
        }
    }
    
    @IBAction func btnCancelReasonAction(_ sender: UIButton) {
        lblReason1.backgroundColor = .white
        lblReason2.backgroundColor = .white
        lblReason3.backgroundColor = .white
        lblReason4.backgroundColor = .white
        lblReason5.backgroundColor = .white
        blurEffectView.removeFromSuperview()
        vwRejectReason.removeFromSuperview()
    }
    
    @IBAction func btnReason1Action(_ sender: UIButton) {
        RejectReason = "Offer too low. Resubmit with a higher price."
        lblReason1.backgroundColor = .lightGray
        lblReason2.backgroundColor = .white
        lblReason3.backgroundColor = .white
        lblReason4.backgroundColor = .white
        lblReason5.backgroundColor = .white
    }
    
    @IBAction func btnReason2Action(_ sender: UIButton) {
        RejectReason = "Song quality too low. Resubmit the song in a better quality."
        lblReason1.backgroundColor = .white
        lblReason2.backgroundColor = .lightGray
        lblReason3.backgroundColor = .white
        lblReason4.backgroundColor = .white
        lblReason5.backgroundColor = .white
    }
    
    @IBAction func btnReason3Action(_ sender: UIButton) {
        RejectReason = "Song is not for all audiences. Resubmit the song edited."
        lblReason1.backgroundColor = .white
        lblReason2.backgroundColor = .white
        lblReason3.backgroundColor = .lightGray
        lblReason4.backgroundColor = .white
        lblReason5.backgroundColor = .white
    }
    
    @IBAction func btnReason4Action(_ sender: UIButton) {
        RejectReason = "The song is not a fit for this event."
        lblReason1.backgroundColor = .white
        lblReason2.backgroundColor = .white
        lblReason3.backgroundColor = .white
        lblReason4.backgroundColor = .lightGray
        lblReason5.backgroundColor = .white
    }
    
    @IBAction func btnReason5Action(_ sender: UIButton) {
        RejectReason = "No reason."
        lblReason1.backgroundColor = .white
        lblReason2.backgroundColor = .white
        lblReason3.backgroundColor = .white
        lblReason4.backgroundColor = .white
        lblReason5.backgroundColor = .lightGray
    }
    
    //OTHER ARTIST CONNECTED
    @IBAction func btnCloseAction(_ sender: UIButton) {
        UIView.animate(withDuration: 3) {
            self.cnsArtistConnectTop.constant = self.view.frame.size.height
            self.view.layoutIfNeeded()
        }
        
        self.vwArtConn.isHidden = true
        self.cnsArtistConnectTop.constant = 0
        self.view.layoutIfNeeded()
        self.scrView.isScrollEnabled = true
    }
    
    //MARK: - WEBSERVICES
    func callGetProjectDetailWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
           
            globalObjects.shared.djProjId = projectId
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    //Loader.shared.hide()
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        self.setProjectDetail(detailProject: detailProject)
                    }else{
                        Loader.shared.hide()
                        if(detailProject.message == "You are not authorised. Please login again."){
                            self.view.makeToast(detailProject.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                            })
                        }
                        else{
                            self.view.makeToast(detailProject.message)
                        }
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    func setProjectDetail(detailProject:ProjectDetailModel) {
        
        let startString = detailProject.projectDetails![0].event_start_time! // 02:53
        print("startString1",detailProject.projectDetails![0].event_start_time)

        let dateAsString = startString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date24 = dateFormatter.date(from: dateAsString)

        dateFormatter.dateFormat = "hh:mm a"
        let date12 = dateFormatter.string(from: date24!)

        let startDate12 = date12
        
//        let startDate12 = startString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
//        print("startDate12",startDate12)
//        let startDate12 = startString.localToUTC(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
//        print("startDate12",startDate12)
        
        let endString = detailProject.projectDetails![0].event_end_time!
        let endDate12 = endString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")

        self.isProjOld = detailProject.projectDetails![0].is_old!
        self.isInProgress = detailProject.projectDetails![0].project_status!
        self.is_CancelStatus = "\(detailProject.projectDetails![0].is_cancelled!)"
        self.iscompletedID = "\(detailProject.projectDetails![0].is_completed!)"
        // ashitesh
//        btnEdit.isHidden = is_CancelStatus == "1" || iscompletedID == "1" || isProjOld == "1"
        
        
        
        
//        if is_CancelStatus == "1" || iscompletedID == "1" || isProjOld == "1"{
//            btnEdit.isHidden = true
//        }else{
//            btnEdit.isHidden = false
//        }
        Loader.shared.hide()
        self.projTimezone = detailProject.projectDetails![0].project_timezone!
       // if self.isProjOld == "1"{
//            self.isEnd = true
//            self.artistConnected = true
//            self.lblControlArray = ["Delete Project"]
//            self.imgControlArray = ["delete_post"]
//            self.collectionVwControls.reloadData()
//
//            self.btnAccepted.setTitle("VIEW CONNECTS", for: .normal)
//            self.btnAccepted.setTitleColor(.themeBlack, for: .normal)
//            self.lblConnectSubmissions.isHidden = true
//            self.btnAccepted.isHidden = false
//            self.vwWaitButton.isHidden = true
//            self.vwRejectButton.isHidden = true
//            self.btnNotAccepted.isHidden = true
//            self.btnWait.isHidden = true
       // }
       // else {
        if detailProject.projectDetails![0].is_cancelled == 1{
            self.isEnd = false
            self.isCancelled = true
            self.cancelProject()
        } else if detailProject.projectDetails![0].is_completed == 1{
            self.isComplete = true
            self.callProjectCompleted()
        }
        else{
            self.isCancelled = false
            self.isEnd = false
//            if detailProject.projectDetails![0].is_completed == 1{
//                self.isComplete = true
//                self.callProjectCompleted()
//            }
//            else{
                self.isComplete = false
                self.callArtistSongStatusWebService(status: "0")
                self.callArtistSongStatusWebService(status: "1")
                self.callArtistSongStatusWebService(status: "2")
            //}
        }
    //}
       // btnEdit.isHidden = is_CancelStatus == "1" || iscompletedID == "1" || isProjOld == "1"
        self.lbldjProjName.text = detailProject.projectDetails![0].title
        self.lblProjectName.text = detailProject.projectDetails![0].title
        self.lbldjByName.text = "By ".localize + detailProject.projectDetails![0].project_by!
        self.lbldjBio.text = detailProject.projectDetails![0].project_description
        if(self.lbldjBio.numberOfLines >= 0 && self.lbldjBio.numberOfLines < 8){
            self.scrlVwHght.constant = 1386
        }
        else {
            self.scrlVwHght.constant = 1386 + 235
        }
        
        let dateStr = detailProject.projectDetails![0].event_day_date!
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM/dd/yyyy"
        let datee = dateFormat.date(from: dateStr )
        dateFormat.dateFormat = "dd MM yyyy"
        let date22 = dateFormat.string(from: datee!)
        self.lblDayandDateTop.text = "| " + "Starts @" + startDate12
        dateStr
        self.lbldjTopTime.text = dateStr
        self.lbldjProjType.text = "TYPE: ".localize + detailProject.projectDetails![0].project_info_type!
        self.lbldjAudience.text = "AUDIENCE (expected): ".localize + detailProject.projectDetails![0].project_info_audiance!
        self.lbldjVenueName.text = "NAME: ".localize + detailProject.projectDetails![0].venue_name!
        
        let dateString = detailProject.projectDetails![0].event_date
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter1.date(from: dateString ?? "")
        dateFormatter1.dateFormat = "MMM d, yyyy"
        let date2 = dateFormatter1.string(from: date!)
        
        self.lbldjVenueDate.text = "DATE: ".localize + date2
        //self.lbldjVenueDate.text = "DATE: ".localize + detailProject.projectDetails![0].event_date!.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "MMM d, yyyy")
//        self.lbldjVenueTime.text = "TIME: ".localize + startDate12 + " to ".localize
//            + endDate12
        self.lbldjVenueTime.text = "TIME: ".localize + startDate12
        self.projLat = detailProject.projectDetails![0].latitude!
        self.projLong = detailProject.projectDetails![0].longitude!
        
        
        let location = CLLocationCoordinate2D(latitude: Double(self.projLat) ?? 0.0,longitude: Double(self.projLong) ?? 0.0)

        let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            let region = MKCoordinateRegion(center: location, span: span)
            venuMapvw.setRegion(region, animated: true)
        
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            
        venuMapvw.addAnnotation(annotation)
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "," // or possibly "." / ","
        formatter.numberStyle = .decimal
//        formatter.string(from: Int(detailProject.projectDetails![0].price!)! as NSNumber)
//        let string = formatter.string(from: Int(detailProject.projectDetails![0].price!)! as NSNumber)
//        self.lbldjConnectCost.text = "COST(Per Project): ".localize + self.currentCurrency + string!
//
        self.lbldjConnectCost.text = "COST(Per Connect): ".localize + self.currentCurrency + detailProject.projectDetails![0].price!
        
        //self.projCost = self.currentCurrency + string!
        self.projCost = self.currentCurrency + detailProject.projectDetails![0].price!
        self.lblProjectPrice.text = self.projCost
        self.lbldjVenueAdd.text = "LOCATION: ".localize +  detailProject.projectDetails![0].venue_address!
        self.lbldjConnectGenre.text = "GENRE(s): ".localize + detailProject.projectDetails![0].genre!
        //self.remainingTime = detailProject.projectDetails![0].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
        
        self.remainingTime = detailProject.projectDetails![0].closing_time!
        print("closingTime",remainingTime)

        self.startTimer()
        self.lbldjConnectRegulation.text = "RESTRICTIONS: ".localize + detailProject.projectDetails![0].regulation!
        if detailProject.projectDetails![0].special_Information! == " "{
            self.lbldjSpecialNone.text = "None".localize
        }else{
            self.lbldjSpecialNone.text = detailProject.projectDetails![0].special_Information
        }
        // profile image, project image
        let profileImageUrl = URL(string: "\(detailProject.projectDetails![0].profile_image!)")
        self.imgDjProfImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        
        let projectImageUrl = URL(string: "\(detailProject.projectDetails![0].project_image!)")
        self.imgDjProjImage.kf.setImage(with: projectImageUrl, placeholder: UIImage(named: "djCrowd"),  completionHandler: nil)
        
        if let projectLis = detailProject.projectDetails![0].spin_submission{
            self.GetProfileWaitList = projectLis
            self.btnWait.setTitle("\(self.GetProfileWaitList.count) waiting", for: .normal)
        }
        if self.isCompleteFromViewProfile == true{
            UIView.animate(withDuration: 1.0) {
                self.vwArtConn.isHidden = false
                self.cnsArtistConnectTop.constant = 80
                self.view.layoutIfNeeded()
                self.scrView.isScrollEnabled = false
            }
        }else{
            if isFromBackLive{
                self.vwArtConn.isHidden = false
                self.cnsArtistConnectTop.constant = 80
                self.view.layoutIfNeeded()
                isFromBackLive = false
                self.scrView.isScrollEnabled = false
            }else{
                self.vwArtConn.isHidden = true
                self.cnsArtistConnectTop.constant = 0
                self.view.layoutIfNeeded()
                self.scrView.isScrollEnabled = true
            }
        }
        self.isLoaded = true
    }
    func callArtistSongStatusWebService(status: String){
        if getReachabilityStatus(){ //add closing_time_seconds == "0" hide verifcation lbl.
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAppliedartistAudioAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)&audio_status=\(status)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SongStatusModel>) in
                
                switch response.result {
                case .success(_):
                    
                    let songStatusProfile = response.result.value!
                    if songStatusProfile.success == 1{
                        Loader.shared.hide()
                        if status == "0"{
                            self.waitArray = songStatusProfile.appliedAudioData!
                            self.btnWait.setTitle("\(self.waitArray.count) waiting", for: .normal)
                            self.tableWait.isHidden = false
                            self.tableWait.reloadData()
                            self.lblWaitArtistCount.text = "\(self.waitArray.count) " + "dj_wait".localize
                            self.waitArrayCount = self.waitArray.count
                            if(self.waitArray.count > 0){
                                self.btnEdit.isHidden = true
                                self.vwWaitButton.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
                            }
                            else{
                                self.vwWaitButton.backgroundColor = .clear
                            }
                            
                        }else if status == "1"{
                            self.acceptArray = songStatusProfile.appliedAudioData!
                            self.tableAccept.isHidden = false
                            self.tableAccept.reloadData()
                            self.btnAccepted.setTitle("\(self.acceptArray.count) accepted", for: .normal)
                            self.lblArtistAcceptCount.text = "\(self.acceptArray.count) " + "dj_accept".localize
                            self.acceptArrayCount = self.acceptArray.count

//                            if(self.acceptArray.count > 0){
//                                self.btnEdit.isHidden = true
//                            }
                            if(self.acceptArray.count > 0){
                                self.btnEdit.isHidden = true
                                self.vwAccptButtonv.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
                            }
                            else{
                                self.vwAccptButtonv.backgroundColor = .clear
                            }
                            
                            self.tblArtistConnected.reloadData()
                        }else{
                            self.rejectArray = songStatusProfile.appliedAudioData!
                            self.tableNotAccept.isHidden = false
                            self.tableNotAccept.reloadData()
                            self.btnNotAccepted.setTitle("\(self.rejectArray.count) not accepted", for: .normal)
                            self.lblNotAcceptArtistCount.text = "\(self.rejectArray.count) " + "dj_reject".localize
                            self.notAcceptArrayCount = self.rejectArray.count
                            if(self.rejectArray.count > 0){
                                self.vwRejectButton.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
                            }
                            else{
                                self.vwRejectButton.backgroundColor = .clear
                            }
                        }
                    }else{
                        Loader.shared.hide()
                        if status == "1"{
                            self.waitArrayCount = 0
                            self.tableWait.reloadData()
                            self.btnWait.setTitle("0 waiting", for: .normal)
                            self.lblWaitArtistCount.text = "0 " + "dj_wait".localize
                            self.vwWaitButton.backgroundColor = .clear
                        }else if status == "0"{
                            self.btnAccepted.setTitle("0 accepted", for: .normal)
                            self.lblArtistAcceptCount.text = "0 " + "dj_accept".localize
                            self.vwAccptButtonv.backgroundColor = .clear
                        }else{
                            self.btnNotAccepted.setTitle("0 not accepted", for: .normal)
                            self.lblNotAcceptArtistCount.text = "0 " + "dj_reject".localize
                            self.vwRejectButton.backgroundColor = .clear
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
                            self.waitArray.remove(at: removeId)
                            self.tableWait.reloadData()

                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.viewWaitRequest.removeFromSuperview()
                                self.callArtistSongStatusWebService(status: "0")
                                self.callArtistSongStatusWebService(status: "1")
                                self.callArtistSongStatusWebService(status: "2")
                                
                            })

                        }
                        if self.selectedStatus == .notAccepted{
                            self.waitArray.remove(at: removeId)
                            self.tableWait.reloadData()
                            if(self.waitArray.count > 0){
                                
                            }
                            else{
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                    self.viewWaitRequest.removeFromSuperview()
                                    self.callArtistSongStatusWebService(status: "0")
                                    self.callArtistSongStatusWebService(status: "1")
                                    self.callArtistSongStatusWebService(status: "2")
                                    
                                })
                            }
                        }
                    }else{
                        Loader.shared.hide()
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
    
    func callGetProjectStatusWebService(_ type: String){
        if getReachabilityStatus(){
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "projectid":"\(projectId)",
                "project_status":"\(type)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.statusChangeProjectAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let projectStatusModel = response.result.value!
                    
                    if projectStatusModel.success == 1{
                        if type != "cancel"{
                            self.artistConnected = true
                            //self.lblConnectSubmissions.isHidden = true
                            self.btnAccepted.isHidden = false
                            self.vwWaitButton.isHidden = true
                            self.vwRejectButton.isHidden = true
                            //self.btnAccepted.setTitle("VIEW CONNECTS", for: .normal)
                            //self.btnAccepted.setTitleColor(.white, for: .normal)
                            self.btnAccepted.setTitle("", for: .normal)
                            self.btnAccepted.setTitleColor(.clear, for: .normal)
                            self.vwAccptButtonv.backgroundColor = .clear
                            self.viewConctBtn.isHidden = false
                            self.btnEdit.isHidden = true
                            self.viewConctBtn.setTitleColor(.white, for: .normal)
                            self.btnNotAccepted.isHidden = true
                            self.btnWait.isHidden = true
                        }
                        self.callGetProjectDetailWebService()
                        
                    }else{
                        Loader.shared.hide()
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
    
    func callSetOrderWebservice(){
        if getReachabilityStatus(){
            for i in 0..<acceptArray.count{
                acceptArrayId.append("\(acceptArray[i].audioid!)")
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
                        self.stringArrayCleaned = ""
                        self.acceptArrayId.removeAll()
                        self.view.makeToast(setOrderModel.message)
                    }else{
                        Loader.shared.hide()
                        self.stringArrayCleaned = ""
                        self.acceptArrayId.removeAll()
                        self.view.makeToast(setOrderModel.message)
                    }
                case .failure(let error):
                    self.stringArrayCleaned = ""
                    self.acceptArrayId.removeAll()
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callDeleteProjectWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "projectid":"\(projectId)"
            ]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.deleteProjectAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let deleteModel = response.result.value!
                    if deleteModel.success == 1{
                        let transition = CATransition()
                        transition.duration = 0.5
                        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                        transition.type = CATransitionType.reveal
                        transition.subtype = CATransitionSubtype.fromBottom
                        self.navigationController?.view.layer.add(transition, forKey: nil)
                        self.navigationController?.popViewController(animated: false)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(deleteModel.message)
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
            print("parameters",parameters)
            
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
    
    func callCurrencyListWebService(){
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
        }
    }
    
    func callNewArtistConnectedStatusWebService(){ //ashi
        isCompleteFromViewProfile = false
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAppliedartistAudioAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)&audio_status=1"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SongStatusModel>) in
                
                switch response.result {
                case .success(_):
                    let songStatusProfile = response.result.value!
                    if songStatusProfile.success == 1{
                        self.acceptArray = songStatusProfile.appliedAudioData!
                        self.lblNoOfArtistConnected.text = "\(self.acceptArray.count) Artist Connected"
                        for i in 0..<self.acceptArray.count{
                            self.playList.append(self.acceptArray[i].audiofile!)
                            self.userDetail.append(self.acceptArray[i].artistname!)
                            self.albumDetail.append(self.acceptArray[i].audioname!)
                        }
                        self.tblArtistConnected.reloadData()
                        
                    }else{
                        self.lblNoOfArtistConnected.text = "0 Artist Connected"
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callDJLiveWebservice(b_Id : String, m_Id : String, senderId: Int){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "dj_id":"\(UserModel.sharedInstance().userId!)",
                "artist_id":"\(artist_ID)",
                "project_id":"\(projectId)",
                "broadcastID":"\(b_Id)",
                "id_for_verify":"\(m_Id)",
                "type":"project"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addDjLiveAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let addLiveModel = response.result.value!
                    if addLiveModel.success == 1{
                        self.view.makeToast(addLiveModel.message)
                        for i in 0..<self.acceptArray.count{
                            let indexPath1 = IndexPath.init(row: i, section: 0)
                            let cell = self.tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                            cell.vwBackKeep.isHidden = true
                            cell.lblVideoSongStatus.isHidden = false
                            cell.btnVerify.isUserInteractionEnabled = false
                            cell.btnViewVideo.isUserInteractionEnabled = false
                            if i == senderId{
                                
                                if(self.videoVerified == 1){
                                    cell.lblVideoSongStatus.text = "Video verified"
                                    cell.lblVideoSongStatus.textColor = .green
                                }
                                else{
                                    cell.lblVideoSongStatus.text = "Waiting for Artist"
                                    cell.lblVideoSongStatus.textColor = .red
                                }
                            }
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(addLiveModel.message)
                        
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
    
    func callDeleteWebservice(b_Id : String){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "broadcastID":"\(b_Id)"
            ]
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.removeDjLiveAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let deleteModel = response.result.value!
                    if deleteModel.success == 1{
                        self.view.makeToast(deleteModel.message)
                        for i in 0..<self.acceptArray.count{
                            if i == self.currentIndex{
                                let indexPath1 = IndexPath.init(row: i, section: 0)
                                let cell = self.tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                                cell.vwBackKeep.isHidden = true
                                cell.lblVideoSongStatus.isHidden = false
                                cell.btnVerify.isUserInteractionEnabled = true
                                cell.btnViewVideo.isUserInteractionEnabled = false
                                self.thumbnaillStr = ""
                                cell.imgVideoThumbnail.image = UIImage(named: "verifyCenterLogo")
                                if(self.videoVerified == 1){
                                    cell.lblVideoSongStatus.text = "Video verified"
                                    cell.lblVideoSongStatus.textColor = .green
                                }else{
                                cell.lblVideoSongStatus.text = "Verification Waiting"
                                cell.lblVideoSongStatus.textColor = .red
                                }
                            }else{
                                let indexPath1 = IndexPath.init(row: i, section: 0)
                                let cell = self.tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                                cell.vwBackKeep.isHidden = true
                                cell.lblVideoSongStatus.isHidden = false
                                cell.btnVerify.isUserInteractionEnabled = true
                                cell.btnViewVideo.isUserInteractionEnabled = false
                                
                            }
                        }
                        self.tblArtistConnected.reloadData()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(deleteModel.message)
                        
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
    
    func callViewVideoWebService(_ brodcastID : String){
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
                    let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                    let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as? ArtistBambUserPlayerVC
                    next1?.uri = uri!
                    next1?.isFromProjectDetail = true
                    next1?.projId = self.projectId
                    next1?.broadCastID = brodcastID
                    self.navigationController?.pushViewController(next1!, animated: false)
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
    
    func callKeepWebservice(b_Id : String,senderId : Int){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "broadcastID":"\(b_Id)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.changeBroadcastStatusAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let keepModel = response.result.value!
                    if keepModel.success == 1{
                        //self.view.makeToast(keepModel.message)
                        self.view.makeToast("verification video save successfully")
                        for i in 0..<self.acceptArray.count{
                            let indexPath1 = IndexPath.init(row: i, section: 0)
                            let cell = self.tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                            cell.vwBackKeep.isHidden = true
                            cell.lblVideoSongStatus.isHidden = false
                            cell.btnVerify.isUserInteractionEnabled = false
                            cell.btnViewVideo.isUserInteractionEnabled = false
                            //let thumbnail = URL(string: "\(self.acceptArray[i].previewImg!)")
                            
                            let thumbnail = URL(string: self.thumbnaillStr)
                            if(self.thumbnaillStr != ""){
                                //cell.imgVideoThumbnail.image = self.thumbnaill
                                cell.imgVideoThumbnail.kf.setImage(with: thumbnail, placeholder: UIImage(named: "verifyCenterLogo"),  completionHandler: nil)
                            }else{
                                //self.thumbnaillStr = ""
//                            cell.imgVideoThumbnail.kf.setImage(with: thumbnail, placeholder: UIImage(named: "verifyCenterLogo"),  completionHandler: nil)
                            }
                            if i == senderId{
//                                cell.lblVideoSongStatus.text = "Waiting for Artist"
//                                cell.lblVideoSongStatus.textColor = .red
                                if(self.videoVerified == 1){
                                    cell.lblVideoSongStatus.text = "Video verified"
                                    cell.lblVideoSongStatus.textColor = .green
                                }
                                else{
                                    cell.lblVideoSongStatus.text = "Waiting for Artist"
                                    cell.lblVideoSongStatus.textColor = .red
                                }
                            }
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(keepModel.message)
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
    
    //MARK: - OTHER METHODS
    func openForToTakeVideo(artistID:Int, audioID:Int){
        let alertController = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let CameraAction = UIAlertAction(title: "Go Live", style: .default) { (ACTION) in

            self.makeLiveVideo(artistID: artistID, audioID: audioID)
        }
        let GalleryAction = UIAlertAction(title: "Upload Video", style: .default) { (ACTION) in
            self.openGallary()
            //self.showImagePicker()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (ACTION) in
        }
        alertController.addAction(CameraAction)
        alertController.addAction(GalleryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func showImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .savedPhotosAlbum
        //picker.mediaTypes = [kUTTypeMovie as String]
        picker.mediaTypes = ["public.movie"]
        picker.videoQuality = .typeIFrame1280x720
        self.present(picker, animated: true, completion: nil)
    }
    
    func uploadStarted() {
        let alert = UIAlertController(title: "Uploading", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.uploadEnded()
            self.fileUploader?.cancelUpload()
        })
        self.present(alert, animated: true, completion: {
            let pb = UIProgressView(frame: CGRect(x: 30.0, y: 80.0, width: 225.0, height: 90.0))
            pb.progressViewStyle = .bar
            alert.view.addSubview(pb)
            self.progressBarr = pb
        })
        uploadDialog = alert
    }

    func uploadUpdated(_ progress: NSNumber) {
        debugPrint("Upload progress", progress.floatValue)
        progressBarr?.setProgress(progress.floatValue, animated: true)
    }

    func uploadEnded() {
        debugPrint("Upload finished")
        progressBarr?.removeFromSuperview()
        uploadDialog?.dismiss(animated: true)
    }

    func uploadFailed() {
        progressBarr?.removeFromSuperview()
        uploadDialog?.dismiss(animated: true)
        showError("", title: "Upload failed")
    }

    func showError(_ message: String, title: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func openGallary()
    {
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        picker.mediaTypes = ["public.movie"]
            present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        picker.dismiss(animated: true, completion: nil)
//            fileUploader?.getTicketAndUploadFromPicker(info: info)
//
//        var videoURL : NSURL?
//        videoURL = info[UIImagePickerController.InfoKey.mediaURL]as? NSURL
//            print(videoURL!)
//            do {
//                let asset = AVURLAsset(url: videoURL as! URL , options: nil)
//                let imgGenerator = AVAssetImageGenerator(asset: asset)
//                imgGenerator.appliesPreferredTrackTransform = true
//                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
//                thumbnaill = UIImage(cgImage: cgImage)
//                thumbnaillStr = "setIamge"
//                for i in 0..<self.acceptArray.count{
//                    let indexPath1 = IndexPath.init(row: i, section: 0)
//                    let cell = self.tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
//
//                    cell.imgVideoThumbnail.image = thumbnaill
//                }
//                //imgView.image = thumbnail
//            } catch let error {
//                print("*** Error generating thumbnail: \(error.localizedDescription)")
//            }
            picker.dismiss(animated: true, completion: nil)
        // Using the full key
        if let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            print("videoURL",url)
        }

        // Using just the information key value
        if let url = info[.mediaURL] as? URL {
            print("videoURL1",url)
            // Do something with the URL
        }

            
    }
}

//MARK: - EXTENSIONS
extension DJProjectDetail : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}

//extension DJProjectDetail : UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate{
extension DJProjectDetail : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return waitArray.count
        }else if tableView.tag == 1 {
            //return 3
            return acceptArray.count
        }else if tableView.tag == 2{
            return rejectArray.count
        }else {
            return acceptArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWait", for: indexPath) as! waitingRequestDetails
            indexPathRow = indexPath.row
            //cell.delegate = self // swipe cell delegate -- ashitesh
            cell.imgProfileImage.layer.cornerRadius = cell.imgProfileImage.frame.size.height/2
            if let url = waitArray[indexPath.row].audiofile{
                cell.url = URL(string: url)
            }
//            cell.waitSlider.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
//            cell.waitSlider.tag = indexPath.row
            let profileImageUrl = URL(string: "\(waitArray[indexPath.row].profilepicture!)")
            cell.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.lblProjectname.text = waitArray[indexPath.row].audioname
            cell.lblDjName.text = waitArray[indexPath.row].artistname
            cell.lblGenre.text = waitArray[indexPath.row].genre ?? ""
            cell.btnLikeWait.tag = indexPath.row
            cell.btnLikeWait.addTarget(self, action: #selector(btnLikeWait_Action(_:)), for: .touchUpInside)
            cell.btnDislikeWait.tag = indexPath.row
            cell.btnDislikeWait.addTarget(self, action: #selector(btnDislikeWait_Action(_:)), for: .touchUpInside)
            cell.waitSlider.setThumbImage(UIImage(named: "songSlider"), for: .normal)
            if waitArray[indexPath.row].cost!.isEmpty == false{
                cell.lblCost.isHidden = false
                cell.lblOffering.isHidden = false
                cell.lblCost.text = "Cost: \(self.projCost)"
                let formatter = NumberFormatter()
                formatter.groupingSeparator = "," // or possibly "." / ","
                formatter.numberStyle = .decimal
//                formatter.string(from: Int(waitArray[indexPath.row].offering!)! as NSNumber)
//                let string1 = formatter.string(from: Int(waitArray[indexPath.row].offering!)! as NSNumber)
//
                //cell.lblOffering.text = " Offerings: "\(waitArray[indexPath.row].offering!)"
               // cell.lblOffering.text = " Offerings: " + string1!
                self.isOfferAudio = true
            }else{
                cell.lblCost.isHidden = true
                cell.lblOffering.isHidden = true
                self.isOfferAudio = false
            }
            
            return cell
        }else if tableView.tag == 1{
            // accept
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellAccept", for: indexPath) as! acceptRequestDetails
            cell.url = acceptArray[indexPath.row].audiofile!
           // self.preparePlayer(URL(string: acceptArray[indexPath.row].audiofile!))
            
            cell.imgAcceptProfile.layer.cornerRadius = cell.imgAcceptProfile.frame.size.height/2
            
            cell.acceptSlider.setThumbImage(UIImage(named: "songSlider"), for: .normal)
            cell.btnAcceptPlay.tag = indexPath.row
            let profileImageUrl = URL(string: "\(acceptArray[indexPath.row].profilepicture!)")
            cell.imgAcceptProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            
            cell.lblAcProjName.text = acceptArray[indexPath.row].audioname!
            cell.lblAcDjName.text = acceptArray[indexPath.row].artistname!
            cell.lblAcGenre.text = acceptArray[indexPath.row].genre!
            return cell
        }else if tableView.tag == 2{
            // not accept
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellNotAccept", for: indexPath) as! notAcceptRequestDetails
            cell.notAcceptSlider.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
            let profileImageUrl = URL(string: "\(rejectArray[indexPath.row].profilepicture!)")
            cell.imgNAcProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.url = URL(string: rejectArray[indexPath.row].audiofile!)
            cell.lblNAcProName.text = rejectArray[indexPath.row].audioname!
            cell.lblNAcDjName.text = rejectArray[indexPath.row].artistname!
            cell.lblNAcGenre.text = rejectArray[indexPath.row].genre!
            cell.lblDjReason.text = rejectArray[indexPath.row].reason!
            return cell
        }else {
            // artist connected
            let cell = tableView.dequeueReusableCell(withIdentifier: "connectedArtistDetails", for: indexPath) as! connectedArtistDetails
            let profileImageUrl = URL(string: "\(acceptArray[indexPath.row].profilepicture!)")
            cell.imageLoadingLbl.isHidden = true
            cell.imgArtistProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.btnArtistConnectPlay.tag = indexPath.row
            cell.btnArtistConnectPlay.addTarget(self, action: #selector(btnArtistAcceptPlay_Action(_:)), for: .touchUpInside)
            cell.btnDownload.tag = indexPath.row
            cell.btnDownload.addTarget(self, action: #selector(btnArtistSongDownload_Action(_:)), for: .touchUpInside)
            cell.btnBack.tag = indexPath.row
            cell.btnBack.addTarget(self, action: #selector(btnGoBackAction(_:)), for: .touchUpInside)
//            if (self.getZeroTime == "0 DAY 0 HR 0 MIN 0 SEC"){
//                cell.btnKeep.isHidden = true
//                cell.btnBack.isHidden = true
//                cell.btnVerify.isHidden = true
//                cell.verifyConctLbl.isHidden = true
//                cell.dashLbl.isHidden = true
//                cell.liveIconImg.isHidden = true
//            }
//            else{
//                cell.btnKeep.isHidden = false
//                cell.btnBack.isHidden = false
//                cell.btnVerify.isHidden = false
//                cell.verifyConctLbl.isHidden = false
//                cell.dashLbl.isHidden = false
//                cell.liveIconImg.isHidden = false
//            }
            cell.btnKeep.tag = indexPath.row
            cell.btnKeep.addTarget(self, action: #selector(btnKeepAction(_:)), for: .touchUpInside)
            cell.lblProjectAmount.text = acceptArray[indexPath.row].project_price!
            cell.lblArtistSongName.text = acceptArray[indexPath.row].audioname!
            cell.lblArtistName.text = acceptArray[indexPath.row].artistname!
            cell.lblArtistMusicGenre.text = acceptArray[indexPath.row].genre!
            
            cell.btnVerify.tag = indexPath.row
            cell.btnVerify.addTarget(self, action: #selector(btnGoLive_Action(_:)), for: .touchUpInside)
            cell.btnViewVideo.tag = indexPath.row
            cell.btnViewVideo.addTarget(self, action: #selector(btnViewVideoAction(_:)), for: .touchUpInside)
            if acceptArray[indexPath.row].cost!.isEmpty == false{
                
                let formatter = NumberFormatter()
                formatter.groupingSeparator = "," // or possibly "." / ","
                formatter.numberStyle = .decimal
//                formatter.string(from: Int(acceptArray[indexPath.row].offering!)! as NSNumber)
//                let string2 = formatter.string(from: Int(acceptArray[indexPath.row].offering!)! as NSNumber)
//
                cell.lblProjectAmount.text = "\(self.currentCurrency)\(acceptArray[indexPath.row].offering!)"
               // cell.lblProjectAmount.text = "\(self.currentCurrency)" + " " + string2!
            }else{
                cell.lblProjectAmount.text = "\(self.projCost)"
            }
           // if acceptArray[indexPath.row].applied_broadcast_id!.isEmpty{
           // saveResourceUri = notification.userInfo!["videoURLSt"] as? String ?? ""
            //savepreviewImage = notification.userInfo!["VideoImagSt"] as? String ?? ""//
            if( saveResourceUri == ""){
            //if acceptArray[indexPath.row].applied_broadcast_id!.isEmpty{
                cell.vwBackKeep.isHidden = true //2   1 as,  3 as // n 4 - hide loader// ashitesh
                thumbnaillStr = savepreviewImage
                if(self.thumbnaillStr != ""){
                    cell.imgVideoThumbnail.image = self.thumbnaill
                }else{
                    self.thumbnaillStr = ""
                cell.btnVerify.isUserInteractionEnabled = true
                let image = acceptArray[indexPath.row].previewImg as? String ?? ""
                let thumbnail = URL(string: image)
                cell.imgVideoThumbnail.kf.setImage(with: thumbnail, placeholder: UIImage(named: "verifyCenterLogo"),  completionHandler: nil)
                    if(self.videoVerified == 1){
                        cell.lblVideoSongStatus.text = "Video verified"
                        cell.lblVideoSongStatus.textColor = .green
                    }else{
                cell.lblVideoSongStatus.text = "Verification Waiting"
                        cell.lblVideoSongStatus.textColor = .red
                    }
               
                cell.btnViewVideo.isUserInteractionEnabled = false //1
                cell.imgVideoThumbnail.image = UIImage(named: "verifyCenterLogo")
                if(getBroadCastIdSt != "" && image == ""){
                    cell.imageLoadingLbl.isHidden = false
                }
                else{
                    cell.imageLoadingLbl.isHidden = true
                }
                }
               
            }
            else{
                thumbnaillStr = savepreviewImage
//                if acceptArray[indexPath.row].is_keep! == 1{
                if thumbnaillStr == "" {
                    cell.vwBackKeep.isHidden = true
                }
                else{
                    //self.Loader.shared.hide()
                    Loader.shared.show()
                    
                    cell.vwBackKeep.isHidden = false
                    //BroadcastID = acceptArray[indexPath.row].applied_broadcast_id!
                }
                cell.lblVideoSongStatus.isHidden = true
                cell.imageLoadingLbl.isHidden = true //99
                //let thumbnail = URL(string: "\(acceptArray[indexPath.row].previewImg!)")
                let thumbnail = URL(string: thumbnaillStr)
                if(thumbnaillStr != ""){
                    //cell.imgVideoThumbnail.image = thumbnaill
                    cell.imgVideoThumbnail.kf.setImage(with: thumbnail, placeholder: UIImage(named: "verifyCenterLogo"),  completionHandler: nil)
                }else{
                    //thumbnaillStr = ""
               // cell.imgVideoThumbnail.kf.setImage(with: thumbnail, placeholder: UIImage(named: "verifyCenterLogo"),  completionHandler: nil)
                }
                Loader.shared.hide()
                
                cell.btnVerify.isUserInteractionEnabled = false
                cell.btnViewVideo.isUserInteractionEnabled = true
               // if acceptArray[indexPath.row].is_video_verify! == 0{
                   // cell.lblVideoSongStatus.text = "Waiting for Artist"
                //}else{
                    //cell.lblVideoSongStatus.text = "Verified - Payment Sent"
               // } // commented by ashitesh
            }
            
            let closingTimeSTr = acceptArray[indexPath.row].closing_time_seconds ?? 0
            let iskeepIntval = acceptArray[indexPath.row].is_keep ?? 0
            print("closingTimeSTr:",closingTimeSTr)
            print("previewImgStr : ",iskeepIntval)
            if(closingTimeSTr == 0 || iskeepIntval == 1){
                cell.btnKeep.isHidden = true
                cell.btnBack.isHidden = true
                cell.btnVerify.isHidden = true
                //cell.verifyConctLbl.isHidden = true
                cell.dashLbl.isHidden = true
                //cell.liveIconImg.isHidden = true
                if(self.videoVerified == 1){
                    cell.lblVideoSongStatus.text = "Video verified"
                    cell.lblVideoSongStatus.textColor = .green
                }
                else{
                    cell.lblVideoSongStatus.text = "Waiting for Artist"
                    cell.lblVideoSongStatus.textColor = .red
                }
                //cell.lblVideoSongStatus.text = "Waiting for Artist" // 1
                cell.lblVideoSongStatus.textColor = .red
                cell.lblVideoSongStatus.isHidden = false
            }
//            else{
//               // cell.vwBackKeep.isHidden = false
//                cell.btnKeep.isHidden = false//3
//                cell.btnBack.isHidden = false
//                cell.btnVerify.isHidden = false
//                cell.verifyConctLbl.isHidden = false
//                cell.dashLbl.isHidden = false
//                cell.liveIconImg.isHidden = false
//                cell.lblVideoSongStatus.isHidden = true
//            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0 {
            return 254
        }else if tableView.tag == 1 {
            return 193
        }else if tableView.tag == 2{
            return 240
        }else {
            return 253
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//
//        options.maximumButtonWidth = 90
//        options.minimumButtonWidth = 90
//        options.buttonSpacing = 8
//
//        return options
//    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        if tableView.tag == 0{
//            if orientation == .right {
//
//                let profile = SwipeAction(style: .destructive, title: "") { action, indexPath in
//                    self.removeIndex = indexPath.row
//                    self.Audio_id = "\(self.waitArray[indexPath.row].audioid!)"
//                    self.selectedStatus = .accepted
//                    self.callAcceptRejectSongWebService(audioStatus: "1", removeId: self.removeIndex)
//                }
//                profile.backgroundColor = UIColor .themeWhite
//                //profile.image = UIImage(named: "like")
//                profile.image = UIImage(named: "btnlikeg")
//
//                profile.font = .boldSystemFont(ofSize: 10)
//                profile.textColor = UIColor.red
//                return [profile]
//            }
//            if orientation == .left {
//
//                let profile = SwipeAction(style: .destructive, title: "") { action, indexPath in
//                    self.removeIndex = indexPath.row
//                    self.Audio_id = "\(self.waitArray[indexPath.row].audioid!)"
//                    //self.viewWaitRequest.removeFromSuperview()
//                    self.waitTableBgVw.isHidden = true
//                    self.waitShadowBgVw.isHidden = true
//                    self.tableBgVw.isHidden = true
//                    self.blurEffectView.frame = self.view.bounds
//                    self.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                    self.view.addSubview(self.blurredView)
//                    self.vwRejectReason.center = self.view.center
//                    self.view.addSubview(self.vwRejectReason)
////                    self.view.addSubview(self.blurEffectView)
////                    self.vwRejectReason.center = self.view.center
////                    self.view.addSubview(self.vwRejectReason)
//
//
//
//                }
//                profile.backgroundColor = UIColor .themeWhite
//                //profile.image = UIImage(named: "dis-like")
//                profile.image = UIImage(named: "btndont liker")
//               // profile.tintColor = UIColor.red
//                if #available(iOS 13.0, *) {
//                    profile.image?.withTintColor(UIColor(red: 138/255, green: 62/255, blue: 169/255, alpha: 1.0))
//                } else {
//                    // Fallback on earlier versions
//                }
//
//                profile.font = .boldSystemFont(ofSize: 10)
//                profile.textColor = UIColor.red
//                return [profile]
//            }
//        }else{
//            return nil
//        }
//        return nil
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = acceptArray[sourceIndexPath.row]
        acceptArray.remove(at: sourceIndexPath.row)
        acceptArray.insert(itemToMove, at: destinationIndexPath.row)
    }
    func tableView(_ tableview: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
extension DJProjectDetail: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEnd == true{
            return 1
        }else if isCancelled == true{
            return 2
        }else{
            if isComplete == true{
                return 3
            }else{
                return 4
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectControlButtons", for: indexPath) as! projectControlButtons
        cell.btnProjControl.tag = indexPath.row
        cell.btnProjControl.addTarget(self, action: #selector(btnProjControl_Action(_:)), for: .touchUpInside)
        cell.cellBgVw.layer.borderWidth = 1
        cell.cellBgVw.layer.cornerRadius = cell.cellBgVw.frame.size.height/2
//        if indexPath.item == 0{
//            cell.cellBgVw.roundCorners(corners: [.topLeft, .bottomLeft], radius: cell.cellBgVw.frame.size.height/2)
//            cell.cellBgVw.clipsToBounds = true
//        }
        
        cell.cellBgVw.layer.borderColor = UIColor.white.cgColor
        if isEnd == true{
            cell.lblButtonName.text = lblControlArray[indexPath.row]
            cell.lblButtonName.textColor = .red
        }else{
            cell.lblButtonName.text = lblControlArray[indexPath.row]
            cell.lblButtonName.textColor = .white
        }
        cell.imgControl.image = UIImage(named: imgControlArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isEnd == true{
            return CGSize(width:(collectionVwControls.frame.width), height: 40)
        }else if isCancelled == true{
            cnsVwProjectControlHeight.constant = 50
            return CGSize(width:(collectionVwControls.frame.width)/2, height: 40)
        }else{
            if isComplete == false{
                cnsVwProjectControlHeight.constant = 100
                return CGSize(width:(collectionVwControls.frame.width)/2, height: 40)
            }else{
                cnsVwProjectControlHeight.constant = 100
                return CGSize(width:(collectionVwControls.frame.width)/2, height: 40)
            }
        }
    }
}

class MySlide: UISlider {
    @IBInspectable var height: CGFloat = 30
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: height))
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}




