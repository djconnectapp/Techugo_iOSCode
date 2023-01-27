//
//  DJSongReviewsVC.swift
//  DJConnect
//
//  Created by mac on 05/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import AlamofireObjectMapper
import MobileCoreServices

import AVKit
import AVFoundation
import MediaPlayer



//public protocol VideoPickerDelegate: AnyObject {
//    func didSelect(url: URL?)
//}

class DJSongReviewsVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, AVPlayerViewControllerDelegate {
    

    //MARK: - OUTLETS
    @IBOutlet weak var lblStep1ofStep4: UILabel!
    @IBOutlet weak var vwStep1: UIView!
    @IBOutlet weak var vwPaymentComplete: UIView!
    @IBOutlet weak var lblStep2ofStep4: UILabel!
    @IBOutlet weak var vwAddAudio: UIView!
    @IBOutlet weak var vwAudioAdded: UIView!
    @IBOutlet weak var lblStep3ofStep4: UILabel!
    @IBOutlet weak var txfSongName: textFieldProperties!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongBy: UILabel!
    @IBOutlet weak var lblSongGenre: UILabel!
    @IBOutlet weak var btnBackStep2: UIButton!
    @IBOutlet weak var btnSubmitStep2: UIButton!
    @IBOutlet weak var lblVerticalDivider: UILabel!
    @IBOutlet weak var lblNotifyDetail: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var lblClickDetail: UILabel!
    @IBOutlet weak var lblLiveReview: UILabel!
    @IBOutlet weak var lblUploadVideoReview: UILabel!
    @IBOutlet weak var lblStep4ofStep4: UILabel!
    @IBOutlet weak var lblComplete: UILabel!
    @IBOutlet weak var lblCompleteDetail: UILabel!
    @IBOutlet weak var btnAddAudio: UIButton!
    @IBOutlet weak var AudioSlider: UISlider!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var imgProfileImage: imageProperties!
    @IBOutlet weak var lblByDj: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblReviewCost: UILabel!
    @IBOutlet weak var imgArstistProfile: imageProperties!
    @IBOutlet weak var vwStep3: UIView!
    @IBOutlet weak var vwStep4: UIView!
    @IBOutlet weak var lblStep3SongName: UILabel!
    @IBOutlet weak var lblStep3SongBy: UILabel!
    @IBOutlet weak var lblStep3Genre: UILabel!
    @IBOutlet weak var lblStep3MinTime: UILabel!
    @IBOutlet weak var lblStep3MaxTime: UILabel!
    @IBOutlet weak var sliderStep3: UISlider!
    @IBOutlet weak var btnPlayStep3: UIButton!
    @IBOutlet weak var lblStep4SongName: UILabel!
    @IBOutlet weak var lblStep4SongBy: UILabel!
    @IBOutlet weak var lblStep4SongGenre: UILabel!
    @IBOutlet weak var btnPlayStep4: UIButton!
    @IBOutlet weak var lblStep4MinTime: UILabel!
    @IBOutlet weak var sliderStep4: UISlider!
    @IBOutlet weak var lblStep4MaxTime: UILabel!
    @IBOutlet weak var imgMusicUserStep4: imageProperties!
    @IBOutlet weak var imgMusicUserStep3: imageProperties!
    @IBOutlet weak var btnLiveVerify: UIButton!
    @IBOutlet weak var btnUploadVideo: UIButton!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var lblStep4RemainingTime: UILabel!
    @IBOutlet weak var btnStep3Email: UIButton!
    @IBOutlet weak var lblStep3Email: UILabel!
    @IBOutlet weak var imgStep3Email: UIImageView!
    
    
    @IBOutlet weak var cnsVwAddAudioLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsVwAddedAudioLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsVwStep3Leading: NSLayoutConstraint!
    @IBOutlet weak var cnsVwStep4Leading: NSLayoutConstraint!
    
    @IBOutlet weak var lblProjectPrice: UILabel!
    @IBOutlet weak var lblTransacFee: UILabel!
    @IBOutlet weak var lblTotalProjectPrice: UILabel!
    
    //localize outlet
    @IBOutlet weak var lblLo_ProjPrice: UILabel!
    @IBOutlet weak var lblLo_TransFee: UILabel!
    @IBOutlet weak var lblLo_TotalPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var lblLo_AddSub: UILabel!
    @IBOutlet weak var lblLo_ReviewAck: UILabel!
    @IBOutlet weak var lblLo_AddedSub: UILabel!
    @IBOutlet weak var lblLo_Step3AddedSub: UILabel!
    @IBOutlet weak var lblLo_DjNotification: UILabel!
    @IBOutlet weak var lblLo_Step4Sub: UILabel!
    @IBOutlet weak var lblLo_Step4Ack: UILabel!
    

    @IBOutlet weak var btnSongDownload: UIButton!
    
    
    @IBOutlet weak var sendSongBgVw: UIView!
    
    @IBOutlet weak var songEmailVw: UIView!
    
    @IBOutlet weak var sentSongEmailTxtFld: UITextField!
    
    @IBOutlet weak var sendSongtoEmailBtn: UIButton!
    
    var imagePickerController = UIImagePickerController()
    var videoURL : NSURL?
    
    @IBOutlet weak var videoPlayBtn: UIButton!
    
    var viewVidioPlayer = UIView()
    var verifyVideoStatus: Bool?

   // @IBOutlet weak var viewVidioPlayer: UIView!
    
    //MARK: - ENUM
    enum uploadType: String{
        case audioFile
        case videoFile
    }
    
    //MARK: - GLOBAL VARIABLES
    var songData = NSData()
    var videoData = NSData()
    var minuteString = String()
    var secondString = String()
    var audioPlayer: AVAudioPlayer?
    var apiSongData = String()
    var djId = String()
    var projBy = String()
    var connectCost = String()
    var userProfile = UIImage()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var remainingTime = String()
    var currentCurrency = String()
    var songReviewID = String()
    var isSongReviewAlert = false
    var artist_id = String()
    var broadCast = String()
    var songReviewIdStr = Int()
    var picker: UIImagePickerController = UIImagePickerController()
    var selectFileType = uploadType.audioFile
    var isFromNotification = false
    
    var getVideoStatusStr = String()
    var setTotalPr = String()
    
    
    @IBOutlet weak var progressVw: UIView!
    @IBOutlet weak var prgressVwBar: UIProgressView!
    @IBOutlet weak var prgrsPrcntgLbl: UILabel!
    
    var minValue = 0
    var maxValue = 100
    var downloader = Timer()
    
    var songUrl = String()
    
    var videoUrlStr = String()
    var resourceURI = String()
    var broadCastID = ""
    var addSongUrl = String()
    
    var projectIdStr = String()
    var getAlertId = String()
    var videoid = ""
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCYLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("getVideoStatusStr11:", getVideoStatusStr)
        self.progressVw.isHidden = true
        
        btnConfirm.layer.cornerRadius = btnConfirm.frame.size.height/2
        btnConfirm.clipsToBounds = true
        txfSongName.layer.cornerRadius = 5
        txfSongName.clipsToBounds = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        sendSongBgVw.isHidden = true
       // sendSongtoEmailBtn.isUserInteractionEnabled = false
    
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        sendSongBgVw.addGestureRecognizer(tap1)
        sendSongBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        songEmailVw.layer.cornerRadius = 10;
        songEmailVw.layer.masksToBounds = true;
        sendSongtoEmailBtn.layer.cornerRadius = 5;
        sendSongtoEmailBtn.layer.masksToBounds = true;
        sentSongEmailTxtFld.delegate = self
        sentSongEmailTxtFld.text = UserModel.sharedInstance().email!
        sentSongEmailTxtFld.isUserInteractionEnabled = true
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        lblCurrentDate.text = "DATE : \(formatter.string(from: date))"
        self.lblByDj.text = "By ".localize + "\(self.projBy)"
        
        print("self.connectCost1:",self.connectCost)
        if(self.connectCost != ""){
        let formatterr = NumberFormatter()
        formatterr.groupingSeparator = "," // or possibly "." / ","
        formatterr.numberStyle = .decimal
//        formatterr.string(from: Int(self.connectCost)! as NSNumber)
//        let string5 = formatterr.string(from: Int(self.connectCost)! as NSNumber)
           // self.lblReviewCost.text = "COST :" + "\(self.currentCurrency)" + string5!
            self.lblReviewCost.text = "COST :" + " \(self.currentCurrency)\(self.connectCost)"
        }
        //self.lblReviewCost.text = "COST :" + " \(self.currentCurrency)\(self.connectCost)"
        
        
       // self.imgProfileImage.image = self.userProfile // <UIImage:0x600001402fd0 anonymous {0, 0}>
        
        self.imgProfileImage.image = UIImage(named: "user-profile")
        localizeElements()
        self.AudioSlider.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        self.sliderStep3.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        self.sliderStep4.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        vwAddAudio.isHidden = true
        vwAudioAdded.isHidden = true
        vwStep3.isHidden = true
        vwStep4.isHidden = true
        cnsVwAddAudioLeading.constant = self.view.frame.size.width
        cnsVwAddedAudioLeading.constant = self.view.frame.size.width
        cnsVwStep3Leading.constant = self.view.frame.size.width
        cnsVwStep4Leading.constant = self.view.frame.size.width
        if UserModel.sharedInstance().userType == "DJ"{
            callDjGetSongReviewDataWebService()
        }else{
            callGetSongReviewDataWebService()
        }
    }
    
    
    //MARK: - ACTIONS
    @IBAction func btnBackAction(_ sender: UIButton) {
        if isSongReviewAlert == true{
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            sideMenuController()?.setContentViewController(next1!)
        }else if isFromNotification == true{
            backNotificationView()
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnBackStep2(_ sender: UIButton) {
        vwAudioAdded.isHidden = true
        vwAddAudio.isHidden = false
        txfSongName.text?.removeAll()
    }
    
    func showDownload(){
        downloader = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(DJSongReviewsVC.updater)), userInfo: nil, repeats: true)
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
            
            callAddSongReviewWebservice()
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        lblStep1ofStep4.text = "dropstep3of4".localize
        
        self.progressVw.isHidden = false
        showDownload()
        print("upload")
//        callAddSongReviewWebservice() // ashitesh to show new progres vw
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        if audioPlayer != nil{
            if sender.currentImage == UIImage(named: "audio_pause"){
                audioPlayer?.pause()
                sender.setImage(UIImage(named: "audio-play"), for: .normal)
                
            }else{
                audioPlayer?.play()
                _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
                sender.setImage(UIImage(named: "audio_pause"), for: .normal)
            }
        }else{
            self.preparePlayer(URL(string: apiSongData))
        }
    }
    
    @IBAction func btnLiveVerifyAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "VideoVerifyVC") as! VideoVerifyVC
        vc1.artist_id = artist_id
        vc1.media_Id = songReviewID
        vc1.liveType = "review"
        vc1.project_id = "null"
        navigationController?.pushViewController(vc1, animated: false)
    }
    
    @IBAction func btnUploadReviewAction(_ sender: UIButton) {
        selectFileType = .videoFile
        print("open picker")

//        let documentPicker = UIDocumentPickerViewController(documentTypes: [ "public.m4a","public.mp3", "public.wav","public.audio","public.MPEG-4","public.mp4","public.movie","public.qt"], in: .import)
        
        imagePickerController.sourceType = .photoLibrary
          imagePickerController.delegate = self
//          imagePickerController.mediaTypes = ["public.movie"]
        imagePickerController.mediaTypes = ["public.m4a","public.wav","public.MPEG-4","public.mp4","public.movie","public.qt"]

        present(imagePickerController, animated: true, completion: nil)

    }
        
    @IBAction func btnReviewCompleteAction(_ sender: UIButton) {
        globalObjects.shared.reviewConnect = true
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
    
    @IBAction func btnAddAudioAction(_ sender: UIButton) {
        selectFileType = .audioFile
        if txfSongName.text?.isEmpty == false{
            txfSongName.resignFirstResponder()
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio","public.MPEG-4"], in: .import)
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }else{
            txfSongName.resignFirstResponder()
            self.view.makeToast("Please Enter Song Name")
        }
    }
    
    @IBAction func btnSliderAction(_ sender: UISlider) {
        if self.vwStep3.isHidden == false{
            audioPlayer?.currentTime = TimeInterval(sliderStep3.value)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }else if self.vwStep4.isHidden == false{
            audioPlayer?.currentTime = TimeInterval(sliderStep4.value)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }else{
            audioPlayer?.currentTime = TimeInterval(AudioSlider.value)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
    }
    
    @IBAction func btnStep3PlayAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnConfirm_Action(_ sender: UIButton) {
        vwStep1.isHidden = true
        lblStep1ofStep4.text = "dropstep2of4".localize
        btnAddAudio.isEnabled = true
        txfSongName.isEnabled = true
        vwAddAudio.isHidden = false
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.cnsVwAddAudioLeading.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in
            
        }
    }
    
    @IBAction func btnStep3Email_Action(_ sender: UIButton) {
       // callEmailSongWebservice(songId: songReviewID)
        self.sendSongBgVw.isHidden = false
        self.songEmailVw.isHidden = false
        //sendSongtoEmailBtn.isUserInteractionEnabled = true
        
    }
    
    @IBAction func sendSongToEmailBtnTapped(_ sender: Any) {
        
        if sentSongEmailTxtFld.text == ""{
            self.view.makeToast("Please Enter Email Address".localize)
        }else if !validateEmail(email: sentSongEmailTxtFld.text!){
            self.view.makeToast("Please Enter Valid Email Address".localize)
        }
        else{
        self.calldjSendMailAPI()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.sendSongBgVw.isHidden = true
        self.songEmailVw.isHidden = true
       // self.sendSongtoEmailBtn.isUserInteractionEnabled = false
    }
    
    @IBAction func btnSngDownloadTapped(_ sender: Any) {
        
        self.shareLink()
        //self.callDownloadSongWebservice()
    }
    
    func shareLink(){
        let urlData = NSData(contentsOf: URL(string:"\(songUrl)")!)
        
//        if ((urlData) != nil){
//            let date = Date()
//            let format = DateFormatter()
//            format.dateFormat = "yyyyMMdd_HHmmss"
//            let timestamp = format.string(from: date)
//
//            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//            let docDirectory = paths[0]
//            let filePath = "\(docDirectory)/Audio_\(timestamp).mp3"
//            urlData?.write(toFile: filePath, atomically: true)
//            // file saved
//            let videoLink = NSURL(fileURLWithPath: filePath)
//
//            let objectsToShare = [videoLink] //comment!, imageData!, myWebsite!]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            self.present(activityVC, animated: true, completion: nil)
//        }
        
        if let name = URL(string: "\(songUrl)"), !name.absoluteString.isEmpty {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
          // show alert for not available
        }
    }
    
    @IBAction func videoPlayBtnTapped(_ sender: Any) {

//        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
//        let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as? ArtistBambUserPlayerVC
//        next1?.getVideoRlSTr = videoUrlStr
//        next1?.screenType = "DjSongReviewsVC"
//        navigationController?.pushViewController(next1!, animated: false)
        
        callVideoVerifyWebservice()
        
//        let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
//        let next1 = storyBoard.instantiateViewController(withIdentifier: "UploadVideoViewController") as? UploadVideoViewController
//        next1?.getVideoRlSTr = videoUrlStr
//        next1?.screenType = "DjSongReviewsVC"
//        navigationController?.pushViewController(next1!, animated: false)
        
    }
    
    func callVideoVerifyWebservice(){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audioid":"0",
                "dj_id":djId,
                "type":"review"
            ]
            print("videoVerifyArtistSideReview",parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.videoVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let videoVerifyModel = response.result.value!
                  
                        let videoURL = URL(string: self.videoUrlStr)
//                        let player = AVPlayer(url: videoURL!)
//                        let playerViewController = AVPlayerViewController()
//                        playerViewController.player = player
//                        self.present(playerViewController, animated: true) {
//                            playerViewController.player!.play()
//                        }
                
                    // custom screen to show video - inprogress
                        let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "UploadVideoViewController") as? UploadVideoViewController
                    next1?.getVideoRlSTr = self.videoUrlStr
                        next1?.screenType = "DjSongReviewsVC"
                    
                    next1?.getVideoStatusStr = self.getVideoStatusStr
                    next1?.getSenderId = self.djId
                    next1?.getAlertId = self.getAlertId
                    next1?.videoid = self.videoid
                    
                    self.navigationController?.pushViewController(next1!, animated: false)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    
    func callDownloadSongWebservice(){
        
        if let audioUrl = URL(string: songUrl) {

            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)

//            // to check if it exists before downloading it
//            if FileManager.default.fileExists(atPath: destinationUrl.path) {
//                print("The file already exists at path")
//                //self.view.makeToast("The file already exists at path")
//
//                // if the file doesn't exist
//            }
//            else {

                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl) { location, response, error in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                        //self.view.makeToast("File moved to documents folder")
                    } catch {
                        print(error)
                    }
                }.resume()
           // }
        }
        
        self.view.makeToast("File moved to documents folder")

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
            if self.vwStep3.isHidden == false{
                lblStep3MinTime.text = String(self.AudioSlider.value)
                lblStep3MaxTime.text = "\(minuteString):\(secondString)"
                self.sliderStep3.maximumValue = Float(Double(self.audioPlayer!.duration))
                self.audioPlayer?.currentTime = Double(self.sliderStep3.value)
            }else if self.vwStep4.isHidden == false{
                lblStep4MinTime.text = String(self.AudioSlider.value)
                lblStep4MaxTime.text = "\(minuteString):\(secondString)"
                self.sliderStep4.maximumValue = Float(Double(self.audioPlayer!.duration))
                self.audioPlayer?.currentTime = Double(self.sliderStep4.value)
            }else{
                lblMinTime.text = String(self.AudioSlider.value)
                lblMaxTime.text = "\(minuteString):\(secondString)"
                self.AudioSlider.maximumValue = Float(Double(self.audioPlayer!.duration))
                self.audioPlayer?.currentTime = Double(self.AudioSlider.value)
            }
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
    
    func setStep2Complete(){
        lblStep2ofStep4.textColor = .black
        lblStep3ofStep4.textColor = UIColor.black
        lblNotifyDetail.textColor = UIColor.black
        vwAddAudio.isHidden = true
        vwAudioAdded.isHidden = false
        vwPaymentComplete.isHidden = false
        vwStep1.isHidden = true
        btnSubmitStep2.isHidden = true
        lblVerticalDivider.isHidden = true
        btnBackStep2.isHidden = true
        btnAddAudio.isEnabled = false
        txfSongName.isEnabled = false
        lblRemainingTime.isHidden = false
    }
    
    func localizeElements(){
        lblStep1ofStep4.text = "dropstep1of4".localize
        lblLo_ProjPrice.text = "Project Price: ".localize
        lblLo_TransFee.text = "Transaction Fee:".localize
        lblLo_TotalPrice.text = "Total:".localize
        lblLo_AddSub.text = "Song Submission".localize
        lblLo_ReviewAck.text = "Song_Review_Ack".localize
        btnConfirm.setTitle("Confirm".localize, for: .normal)
        btnSubmitStep2.setTitle("SUBMIT".localize, for: .normal)
        btnBackStep2.setTitle("BACK".localize, for: .normal)
        lblLo_AddedSub.text = "Song Submission".localize
        lblLo_Step3AddedSub.text = "Song Submission".localize
        lblLo_DjNotification.text = "DJ Notification".localize
        lblNotifyDetail.text = "SongReview_Time".localize
        lblClickDetail.text = "SongReview_Email".localize
        lblLiveReview.text = "SongReview_Live".localize
        lblUploadVideoReview.text = "SongReview_Video".localize
        lblLo_Step4Sub.text = "Song Submission".localize
        lblComplete.text = "COMPLETE".localize
        lblLo_Step4Ack.text = "SongReview_Time".localize
        lblCompleteDetail.text = "SongReview_Done".localize
        lblOr.text = "".localize
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSongReviewVideoVerify" {
            let destinationVC = segue.destination as! SongReviewVideoVerifyVC
            destinationVC.artist_id = artist_id
            destinationVC.media_Id = songReviewID
        }
        
    }
    
    //MARK: - SELECTOR METHODS
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        if self.vwStep3.isHidden == false{
            lblStep3MaxTime.text = "\(remMin):\(remSec)"
            lblStep3MinTime.text = "\(minCurrent):\(secCurrent)"
            sliderStep3.value = Float(Double((audioPlayer?.currentTime)!))
        }else if self.vwStep4.isHidden == false{
            lblStep4MaxTime.text = "\(remMin):\(remSec)"
            lblStep4MinTime.text = "\(minCurrent):\(secCurrent)"
            sliderStep4.value = Float(Double((audioPlayer?.currentTime)!))
        }else{
            lblMaxTime.text = "\(remMin):\(remSec)"
            lblMinTime.text = "\(minCurrent):\(secCurrent)"
            AudioSlider.value = Float(Double((audioPlayer?.currentTime)!))
        }
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        
        if vwStep3.isHidden == false{
            self.lblRemainingTime.text = countdown
        }else{
            self.lblStep4RemainingTime.text = countdown
        }
    }
    
    
    //MARK: - WEBSERVICES
    
    func callAddSongReviewWebservice(){
        if getReachabilityStatus(){
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "dj_id":"\(djId)",
                "audio_title":"\(txfSongName.text!)",
                //"audio_file":"\(addSongUrl)",
                "song_cost":"\(setTotalPr)",
                "is_offer":"",
                "cost":"",
                "offer_cost":"",
               // "audio_file":"\(songData)"
            ]
            print("parametersAddSong", parameters)
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addSongAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
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
                    upload.responseObject(completionHandler: { (response:DataResponse<DSongReviewModel>) in
                        switch response.result {
                        case .success(_):
                            Loader.shared.hide()
                            CommonFunctions.shared.hideLoader()
                            let addMediaProfile = response.result.value!
                            if addMediaProfile.success == 1{
                                self.view.makeToast(addMediaProfile.message)
                                self.apiSongData = (addMediaProfile.audio_data?.audio_file)!
                                print(self.apiSongData)
                                self.btnBackStep2.isHidden = true
                                self.btnSubmitStep2.isHidden = true
                                self.btnSongDownload.isHidden = true
                                self.lblVerticalDivider.isHidden = true
                                self.lblStep3MinTime.text = "00:00"
                                self.lblStep3MaxTime.text = self.minuteString + ":" + self.secondString
                                self.lblStep3SongName.text = "\(self.txfSongName.text!)"
                                self.lblStep3SongBy.text = "By ".localize + UserModel.sharedInstance().uniqueUserName!
                                self.lblStep3Genre.text = "\(UserModel.sharedInstance().genereList!)"
                                self.lblNotifyDetail.textColor = UIColor.black
                                self.lblRemainingTime.isHidden = false
                                self.vwAudioAdded.isHidden = true
                                self.vwStep3.isHidden = false
                                self.btnLiveVerify.isHidden = true
                                self.btnUploadVideo.isHidden = true
                                self.lblLiveReview.isHidden = true
                                self.lblUploadVideoReview.isHidden = true
                                self.lblOr.isHidden = true
                                self.lblClickDetail.isHidden = true
                                self.preparePlayer(URL(string: (addMediaProfile.audio_data!.audio_file!)))
                                self.view.layoutIfNeeded()
                                
                                UIView.animate(withDuration: 1.0, animations: {
                                    self.cnsVwStep3Leading.constant = 0
                                    self.view.layoutIfNeeded()
                                }) { (completion) in
                                    
                                }
                                self.remainingTime = (addMediaProfile.audio_data?.closing_time!)!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }else{
                                Loader.shared.hide()
                                CommonFunctions.shared.hideLoader()
                                self.view.makeToast(addMediaProfile.message)
                            }
                            
                        case .failure(let error):
                            Loader.shared.hide()
                            CommonFunctions.shared.hideLoader()
                            debugPrint(error)
                            print("Error")
                        }
                        
                    })
                case .failure(let error):
                    Loader.shared.hide()
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
    func callGetSongReviewDataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
           
            
            var url = String()
            
            if(songReviewIdStr != 0 || songReviewIdStr != nil){
                url = "\(webservice.url)\(webservice.getSongReviewStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(djId)&apply_user_id=\(UserModel.sharedInstance().userId!)&song_review_id=\(songReviewIdStr)"
            }
                else{
                    
                    url = "\(webservice.url)\(webservice.getSongReviewStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(djId)&apply_user_id=\(UserModel.sharedInstance().userId!)"
                }
            
            Alamofire.request(getServiceURL(url), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjSongReviewStepModel>) in
            
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let getData = response.result.value!
                    if getData.success == 1{
                        self.songReviewID = "\(getData.song_review_id!)"
                        self.lblByDj.text = "by \(getData.step2!.dj_name!)"
                        
                        let formatterr = NumberFormatter()
                        formatterr.groupingSeparator = "," // or possibly "." / ","
                        formatterr.numberStyle = .decimal
//                        formatterr.string(from: Int(getData.step2!.song_review_cost!)! as NSNumber)
//                        let string5 = formatterr.string(from: Int(getData.step2!.song_review_cost!)! as NSNumber)
//
//                        self.lblReviewCost.text = "COST : " + "\(self.currentCurrency)" + string5!
                        self.lblReviewCost.text = "COST : \(self.currentCurrency)\(getData.step2!.song_review_cost!)"
                        
                        if let userProfileUrl = URL(string : getData.step2!.dj_pic!){
                            self.imgProfileImage.kf.setImage(with: userProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        }else{
                            self.imgProfileImage.image = UIImage(named: "user-profile")
                        }
                        
                        if getData.step2!.step2_status! == "1"{
                            self.vwStep3.isHidden = false
                            self.cnsVwStep3Leading.constant = 0
                            self.vwStep1.isHidden = true
                            self.lblStep1ofStep4.text = "dropstep3of4".localize
                            self.lblStep3SongName.text = getData.step2!.audio_name!
                            self.lblStep3SongBy.text = "by \(getData.step2!.artist_name!)"
                            self.lblStep3Genre.text = getData.step2!.artist_genre!
                            let musicProfileUrl = URL(string : getData.step2!.artist_pic ?? "")
                            self.imgMusicUserStep3.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            self.btnLiveVerify.isHidden = true
                            self.btnSongDownload.isHidden = true
                            self.btnUploadVideo.isHidden = true
                            self.lblLiveReview.isHidden = true
                            self.lblUploadVideoReview.isHidden = true
                            self.lblRemainingTime.isHidden = false
                            self.lblOr.isHidden = true
                            self.lblClickDetail.isHidden = true
                            self.apiSongData = getData.step2!.audio_file ?? ""
                            self.preparePlayer(URL(string: self.apiSongData))
                            if getData.step3!.step3_status! == "1"{
                                if getData.step3!.is_video == "1"{
                                    self.vwStep4.isHidden = false
                                    self.vwStep3.isHidden = true
                                    self.cnsVwStep4Leading.constant = 0
                                    self.vwStep1.isHidden = true
                                    self.lblStep1ofStep4.text = "dropstep4of4".localize
                                    self.lblStep4SongName.text = getData.step2!.audio_name!
                                    self.lblStep4SongBy.text = "by \(getData.step2!.artist_name!)"
                                    self.lblStep4SongGenre.text = getData.step2!.artist_genre!
                                    let musicProfileUrl = URL(string : getData.step2!.artist_pic ?? "")
                                    self.imgMusicUserStep4.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                                    self.preparePlayer(URL(string: getData.step2!.audio_file!))
                                    self.videoUrlStr = getData.step2!.video_file ?? ""
                                }
//                                if getData.step3!.remaining_time!.contains("00:00:00") {
//                                    self.vwStep1.isHidden = false
//                                    self.vwStep3.isHidden = true
//                                    self.vwStep4.isHidden = true
//                                    self.callStep1DataWebService()
//                                }else{
//                                    self.remainingTime = getData.step3!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
//                                    self.startTimer()
//                                }
                            }
                        }else{
                           // self.vwStep1.isHidden = false
                            self.callStep1DataWebService()
                        }
                    }else{
                        //self.vwStep1.isHidden = false
                        self.callStep1DataWebService()
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
    
    // dj flow
    func callDjGetSongReviewDataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            print("songReviewStepApi:", Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getSongReviewStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(UserModel.sharedInstance().userId!)&apply_user_id=\(artist_id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil))
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getSongReviewStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(UserModel.sharedInstance().userId!)&apply_user_id=\(artist_id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjSongReviewStepModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let getData = response.result.value!
                    if getData.success == 1{
                        self.songReviewID = "\(getData.song_review_id!)"
                        if getData.step2!.step2_status! == "1"{
                            self.lblByDj.text = "by \(getData.step2!.dj_name!)"
                            self.lblReviewCost.text = "COST : \(UserModel.sharedInstance().userCurrency!)\(getData.step2!.song_review_cost ?? "")"
                            let userProfileUrl = URL(string : getData.step2!.dj_pic ?? "")
                            if userProfileUrl != nil{
                            self.imgProfileImage.kf.setImage(with: userProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }else{
                                self.imgProfileImage.setImage(UIImage(named: "user-profile")!)
                            }
                            self.vwStep3.isHidden = false
                            self.cnsVwStep3Leading.constant = 0
                            self.vwStep1.isHidden = true
                            self.lblStep1ofStep4.text = "dropstep3of4".localize
                            self.lblStep3SongName.text = getData.step2!.audio_name!
                            self.lblStep3SongBy.text = "By ".localize + "\(getData.step2!.artist_name!)"
                            self.lblStep3Genre.text = getData.step2!.artist_genre!
                            let musicProfileUrl = URL(string : getData.step2!.artist_pic ?? "")
                            self.imgMusicUserStep3.kf.setImage(with: musicProfileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            self.btnStep3Email.isEnabled = true
                            self.imgStep3Email.isHidden = false
                            self.lblStep3Email.isHidden = false
                            self.btnLiveVerify.isHidden = false
                            self.btnUploadVideo.isHidden = false
                            self.lblLiveReview.isHidden = false
                            self.lblLo_DjNotification.text = ""
                            self.lblNotifyDetail.text = "Email or download the song directly to your phone. Click the LIVE button to stream your review or click the Upload button to attach it directly from your phone."
                            self.lblUploadVideoReview.isHidden = false
                            self.lblRemainingTime.isHidden = false
                            self.lblOr.isHidden = false
                            self.lblClickDetail.isHidden = false
                            self.preparePlayer(URL(string: getData.step2!.audio_file!))
                            print("songurl",getData.step2!.audio_file!)
                            self.songUrl = getData.step2!.audio_file!
                            
                        }else{
                            self.callStep1DataWebService()
                        }
                        if getData.step3!.step3_status! == "1"{
                            if getData.step3!.remaining_time!.contains("00:00:00") {
                                self.lblRemainingTime.text = "TIME EXPIRED".localize
                            }else{
                                self.remainingTime = getData.step3!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }
                        }
//                        if getData.step3!.is_video == "1"{
//                            self.btnLiveVerify.isEnabled = false
//                            self.btnUploadVideo.isEnabled = false
//                        } comented by ashitesh
                        self.vwStep1.isHidden = true
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
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id=&dj_id=\(djId)&type=songreview&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let step1Model = response.result.value!
                    if step1Model.success == 1{
                        if(self.addSongUrl != ""){
                            self.lblStep1ofStep4.text = "dropstep2of4".localize
                            self.vwStep1.isHidden = true
                            self.vwAddAudio.isHidden = true
                            self.vwAudioAdded.isHidden = false
                        }
                        else{
                            self.vwStep1.isHidden = false
                            self.lblStep1ofStep4.text = "dropstep1of4".localize
                        }
                        
                        
                        let formatterr = NumberFormatter()
                        formatterr.groupingSeparator = "," // or possibly "." / ","
                        formatterr.numberStyle = .decimal
                        
                        
                        
                        if let price = step1Model.result!.project_price{
//                            formatterr.string(from: Int(price)! as NSNumber)
//                            let string5 = formatterr.string(from: Int(price)! as NSNumber)
//                            self.lblProjectPrice.text =  "  " + self.currentCurrency + string5!
                            self.lblProjectPrice.text =  "  " + self.currentCurrency + price
                        }
                        if let transPrice = step1Model.result!.transaction_fees{
//                            formatterr.string(from: Int(transPrice)! as NSNumber)
//                            let string5 = formatterr.string(from: Int(transPrice)! as NSNumber)
//                            self.lblTransacFee.text =  "  " + self.currentCurrency + string5!
                            self.lblTransacFee.text =  "  " + self.currentCurrency + transPrice
                        }
                        
                        self.setTotalPr = step1Model.result!.total_price!
                        if let totAmount = step1Model.result!.total_price{
//                            formatterr.string(from: Int(totAmount)! as NSNumber)
//                            let string5 = formatterr.string(from: Int(totAmount)! as NSNumber)
//                            self.lblTotalProjectPrice.text =  "  " + self.currentCurrency + string5!
                            self.lblTotalProjectPrice.text =  "  " + self.currentCurrency + totAmount
                        }
                        
                        let formatter13 = NumberFormatter()
                        formatter13.groupingSeparator = "," // or possibly "." / ","
                        formatter13.numberStyle = .decimal
//                        formatter13.string(from: Int(self.setTotalPr) as! NSNumber)
//                        let string5 = formatterr.string(from: Int(self.setTotalPr) as! NSNumber)
//                            self.lblReviewCost.text = "COST : " + "\(self.currentCurrency)" + string5!
                        self.lblReviewCost.text = "COST : " + "\(self.currentCurrency)" + "\(self.setTotalPr)"
                            
                        
                        
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
    
    func callAddVideoReviewWebservice(fileName: String){
        
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "song_review_id":"\(songReviewID)",
                "video_name":"\(fileName)"
            ]
            print("addVideo parameter",parameters)
            Loader.shared.show()
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addVideo)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    multipartFormData.append(self.videoData as Data, withName: "video_file", fileName: "audio.mp4", mimeType: "audio/mp4")
                }
            }, to: serviceURL) { (result) in
                switch result {
                case .success(let upload,_,_):
                    print("multipart",(self.videoData as Data, withName: "video_file", fileName: "audio.mp4", mimeType: "audio/mp4"))
//                    upload.uploadProgress(closure: { (progress) in
//                        CommonFunctions.shared.showProgress(progress: CGFloat(progress.fractionCompleted))
//                    })
                    upload.responseObject(completionHandler: { (response:DataResponse<FinishProfileModel>) in
                        switch response.result {
                        case .success(_):
                            Loader.shared.hide()
                            CommonFunctions.shared.hideLoader()
                            let addMediaProfile = response.result.value!
                            if addMediaProfile.success == 1{
                                self.view.makeToast(addMediaProfile.message)
                                self.showAlertView("your video has been uploaded successfully.","Success!!")
                                self.btnLiveVerify.isEnabled = false
                                self.btnUploadVideo.isEnabled = false
                            }else{
                                CommonFunctions.shared.hideLoader()
                                self.view.makeToast(addMediaProfile.message)
                            }
                            
                        case .failure(let error):
                            CommonFunctions.shared.hideLoader()
                            debugPrint(error)
                            print("Error")
                        }
                        
                    })
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
    
    func callEmailSongWebservice(songId : String){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "audioid":"\(songId)",
                "type":"song_review"
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
    
    func calldjSendMailAPI(){
        if getReachabilityStatus(){
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "email":sentSongEmailTxtFld.text!,
                "audio_url":"\(songUrl)",
            ]
            print("parameters",parameters)
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.djSendMailAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let sentMailModel = response.result.value!
                    if sentMailModel.success == 1{
                        self.sendSongBgVw.isHidden = true
                        self.songEmailVw.isHidden = true
//                        self.view.makeToast(sentMailModel.message)
                        self.view.makeToast("Audio sent to the mail")
                    }else{
                        self.sendSongBgVw.isHidden = true
                        self.songEmailVw.isHidden = true
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
}
//MARK: - EXTENSIONS
extension DJSongReviewsVC: UIDocumentPickerDelegate, UINavigationControllerDelegate{
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        print("info",info)
        let videoURLl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
    print("mediaURL",videoURLl)


        imagePickerController.dismiss(animated: true, completion: nil)


          videoData = try! Data(contentsOf: videoURLl as! URL) as NSData
          var filename = videoURLl?.lastPathComponent
          filename = filename?.description.replacingOccurrences(of: " ", with: "")
          print("filename",filename)
        
        
        //self.callAddVideoReviewWebservice(fileName: urlString)
              self.callAddVideoReviewWebservice(fileName: filename!)
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        if selectFileType == .audioFile{
            let data = try! Data(contentsOf: url)
            print(data.count)
            if data.count > 26214400{
                self.view.makeToast("You are not allowed to upload a file of size more than 25 MB.")
            }else{
                vwAddAudio.isHidden = true
                vwAudioAdded.isHidden = false
                lblStep1ofStep4.text = "dropstep2of4".localize //1 ashitesh
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: 1.0, animations: {
                    self.cnsVwAddedAudioLeading.constant = 0
                    self.view.layoutIfNeeded()
                }) { (completion) in
                    
                }
                songData = try! Data(contentsOf: url) as NSData
                addSongUrl = url.absoluteString
                preparePlayer(url)
                lblSongName.text = txfSongName.text
                lblSongBy.text = "by \(UserModel.sharedInstance().uniqueUserName!)"
                lblSongGenre.text = UserModel.sharedInstance().genereList!
                let profileUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
                self.imgArstistProfile.kf.setImage(with: profileUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            }
        }else{
            videoData = try! Data(contentsOf: url) as NSData
            var filename = url.lastPathComponent
            filename = filename.description.replacingOccurrences(of: " ", with: "")
            self.showAlertView("Are you sure, you want to upload the video?.","Upload?", "OK", completionHandler: { (ACTION) in
                self.callAddVideoReviewWebservice(fileName: filename)
            })
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
      print("hello cancel")
        controller.dismiss(animated: true, completion: nil)
    }
    
}
extension DJSongReviewsVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlayStep3.setImage(UIImage(named:"audio-play.png"),for: .normal)
        btnPlay.setImage(UIImage(named:"audio-play.png"),for: .normal)
        btnPlayStep4.setImage(UIImage(named:"audio-play.png"),for: .normal)
    }
}



//extension DJSongReviewsVC: UINavigationControllerDelegate {
//
//}
