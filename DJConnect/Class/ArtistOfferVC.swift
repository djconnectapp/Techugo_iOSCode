//
//  ArtistOfferVC.swift
//  DJConnect
//
//  Created by mac on 22/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AVFoundation
import AlamofireObjectMapper
import Alamofire

class ArtistOfferVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblStepNumber: UILabel!
    @IBOutlet weak var txfOffer: UITextField!
    @IBOutlet weak var lblEnterOffer: UILabel!
    @IBOutlet weak var lblProjName: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var vwPaymentNotComplete: UIView!
    @IBOutlet weak var vwStep2AddAudio: UIView!
    @IBOutlet weak var txfSongName: textFieldProperties!
    @IBOutlet weak var vwStep2AddedAudio: UIView!
    @IBOutlet weak var btnStep2Back: UIButton!
    @IBOutlet weak var btnStep2Submit: UIButton!
    @IBOutlet weak var lblStep2SongName: UILabel!
    @IBOutlet weak var lblStep2SongBy: UILabel!
    @IBOutlet weak var lblStep2Genre: UILabel!
    @IBOutlet weak var btnStep2Play: UIButton!
    @IBOutlet weak var lblStep2MinTime: UILabel!
    @IBOutlet weak var Step2Slider: UISlider!
    @IBOutlet weak var lblStep2MaxTime: UILabel!
    @IBOutlet weak var lblStep2UserProfile: imageProperties!
    @IBOutlet weak var lblStep3SongName: UILabel!
    @IBOutlet weak var lblStep3MinTime: UILabel!
    @IBOutlet weak var step3Silder: UISlider!
    @IBOutlet weak var lblStep3MaxTime: UILabel!
    @IBOutlet weak var imgStep3MusicProfile: imageProperties!
    @IBOutlet weak var btnStep3Play: UIButton!
    @IBOutlet weak var lblStep3SongGenre: UILabel!
    @IBOutlet weak var lblStep3SongBy: UILabel!
    @IBOutlet weak var vwStep3SongStatus: UIView!
    @IBOutlet weak var lblStatusHeader: UILabel!
    @IBOutlet weak var lblDjNotify: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var btnViewConnect: UIButton!
    @IBOutlet weak var lblStatusAck: UILabel!
    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var lblReasonDetail: UILabel!
    @IBOutlet weak var lblMainByDj: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var imgMainUserProfile: imageProperties!
    @IBOutlet weak var cnsStep2AddAudioLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsStep2AddedAudioLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsStep3SongStatusLeading: NSLayoutConstraint!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var cnsToptextfieldOffer: NSLayoutConstraint!
    
    @IBOutlet weak var vwStep1: UIView!
    @IBOutlet weak var lblProjectPrice: UILabel!
    @IBOutlet weak var lblTransactionFee: UILabel!
    @IBOutlet weak var lblTotalProjPrice: UILabel!
    
    //localize outlets
    @IBOutlet weak var lblLo_ProjPrice: UILabel!
    @IBOutlet weak var lblLo_TransFee: UILabel!
    @IBOutlet weak var lblLo_TotalPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lblLo_Step2SongSub: UILabel!
    @IBOutlet weak var lblLo_step2SongAck: UILabel!
    @IBOutlet weak var lblLo_StepAddedSub: UILabel!
    @IBOutlet weak var lblLo_Step3SongSub: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var minuteString = String()
    var secondString = String()
    var songData = NSData()
    var audioPlayer: AVAudioPlayer?
    var apiSongData = String()
    var remainingTime = String()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var old_offer = String()
    var projTimezone = String()
    var isFromAlert = Bool()
    var userDetailDict = [String: String]()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        lblProjName.text = "\(userDetailDict["projectName"]!)"
        lblMainByDj.text = "\(userDetailDict["projectBy"]!)"
        lblCost.text = "COST: ".localize + "\(userDetailDict["projectCost"]!)"
        lblStep2Genre.text = UserModel.sharedInstance().genereList!
        lblStep3SongGenre.text = UserModel.sharedInstance().genereList!
        localizeElements()
        let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
        self.lblStep2UserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        let djImageUrl = URL(string: userDetailDict["userProfile"]!)
        self.imgMainUserProfile.kf.setImage(with: djImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        self.Step2Slider.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        self.step3Silder.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat =  "MMM d, yyyy"
        lblCurrentDate.text = "Today's Date : \(formatter.string(from: date))"
        
        vwStep2AddAudio.isHidden = true
        vwStep2AddedAudio.isHidden = true
        vwStep3SongStatus.isHidden = true
        
        cnsStep2AddAudioLeading.constant = self.view.frame.size.width
        cnsStep2AddedAudioLeading.constant = self.view.frame.size.width
        cnsStep3SongStatusLeading.constant = self.view.frame.size.width
        GetBuyProjectDataWebService()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnBackAction(_ sender: UIButton) {
        if isFromAlert == true{
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            sideMenuController()?.setContentViewController(next1!)
        }else{
            navigationController?.popViewController(animated: true)
        }    }
    
    @IBAction func btnSendAction(_ sender: UIButton) {
        if btnSend.currentTitle == "Send"{
            txfOffer.isEnabled = true
            lblEnterOffer.text = "Enter Offer:".localize + " \(userDetailDict["currentCurrency"]!) "
            cnsToptextfieldOffer.constant = -2
            btnOffer.isEnabled = true
            let costStr = (userDetailDict["projectCost"]!)
            print("costStr",costStr) // ₹50
            var newCostStr:String?
            if costStr.contains("₹") {
                newCostStr = costStr.replacingOccurrences(of: "₹", with: "", options: .literal, range: nil)
            }
            print("txfOffer",txfOffer.text)
            let ofrPrice:Int! = Int(txfOffer.text!)
            print("ofrPrice",ofrPrice)
            if(ofrPrice < Int(newCostStr!)!){
                print("got t")
                callSetOfferWebService()
            }
            else{
                txfOffer.isEnabled = true
                self.view.makeToast("Cann't offer more than actual price")
            }
           // callSetOfferWebService()
        }else{
            btnSend.setTitleColor(.red, for: .normal)
            old_offer = txfOffer.text!
            //txfOffer.text!.removeAll()
            txfOffer.isEnabled = true
            lblEnterOffer.text = "Enter Offer:".localize + " \(userDetailDict["currentCurrency"]!) ______"
            cnsToptextfieldOffer.constant = -5
            // hide payment
            vwStep1.isHidden = true
        }
    }
    
    @IBAction func btnAddAudioAction(_ sender: UIButton) {
        if txfSongName.text?.isEmpty == false{
            txfSongName.resignFirstResponder()
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio"], in: .import)
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }else{
            txfSongName.resignFirstResponder()
            self.view.makeToast("Please Enter Song Name")
        }
    }
    
    @IBAction func btnStep2BackAction(_ sender: UIButton) {
        vwStep2AddAudio.isHidden = false
        vwStep2AddedAudio.isHidden = true
        txfSongName.text?.removeAll()
    }
    
    @IBAction func btnStep2SubmitAction(_ sender: UIButton) {
        lblStepNumber.text = "dropstep3of4".localize
        btnStep2Submit.isUserInteractionEnabled = false
        callAddAudioWebservice()
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
    
    @IBAction func btnStep3SliderAction(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(step3Silder.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    @IBAction func btnStep2SliderAction(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(Step2Slider.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    @IBAction func btnOfferAction(_ sender: UIButton) {
        old_offer = txfOffer.text!
        txfOffer.text!.removeAll()
        txfOffer.isEnabled = true
        lblEnterOffer.text = "Enter Offer:".localize + " \(userDetailDict["currentCurrency"]!) ______"
        cnsToptextfieldOffer.constant = -5
        // hide payment
        vwStep1.isHidden = true
    }
    
    @IBAction func btnConfirmAction(_ sender: UIButton) {
        if txfOffer.text?.isEmpty == false{
            lblStepNumber.text = "dropstep2of4".localize
            vwStep1.isHidden = true
            vwStep2AddAudio.isHidden = false
            // offer new changes
            //btnOffer.isEnabled = false
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1.0, animations: {
                self.cnsStep2AddAudioLeading.constant = 0
                self.view.layoutIfNeeded()
            }) { (completion) in
                
            }
        }else{
            self.view.makeToast("Please enter offer value to proceed.")
        }
    }
    
    @IBAction func btnViewConnect_Action(_ sender: UIButton) {
        globalObjects.shared.offerViewConnect = true
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
                lblStep2MinTime.text = String(self.Step2Slider.value)
                lblStep2MaxTime.text = "\(minuteString):\(secondString)"
                self.audioPlayer?.currentTime = Double(self.Step2Slider.value)
                self.Step2Slider.maximumValue = Float(Double(self.audioPlayer!.duration))
            }else{
                lblStep3MinTime.text = String(self.step3Silder.value)
                lblStep3MaxTime.text = "\(minuteString):\(secondString)"
                self.audioPlayer?.currentTime = Double(self.step3Silder.value)
                self.step3Silder.maximumValue = Float(Double(self.audioPlayer!.duration))
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
        lblStepNumber.text = "step1of5".localize
        lblLo_ProjPrice.text = "Project Price: ".localize
        lblLo_TransFee.text = "Transaction Fee:".localize
        lblLo_TotalPrice.text = "Total:".localize
        btnConfirm.setTitle("Confirm".localize, for: .normal)
        lblLo_step2SongAck.text = "buyaddaudioack".localize
        lblLo_Step2SongSub.text = "Song Submission".localize
        lblLo_StepAddedSub.text = "Song Submission".localize
        btnStep2Submit.setTitle("SUBMIT".localize, for: .normal)
        btnStep2Back.setTitle("BACK".localize, for: .normal)
        lblLo_Step3SongSub.text = "Song Submission".localize
        lblDjNotify.text = "buyStep3ack".localize
        lblReason.text = "Reason".localize
        btnViewConnect.setTitle("VIEW CONNECT".localize, for: .normal)
    }
    
    //MARK:- SELECTOR METHODS
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        self.lblRemainingTime.text = countdown
    }
    
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        if self.vwStep3SongStatus.isHidden == true{
            lblStep2MaxTime.text = "\(remMin):\(remSec)"
            lblStep2MinTime.text = "\(minCurrent):\(secCurrent)"
            Step2Slider.value = Float(Double((audioPlayer?.currentTime)!))
        }else{
            lblStep3MaxTime.text = "\(remMin):\(remSec)"
            lblStep3MinTime.text = "\(minCurrent):\(secCurrent)"
            step3Silder.value = Float(Double((audioPlayer?.currentTime)!))
        }
    }
    //MARK: - WEBSERVICES
    func callSetOfferWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "project_id":"\(userDetailDict["projId"]!)",
                "cost":"\(userDetailDict["projectCost"]!)",
                "offering":"\(txfOffer.text!)",
                "old_offering":"\(old_offer)"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.applyProjectPaymentAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    let setOfferProfile = response.result.value!
                    if setOfferProfile.success == 1{
                        Loader.shared.hide()
                        // unhide payment
                        if self.vwStep2AddAudio.isHidden == true{
                            self.vwStep1.isHidden = false
                        }
                        if self.btnSend.currentTitle == "Send"{
                            self.btnSend.setTitleColor(.lightGray, for: .normal)
                            self.btnSend.setTitle("Change", for: .normal)
                            self.txfOffer.isEnabled = false
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
    
    func callAddAudioWebservice(){
        
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "projectid":"\(userDetailDict["projId"]!)",
                "is_offer":"1",
                "offer_price":"\(txfOffer.text!)",
                "audio_name":"\(txfSongName.text!)",
                
            ]
            
            print("AddAudioWebserviceParam",parameters)
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addAudioProjectBuyAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
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
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseObject(completionHandler: { (response:DataResponse<buyProjectAudioModel>) in
                        switch response.result {
                        case .success(_):
                            CommonFunctions.shared.hideLoader()
                            let addMediaProfile = response.result.value!
                            if addMediaProfile.success == 1{
                                self.btnStep2Submit.isUserInteractionEnabled = false
                                self.view.makeToast(addMediaProfile.message)
                                self.apiSongData = (addMediaProfile.audioData?.audio_file)!
                                self.lblStep3MinTime.text = "00:00"
                                self.lblStep3MaxTime.text = self.minuteString + ":" + self.secondString
                                self.lblStep3SongName.text = addMediaProfile.audioData?.audio_name!
                                self.lblStep3SongBy.text = UserModel.sharedInstance().uniqueUserName!
                                let musicProfileUrl = URL(string : UserModel.sharedInstance().userProfileUrl!)
                                self.imgStep3MusicProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                                self.vwStep2AddedAudio.isHidden = true
                                self.vwStep3SongStatus.isHidden = false
                                self.lblStatusAck.isHidden = true
                                self.lblReasonDetail.isHidden = true
                                self.preparePlayer(URL(string: (addMediaProfile.audioData!.audio_file!)))
                                self.view.layoutIfNeeded()
                                
                                UIView.animate(withDuration: 1.0, animations: {
                                    self.cnsStep3SongStatusLeading.constant = 0
                                    self.view.layoutIfNeeded()
                                }) { (completion) in
                                    
                                }
                                self.callProjectStatusWebService()
                            }else{
                                self.btnStep2Submit.isUserInteractionEnabled = true
                                CommonFunctions.shared.hideLoader()
                                self.view.makeToast(addMediaProfile.message)
                            }
                        case .failure(let error):
                            self.btnStep2Submit.isUserInteractionEnabled = true
                            CommonFunctions.shared.hideLoader()
                            debugPrint(error)
                            print("Error")
                        }
                    })
                case .failure(let error):
                    self.btnStep2Submit.isUserInteractionEnabled = true
                    Loader.shared.hide()
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
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getBuyProjectStatus)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(userDetailDict["projId"]!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyProjectStatusModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStatusModel = response.result.value!
                    if buyStatusModel.success == 1{
                        if buyStatusModel.responseData!.status! == 0{
                            if buyStatusModel.responseData!.remaining_time! == "0days 0hr 0min 0sec"{
                                self.lblStatusHeader.text = "DJ Notification".localize
                                self.lblRemainingTime.textColor = .red
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
    
    func GetBuyProjectDataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getStepsProjectAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(userDetailDict["projId"]!)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetBuyProjStepsModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStepModel = response.result.value!
                    if buyStepModel.success == 1{
                        
                        let formatterr = NumberFormatter()
                        formatterr.groupingSeparator = "," // or possibly "." / ","
                        formatterr.numberStyle = .decimal
                        
                        if buyStepModel.step2 == "1"{
                            if buyStepModel.step3!.audio_file!.isEmpty == false{
                                self.cnsStep3SongStatusLeading.constant = 0
                                self.vwStep3SongStatus.isHidden = false
                                self.lblStepNumber.text = "dropstep3of4".localize
                                self.lblStep3SongBy.text = buyStepModel.step3!.artist_name!
                                self.lblStep3SongName.text = buyStepModel.step3!.artist_applied_audio_name!
                                self.lblStep3SongGenre.text = buyStepModel.step3!.artist_genre!
                                
                                formatterr.string(from: Int(buyStepModel.step3!.offering!)! as NSNumber)
                                let string5 = formatterr.string(from: Int(buyStepModel.step3!.offering!)! as NSNumber)
                                self.txfOffer.text = string5!
//                                self.txfOffer.text = buyStepModel.step3!.offering!
                                
                                self.lblEnterOffer.text = "Enter Offer:".localize + " \(self.userDetailDict["currentCurrency"]!) ______"
                                self.cnsToptextfieldOffer.constant = -2
                                let musicProfileUrl = URL(string : buyStepModel.step3!.artist_photo!)
                                self.imgStep3MusicProfile.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                                if let reason = buyStepModel.step3!.reason{
                                    self.lblReason.isHidden = false
                                    self.lblReasonDetail.text = reason
                                }
                                self.preparePlayer(URL(string: buyStepModel.step3!.audio_file!))
                                self.callProjectStatusWebService()
                            }else if buyStepModel.step3!.offering!.isEmpty == false{
                                self.lblStepNumber.text = "dropstep2of4".localize
                                if self.btnSend.currentTitle == "Send"{
                                    self.btnSend.setTitleColor(.lightGray, for: .normal)
                                    self.btnSend.setTitle("Change", for: .normal)
                                    self.btnSend.isEnabled = true
                                }
                                self.cnsStep2AddAudioLeading.constant = 0
                                self.vwStep2AddAudio.isHidden = false
                                self.vwStep1.isHidden = true
                                self.btnOffer.isEnabled = false
                                self.txfOffer.isEnabled = false
                                formatterr.string(from: Int(buyStepModel.step3!.offering!)! as NSNumber)
                                let string5 = formatterr.string(from: Int(buyStepModel.step3!.offering!)! as NSNumber)
                                self.txfOffer.text = string5!
                                
                                self.lblEnterOffer.text = "Enter Offer:".localize + " \(self.userDetailDict["currentCurrency"]!) ______"
                                self.cnsToptextfieldOffer.constant = -2
                            }else{
                                if self.userDetailDict["isOfferOn"]! == "0"{
                                    // as per offer new change payment is hide unless offer not set by send btn
                                    self.vwStep3SongStatus.isHidden = true
                                    self.txfOffer.isEnabled = true
                                    self.lblEnterOffer.text = "Enter Offer:".localize + " \(self.userDetailDict["currentCurrency"]!) ______"
                                    self.cnsToptextfieldOffer.constant = -5
                                    self.callStep1DataWebService()
                                }else{
                                    self.vwStep1.isHidden = true
                                }
                            }
                            if buyStepModel.is_completed! == 1{
                                self.lblStepNumber.text = "dropstep4of4".localize
                                self.lblStatusHeader.text = "Project Complete".localize
                                self.lblDjNotify.text = "buyStep3ackDone".localize
                                self.btnViewConnect.isHidden = false
                                self.lblRemainingTime.isHidden = true
                                self.lblStatusAck.isHidden = true
                                self.lblReason.isHidden = true
                                self.lblReasonDetail.isHidden = true
                            }
                        }
                        if self.userDetailDict["isOfferOn"] == "0"{
                            // as per offer new change payment is hide unless offer not set by send btn
                            if self.isFromAlert == true{
                                self.vwStep1.isHidden = true
                                self.vwStep3SongStatus.isHidden = false
                            }else{
                                if buyStepModel.is_completed! == 1{
                                    if buyStepModel.step3!.status == 2{
                                        self.vwStep3SongStatus.isHidden = false
                                        let formatterr = NumberFormatter()
                                        formatterr.groupingSeparator = "," // or possibly "." / ","
                                        formatterr.numberStyle = .decimal
                                        formatterr.string(from: Int(buyStepModel.step3!.offering!)! as NSNumber)
                                        let string5 = formatterr.string(from: Int(buyStepModel.step3!.offering!)! as NSNumber)
                                        self.txfOffer.text = string5!
                                        
                                        self.lblEnterOffer.text = "Enter Offer:".localize + " \(self.userDetailDict["currentCurrency"]!) ______"
                                        self.cnsToptextfieldOffer.constant = -2
                                    }
                                }else{
                                    self.vwStep3SongStatus.isHidden = true
                                    self.txfOffer.isEnabled = true
                                    self.lblEnterOffer.text = "Enter Offer:".localize + " \(self.userDetailDict["currentCurrency"]!) ______"
                                    self.cnsToptextfieldOffer.constant = -2
                                    self.callStep1DataWebService()
                                }
                            }
                        }
                    }else{
                        self.vwStep1.isHidden = false
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
    
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id=\(userDetailDict["projId"]!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(userDetailDict["projUserId"]!)&type=project"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
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
                            let string5 = formatterr.string(from: Int(price)! as NSNumber)
                            self.lblProjectPrice.text =  "  " + self.userDetailDict["currentCurrency"]! + string5!
                        }
                        if let transPrice = step1Model.result!.transaction_fees{
                            formatterr.string(from: Int(transPrice)! as NSNumber)
                            let string5 = formatterr.string(from: Int(transPrice)! as NSNumber)
                            self.lblTransactionFee.text =  "  " + self.userDetailDict["currentCurrency"]! + string5!
                        }
                        if let totAmount = step1Model.result!.total_price{
                            formatterr.string(from: Int(totAmount)! as NSNumber)
                            let string5 = formatterr.string(from: Int(totAmount)! as NSNumber)
                            self.lblTotalProjPrice.text =  "  " + self.userDetailDict["currentCurrency"]! + string5!
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
}


//MARK: - EXTENSIONS
extension ArtistOfferVC : UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let data = try! Data(contentsOf: url)
        print(data.count)
        if data.count > 26214400{
            self.view.makeToast("You are not allowed to upload a file of size more than 25 MB.")
        }else{
            vwStep2AddAudio.isHidden = true
            vwStep2AddedAudio.isHidden = false
            lblStepNumber.text = "dropstep3of4".localize
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1.0, animations: {
                self.cnsStep2AddedAudioLeading.constant = 0
                self.view.layoutIfNeeded()
            }) { (completion) in
                
            }
            songData = try! Data(contentsOf: url) as NSData
            preparePlayer(url)
            lblStep2SongName.text = txfSongName.text
            lblStep2SongBy.text = "by \(UserModel.sharedInstance().uniqueUserName!)"
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}

extension ArtistOfferVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnStep2Play.setImage(UIImage(named:"audio-play.png"),for: .normal)
        btnStep3Play.setImage(UIImage(named:"audio-play.png"),for: .normal)
    }
}

extension ArtistOfferVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txfOffer{
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if newString.isEmpty{
                btnSend.setTitleColor(.lightGray, for: .normal)
                btnSend.isEnabled = false
                return true
            }
            else {
                btnSend.setTitleColor(.red, for: .normal)
                if btnSend.currentTitle == "Change"{
                    btnSend.setTitle("Send", for: .normal)
                }
                btnSend.isEnabled = true
                return true
            }
            // commented by ashitesh
//            if txfOffer.text!.count > 0{
//                btnSend.setTitleColor(.red, for: .normal)
//                if btnSend.currentTitle == "Change"{
//                    btnSend.setTitle("Send", for: .normal)
//                }
//                btnSend.isEnabled = true
//                return true
//            }else{
//                btnSend.setTitleColor(.lightGray, for: .normal)
//                btnSend.isEnabled = false
//                return true
//            }
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
