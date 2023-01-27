//
//  PostDetailViewController.swift
//  DJConnect
//
//  Created by Techugo on 30/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import MapKit
import AlamofireObjectMapper
import Alamofire
import AVFoundation
import SwipeCellKit
import Photos
import SwiftyGif
import FBSDKCoreKit
import FBSDKLoginKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var topImgVw: UIImageView!
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var byNameLbl: UILabel!
    @IBOutlet weak var costPriceLbl: UILabel!
    @IBOutlet weak var timeBgVw: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var hdrConnectSubmisinLbl: UILabel!
    @IBOutlet weak var waitingBtn: UIButton!
    @IBOutlet weak var accptdBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var dirctnStrtBgVw: UIView!
    @IBOutlet weak var dirctnBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var hdrDetailLbl: UILabel!
    @IBOutlet weak var descrptnDetailLbl: UILabel!
    @IBOutlet weak var hdrVenueInfoLbl: UILabel!
    
    var getZeroTime = String()
    var projectId = String()
    var isProjOld = String()
    var isInProgress = String()
    
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
    var imgControlArray = ["project_direction","project","Untitled-71","project_share"]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVw()
    }
    
    func setUpVw(){
         
        profileImgVw.layer.cornerRadius = profileImgVw.frame.size.height/2
        profileImgVw.clipsToBounds = true
        
        timeBgVw.layer.cornerRadius = timeBgVw.frame.size.height/2
        timeBgVw.clipsToBounds = true
        
        dirctnStrtBgVw.layer.cornerRadius = dirctnStrtBgVw.frame.size.height/2
        dirctnStrtBgVw.clipsToBounds = true
    }
    
    @IBAction func waitngBtnTapped(_ sender: Any) {
    }
    
    @IBAction func accptdBtntapped(_ sender: Any) {
    }
    @IBAction func rejctdBtnTapped(_ sender: Any) {
    }
    
    @IBAction func directionBtntapped(_ sender: Any) {
    }
    @IBAction func startBtnTapped(_ sender: Any) {
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
    }
    

}
