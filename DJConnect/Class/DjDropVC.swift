//
//  DjDropVC.swift
//  DJConnect
//
//  Created by mac on 23/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import AVFoundation
import UITextView_Placeholder
import AVKit

class DjDropVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var vwAddAudio: UIView!
    @IBOutlet weak var vwUploadedAudio: UIView!
    @IBOutlet weak var vwSubmitStep3: UIView!
    @IBOutlet weak var vwTvDrop: viewProperties!
    @IBOutlet weak var vwStep2: UIView!
    @IBOutlet weak var tvDJDrop: UITextView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var tfDJDRopTitle: textFieldProperties!
    @IBOutlet weak var vwStep1: UIView!
    @IBOutlet weak var vwDonePayment: UIView!
    @IBOutlet weak var vwSumbit: UIView!
    @IBOutlet weak var lblTitleDisplay: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblDjDropName: UILabel!
    @IBOutlet weak var lblDjDropBy: UILabel!
    @IBOutlet weak var lblDJGenre: UILabel!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var lblDjNotify: UILabel!
    @IBOutlet weak var lblDjClick: UILabel!
    @IBOutlet weak var lblComplete: UILabel!
    @IBOutlet weak var lblFinal: UILabel!
    @IBOutlet weak var audioSeekBar: UISlider!
    
    @IBOutlet weak var lblWordCount: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var btnAddAudio: UIButton!
    @IBOutlet weak var btnBackAudio: UIButton!
    
    @IBOutlet weak var btnSubmitAudio: UIButton!
    @IBOutlet weak var imgUserProfile: imageProperties!
    @IBOutlet weak var imgMusicUserProfile: UIImageView!
    @IBOutlet weak var lblConnectCost: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblByName: UILabel!
    @IBOutlet weak var lblStep1of4: UILabel!
    @IBOutlet weak var vwStep3: UIView!
    @IBOutlet weak var vwStep4: UIView!
    @IBOutlet weak var lblStep3DropDescri: UILabel!
    @IBOutlet weak var lblStep3Title: UILabel!
    @IBOutlet weak var btnStep3Play: UIButton!
    
    @IBOutlet weak var lblStep4Title: UILabel!
    @IBOutlet weak var lblStep4TitleDescri: UILabel!
    @IBOutlet weak var cnsStep2Leading: NSLayoutConstraint!
    @IBOutlet weak var cnsStep3Leading: NSLayoutConstraint!
    @IBOutlet weak var cnsStep4Leading: NSLayoutConstraint!
    
    @IBOutlet weak var lblProjectPrice: UILabel!
    @IBOutlet weak var lblTransacFee: UILabel!
    @IBOutlet weak var lblTotalProject: UILabel!
    
    //localize outlet
    @IBOutlet weak var lblLo_ProjPrice: UILabel!
    @IBOutlet weak var lblLo_TransFee: UILabel!
    @IBOutlet weak var lblLo_TotalPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnStep2Back: UIButton!
    @IBOutlet weak var btnStep2Submit: UIButton!
    @IBOutlet weak var lblLo_UploadDjDrop: UILabel!
    @IBOutlet weak var txfAddVaryPrice: UITextField!
    @IBOutlet weak var cnstxfVaryPriceTop: NSLayoutConstraint!
    @IBOutlet weak var lblEnterPrice: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var songData = NSData()
    var projectUserId = String()
    var audioPlayer: AVAudioPlayer?
    var apiSongData = String()
    var isPlaying = false
    var minuteString = String()
    var secondString = String()
    var fileName = String()
    var projBy = String()
    var connectCost = String()
    var userProfile = UIImage()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var remainingTime = String()
    var artist_id = String()
    var senderId = String()
    var receiverId = String()
    var isDropAlert = false
    var currentCurrency = String()
    var isFromNotification = false
    var dropType = String()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let placeholderString = "Enter the details you would like the DJ to say for your DJ drop."
        tvDJDrop.placeholder = placeholderString
        tfDJDRopTitle.isUserInteractionEnabled = false
        tvDJDrop.isUserInteractionEnabled = false
        
        let formatterr = NumberFormatter()
        formatterr.groupingSeparator = "," // or possibly "." / ","
        formatterr.numberStyle = .decimal
        
        if UserModel.sharedInstance().userType == "DJ"{
            formatterr.string(from: Int(connectCost)! as NSNumber)
            let string5 = formatterr.string(from: Int(connectCost)! as NSNumber)
            lblConnectCost.text = "COST :".localize + " \(currentCurrency)" + string5!
//            lblConnectCost.text = "COST :".localize + " \(currentCurrency)\(connectCost)"
            
            lblByName.text = "By ".localize + "\(projBy)"
            imgUserProfile.image = userProfile
        }else{
            formatterr.string(from: Int(connectCost)! as NSNumber)
            let string5 = formatterr.string(from: Int(connectCost)! as NSNumber)
            lblConnectCost.text = "COST :".localize + " \(currentCurrency)" + string5!
//            lblConnectCost.text = "COST :".localize + " \(currentCurrency)\(connectCost)"
            
            lblByName.text = "By ".localize + "\(projBy)"
            imgUserProfile.image = userProfile
        }
        callCurrencyListWebService()
        // for varied flow.. use below code
        if dropType == "0"{
            lblEnterPrice.isHidden = true
            txfAddVaryPrice.isHidden = true
        }else{
            lblEnterPrice.isHidden = false
            txfAddVaryPrice.isHidden = false
            
            lblEnterPrice.text = "Enter Price:".localize + " \(currentCurrency) ________ "
        }
        // for fixed flow.. hide price label
        lblEnterPrice.isHidden = true
        txfAddVaryPrice.isHidden = true
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat =  "MMM d, yyyy"
        lblCurrentDate.text = "DATE : \(formatter.string(from: date))"
        
        let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
        self.imgMusicUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        lblDJGenre.text = UserModel.sharedInstance().genereList!
        if UserModel.sharedInstance().userType == "DJ"{
            GetArtistDropDataWebService()
        }else{
            GetDjDropDataWebService()
        }
        
        vwStep2.isHidden = true
        vwStep3.isHidden = true
        vwStep4.isHidden = true
        cnsStep2Leading.constant = self.view.frame.size.width
        cnsStep3Leading.constant = self.view.frame.size.width
        cnsStep4Leading.constant = self.view.frame.size.width
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.audioSeekBar.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        localizeElements()
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
            lblMinTime.text = String(self.audioSeekBar.value)
            lblMaxTime.text = "\(minuteString):\(secondString)"
            self.audioPlayer?.currentTime = Double(self.audioSeekBar.value)
            self.audioSeekBar.maximumValue = Float(Double(self.audioPlayer!.duration))
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }
    
    func localizeElements(){
        lblDjNotify.text = "dropStep3Detail1".localize
        lblDjClick.text = "dropStep3Detail2".localize
        lblFinal.text = "dropFinal".localize
        lblStep1of4.text = "dropstep1of4".localize
        lblStep1of4.text = "dropstep1of4".localize
        lblLo_ProjPrice.text = "Project Price: ".localize
        lblLo_TransFee.text = "Transaction Fee:".localize
        lblLo_TotalPrice.text = "Total:".localize
        btnConfirm.setTitle("Confirm".localize, for: .normal)
        btnStep2Submit.setTitle("SUBMIT".localize, for: .normal)
        btnStep2Back.setTitle("BACK".localize, for: .normal)
        btnNext.setTitle("Next".localize, for: .normal)
        lblLo_UploadDjDrop.text = "Upload DJ Drop".localize
        btnSubmitAudio.setTitle("SUBMIT".localize, for: .normal)
        btnBackAudio.setTitle("BACK".localize, for: .normal)
        lblComplete.text = "COMPLETE".localize
    }
    
    func startTimerIntial() {
        let releaseDateString = "\(remainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.timeZone = NSTimeZone(name: "Asia/Kolkata") as TimeZone?
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func startTimer() {
        let releaseDateString = "\(remainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.timeZone = NSTimeZone(name: "Asia/Kolkata") as TimeZone?
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
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
    
    //MARK: - SELECTOR METHODS
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        lblMaxTime.text = "\(remMin):\(remSec)"
        lblMinTime.text = "\(minCurrent):\(secCurrent)"
        audioSeekBar.value = Float(Double((audioPlayer?.currentTime)!))
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        
        self.lblRemainingTime.text = countdown
    }
    //MARK: - ACTIONS
    @IBAction func btnSecondStepNext_Action(_ sender: UIButton) {
        
    }
    
    @IBAction func btnBackStep2_Action(_ sender: UIButton) {
        tfDJDRopTitle.text?.removeAll()
        tvDJDrop.text.removeAll()
        lblWordCount.text = "0/500"
        vwSumbit.isHidden = true
    }
    @IBAction func btnSubmitStep2_Action(_ sender: Any) {
        lblEnterPrice.text = "Enter Price:".localize + " \(currentCurrency) "
        cnstxfVaryPriceTop.constant = -2
        txfAddVaryPrice.isEnabled = false
        calladdDjDropWebService()
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        if isDropAlert == true{
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            sideMenuController()?.setContentViewController(next1!)
        }else if isFromNotification == true{
            backNotificationView()
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnNext_Action(_ sender: UIButton) {
        vwTvDrop.isHidden = true
        tfDJDRopTitle.isHidden = true
        lblDiscription.isHidden = false
        vwSumbit.isHidden = false
        lblTitleDisplay.isHidden = false
        lblDiscription.text = tvDJDrop.text!
        lblTitleDisplay.text = tfDJDRopTitle.text!
        vwStep2.layoutIfNeeded()
    }
    
    @IBAction func btnAddAudio_Action(_ sender: UIButton) {
        //call add audio api
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio"], in: .import)
        print("MP3, AAC, M4A, WAV, AIFF, M4R")
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    @IBAction func btnBackStep3_Action(_ sender: UIButton) {
        vwAddAudio.isHidden = false
        vwSubmitStep3.isHidden = true
        vwUploadedAudio.isHidden = true
        lblComplete.textColor = .black
        lblFinal.textColor = .black
        
    }
    @IBAction func btnSubmitStep3_Action(_ sender: UIButton) {
        vwSubmitStep3.isHidden = true
        vwAddAudio.isHidden = true
        vwUploadedAudio.isHidden = false
        calladdDjDropAudioWebService()
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @IBAction func btnAudioSeekBarAction(_ sender: Any) {
        audioPlayer?.currentTime = TimeInterval(audioSeekBar.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    @IBAction func btnDropCompleteAction(_ sender: UIButton) {
        globalObjects.shared.dropCompleteConnect = true
        UserModel.sharedInstance().isPin = false
        if UserModel.sharedInstance().userType == "DJ"{
            let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationProfile") as! UINavigationController
            let desireViewController = homeSB.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
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
        }else{
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
    
    @IBAction func btnConfirmAction(_ sender: UIButton) {
        lblStep1of4.text = "dropstep2of4".localize
        vwStep1.isHidden = true
        vwStep2.isHidden = false
        tfDJDRopTitle.isUserInteractionEnabled = true
        tvDJDrop.isUserInteractionEnabled = true
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsStep2Leading.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in
            
        }
    }
    
    
    //MARK: - WEBSERVICES
    func calladdDjDropWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "dj_id":"\(projectUserId)",
                "dj_drop_title":"\(tfDJDRopTitle.text!)",
                "dj_drop_des":"\(tvDJDrop.text!)",
                "is_offer":"0",
                "offer_cost":"\(txfAddVaryPrice.text!)",
                "cost":"\(connectCost)"
            ]
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addDjdropAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<AddDjDropModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let djStatusModel = response.result.value!
                    if djStatusModel.success == 1{
                        self.vwSumbit.isHidden = true
                        self.tfDJDRopTitle.resignFirstResponder()
                        self.tvDJDrop.resignFirstResponder()
                        self.vwStep2.isHidden = true
                        self.vwStep3.isHidden = false
                        self.vwAddAudio.isHidden = true
                        self.lblStep3Title.text = self.tfDJDRopTitle.text
                        self.lblStep3DropDescri.text = self.tvDJDrop.text
                        self.lblDjClick.isHidden = true
                        self.lblStep1of4.text = "dropstep3of4".localize
                        self.view.layoutIfNeeded()
                        
                        UIView.animate(withDuration: 1.0, animations: {
                            self.cnsStep3Leading.constant = 0
                            self.view.layoutIfNeeded()
                        }) { (completion) in
                            
                        }
                        self.remainingTime = djStatusModel.djDropData!.closing_time!
                        self.startTimerIntial()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(djStatusModel.message)
                        self.vwSumbit.isHidden = false
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
    
    func calladdDjDropAudioWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "dj_id":"\(artist_id)",
                "audio_name":"\(lblStep3Title.text! + " Drop ")",
            ]
            
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addAudioDjDropAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    multipartFormData.append(self.songData as Data, withName: "audio_file", fileName: "audio.mp3", mimeType: "audio/mp3")
                }
            }, to: serviceURL) { (result) in
                switch result {
                case .success(let upload,_,_):
                    
                    upload.uploadProgress(closure: { (progress) in
                        CommonFunctions.shared.showProgress(progress: CGFloat(progress.fractionCompleted))
                    })
                    upload.responseString { response in
                        CommonFunctions.shared.hideLoader()
                        if response.result.isSuccess == true{
                            if let json = response.result.value as? [String:Any] {
                                if json["success"]! as! String == "1"{
                                    CommonFunctions.shared.hideLoader()
                                    globalObjects.shared.dropAudioAdded = true
                                    self.apiSongData = json["audio"] as! String
                                    self.lblMinTime.text = "00:00"
                                    self.lblMaxTime.text = self.minuteString + ":" + self.secondString
                                    self.lblDjDropName.text = "\(self.lblStep3Title.text!) Drop"
                                    self.lblDjDropBy.text = "Drop by \(UserModel.sharedInstance().uniqueUserName!)"
                                    let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
                                    self.imgMusicUserProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                                    self.vwSubmitStep3.isHidden = true
                                    self.showAlertView("your audio has been uploaded successfully.","Success!!")
                                    self.view.makeToast("Audio Added Successfully")
                                }else{
                                    CommonFunctions.shared.hideLoader()
                                    self.vwSubmitStep3.isHidden = false
                                    self.view.makeToast("Audio submission failed.")
                                    print("ERROR")
                                }
                            }
                        }
                    }
                case .failure(let error):
                    CommonFunctions.shared.hideLoader()
                    print(error)
                    break
                }
            }
            
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    // artist flow
    func GetDjDropDataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getDjDropStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(projectUserId)&artist_id=\(UserModel.sharedInstance().userId!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjDropStepModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let dropStepModel = response.result.value!
                    if dropStepModel.success == 1{
                        let formatterr = NumberFormatter()
                        formatterr.groupingSeparator = "," // or possibly "." / ","
                        formatterr.numberStyle = .decimal
                        
                        if dropStepModel.step2!.status! == "1"{
                            self.vwStep3.isHidden = false
                            self.cnsStep3Leading.constant = 0
                            self.vwStep1.isHidden = true
                            self.lblStep1of4.text = "dropstep3of4".localize
                            self.lblStep3Title.text = dropStepModel.step2!.dj_drop_title!
                            self.lblStep3DropDescri.text = dropStepModel.step2!.dj_drop_des!
                            self.lblByName.text = "By ".localize + "\(dropStepModel.step2!.dj_name!)"
                            formatterr.string(from: Int(dropStepModel.step2!.dj_drop_cost!)! as NSNumber)
                            let string5 = formatterr.string(from: Int(dropStepModel.step2!.dj_drop_cost!)! as NSNumber)
                            self.lblConnectCost.text = "COST :".localize + " \(self.currentCurrency)" + string5!
                           // self.lblConnectCost.text = "COST :".localize + " \(self.currentCurrency)\(dropStepModel.step2!.dj_drop_cost!)"
                            
                            self.lblDjClick.isHidden = true
                            self.vwAddAudio.isHidden = true
                            self.vwUploadedAudio.isHidden = true
                            if let ImageUrl = dropStepModel.step2!.dj_pic{
                                let profileImageUrl = URL(string: ImageUrl)
                                self.imgUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                            if dropStepModel.step2!.remaining_time!.contains("00:00:00") {
                                self.vwStep1.isHidden = false
                                self.txfAddVaryPrice.text?.removeAll()
                                self.vwStep3.isHidden = true
                                formatterr.string(from: Int(self.connectCost)! as NSNumber)
                                let string6 = formatterr.string(from: Int(self.connectCost)! as NSNumber)
                                self.lblConnectCost.text = "COST :".localize + " \(self.currentCurrency)" + string6!
//                                self.lblConnectCost.text = "COST :".localize + " \(self.currentCurrency)\(self.connectCost)"
                                
                                self.callStep1DataWebService()
                            }else{
                                self.remainingTime = dropStepModel.step2!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }
                            if dropStepModel.step3!.status! == "1"{
                                self.vwStep3.isHidden = true
                                self.vwStep4.isHidden = false
                                self.cnsStep4Leading.constant = 0
                                self.vwStep1.isHidden = true
                                self.lblStep1of4.text = "dropstep4of4".localize
                                self.lblStep4Title.text = dropStepModel.step2!.dj_drop_title!
                                self.lblStep4TitleDescri.text = dropStepModel.step2!.dj_drop_des!
                            }
                        }else{
                            self.vwStep1.isHidden = false
                            self.callStep1DataWebService()
                        }
                        
                    }else{
                        self.vwStep1.isHidden = false
                        self.callStep1DataWebService()
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
    
    // dj flow
    func GetArtistDropDataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getDjDropStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(UserModel.sharedInstance().userId!)&artist_id=\(artist_id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjDropStepModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let dropStepModel = response.result.value!
                    if dropStepModel.success == 1{
                        if dropStepModel.step2!.status! == "1"{
                            self.vwStep3.isHidden = false
                            self.cnsStep3Leading.constant = 0
                            self.vwStep1.isHidden = true
                            self.lblStep1of4.text = "dropstep3of4".localize
                            self.lblStep3Title.text = dropStepModel.step2!.dj_drop_title!
                            self.lblStep3DropDescri.text = dropStepModel.step2!.dj_drop_des!
                            self.lblByName.text = "By ".localize + "\(dropStepModel.step2!.dj_name!)"
                            
                            let formatterr = NumberFormatter()
                            formatterr.groupingSeparator = "," // or possibly "." / ","
                            formatterr.numberStyle = .decimal
                            formatterr.string(from: Int(dropStepModel.step2!.dj_drop_cost!)! as NSNumber)
                            let string6 = formatterr.string(from: Int(dropStepModel.step2!.dj_drop_cost!)! as NSNumber)
                            self.lblConnectCost.text = "COST :".localize + " \(self.currentCurrency)" + string6!
                            //self.lblConnectCost.text = "COST :".localize + " \(self.currentCurrency)\(dropStepModel.step2!.dj_drop_cost!)"
                            
                            self.lblDjClick.isHidden = true
                            self.vwAddAudio.isHidden = false
                            self.vwUploadedAudio.isHidden = true
                            if let ImageUrl = dropStepModel.step2!.dj_pic{
                                let profileImageUrl = URL(string: ImageUrl)
                                self.imgUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                            if let cost = dropStepModel.step2!.dj_drop_cost{
                                self.lblConnectCost.text = "COST : \(UserModel.sharedInstance().userCurrency!)\(cost)"
                            }
                            if let name =  dropStepModel.step2!.dj_name{
                                self.lblByName.text = "By \(name)"
                            }
                            if dropStepModel.step2!.remaining_time!.contains("00:00:00") {
                                self.lblRemainingTime.text = "TIME EXPIRED".localize
                            }else{
                                self.remainingTime = dropStepModel.step2!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }
                        }
                        
                        if dropStepModel.step3!.status! == "1"{
                            self.vwUploadedAudio.isHidden = false
                            self.vwAddAudio.isHidden = true
                            self.lblDjDropName.text = "\(self.lblStep3Title.text!) Drop"
                            self.lblDjDropBy.text = "Drop by \(UserModel.sharedInstance().uniqueUserName!)"
                            let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
                            self.imgMusicUserProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            if let url = dropStepModel.step3!.audio_file{
                                self.preparePlayer(URL(string: url))
                            }
                        }
                    }else{
                        self.vwStep1.isHidden = false
                        self.callStep1DataWebService()
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
    
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id=&dj_id=\(projectUserId)&token=\(UserModel.sharedInstance().token!)&type=djdrop"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let step1Model = response.result.value!
                    if step1Model.success == 1{
                        self.vwStep1.isHidden = false
                        let formatterr = NumberFormatter()
                        formatterr.groupingSeparator = "," // or possibly "." / ","
                        formatterr.numberStyle = .decimal
                        
                        if let price = step1Model.result!.project_price{
                            formatterr.string(from: Int(price)! as NSNumber)
                            let string6 = formatterr.string(from: Int(price)! as NSNumber)
                            self.lblProjectPrice.text =  "  " + self.currentCurrency + string6!
                        }
                        if let transPrice = step1Model.result!.transaction_fees{
                            formatterr.string(from: Int(transPrice)! as NSNumber)
                            let string6 = formatterr.string(from: Int(transPrice)! as NSNumber)
                            self.lblTransacFee.text =  "  " + self.currentCurrency + string6!
                        }
                        if let totAmount = step1Model.result!.total_price{
                            formatterr.string(from: Int(totAmount)! as NSNumber)
                            let string6 = formatterr.string(from: Int(totAmount)! as NSNumber)
                            self.lblTotalProject.text =  "  " + self.currentCurrency + string6!
                        }
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
    
    func callCurrencyListWebService(){
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
        }
    }
}
//MARK: - EXTENSIONS
extension DjDropVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 0{
            vwSumbit.isHidden = true
        }else{
            vwSumbit.isHidden = false
        }
        let len = textView.text.count
        lblWordCount.text = "\(len)/500"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.count == 0 {
            if textView.text.count != 0 {
                return true
            }
        } else if textView.text.count > 499 {
            return false
        }
        return true
    }
    
}
extension DjDropVC: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let data = try! Data(contentsOf: url)
        print(data.count)
        if data.count > 26214400{
            self.view.makeToast("You are not allowed to upload a file of size more than 25 MB.")
        }else{
            vwAddAudio.isHidden = true
            vwUploadedAudio.isHidden = false
            fileName = url.lastPathComponent
            vwSubmitStep3.isHidden = false
            btnSubmitAudio.isEnabled = true
            btnBackAudio.isEnabled = true
            
            songData = try! Data(contentsOf: url) as NSData
            preparePlayer(url)
            lblDjDropName.text = "\(lblStep3Title.text!) Drop"
            lblDjDropBy.text = "Drop by \(UserModel.sharedInstance().uniqueUserName!)"
            let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
            self.imgMusicUserProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        vwAddAudio.isHidden = false
        vwUploadedAudio.isHidden = true
        vwSubmitStep3.isHidden = true
    }
}

extension DjDropVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnStep3Play.setImage(UIImage(named:"audio-play"),for: .normal)
    }
}
