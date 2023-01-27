//
//  DjRemixVC.swift
//  DJConnect
//
//  Created by mac on 19/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import UITextView_Placeholder

class DjRemixVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblStepNumber: UILabel!
    @IBOutlet weak var imgUserProfile: imageProperties!
    @IBOutlet weak var lblByName: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var vwStep1: UIView!
    @IBOutlet weak var vwStep2: UIView!
    @IBOutlet weak var vwStep3: UIView!
    @IBOutlet weak var vwStep4: UIView!
    @IBOutlet weak var lblLo_ProjPrice: UILabel!
    @IBOutlet weak var lblProjPrice: UILabel!
    @IBOutlet weak var lblLo_transFee: UILabel!
    @IBOutlet weak var lblTransFee: UILabel!
    @IBOutlet weak var lblLo_ProjPriceTotal: UILabel!
    @IBOutlet weak var lblProjectTotalPrice: UILabel!
    @IBOutlet weak var btnAddAudio: UIButton!
    @IBOutlet weak var txfSongName: textFieldProperties!
    @IBOutlet weak var vwRemixDescrip: viewProperties!
    @IBOutlet weak var lblWordCount: UILabel!
    @IBOutlet weak var txfRemixDescription: UITextView!
    @IBOutlet weak var lblStep3Descrip: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var vwStep3AddAudio: UIView!
    @IBOutlet weak var vwStep3AddedAudio: UIView!
    @IBOutlet weak var vwStep3Submit: UIView!
    @IBOutlet weak var vwStep2DetailAdded: UIView!
    @IBOutlet weak var lblStep2DetailAddedDescrip: UILabel!
    @IBOutlet weak var lblStep2RemixName: UILabel!
    @IBOutlet weak var lblStep2RemixBy: UILabel!
    @IBOutlet weak var lblStep2RemixGenre: UILabel!
    @IBOutlet weak var btnStep2Play: UIButton!
    @IBOutlet weak var lblStep2MinTime: UILabel!
    @IBOutlet weak var lblStep2MaxTime: UILabel!
    @IBOutlet weak var SliderStep2: UISlider!
    @IBOutlet weak var imgStep2MusicProfile: imageProperties!
    @IBOutlet weak var lblStep4Descrip: UILabel!
    
    @IBOutlet weak var lblStep3RemixName: UILabel!
    @IBOutlet weak var lblStep3RemixBy: UILabel!
    @IBOutlet weak var lblStep3RemixGenre: UILabel!
    @IBOutlet weak var btnStep3Play: UIButton!
    @IBOutlet weak var lblStep3MinTime: UILabel!
    @IBOutlet weak var lblStep3MaxTime: UILabel!
    @IBOutlet weak var SliderStep3: UISlider!
    @IBOutlet weak var imgStep3MusicProfile: imageProperties!
    
    @IBOutlet weak var imgArSubmitImage: imageProperties!
    @IBOutlet weak var lblArSubmitSongName: UILabel!
    @IBOutlet weak var lblArSubmitSongBy: UILabel!
    @IBOutlet weak var lblArSubmitGenre: UILabel!
    @IBOutlet weak var btnPlaySubmit: UIButton!
    @IBOutlet weak var lblArMinTime: UILabel!
    @IBOutlet weak var lblArMaxTime: UILabel!
    @IBOutlet weak var SliderArSubmit: UISlider!
    @IBOutlet weak var vwArSongSubmitted: UIView!
    
    
    @IBOutlet weak var lblDjClick: UILabel!
    
    @IBOutlet weak var cnsVwStep1LeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var cnsVwStep2LeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var cnsVwStep3LeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var cnsVwStep4LeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var cnsVwStep2DetailAddedLeadingSpace: NSLayoutConstraint!
    
    //MARK: - ENUM
    enum uploadType: String{
        case artistUpload
        case djUpload
    }
    
    //MARK: - GLOBAL VARIABLES
    var currentCurrency = String()
    var projectUserId = String()
    var fileName = String()
    var songData = NSData()
    var djsongData = NSData()
    var audioPlayer: AVAudioPlayer?
    var arAudioPlayer: AVAudioPlayer?
    var artist_id = String()
    var remainingTime = String()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var isRemixAlert = false
    var isFromNotification = false
    var projBy = String()
    var connectCost = String()
    var userProfile = UIImage()
    var selectFileType = uploadType.artistUpload
    var remix_id = String()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cnsVwStep2LeadingSpace.constant = self.view.frame.size.width
        cnsVwStep3LeadingSpace.constant = self.view.frame.size.width
        cnsVwStep4LeadingSpace.constant = self.view.frame.size.width
        cnsVwStep2DetailAddedLeadingSpace.constant = self.view.frame.size.width
        callCurrencyListWebService()
        let placeholderString = "Enter the details you would like the DJ know about your Remix."
        txfRemixDescription.placeholder = placeholderString
        txfRemixDescription.isUserInteractionEnabled = false
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "," // or possibly "." / ","
        formatter.numberStyle = .decimal
        
        if UserModel.sharedInstance().userType == "DJ"{
            formatter.string(from: Int(connectCost)! as NSNumber)
            let string5 = formatter.string(from: Int(connectCost)! as NSNumber)
            lblPrice.text = "COST :".localize + " \(currentCurrency)" + string5!
//            lblPrice.text = "COST :".localize + " \(currentCurrency)\(connectCost)"
            lblByName.text = "By ".localize + "\(projBy)"
            imgUserProfile.image = userProfile
        }else{
            formatter.string(from: Int(connectCost)! as NSNumber)
            let string5 = formatter.string(from: Int(connectCost)! as NSNumber)
            lblPrice.text = "COST :".localize + " \(currentCurrency)" + string5!
//            lblPrice.text = "COST :".localize + " \(currentCurrency)\(connectCost)"
            lblByName.text = "By ".localize + "\(projBy)"
            imgUserProfile.image = userProfile
        }
        if UserModel.sharedInstance().userType == "AR"{
            GetArRemixDataWebService()
        }else{
            GetDjRemixDataWebService()
        }
        self.SliderStep2.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        self.SliderStep3.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        self.SliderArSubmit.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
    }
    
    //MARK: - ACTIONS
    @IBAction func btnMainBackAction(_ sender: UIButton) {
        if isRemixAlert == true{
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            sideMenuController()?.setContentViewController(next1!)
        }else if isFromNotification == true{
            backNotificationView()
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnConfirmAction(_ sender: UIButton) {
        lblStepNumber.text = "dropstep2of4".localize
        vwStep1.isHidden = true
        vwStep2.isHidden = false
        txfRemixDescription.isUserInteractionEnabled = true
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsVwStep2LeadingSpace.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in
            
        }
    }
    
    @IBAction func btnAddAudioAction(_ sender: UIButton) {
        if txfSongName.text?.isEmpty == true{
            self.view.makeToast("Please Enter Remix Name")
        }else if txfRemixDescription.text.isEmpty == true{
            self.view.makeToast("Please Enter Remix Description")
        }else{
            selectFileType = .artistUpload
            txfSongName.resignFirstResponder()
            txfRemixDescription.resignFirstResponder()
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio"], in: .import)
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnStep2PlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @IBAction func btnBackStep2_Action(_ sender: UIButton) {
        vwStep2.isHidden = false
        vwStep2DetailAdded.isHidden = true
        txfRemixDescription.text?.removeAll()
        txfSongName.text?.removeAll()
        lblWordCount.text = "0/500"
        cnsVwStep2DetailAddedLeadingSpace.constant = self.view.frame.size.width
    }
    
    @IBAction func btnSubmitStep2_Action(_ sender: UIButton) {
        calladdDjRemixAudioWebService()
    }
    
    @IBAction func btnDjAddAudio_Action(_ sender: UIButton) {
        selectFileType = .djUpload
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnBackStep3_Action(_ sender: UIButton) {
        vwStep3AddAudio.isHidden = false
        vwStep3Submit.isHidden = true
        vwStep3AddedAudio.isHidden = true
    }
    
    @IBAction func btnStep3Submit_Action(_ sender: UIButton) {
        vwStep3Submit.isHidden = true
        vwStep3AddAudio.isHidden = true
        vwStep3AddedAudio.isHidden = false
        callDjRemixAudioWebService()
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
    
    @IBAction func btnRemixComplete_Action(_ sender: UIButton) {
        globalObjects.shared.dropCompleteConnect = true
        UserModel.sharedInstance().isPin = false
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
    
    @IBAction func btnArSubmitPlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "audio_pause"){
            arAudioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            arAudioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateArSubmitSeekBar), userInfo: nil, repeats: true)
            
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
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
            let minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            let secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            if selectFileType == .artistUpload{
                lblStep2MinTime.text = String(self.SliderStep2.value)
                lblStep2MaxTime.text = "\(minuteString):\(secondString)"
                self.audioPlayer?.currentTime = Double(self.SliderStep2.value)
                self.SliderStep2.maximumValue = Float(Double(self.audioPlayer!.duration))
            }else{
                lblStep3MinTime.text = String(self.SliderStep3.value)
                lblStep3MaxTime.text = "\(minuteString):\(secondString)"
                self.audioPlayer?.currentTime = Double(self.SliderStep3.value)
                self.SliderStep3.maximumValue = Float(Double(self.audioPlayer!.duration))
            }
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }
    
    func prepareArSubmitPlayer(_ songurl: URL?) {
        guard let url = songurl else {
            print("Invalid URL")
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            arAudioPlayer = try AVAudioPlayer(data: soundData)
            arAudioPlayer!.volume = 0.7
            arAudioPlayer!.delegate = self
            let minuteString = String(format: "%02d", (Int(arAudioPlayer!.duration) / 60))
            let secondString = String(format: "%02d", (Int(arAudioPlayer!.duration) % 60))
            lblArMinTime.text = String(self.SliderArSubmit.value)
            lblArMaxTime.text = "\(minuteString):\(secondString)"
            self.arAudioPlayer?.currentTime = Double(self.SliderArSubmit.value)
            self.SliderArSubmit.maximumValue = Float(Double(self.arAudioPlayer!.duration))
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateArSubmitSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }
    
    func startTimer() {
        let releaseDateString = "\(remainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.timeZone = NSTimeZone(name: "Asia/Kolkata") as TimeZone?
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func startTimerIntial() {
        let releaseDateString = "\(remainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.timeZone = NSTimeZone(name: "Asia/Kolkata") as TimeZone?
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    //MARK: - SELECTOR METHODS
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        if selectFileType == .artistUpload{
            lblStep2MaxTime.text = "\(remMin):\(remSec)"
            lblStep2MinTime.text = "\(minCurrent):\(secCurrent)"
            SliderStep2.value = Float(Double((audioPlayer?.currentTime)!))
        }else{
            lblStep3MaxTime.text = "\(remMin):\(remSec)"
            lblStep3MinTime.text = "\(minCurrent):\(secCurrent)"
            SliderStep3.value = Float(Double((audioPlayer?.currentTime)!))
        }
    }
    
    @objc func UpdateArSubmitSeekBar() {
        let minCurrent = String(format: "%02d", (Int(arAudioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(arAudioPlayer!.currentTime) % 60))
        let total = Int(arAudioPlayer!.duration) - Int(arAudioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        lblArMaxTime.text = "\(remMin):\(remSec)"
        lblArMinTime.text = "\(minCurrent):\(secCurrent)"
        SliderArSubmit.value = Float(Double((arAudioPlayer?.currentTime)!))
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        self.lblRemainingTime.text = countdown
        
    }
    //MARK: - WEBSERVICES
    func callCurrencyListWebService(){
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
        }
    }
    
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id=&dj_id=\(projectUserId)&token=\(UserModel.sharedInstance().token!)&type=djremix"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let step1Model = response.result.value!
                    if step1Model.success == 1{
                        let formatter = NumberFormatter()
                        formatter.groupingSeparator = "," // or possibly "." / ","
                        formatter.numberStyle = .decimal
                        
                        self.vwStep1.isHidden = false
                        if let price = step1Model.result!.project_price{
                            formatter.string(from: Int(price)! as NSNumber)
                            let string5 = formatter.string(from: Int(price)! as NSNumber)
                            
                            self.lblProjPrice.text =  "  " + self.currentCurrency + string5!
                        }
                        if let transPrice = step1Model.result!.transaction_fees{
                            formatter.string(from: Int(transPrice)! as NSNumber)
                            let string5 = formatter.string(from: Int(transPrice)! as NSNumber)
                            self.lblTransFee.text =  "  " + self.currentCurrency + string5!
                        }
                        if let totAmount = step1Model.result!.total_price{
                            formatter.string(from: Int(totAmount)! as NSNumber)
                            let string5 = formatter.string(from: Int(totAmount)! as NSNumber)
                            self.lblProjectTotalPrice.text =  "  " + self.currentCurrency + string5!
//                            self.lblProjectTotalPrice.text =  "  " + self.currentCurrency + totAmount
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(step1Model.message)
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
    
    // artist flow
    func GetArRemixDataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getDjRemixStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(projectUserId)&apply_user_id=\(UserModel.sharedInstance().userId!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjRemixStepModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let remixStepModel = response.result.value!
                    if remixStepModel.success == 1{
                        if remixStepModel.step2!.step2_status! == "1"{
                            
                            let formatter = NumberFormatter()
                            formatter.groupingSeparator = "," // or possibly "." / ","
                            formatter.numberStyle = .decimal
                            
                            self.vwStep3.isHidden = false
                            self.cnsVwStep3LeadingSpace.constant = 0
                            self.vwStep1.isHidden = true
                            self.lblStepNumber.text = "dropstep3of4".localize
                            self.lblStep3Descrip.text = remixStepModel.step2!.djremix_description!
                            self.remainingTime = remixStepModel.step2!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                            self.lblArSubmitSongName.text = remixStepModel.step2!.audio_name!
                            self.lblArSubmitSongBy.text = "Remix By " + "\(remixStepModel.step2!.artist_name!)"
                            self.lblArSubmitGenre.text = "\(remixStepModel.step2!.artist_genre!)"
                            if let artistSubmitImageUrl = remixStepModel.step2!.artist_pic{
                                self.vwArSongSubmitted.isHidden = false
                                let musicProfileUrl = URL(string : artistSubmitImageUrl)
                                self.imgArSubmitImage.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                            let songUrl = URL(string: "\(remixStepModel.step2!.audio_file!)")
                            self.prepareArSubmitPlayer(songUrl)
                            self.lblByName.text = "By ".localize + "\(remixStepModel.step2!.dj_name!)"
                            
                            formatter.string(from: Int(remixStepModel.step2!.dj_remix_cost!)! as NSNumber)
                            let string5 = formatter.string(from: Int(remixStepModel.step2!.dj_remix_cost!)! as NSNumber)
                            self.lblPrice.text = "COST :".localize + " " + string5!
//                            self.lblPrice.text = "COST :".localize + " \(self.currentCurrency)\(remixStepModel.step2!.dj_remix_cost!)"
                            self.lblDjClick.isHidden = true
                            self.vwStep2.isHidden = true
                            self.vwStep2DetailAdded.isHidden = true
                            if let ImageUrl = remixStepModel.step2!.dj_pic{
                                let profileImageUrl = URL(string: ImageUrl)
                                self.imgUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                            
                            if remixStepModel.step2!.remaining_time!.contains("00:00:00") {
                                self.vwStep1.isHidden = false
                                self.vwStep3.isHidden = true
                                
                                formatter.string(from: Int(self.connectCost)! as NSNumber)
                                let string5 = formatter.string(from: Int(self.connectCost)! as NSNumber)
//                                self.lblPrice.text = "COST :".localize + " \(self.currentCurrency)\(self.connectCost)"
                                self.lblPrice.text = "COST :".localize + " \(self.currentCurrency)" + " " + string5!
                                self.callStep1DataWebService()
                            }else{
                                self.remainingTime = remixStepModel.step2!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }
                            if remixStepModel.step3!.step3_status! == "1"{
                                self.vwStep3.isHidden = true
                                self.vwStep4.isHidden = false
                                self.cnsVwStep4LeadingSpace.constant = 0
                                self.vwStep1.isHidden = true
                                self.lblStepNumber.text = "dropstep4of4".localize
                                self.lblStep4Descrip.text = remixStepModel.step2!.djremix_description!
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
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please Check your Internet Connection")
        }
    }
    
    // dj flow
    func GetDjRemixDataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getDjRemixStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(UserModel.sharedInstance().userId!)&apply_user_id=\(artist_id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjRemixStepModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let remixStepModel = response.result.value!
                    if remixStepModel.success == 1{
                        if remixStepModel.step2!.step2_status! == "1"{
                            
                            let formatter = NumberFormatter()
                            formatter.groupingSeparator = "," // or possibly "." / ","
                            formatter.numberStyle = .decimal
                            
                            self.vwStep3.isHidden = false
                            self.cnsVwStep3LeadingSpace.constant = 0
                            self.vwStep1.isHidden = true
                            self.lblStepNumber.text = "dropstep3of4".localize
                            self.lblStep3Descrip.text = remixStepModel.step2!.djremix_description!
                            self.lblByName.text = "By ".localize + "\(remixStepModel.step2!.dj_name!)"
                            
                            formatter.string(from: Int(remixStepModel.step2!.dj_remix_cost!)! as NSNumber)
                            let string5 = formatter.string(from: Int(remixStepModel.step2!.dj_remix_cost!)! as NSNumber)
                            self.lblPrice.text = "COST :".localize + string5!
//                            self.lblPrice.text = "COST :".localize + " \(self.currentCurrency)\(remixStepModel.step2!.dj_remix_cost!)"
                            self.lblArSubmitSongName.text = remixStepModel.step2!.audio_name!
                            self.lblArSubmitSongBy.text = "Remix By " + "\(remixStepModel.step2!.artist_name!)"
                            self.lblArSubmitGenre.text = "\(remixStepModel.step2!.artist_genre!)"
                            if let artistSubmitImageUrl = remixStepModel.step2!.artist_pic{
                                self.vwArSongSubmitted.isHidden = false
                                let musicProfileUrl = URL(string : artistSubmitImageUrl)
                                self.imgArSubmitImage.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                            let songUrl = URL(string: "\(remixStepModel.step2!.audio_file!)")
                            self.prepareArSubmitPlayer(songUrl)
                            self.lblDjClick.isHidden = true
                            self.vwStep3AddAudio.isHidden = false
                            self.vwStep3AddedAudio.isHidden = true
                            if let ImageUrl = remixStepModel.step2!.dj_pic{
                                let profileImageUrl = URL(string: ImageUrl)
                                self.imgUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                            if let cost = remixStepModel.step2!.dj_remix_cost{
                                self.lblPrice.text = "COST : \(UserModel.sharedInstance().userCurrency!)\(cost)"
                            }
                            if let name =  remixStepModel.step2!.dj_name{
                                self.lblByName.text = "By \(name)"
                            }
                            if remixStepModel.step2!.remaining_time!.contains("00:00:00") {
                                self.lblRemainingTime.text = "TIME EXPIRED".localize
                            }else{
                                self.remainingTime = remixStepModel.step2!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }
                        }
                        
                        if remixStepModel.step3!.step3_status! == "1"{
                            self.selectFileType = .djUpload
                            self.vwStep3AddedAudio.isHidden = false
                            self.vwStep3AddAudio.isHidden = true
                            self.lblStep3RemixName.text = "\(remixStepModel.step2!.audio_name!) Remix"
                            self.lblStep3RemixBy.text = "Remix by \(UserModel.sharedInstance().uniqueUserName!)"
                            let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
                            self.imgStep3MusicProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            if let url = remixStepModel.step2!.audio_file{
                                self.preparePlayer(URL(string: url))
                            }
                        }else{
                            self.selectFileType = .artistUpload
                        }
                    }else{
                        self.vwStep1.isHidden = false
                        self.callStep1DataWebService()
                        Loader.shared.hide()
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
    
    //artist uploading song
    func calladdDjRemixAudioWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audio_title":"\(txfSongName.text! + " Remix ")",
                "dj_id":"\(artist_id)",
                "dj_remix_title":"Remix",
                "dj_remix_description":"\(txfRemixDescription.text!)",
            ]
            
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addDjRemixAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
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
                    upload.responseJSON { response in
                        CommonFunctions.shared.hideLoader()
                        let json = response.result.value as? [String:Any]
                        if response.result.isSuccess == true{
                            if let json = response.value as? [String:Any] {
                                if json["success"]! as! String == "1"{
                                    let audio_data = json["audio_data"]! as! [String:Any]
                                    self.remainingTime = audio_data["closing_time"]! as! String
                                    self.lblStep3Descrip.text = "\(self.txfRemixDescription.text!)"
                                    CommonFunctions.shared.hideLoader()
                                    globalObjects.shared.dropAudioAdded = true
                                    self.startTimerIntial()
                                    self.vwStep2DetailAdded.isHidden = true
                                    self.vwStep2.isHidden = true
                                    self.vwStep3.isHidden = false
                                    self.vwArSongSubmitted.isHidden = false
                                    UIView.animate(withDuration: 1.0, animations: {
                                        self.cnsVwStep3LeadingSpace.constant = 0
                                        self.view.layoutIfNeeded()
                                    }) { (completion) in
                                        
                                    }
                                    self.lblDjClick.isHidden = true
                                    self.vwStep3AddAudio.isHidden = true
                                    self.vwStep3AddedAudio.isHidden = true
                                    self.vwStep3Submit.isHidden = true
                                    self.lblArSubmitSongName.text = "\(self.txfSongName.text!) Remix"
                                    self.lblArSubmitSongBy.text = "Remix by \(UserModel.sharedInstance().uniqueUserName!)"
                                    self.lblArSubmitGenre.text = "\(UserModel.sharedInstance().genereList!)"
                                    let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
                                    self.imgArSubmitImage.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                                    let audio_url = URL(string: audio_data["audio_file"]! as! String)
                                    self.prepareArSubmitPlayer(audio_url)
                                    self.view.makeToast("Audio Added Successfully")
                                }else{
                                    CommonFunctions.shared.hideLoader()
                                    self.view.makeToast("Audio submission failed.")
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
    
    func callDjRemixAudioWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audio_title":"\(fileName) Remix",
                "dj_remix_id":"\(remix_id)",
            ]
            
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addDjRemixAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    multipartFormData.append(self.djsongData as Data, withName: "audio_file", fileName: "audio.mp3", mimeType: "audio/mp3")
                }
            }, to: serviceURL) { (result) in
                switch result {
                case .success(let upload,_,_):
                    
                    upload.uploadProgress(closure: { (progress) in
                        CommonFunctions.shared.showProgress(progress: CGFloat(progress.fractionCompleted))
                    })
                    upload.responseJSON { response in
                        CommonFunctions.shared.hideLoader()
                        let json = response.result.value as? [String:Any]
                        if response.result.isSuccess == true{
                            if let json = response.value as? [String:Any] {
                                if json["success"]! as! String == "1"{
                                    CommonFunctions.shared.hideLoader()
                                    self.vwStep3.isHidden = false
                                    self.cnsVwStep3LeadingSpace.constant = 0
                                    self.vwStep3AddAudio.isHidden = true
                                    self.vwStep3AddedAudio.isHidden = false
                                    self.vwStep3Submit.isHidden = true
                                    self.view.makeToast("Audio Added Successfully")
                                }else{
                                    CommonFunctions.shared.hideLoader()
                                    self.view.makeToast("Audio submission failed.")
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
}
//MARK: - EXTENSIONS
extension DjRemixVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
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

extension DjRemixVC: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let data = try! Data(contentsOf: url)
        print(data.count)
        if data.count > 26214400{
            self.view.makeToast("You are not allowed to upload a file of size more than 25 MB.")
        }else{
            if selectFileType == .artistUpload{
                vwStep2.isHidden = true
                UIView.animate(withDuration: 1.0, animations: {
                    self.cnsVwStep2DetailAddedLeadingSpace.constant = 0
                    self.view.layoutIfNeeded()
                }) { (completion) in
                    
                }
                lblStepNumber.text = "dropstep3of4".localize
                vwStep2DetailAdded.isHidden = false
                fileName = url.lastPathComponent
                songData = try! Data(contentsOf: url) as NSData
                preparePlayer(url)
                lblStep2DetailAddedDescrip.text = "\(txfRemixDescription.text!)"
                lblStep2RemixName.text = "\(txfSongName.text!) Remix"
                lblStep2RemixBy.text = "Remix by \(UserModel.sharedInstance().uniqueUserName!)"
                lblStep2RemixGenre.text = "\(UserModel.sharedInstance().genereList!)"
                let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
                self.imgStep2MusicProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            }else{
                vwStep3AddAudio.isHidden = true
                vwStep3AddedAudio.isHidden = false
                fileName = url.lastPathComponent
                fileName = fileName.description.replacingOccurrences(of: " ", with: "")
                djsongData = try! Data(contentsOf: url) as NSData
                preparePlayer(url)
                lblStep3RemixName.text = "\(fileName) Remix"
                lblStep3RemixBy.text = "Remix by \(UserModel.sharedInstance().uniqueUserName!)"
                lblStep3RemixGenre.text = "\(UserModel.sharedInstance().genereList!)"
                vwStep3Submit.isHidden = false
                let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
                self.imgStep3MusicProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        vwStep2.isHidden = false
        cnsVwStep2DetailAddedLeadingSpace.constant = self.view.frame.size.width
        vwStep2DetailAdded.isHidden = true
    }
    
}
extension DjRemixVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if selectFileType == .artistUpload{
            btnStep2Play.setImage(UIImage(named:"audio-play"),for: .normal)
        }else if selectFileType == .djUpload{
            btnStep3Play.setImage(UIImage(named:"audio-play"),for: .normal)
        }else{
            btnPlaySubmit.setImage(UIImage(named:"audio-play"),for: .normal)
        }
    }
}
