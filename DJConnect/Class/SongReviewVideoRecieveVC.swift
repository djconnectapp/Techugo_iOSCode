//
//  SongReviewVideoRecieveVC.swift
//  DJConnect
//
//  Created by mac on 28/09/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class SongReviewVideoRecieveVC: UIViewController, BambuserPlayerDelegate {
    
    //MARK: -  OUTLETS
    @IBOutlet weak var btnBack: UIButton!
    
    //MARK: - GLOBAL VARIABLES
    var bambuserPlayer: BambuserPlayer
    var playButton: UIButton
    var pauseButton: UIButton
    var rewindButton: UIButton
    var isFromNotification = false
    
    var id = ""
    var uri = ""
    var broadCastID = ""
    var getSenderId = ""
    var getVideoRlSTr = String()
    var screenType = String()
    
    var projectIdStr = String()
    var getAlertId = String()
    var shareBtnTap = String()
    var getVideoStatusStr = String()
    var getSenderIdStr = String()
    
    @IBOutlet weak var shareBtn: UIButton!
    var shareToLink : String?
    
    @IBOutlet weak var popUpBgVw: UIView!
    @IBOutlet weak var verifyPopUpVw: UIView!
    @IBOutlet weak var verifyTxtLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var disputeBtn: UIButton!
    
    @IBAction func verifyBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        callVideoVerifyWebservice(audioId: "\(id)")
    }
    @IBAction func disputeBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        callrejectProjectVerificationAPI()
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
            
            
            print("disputeParameter123",parameters)
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
    @IBAction func closeBtnTapped(_ sender: Any) {
        
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        bambuserPlayer = BambuserPlayer()
        playButton = UIButton(type: UIButton.ButtonType.system)
        pauseButton = UIButton(type: UIButton.ButtonType.system)
        rewindButton = UIButton(type: UIButton.ButtonType.system)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("getSenderId::",getSenderId)
        shareBtnTap = ""
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        
       // self.view.bringSubviewToFront(popUpBgVw)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapped(_:)))
        popUpBgVw.addGestureRecognizer(tap1)
        
        popUpBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        verifyPopUpVw.layer.cornerRadius = 10;
        verifyPopUpVw.layer.masksToBounds = true;
        
        getVideoINMp4(fromShare: false)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try    AVAudioSession.sharedInstance().setActive(true)
        } catch {
        }
        
        bambuserPlayer.delegate = self
        bambuserPlayer.applicationId = "dbJx8NwoMFA0kCSbCjXAlQ"
        
        self.view.addSubview(bambuserPlayer)
        playButton.setTitle("Play", for: UIControl.State.normal)
        playButton.addTarget(bambuserPlayer, action: #selector(BambuserPlayer.playVideo as (BambuserPlayer) -> () -> Void), for: UIControl.Event.touchUpInside)
        self.view.addSubview(playButton)
        pauseButton.setTitle("Pause", for: UIControl.State.normal)
        pauseButton.addTarget(bambuserPlayer, action: #selector(BambuserPlayer.pauseVideo as (BambuserPlayer) -> () -> Void), for: UIControl.Event.touchUpInside)
        self.view.addSubview(pauseButton)
        rewindButton.setTitle("Rewind", for: UIControl.State.normal)
        rewindButton.addTarget(self, action: #selector(ArtistLiveVideoRecieveVC.rewind), for: UIControl.Event.touchUpInside)
        self.view.addSubview(rewindButton)
        self.view.addSubview(btnBack)
        self.view.addSubview(shareBtn)
        self.view.addSubview(popUpBgVw)
        if isFromNotification{
            callArtistVideoWebService("\(broadCastID)")
        }else{
            if(screenType == "DjSongReviewsVC"){
                print("videoUrl","\(getVideoRlSTr)")
                bambuserPlayer.playVideo(getVideoRlSTr)
            }
            else{
                print("uri","\(uri)")
                print("uri","\(getVideoRlSTr)")
            bambuserPlayer.playVideo("\(uri)")
               // bambuserPlayer.playVideo("\(getVideoRlSTr)")
            //callVideoVerifyWebservice(audioId: id) new ashi
            }
        }
    }
    
    @objc func handleTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.popUpBgVw.isHidden = true
        self.verifyPopUpVw.isHidden = true
    }
    
    @IBAction func shareBtnTapped(_ sender: Any) {
        shareBtnTap = "share"
        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
            verifyTxtLbl.text = ""
            self.popUpBgVw.isHidden = true
            self.verifyPopUpVw.isHidden = true
                    if shareToLink != nil{
                        shareLink()
                    }else{
                        getVideoINMp4(fromShare: true)
                    }
        }
        else{
        verifyTxtLbl.text = "This function cannot be performed until you verify the video. Click to verify and complete this project."
        self.popUpBgVw.isHidden = false
        self.verifyPopUpVw.isHidden = false
        }
//        if shareToLink != nil{
//            shareLink()
//        }else{
//            getVideoINMp4(fromShare: true)
//        }
    }
    
    func shareLink(){
//        let urlData = NSData(contentsOf: URL(string:"\(shareToLink!)")!)
//
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
        
        if let name = URL(string: "\(shareToLink)"), !name.absoluteString.isEmpty {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
          // show alert for not available
        }
    }
    
    //MARK:- Webservice
    func getVideoINMp4(fromShare : Bool){
        if getReachabilityStatus(){
            
            let headers = [
                "Content-Type":"application/json",
                "Accept":"application/vnd.bambuser.v2+json",
                "Authorization":"Bearer GMSWiinwYhbj81RcnuhpP7"
            ]
            
            let parameter = ["format": "mp4-h264"]
            Loader.shared.show()
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(broadCastID)/downloads"), method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response:DataResponse<VideoChangeFormate>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let videoModelProfile = response.result.value!
                    if videoModelProfile.status == "ok"{
                        self.shareToLink = videoModelProfile.url as? String
                        if fromShare{
                            self.shareLink()
                        }
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    self.view.makeToast("This broadcast was removed by user")
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    
    @objc func rewind() {
        bambuserPlayer.seek(to: 0.0);
    }
    
    override func viewWillLayoutSubviews() {
        let statusBarOffset = self.topLayoutGuide.length
        bambuserPlayer.frame = CGRect(x: 0, y: 0 + statusBarOffset, width: self.view.bounds.size.width, height: self.view.bounds.size.height - statusBarOffset)
        playButton.frame = CGRect(x: 20, y: 20 + statusBarOffset, width: 100, height: 40)
        pauseButton.frame = CGRect(x: 20, y: 80 + statusBarOffset, width: 100, height: 40)
        rewindButton.frame = CGRect(x: 20, y: 140 + statusBarOffset, width: 100, height: 40)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playbackStatusChanged(_ status: BambuserPlayerState) {
        switch status {
        case kBambuserPlayerStatePlaying:
            playButton.isEnabled = false
            pauseButton.isEnabled = true
            break
            
        case kBambuserPlayerStatePaused:
            playButton.isEnabled = true
            pauseButton.isEnabled = false
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
            break
            
        case kBambuserPlayerStateStopped:
            playButton.isEnabled = true
            pauseButton.isEnabled = false
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
            break
            
        case kBambuserPlayerStateError:
            NSLog("Failed to load video for %@", bambuserPlayer.resourceUri);
            break
            
        default:
            break
        }
    }
    
    @IBAction func btnBack_Action(_ sender: UIButton) {
        if isFromNotification == true{
            backNotificationView()
        }else{
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            sideMenuController()?.setContentViewController(next1!)
        }
    }
    
    //MARK:- Webservice
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
                    let url = videoModelProfile.resourceUri
                    self.bambuserPlayer.playVideo("\(url!)")
                    //self.callVideoVerifyWebservice(audioId: self.id) // new ashi
                
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
    func callVideoVerifyWebservice(audioId : String){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audioid":"\(audioId)",
                "dj_id":getSenderId,
                "type":"review",
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
                            self.getVideoINMp4(fromShare: true)
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
}

