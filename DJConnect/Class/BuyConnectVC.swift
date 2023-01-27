 //
 //  BuyConnectVC.swift
 //  DJConnect
 //
 //  Created by mac on 11/05/20.
 //  Copyright © 2020 mac. All rights reserved.
 //
 
 import UIKit
 import AVFoundation
 import Alamofire
 import HCSStarRatingView
 
 class BuyConnectVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblStepNumber: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var vwPaymentNotComplete: UIView!
    @IBOutlet var vwStep2AddAudio: UIView!
    @IBOutlet var vwStep2AddedAudio: UIView!
    @IBOutlet var vwStep3SongStatus: UIView!
    @IBOutlet weak var txfSongName: textFieldProperties!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblbyName: UILabel!
    @IBOutlet weak var lblGenreType: UILabel!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var lblMinimumTime: UILabel!
    @IBOutlet weak var audioSeekbar: UISlider!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var imgMusicUserProfile: imageProperties!
    @IBOutlet weak var btnSongSubmit: UIButton!
    @IBOutlet weak var lblSongDivider: UILabel!
    @IBOutlet weak var btnSongBack: UIButton!
    @IBOutlet weak var lblStep3SongName: UILabel!
    @IBOutlet weak var lblStep3SongBy: UILabel!
    @IBOutlet weak var lblStep3SongGenre: UILabel!
    @IBOutlet weak var btnStep3PlayButton: UIButton!
    @IBOutlet weak var lblStep3MinTime: UILabel!
    @IBOutlet weak var lblStep3MaxTime: UILabel!
    @IBOutlet weak var imgStep3musicUserProfile: imageProperties!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblProjectBy: UILabel!
    @IBOutlet weak var lblEventDayDate: UILabel!
    @IBOutlet weak var lblEventTime: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblProjectCost: UILabel!
    @IBOutlet weak var imgUserProfile: imageProperties!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet var vwRatingStage: UIView!
    @IBOutlet weak var vwRating: HCSStarRatingView!
    @IBOutlet weak var lblStatusAck: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblReasonDetail: UILabel!
    @IBOutlet weak var btnViewConnect: UIButton!
    @IBOutlet weak var lblStatusHeader: UILabel!
    @IBOutlet weak var lblDjNotify: UILabel!
    @IBOutlet weak var sliderStep3: UISlider!
    @IBOutlet weak var btnRateProject: UIButton!
    @IBOutlet weak var lblRatingWordCount: UILabel!
    @IBOutlet weak var txtViewRatingDetail: UITextView!
    
    @IBOutlet weak var cnsVwAddAudioLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsVwAddedAudioLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsVwSongStatusLeading: NSLayoutConstraint!
    @IBOutlet weak var vwTrial: UIView!
    @IBOutlet weak var lblProjTotalPrice: UILabel!
    @IBOutlet weak var lblTranscFee: UILabel!
    @IBOutlet weak var lblTotalAmountProj: UILabel!
    
    @IBOutlet weak var convertChargesLbl: UILabel!
    @IBOutlet weak var setConvertChargesLbl: UILabel!
    
    //localize outlet
    @IBOutlet weak var lblLo_ProjPrice: UILabel!
    @IBOutlet weak var lblLo_TransFee: UILabel!
    @IBOutlet weak var lblLo_TotalPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lblLo_Step2SongSub: UILabel!
    @IBOutlet weak var lblLo_step2SongAck: UILabel!
    @IBOutlet weak var lblLo_StepAddedSub: UILabel!
    @IBOutlet weak var lblLo_Step3SongSub: UILabel!
    @IBOutlet weak var lblLo_Step5Ques: UILabel!
    @IBOutlet weak var lblLo_Step5RateUr: UILabel!
    @IBOutlet weak var lblLo_ExplainurRating: UILabel!
    
    @IBOutlet weak var dateTimeBgVw: UIView!
    @IBOutlet weak var lblLo_Step2songTxtFldBgVw: UIView!
    
    @IBOutlet weak var prgressVwBar: UIProgressView!
    @IBOutlet weak var progressVw: UIView!
    @IBOutlet weak var prgrsPrcntgLbl: UILabel!
    
    var minValue = 0
    var maxValue = 100
    var downloader = Timer()
    
    //MARK: - GLOBAL VARIABLES
    var minuteString = String()
    var secondString = String()
    var songData = Data()
    var audioPlayer: AVAudioPlayer?
    var apiSongData = String()
    var imgUrl = String()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var remainingTime = String()
    var isFromAlert = false
    var projTimezone = String()
    var semaphore = DispatchSemaphore (value: 0)
    var urlTest = String()
    var userDetailDict = [String: String]()
    
    var getAudioStatusStr = String()
    var audioFileStr = String()
    
    var projectCostPrice = String()
    
    //MARK: - UIVIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // vwTrial.isHidden = true
       // self.btnConfirm.isHidden = true
        
        imgMusicUserProfile.layer.cornerRadius = imgMusicUserProfile.frame.size.height/2
        imgMusicUserProfile.clipsToBounds = true
        
        imgStep3musicUserProfile.layer.cornerRadius = imgStep3musicUserProfile.frame.size.height/2
        imgStep3musicUserProfile.clipsToBounds = true
        
        self.btnConfirm.isUserInteractionEnabled = false
        self.btnConfirm.layer.cornerRadius = btnConfirm.frame.size.height/2
        btnConfirm.clipsToBounds = true
        btnSongSubmit.isHidden = false
        btnSongBack.isHidden = false
        progressVw.isHidden = true
        progressVw.backgroundColor = .white
        audioPlayer?.delegate = self
        txtViewRatingDetail.delegate = self
        
        getAudioStatusStr = userDetailDict["audio_status"] ?? ""
        lblProjectName.text = userDetailDict["projectName"]!
        lblProjectBy.text = userDetailDict["projectBy"]!
        lblEventDayDate.text = " \(userDetailDict["EventDayandDate"] ?? "")"
        lblEventTime.text = userDetailDict["eventTime"] ?? ""
        
        let priSTr = userDetailDict["ProjectCost"]!
        var newPrStr = ""
            
//        if priSTr.contains("₹") {
//            newPrStr = priSTr.replacingOccurrences(of: "₹", with: "INR", options: .literal, range: nil)
//        }
//        lblProjectCost.text = newPrStr
       // lblProjectCost.text = priSTr // "COST : ₹50"
        //print("userDetailDict", userDetailDict["ProjectCost"])
        
        let url = URL(string: userDetailDict["imgUrl"] ?? "")
        imgUserProfile.kf.setImage(with: url, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat =  "MMM d, yyyy"
        lblCurrentDate.text = "Today's Date : \(formatter.string(from: date))"
        if UserModel.sharedInstance().userProfileUrl == nil{
            return
        }
        let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
        self.imgMusicUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        lblGenreType.text = UserModel.sharedInstance().genereList ?? "NA"
        lblbyName.text = "by \(UserModel.sharedInstance().uniqueUserName!)"
//        self.audioSeekbar.setThumbImage(UIImage(named: "vertical-deviderline"), for: .normal)
        self.audioSeekbar.setThumbImage(UIImage(named: "songSlider"), for: .normal)
        //purpleThumb
//        self.sliderStep3.setThumbImage(UIImage(named: "vertical-deviderline"), for: .normal)
        self.sliderStep3.setThumbImage(UIImage(named: "songSlider"), for: .normal)
        if UserModel.sharedInstance().appLanguage == "0"{
            btnBack.setImage(UIImage(named: "back_arrow_arabic"), for: .normal)
        }else{
            btnBack.setImage(UIImage(named: "back_arrow_english"), for: .normal)
        }
        dateTimeBgVw.layer.cornerRadius = dateTimeBgVw.frame.size.height/2
        dateTimeBgVw.clipsToBounds = true
        lblLo_Step2songTxtFldBgVw.layer.cornerRadius = 10.0
        lblLo_Step2songTxtFldBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        lblLo_Step2songTxtFldBgVw.layer.borderWidth = 0.5
        lblLo_Step2songTxtFldBgVw.clipsToBounds = true
        vwStep2AddedAudio.isHidden = true
        vwStep2AddAudio.isHidden = true
        vwStep3SongStatus.isHidden = true
        cnsVwSongStatusLeading.constant = self.view.frame.size.width
        cnsVwAddAudioLeading.constant = self.view.frame.size.width
        cnsVwAddedAudioLeading.constant = self.view.frame.size.width
        vwRating.isUserInteractionEnabled = false
        GetBuyProjectDataWebService()
        
        localizeElements()
    }
    
    func showDownload(){
        downloader = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(BuyConnectVC.updater)), userInfo: nil, repeats: true)
        prgressVwBar.setProgress(0, animated: false)
    }
    
    @objc func updater(){
        if minValue != maxValue{
            minValue += 1
            prgrsPrcntgLbl.text = "\(minValue)"
            prgressVwBar.progress = Float(minValue) / Float(maxValue)
        }
        else{
            minValue = 0
            downloader.invalidate()
            self.progressVw.isHidden = true
            btnSongSubmit.isHidden = false
            btnSongBack.isHidden = false
            callAddAudioWebservice()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
//        lblProjectName.text = userDetailDict["projectName"]!
//        lblProjectBy.text = userDetailDict["projectBy"]!
//        lblEventDayDate.text = "Event on:".localize + " \(userDetailDict["EventDayandDate"]!)"
//        lblEventTime.text = userDetailDict["eventTime"]!
//        lblProjectCost.text = userDetailDict["ProjectCost"]!
//
//        let url = URL(string: userDetailDict["imgUrl"]!)
//        imgUserProfile.kf.setImage(with: url, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
//
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat =  "MMM d, yyyy"
//        lblCurrentDate.text = "Today's Date : \(formatter.string(from: date))"
//        if UserModel.sharedInstance().userProfileUrl == nil{
//            return
//        }
//        let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
//        self.imgMusicUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
//        lblGenreType.text = UserModel.sharedInstance().genereList ?? "NA"
//        lblbyName.text = "by \(UserModel.sharedInstance().uniqueUserName!)"
//        self.audioSeekbar.setThumbImage(UIImage(named: "vertical-deviderline"), for: .normal)
//        self.sliderStep3.setThumbImage(UIImage(named: "vertical-deviderline"), for: .normal)
//        if UserModel.sharedInstance().appLanguage == "0"{
//            btnBack.setImage(UIImage(named: "back_arrow_arabic"), for: .normal)
//        }else{
//            btnBack.setImage(UIImage(named: "back_arrow_english"), for: .normal)
//        }
//        vwStep2AddedAudio.isHidden = true
//        vwStep2AddAudio.isHidden = true
//        vwStep3SongStatus.isHidden = true
//        cnsVwSongStatusLeading.constant = self.view.frame.size.width
//        cnsVwAddAudioLeading.constant = self.view.frame.size.width
//        cnsVwAddedAudioLeading.constant = self.view.frame.size.width
//        vwRating.isUserInteractionEnabled = false
//        GetBuyProjectDataWebService()
//
//        localizeElements()
    }
    //MARK: - ACTIONS
    
    @IBAction func btnProcessPayment(_ sender: UIButton) {
        lblStepNumber.text = "STEP 2 OF 5"
        vwPaymentNotComplete.isHidden = true
        vwStep2AddAudio.isHidden = false
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsVwAddAudioLeading.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in
            
        }
    }
    
    @IBAction func btnAddAudio_Action(_ sender: UIButton) {
        if txfSongName.text?.isEmpty == false{
            txfSongName.resignFirstResponder()
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio","public.mp4"], in: .import)
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }else{
            txfSongName.resignFirstResponder()
            self.view.makeToast("Please Enter Song Name")
        }
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) { //ashitesh - artist side
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @IBAction func btnSliderAction(_ sender: UISlider) {
       // if vwStep3SongStatus.isHidden == false{
            audioPlayer?.currentTime = TimeInterval(sliderStep3.value)
        audioPlayer?.currentTime = TimeInterval(audioSeekbar.value)
            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        }else{
//            audioPlayer?.currentTime = TimeInterval(audioSeekbar.value)
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        }
    }
    
    @IBAction func btnSongBackAction(_ sender: UIButton) {
        audioPlayer?.stop()
        btnPlayPause.setImage(UIImage(named:"Button - Play"),for: .normal)
        sliderStep3.value = 0.0
        audioPlayer?.currentTime = TimeInterval(sliderStep3.value)
        GetBuyProjectDataWebService()
        vwStep2AddedAudio.isHidden = true
//        vwStep2AddAudio.isHidden = false
        txfSongName.text?.removeAll()
        lblStepNumber.text = "step2of5".localize
        self.lblProjectCost.text = "COST :" + projectCostPrice
//        vwStep2AddAudio.frame = CGRect(x: -(self.vwMain.frame.size.width + 1) , y: 0, width: self.vwMain.frame.size.width, height: self.vwMain.frame.size.height)
//        UIView.animate(withDuration: 1) {
//            self.vwStep2AddAudio.frame = CGRect(x: 0 , y: 0, width: self.vwMain.frame.size.width, height: self.vwMain.frame.size.height)
//            self.vwMain.addSubview(self.vwStep2AddAudio)
//        }
    }
    
    @IBAction func btnSongSubmitAction(_ sender: UIButton) {
        audioPlayer?.stop()
        lblStepNumber.text = "step2of5".localize
        self.lblProjectCost.text = "COST :" + projectCostPrice
        btnSongSubmit.isUserInteractionEnabled = false
        btnSongBack.isUserInteractionEnabled = false
        //ashitesh
       // callAddAudioWebservice()
        self.progressVw.isHidden = false
        showDownload()
        print("upload")
        
    }
    
    @IBAction func btnBack_Action(_ sender: UIButton) {
        audioPlayer?.stop()
        if isFromAlert == true{
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            sideMenuController()?.setContentViewController(next1!)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnStep3PlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @IBAction func btnViewConnectAction(_ sender: UIButton) {
        globalObjects.shared.buyViewConnect = true
        UserModel.sharedInstance().isPin = false
        if UserModel.sharedInstance().userType == "AR"{
            let homeSB = UIStoryboard(name: "ArtistProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationArtistProfile") as! UINavigationController
            let desireViewController = homeSB.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as! ArtistViewProfileVC
            desireViewController.viewerId = UserModel.sharedInstance().userId!
            desireViewController.selectedButton = "media"
            desiredViewController.setViewControllers([desireViewController], animated: false)
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
    }
    
    @IBAction func btnRateProjectAction(_ sender: UIButton) {
        
        print("call rate project")
        // enable the button first
        if(txtViewRatingDetail.text == ""){
            self.view.makeToast("Please explain your rating.")
        }
        else{
        callRatingWebService()
        }
    }
    
    @IBAction func btnProceedStep1(_ sender: UIButton) {
    //btnConfirmtapped - first
        lblStepNumber.text = "step2of5".localize
        vwTrial.isHidden = true
        print("vwTrialtrue1")
        vwStep2AddAudio.isHidden = false //111
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsVwAddAudioLeading.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in

        }
        
    }
    
    //MARK: - OTHER METHODS
    func preparePlayer(_ songurl: URL?) {
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
            audioPlayer!.delegate = self
            minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            if self.vwStep3SongStatus.isHidden == true{
                lblMinimumTime.text = String(self.audioSeekbar.value)
                lblMaxTime.text = "\(minuteString):\(secondString)"
                self.audioPlayer?.currentTime = Double(self.audioSeekbar.value)
                self.audioSeekbar.maximumValue = Float(Double(self.audioPlayer!.duration))
            }else{
                lblStep3MinTime.text = String(self.sliderStep3.value)
                lblStep3MaxTime.text = "\(minuteString):\(secondString)"
                self.audioPlayer?.currentTime = Double(self.sliderStep3.value)
                self.sliderStep3.maximumValue = Float(Double(self.audioPlayer!.duration))
            }
        } catch {
            print(error)
        }
        
    }
    
    func startTimer() {
        let releaseDateString = "\(remainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.timeZone = NSTimeZone(name: projTimezone) as TimeZone?
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func localizeElements(){
        if(getAudioStatusStr == "2"){
//            self.vwTrial.isHidden = true
//            self.lblStepNumber.text = "STEP 2 OF 5"
//            //self.vwPaymentNotComplete.isHidden = true
//            self.vwStep2AddAudio.isHidden = false
//            self.view.layoutIfNeeded()
//
//            UIView.animate(withDuration: 1.0, animations: {
//                self.cnsVwAddAudioLeading.constant = 0
//                self.view.layoutIfNeeded()
//            }) { (completion) in
//
//            }
            
            lblStepNumber.text = "step2of5".localize
            self.lblProjectCost.text = "COST :" + projectCostPrice
            vwTrial.isHidden = true
            print("vwTrialtrue2")
            vwStep2AddAudio.isHidden = false
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1.0, animations: {
                self.cnsVwAddAudioLeading.constant = 0
                self.view.layoutIfNeeded()
            }) { (completion) in
                
            }
        }
        else{
            lblStepNumber.text = "step1of5".localize
            lblLo_ProjPrice.text = "Project Price: ".localize
            lblLo_TransFee.text = "Transaction Fee:".localize
            lblLo_TotalPrice.text = "Total:".localize
            btnConfirm.setTitle("Confirm".localize, for: .normal)
            lblLo_step2SongAck.text = "buyaddaudioack".localize
            lblLo_Step2SongSub.text = "Song Submission".localize
            lblLo_StepAddedSub.text = "Song Submission".localize
//            btnSongSubmit.setTitle("SUBMIT".localize, for: .normal)
//            btnSongBack.setTitle("BACK".localize, for: .normal)
            btnSongSubmit.setTitle("Submit", for: .normal)
            btnSongBack.setTitle("Back", for: .normal)
            lblLo_Step3SongSub.text = "Song Submission".localize
            lblDjNotify.text = "buyStep3ack".localize
            lblReason.text = "Reason".localize
            btnViewConnect.setTitle("VIEW CONNECT".localize, for: .normal)
            lblLo_Step5Ques.text = "buystep5ack1".localize
            lblLo_Step5RateUr.text = "buystep5ack2".localize
            lblLo_ExplainurRating.text = "buyExplainRating".localize
            btnRateProject.setTitle("btnRateProject".localize, for: .normal)
        }
        
    }
    
    //MARK: - SELECTOR METHODS
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        
        self.lblRemainingTime.text = countdown
    }
    
    @objc func UpdateSeekBar() { //- artist side
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        if self.vwStep3SongStatus.isHidden == true{
            lblMaxTime.text = "\(remMin):\(remSec)"
            lblMinimumTime.text = "\(minCurrent):\(secCurrent)"
            audioSeekbar.value = Float(Double((audioPlayer?.currentTime)!))
        }else{
            lblStep3MaxTime.text = "\(remMin):\(remSec)"
            lblStep3MinTime.text = "\(minCurrent):\(secCurrent)"
            sliderStep3.value = Float(Double((audioPlayer?.currentTime)!))
        }
    }
    //MARK: - WEBSERVICES
    func callAddAudioWebservice(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "projectid":"\(userDetailDict["projectId"]!)",
                "is_offer":"0",
                "offer_price" : "0",
                "audio_name":"\(txfSongName.text!)",
            ]
            
            print("AddAudioWebserviceParam1",parameters)
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addAudioProjectBuyAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            Loader.shared.show()
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    multipartFormData.append(self.songData as Data, withName: "audio_file", fileName: "audio.mp3", mimeType: "audio/mp3")
                }
            }, to: serviceURL) { (result) in
                switch result {
                case .success(let upload,_,_):
//                    upload.uploadProgress(closure: { (progress) in
//                        CommonFunctions.shared.showProgress(progress: CGFloat(progress.fractionCompleted))
//                    })
                    
//                    self.progressVw.isHidden = false
                   // self.showDownload()
                    upload.responseObject(completionHandler: { (response:DataResponse<buyProjectAudioModel>) in
                        switch response.result {
                        case .success(_):
                            Loader.shared.hide()
                            CommonFunctions.shared.hideLoader()
                            let addMediaProfile = response.result.value!
                            if addMediaProfile.success == 1{
                                self.btnSongSubmit.isUserInteractionEnabled = false
                                self.btnSongBack.isUserInteractionEnabled = false
                               // self.view.makeToast(addMediaProfile.message)
                               // self.apiSongData = (addMediaProfile.audioData?.audio_file)!
                                print(addMediaProfile.audioData?.audio_file)
                                self.lblStep3MinTime.text = "00:00"
                                self.lblStep3MaxTime.text = self.minuteString + ":" + self.secondString
                                self.lblStep3SongName.text = addMediaProfile.audioData?.audio_name!
                                self.lblStep3SongBy.text = UserModel.sharedInstance().uniqueUserName!
                                self.lblStep3SongGenre.text = UserModel.sharedInstance().genereList ?? "NA"
                                let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
//                                if musicProfileUrl != nil{
//                                    self.imgStep3musicUserProfile.kf.setImage(with: musicProfileUrl!, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
//                                }
                                self.vwStep2AddedAudio.isHidden = true
                                self.vwStep3SongStatus.isHidden = false
                                self.lblStepNumber.text = "step3of5".localize
                                self.lblProjectCost.text = "COST :" + self.projectCostPrice
                                self.lblStatusAck.isHidden = true
                                self.lblReasonDetail.isHidden = true
                               // self.preparePlayer(URL(string: (addMediaProfile.audioData!.audio_file!)))
                                self.view.layoutIfNeeded()
                                
                                UIView.animate(withDuration: 1.0, animations: {
                                    self.cnsVwSongStatusLeading.constant = 0
                                    self.view.layoutIfNeeded()
                                }) { (completion) in
                                    
                                }
                                
                                //self.progressVw.isHidden = true
                                // ashitesh - change to navigate home screen
                                //self.callProjectStatusWebService()
                                self.view.makeToast("Audio uploaded successfully")
                                
                                var refreshAlert = UIAlertController(title: "Song Submitted Successfully", message: "", preferredStyle: UIAlertController.Style.alert)

                                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                  print("move to artist home")
                                    
//                                    let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
//                                    let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
//                                    self.sideMenuController()?.setContentViewController(next1!)
                                    
                                    let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
                                    let viewController = storyBoard.instantiateViewController(withIdentifier: "NewArtistHomeVC") as! NewArtistHomeVC
                                    self.sideMenuController?.hideLeftView()
                                    self.sideMenuController?.rootViewController?.show(viewController, sender: self)
                                    self.navigationController?.popToViewController(viewController, animated: true)
                                  }))
                                self.present(refreshAlert, animated: true, completion: nil)
//                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//                                    let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
//                                    let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
//                                    self.sideMenuController()?.setContentViewController(next1!)
//                                })
                                
                            }else{
                                self.btnSongSubmit.isUserInteractionEnabled = true
                                self.btnSongBack.isUserInteractionEnabled = true
                                CommonFunctions.shared.hideLoader()
                               // self.view.makeToast(addMediaProfile.message)
                                self.view.makeToast("You don't have enough Connect Cash to buy this project.")
                            }
                        case .failure(let error):
                            Loader.shared.hide()
                            self.btnSongSubmit.isUserInteractionEnabled = true
                            self.btnSongBack.isUserInteractionEnabled = true
                            CommonFunctions.shared.hideLoader()
                            debugPrint(error)
                        }
                    })
                case .failure(let error):
                    Loader.shared.hide()
                    self.btnSongSubmit.isUserInteractionEnabled = true
                    self.btnSongBack.isUserInteractionEnabled = true
                    CommonFunctions.shared.hideLoader()
                    print(error)
                    break
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callProjectStatusWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getBuyProjectStatus)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(userDetailDict["projectId"]!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyProjectStatusModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStatusModel = response.result.value!
                    if buyStatusModel.success == 1{
                        if buyStatusModel.responseData!.status! == 0{
                            if buyStatusModel.responseData!.remaining_time!.contains("00:00:00"){
                                self.lblStatusHeader.text = "DJ Notification".localize
                                self.lblRemainingTime.textColor = .red
                                self.lblReasonDetail.isHidden = true
                                self.lblRemainingTime.text = "TIME EXPIRED".localize
                                self.lblStatusAck.text = "The time for this project has expired. Your payment has been refunded.".localize
                            }else{
                                self.lblStatusHeader.text = "DJ Notification".localize
                                self.lblStatusAck.isHidden = true
                                self.lblReasonDetail.isHidden = true
                                self.lblReason.isHidden = true
                                self.remainingTime = buyStatusModel.responseData!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.projTimezone = buyStatusModel.responseData!.project_timezone!
                                print(self.remainingTime)
                                self.startTimer()
                            }
                        }
                        if buyStatusModel.responseData!.status! == 1{
                            self.lblStatusHeader.text = "DJ Response".localize
                            self.lblReason.isHidden = true
                            self.lblRemainingTime.textColor = .green
                            self.lblRemainingTime.text = "CONNECT ACCEPTED".localize
                            self.lblStatusAck.text = "The DJ accepted your connect for their project. Wait for step 4 to verify your song was played.".localize
                        }
                        if buyStatusModel.responseData!.status! == 2{
                            self.lblReason.isHidden = false
                            self.lblStatusHeader.text = "DJ Response".localize
                            self.lblRemainingTime.textColor = .red
                            self.lblStatusAck.text = "Your connect was not accepted.".localize
                            self.lblRemainingTime.text = "NOT ACCEPTED".localize
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(buyStatusModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please Check your Internet Connection")
        }
    }
    
    // artist flow
    func GetBuyProjectDataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getStepsProjectAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(userDetailDict["projectId"]!)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetBuyProjStepsModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStepModel = response.result.value!
                    if buyStepModel.success == 1{
                        if buyStepModel.step2 == "1"{
                            self.vwTrial.isHidden = true
                            self.cnsVwSongStatusLeading.constant = 0
                            self.vwStep3SongStatus.isHidden = false
                            self.lblStepNumber.text = "step3of5".localize
                            self.lblProjectCost.text = "COST :" + self.projectCostPrice
                            self.lblStep3SongBy.text = "By ".localize + "\(buyStepModel.step3!.artist_name!)"
                            self.lblStep3SongName.text = buyStepModel.step3!.artist_applied_audio_name!
                            self.lblStep3SongGenre.text = buyStepModel.step3!.artist_genre!
                            let musicProfileUrl = URL(string : buyStepModel.step3!.artist_photo!)
                            if musicProfileUrl != nil{
                                self.imgStep3musicUserProfile.kf.setImage(with: musicProfileUrl!, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                            
                            if let reason = buyStepModel.step3!.reason{
                                self.lblReason.isHidden = false
                                self.lblReasonDetail.text = reason
                            }
                            if buyStepModel.step3!.audio_file != "" && buyStepModel.is_completed! != 1{
                                //self.navigationController?.popViewController(animated: true) //
                            }
                            //self.audioFileStr = buyStepModel.step3!.audio_file ?? ""
                            self.preparePlayer(URL(string: buyStepModel.step3!.audio_file!))
                            self.callProjectStatusWebService()
                            if buyStepModel.is_completed! == 1{
                                self.lblStepNumber.text = "step4of5".localize
                                self.lblStatusHeader.text = "Project Complete".localize
                                self.lblDjNotify.text = "buyStep3ackDone".localize
                                self.btnViewConnect.isHidden = false
                                self.lblRemainingTime.isHidden = true
                                self.lblStatusAck.isHidden = true
                                self.lblReason.isHidden = true
                                self.lblReasonDetail.isHidden = true
                            }
                        }else{
                            if(self.getAudioStatusStr == "2"){
                                self.lblStepNumber.text = "step2of5".localize
                                self.lblProjectCost.text = "COST :" + self.projectCostPrice
                                self.vwTrial.isHidden = true
                                self.vwStep2AddAudio.isHidden = false
                                self.view.layoutIfNeeded()
                                
                                UIView.animate(withDuration: 1.0, animations: {
                                    self.cnsVwAddAudioLeading.constant = 0
                                    self.view.layoutIfNeeded()
                                }) { (completion) in
                                    
                                }
                            }
                            else{
                                
                               // comnted due to - show screen from step2
                            self.vwTrial.isHidden = false
                                print("vwTrialFalse1")
                            self.callStep1DataWebService()
                            self.vwStep3SongStatus.isHidden = true
                                
//                                self.lblStepNumber.text = "step2of5".localize
//                                self.lblProjectCost.text = "COST :" + self.projectCostPrice
//                                self.callStep1DataWebService()
//                                self.vwTrial.isHidden = true
//                                self.vwStep2AddAudio.isHidden = false
//                                self.vwStep3SongStatus.isHidden = true
//                                self.view.layoutIfNeeded()
//
//                                UIView.animate(withDuration: 1.0, animations: {
//                                    self.cnsVwAddAudioLeading.constant = 0
//                                    self.view.layoutIfNeeded()
//                                }) { (completion) in
//
//                                }
                                
                            }
                            //
                        }
                        //ashitesh
                        //if buyStepModel.step5!.status == "1"{
                        if buyStepModel.step5!.review != ""{
                            self.lblStepNumber.text = "step5of5".localize
                            self.vwRatingStage.isHidden = false
                            self.txtViewRatingDetail.text = buyStepModel.step5!.review!
                            let rate = buyStepModel.step5!.rate_value!
                            if let n = NumberFormatter().number(from: rate) {
                                let f = CGFloat(truncating: n)
                                self.vwRating.value = f
                            }
                            self.txtViewRatingDetail.isUserInteractionEnabled = false
                            self.vwRating.isUserInteractionEnabled = false
                            //self.btnRateProject.isEnabled = false
                            self.btnRateProject.isHidden = true
                        }
                        else{
                        if buyStepModel.step3!.is_video_verify == 1{
                            self.lblStepNumber.text = "step5of5".localize
                            self.vwRatingStage.isHidden = false
                            self.vwRating.isUserInteractionEnabled = true
                            self.btnRateProject.isEnabled = true
                        }
                        if self.userDetailDict["isBuyOn"] ?? "" == "0"{
                            if self.isFromAlert == true{
                                self.vwTrial.isHidden = true
                            }else{
                                if buyStepModel.is_completed! == 1{
                                    if buyStepModel.step3!.status == 2{
                                        self.vwTrial.isHidden = true
                                        print("vwTrialtrue3")
                                        self.lblReason.isHidden = false
                                        self.btnViewConnect.isHidden = true
                                        self.lblStatusHeader.text = "DJ Response".localize
                                        self.lblRemainingTime.textColor = .red
                                        self.lblStatusAck.text = "Your connect was not accepted.".localize
                                        self.lblRemainingTime.text = "NOT ACCEPTED".localize
                                        self.lblRemainingTime.isHidden = false
                                        self.lblStatusAck.isHidden = false
                                        self.lblReason.isHidden = false
                                        self.lblReasonDetail.isHidden = false
                                    }
                                }else{
                                    if(self.getAudioStatusStr == "2"){
                                        self.lblStepNumber.text = "step2of5".localize
                                        self.lblProjectCost.text = "COST :" + self.projectCostPrice
                                        self.vwTrial.isHidden = true
                                        print("vwTrialtrue4")
                                        self.vwStep2AddAudio.isHidden = false
                                        self.view.layoutIfNeeded()
                                        
                                        UIView.animate(withDuration: 1.0, animations: {
                                            self.cnsVwAddAudioLeading.constant = 0
                                            self.view.layoutIfNeeded()
                                        }) { (completion) in
                                            
                                        }
                                    }
                                    else{
                                        
                                        //comnted due to sho screen from step2
                                    self.vwTrial.isHidden = false
                                        print("vwTrialFalse2")
                                    self.callStep1DataWebService()
                                    self.vwStep3SongStatus.isHidden = true
                                        
//                                        self.lblStepNumber.text = "step2of5".localize
//                                        self.lblProjectCost.text = "COST :" + self.projectCostPrice
//                                        self.callStep1DataWebService()
//                                        self.vwTrial.isHidden = true
//                                        print("vwTrialtrue4")
//                                        self.vwStep2AddAudio.isHidden = false
//                                        self.vwStep3SongStatus.isHidden = true
//                                        self.view.layoutIfNeeded()
//
//                                        UIView.animate(withDuration: 1.0, animations: {
//                                            self.cnsVwAddAudioLeading.constant = 0
//                                            self.view.layoutIfNeeded()
//                                        }) { (completion) in
//
//                                        }
                                    }
                                }
                            }
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
            self.view.makeToast("Please Check your Internet Connection")
        }
    }
    
    func callRatingWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "rating_by":"\(UserModel.sharedInstance().userId!)",
                "rating_to":"\(userDetailDict["projectId"]!)",
                "rating_value":"\(vwRating.value)",
                "review":"\(txtViewRatingDetail.text!)",
                "token":"\(UserModel.sharedInstance().token!)",               
            ]
            
            print("rating parameters", parameters)
            print("rating URL", Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addProjectRating)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil))
            
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addProjectRating)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let ratingModel = response.result.value!
                    if ratingModel.success == 1{
                        self.view.makeToast(ratingModel.message)
                        //ashitesh
                        //self.navigationController?.popViewController(animated: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
                            let next1 = homeSB.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
                            self.sideMenuController()?.setContentViewController(next1!)
                        })
                        
                       // self.view.makeToast("You have rated this project successfully")
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(ratingModel.message)
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
    
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id=\(userDetailDict["projectId"]!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(userDetailDict["projUserId"]!)&type=project"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let step1Model = response.result.value!
                    if step1Model.success == 1{
                        var projPr = ""
                        var projTrPr = ""
                        if(self.vwStep2AddAudio.isHidden == false){
                            self.vwTrial.isHidden = true
                        }else{
                        self.vwTrial.isHidden = false
                        }
                        //self.vwTrial.isHidden = true
                        print("vwTrialFalse3")
                        if let price = step1Model.result!.project_price{
                            self.lblProjTotalPrice.text =  "  " + self.userDetailDict["TrialCurrency"]! + price
                            projPr =  self.userDetailDict["TrialCurrency"]! + price
                        }
                        if let transPrice = step1Model.result!.transaction_fees{
                            self.lblTranscFee.text =  "  " + self.userDetailDict["TrialCurrency"]! + transPrice
                            projTrPr = self.userDetailDict["TrialCurrency"]! + transPrice
                        }
                        if let currencyCharges = step1Model.result!.currency_convert_charge{
                            if(currencyCharges == "0"){
                                self.setConvertChargesLbl.text = ""
                                self.convertChargesLbl.text = ""
                                self.convertChargesLbl.isHidden = true
                                self.setConvertChargesLbl.isHidden = true
                            }
                            else{
                                self.convertChargesLbl.isHidden = false
                                self.setConvertChargesLbl.isHidden = false
                                self.setConvertChargesLbl.text =  "  " + self.userDetailDict["TrialCurrency"]! + currencyCharges
                                self.convertChargesLbl.text = "Currency Convert"
                            }
                            
                        }
                        
                        if let totAmount = step1Model.result!.total_price{
                            self.lblTotalAmountProj.text =  "  " + self.userDetailDict["TrialCurrency"]! + totAmount
                        }
                        
                        self.lblProjectCost.text = "COST :" + self.lblTotalAmountProj.text! // "COST : ₹50"
                        self.projectCostPrice = self.lblTotalAmountProj.text!
                        self.btnConfirm.isUserInteractionEnabled = true
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(step1Model.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
 }
 
 //MARK: - EXTENSIONS
 extension BuyConnectVC : UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let data = try! Data(contentsOf: url)
        print(data.count)
        if data.count > 26214400{
            self.view.makeToast("You are not allowed to upload a file of size more than 25 MB.")
        }else{
            let mimeType = url.pathExtension
            sliderStep3.value = 0.0
            audioSeekbar.value = 0.0
            audioPlayer?.currentTime = TimeInterval(sliderStep3.value)
            audioPlayer?.currentTime = TimeInterval(audioSeekbar.value)
            vwStep2AddAudio.isHidden = true
            vwStep2AddedAudio.isHidden = false
            vwStep2AddAudio.isHidden = true
            lblStepNumber.text = "step2of5".localize
            self.lblProjectCost.text = "COST :" + projectCostPrice
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1.0, animations: {
                self.cnsVwAddedAudioLeading.constant = 0
                self.view.layoutIfNeeded()
            }) { (completion) in
                
            }
            songData = try! Data(contentsOf: url)
            urlTest = "\(url)"
            preparePlayer(url)
            lblSongName.text = txfSongName.text
            lblbyName.text = "By ".localize + "\(UserModel.sharedInstance().uniqueUserName!)"
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
    
 }
 extension BuyConnectVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlayPause.setImage(UIImage(named:"Button - Play"),for: .normal)
        btnStep3PlayButton.setImage(UIImage(named:"Button - Play"),for: .normal)
    }
 }
 extension BuyConnectVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let len = textView.text.count
        lblRatingWordCount.text = "\(len)/300"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        //txtViewRatingDetail
        if textView == txtViewRatingDetail{
        if text.count == 0 {
            if textView.text.count != 0 {
               // self.btnRateProject.isEnabled = true
                return true
            }
        } else if textView.text.count > 299 {
           // self.btnRateProject.isEnabled = true
            return false
        }
        return true
        }
        else{
            return false
        }
    }
    
 }
