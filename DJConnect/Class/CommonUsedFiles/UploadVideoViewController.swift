//
//  UploadVideoViewController.swift
//  DJConnect
//
//  Created by Techugo on 02/11/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
//import MediaPlayer
//import MobileCoreServices

class UploadVideoViewController: UIViewController {
   // , AVPlayerViewControllerDelegate
    
    
    @IBOutlet weak var viewVidioPlayer: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var playPauseBtn: UIButton!
    
    
    @IBOutlet weak var curntTimeLbl: UILabel!
    @IBOutlet weak var durationTimeLbl: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    var screenType = String()
    var getVideoRlSTr = String()
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = false
    
    
    @IBOutlet weak var popUpBgVw: UIView!
    @IBOutlet weak var verifyPopUpVw: UIView!
    @IBOutlet weak var verifyTxtLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var disputeBtn: UIButton!
    
    var videoid = ""
    var uri = ""
    var getSenderId = ""
    
    var projectIdStr = String()
    var getAlertId = String()
    var shareBtnTap = String()
    var getVideoStatusStr = String()
    var getSenderIdStr = String()
    
    var shareToLink : String?
    
    var timer = Timer()
    var totalDuration = 0
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
    }
    
    @IBAction func verifyBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        callVideoVerifyWebservice(audioId: "\(videoid)")
    }
    
    @IBAction func disputeBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        callrejectProjectVerificationAPI()
    }
    
    func callVideoVerifyWebservice(audioId : String){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audioid":"0",
                "dj_id":getSenderId,
                "type":"request_review",
                "alert_id":"\(getAlertId)"
            ]
            print("videoVerifyArtistSideReview",parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.videoVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let videoVerifyModel = response.result.value!
                    if videoVerifyModel.success == 1{
                        self.view.makeToast(videoVerifyModel.message)
                    }
                    if(self.shareBtnTap == "share"){
                        if self.shareToLink != nil{
                            self.shareLink()
                        }else{
                           // self.getVideoINMp4(fromShare: true)
                        }
                    }
                    self.navigationController?.popViewController(animated: false)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callrejectProjectVerificationAPI(){
        
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "sender_id":"\(getSenderId)",
                "alert_id":"\(getAlertId)"
            ]
            
            
            print("uploadVideo-DisputeScreen",parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.rejectReviewVerificationAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let cancelVideoAfterVerify = response.result.value!
                    if cancelVideoAfterVerify.success == 1{
                        self.view.makeToast(cancelVideoAfterVerify.message)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//                            self.navigationController?.popViewController(animated: false)
//                        })
                        
                        let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
                        self.sideMenuController()?.setContentViewController(next1!)
                        
                        
//                        self.view.makeToast(cancelVideoAfterVerify.message)
//                        self.showToastt(message: "Toast Generated", font: .systemFont(ofSize: 12.0))
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast("something error")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("getSenderId::",getSenderId)
        shareBtnTap = ""
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapped(_:)))
        popUpBgVw.addGestureRecognizer(tap1)
        
        popUpBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        verifyPopUpVw.layer.cornerRadius = 10;
        verifyPopUpVw.layer.masksToBounds = true;

        print("getVideoRlSTr",getVideoRlSTr)
        

        playPauseBtn.setImage(UIImage(named: "pause"), for: .normal)
        let videoURL = URL(string: getVideoRlSTr)
        
        player = AVPlayer(url: videoURL!)
        
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        viewVidioPlayer.layer.addSublayer(playerLayer)
        
       // scheduledTimerWithTimeInterval()
                
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        playerLayer.frame = viewVidioPlayer.frame
    }
    
    @objc func handleTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.popUpBgVw.isHidden = true
        self.verifyPopUpVw.isHidden = true
    }
    
    func addTimeObserver(){
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.player.currentItem else {return}
            self?.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.timeSlider.minimumValue = 0
            self?.timeSlider.value = Float(currentItem.currentTime().seconds)
            self?.curntTimeLbl.text = self?.getTimeStr(from: currentItem.currentTime())
        })
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        shareBtnTap = "share"
        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
            verifyTxtLbl.text = ""
            self.popUpBgVw.isHidden = true
            self.verifyPopUpVw.isHidden = true
                    if getVideoRlSTr != ""{
                        shareLink()
                    }else{
                        //getVideoINMp4(fromShare: true)
                    }
        }
        else{
        verifyTxtLbl.text = "This function cannot be performed until you verify the video. Click to verify and complete this project."
        self.popUpBgVw.isHidden = false
        self.verifyPopUpVw.isHidden = false
        }
    }
    
    func shareLink(){
        let urlData = NSData(contentsOf: URL(string:"\(getVideoRlSTr)")!)
        
//        if ((urlData) != nil){
//            let date = Date()
//            let format = DateFormatter()
//            format.dateFormat = "yyyyMMdd_HHmmss"
//            let timestamp = format.string(from: date)
//            
//            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//            let docDirectory = paths[0]
//            let filePath = "\(docDirectory)/Video_\(timestamp).mp4"
//            urlData?.write(toFile: filePath, atomically: true)
//            // file saved
//            let videoLink = NSURL(fileURLWithPath: filePath)
//            
//            let objectsToShare = [videoLink] //comment!, imageData!, myWebsite!]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            self.present(activityVC, animated: true, completion: nil)
//        }
        
        if let name = URL(string: "\(getVideoRlSTr)"), !name.absoluteString.isEmpty {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
          // show alert for not available
        }
    }
    
    @IBAction func playPauseBtnTapped(_ sender: UIButton) {
        if isVideoPlaying{
            player.pause()
           // sender.setTitle("Play", for: .normal)
            sender.setImage(UIImage(named: "playSample"), for: .normal)
            
            if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
            verifyTxtLbl.text = ""
            self.popUpBgVw.isHidden = true
            self.verifyPopUpVw.isHidden = true
            }
            else{
                verifyTxtLbl.text = "Click to verify and complete this project."
                self.popUpBgVw.isHidden = false
                self.verifyPopUpVw.isHidden = false
            }
        }
        else{
            player.play()
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    @IBAction func sliderValueChnaged(_ sender: UISlider) {
        player.seek(to: CMTimeMake(value: Int64(sender.value*1000), timescale: 1000))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.5 {
            self.durationTimeLbl.text = getTimeStr(from: player.currentItem!.duration)
        }
    }
    
    func  getTimeStr(from time: CMTime) -> String {
        let totalSec = CMTimeGetSeconds(time)
        let hours = Int(totalSec/3600)
        let minutes = Int(totalSec/60) % 60
        let seconds = Int(totalSec.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }
        else{
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
        
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        let currentDuration = self.durationTimeLbl.text!
        let totalSeconds = Int(currentDuration)
        let seconds: Int = totalSeconds! % 60
        let minutes: Int = (totalSeconds! / 60) % 60
        curntTimeLbl.text = String(format: "%02d:%02d", minutes, seconds)
        timeSlider.value = Float(totalDuration)
    
    }
    
    
//    func videoPlay()
//        {
//            let playerController = AVPlayerViewController()
//            playerController.delegate = self
//
//            let bundle = Bundle.main
//            let moviePath: String? = getVideoRlSTr
//            let movieURL = URL(fileURLWithPath: moviePath!)
//
//            let player = AVPlayer(url: movieURL)
//            playerController.player = player
//        self.addChild(playerController)
//            self.view.addSubview(playerController.view)
//            playerController.view.frame = self.view.frame
//
//            player.play()
//
//        }
//
//    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController){
//            print("playerViewControllerWillStartPictureInPicture")
//        }
//
//        func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController)
//        {
//            print("playerViewControllerDidStartPictureInPicture")
//
//        }
//        func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error)
//        {
//            print("failedToStartPictureInPictureWithError")
//        }
//        func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController)
//        {
//            print("playerViewControllerWillStopPictureInPicture")
//        }
//        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController)
//        {
//            print("playerViewControllerDidStopPictureInPicture")
//        }
//        func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool
//        {
//            print("playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart")
//            return true
//        }
    
}
