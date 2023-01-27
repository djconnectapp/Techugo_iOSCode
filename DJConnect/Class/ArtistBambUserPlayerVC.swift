//
//  ArtistBambUserPlayerVC.swift
//  DJConnect
//
//  Created by mac on 30/09/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import AVKit
import CoreMedia
import AssetsLibrary
import Photos

class ArtistBambUserPlayerVC: UIViewController, BambuserPlayerDelegate {
    //MARK: - OUTLETS
    @IBOutlet weak var imgWaterMark: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var seekBar: UISlider!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblAudioName: UILabel!
    
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var shareBgView: UIView!
    @IBOutlet weak var downloadBgVw: UIView!
    @IBOutlet weak var downloadingLbl: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var bambuserPlayer: BambuserPlayer
    var playButton: UIButton
    var pauseButton: UIButton
    var uri = ""
    var broadCastID = ""
    var videoType = ""
    var backType = ""
    var isFromProjectDetail = false
    var projId = String()
    var timer = Timer()
    var timer2 = Timer()
    var shareToLink : String?
    
    var streamType = ""
    var totalDuration = 0
    var currentDuration = 0
    var seekChange = false
    var downloadLink = ""
    var currentButton = ""
    var screenType = String()
    var getVideoRlSTr = String()
    var getVideoStatusStr = String()
    var getalertIdStr = String()
    var getSenderidStr = String()
    var id = String()
    var screenCnnect = String()
    @IBOutlet weak var popUpBgVw: UIView!
    @IBOutlet weak var verifyPopUpVw: UIView!
    @IBOutlet weak var verifyTxtLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var disputeBtn: UIButton!
    
    var shareTapStr = ""
    
    required init?(coder aDecoder: NSCoder) {
        bambuserPlayer = BambuserPlayer()
        playButton = UIButton(type: UIButton.ButtonType.system)
        pauseButton = UIButton(type: UIButton.ButtonType.system)
        super.init(coder: aDecoder)
    }
    
    @IBAction func verifyBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        callVideoVerifyWebservice(audioId: id)
    }
    @IBAction func disputeBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        callrejectProjectVerificationAPI()
    }
    @IBAction func doanloadbTnTapped(_ sender: Any) {
        if(shareToLink != nil){
        shareClicked(videoLinkStr: "\(shareToLink!)")
        }
    }
    
    func shareClicked(videoLinkStr:String) {
        self.downloadingLbl.textColor = .black
       let url = URL(string:videoLinkStr)!
        if(shareTapStr == "Sharetap")
        {
            downloadingLbl.text = "Wait..."
            downloadingLbl.isHidden = false
        }
        else{
            downloadingLbl.isHidden = false
            downloadingLbl.text = "Downloading..."
        }
        

      DispatchQueue.global(qos: .background).async {

           if let urlData = NSData(contentsOf: url) {


               let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

               let fileUrl = URL(fileURLWithPath: documentsPath).appendingPathComponent("fffffff.mp4")

               if FileManager.default.fileExists(atPath:fileUrl.path) {

                   try? FileManager.default.removeItem(at:fileUrl)

                   print("removed")
               }

               try? urlData.write(to: fileUrl)
print(fileUrl)

               self.merge(video: fileUrl.path, withForegroundImage:UIImage(named: "DJCwatermark")!, completion: { (uuu) in

                           DispatchQueue.main.async {

                            self.play(uuu!)
                               print(uuu!)
                           }

                       })
               }
   }

   }
   func play(_ url : URL) {

       if(shareTapStr == "Sharetap")
       {
           shareTapStr = ""
           self.downloadingLbl.isHidden = true
           self.downloadingLbl.textColor = .clear
        var filesToShare = [Any]()

        // Add the path of the file to the Array
        filesToShare.append(url)

        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
       }
       else{
           DispatchQueue.global(qos: .background).async {
               if let urlData = NSData(contentsOf: url) {
                   let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                   let filePath="\(documentsPath)/tempFile.mp4"
                   DispatchQueue.main.async {
                       urlData.write(toFile: filePath, atomically: true)
                       PHPhotoLibrary.shared().performChanges({
                           PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                       }) { completed, error in
                           if completed {
                               DispatchQueue.main.async {
                                   self.downloadingLbl.textColor = .clear
                                   self.downloadingLbl.isHidden = true
                                   self.view.makeToast("Video saved successfully")
                               }
                               print("Video is saved!")
                           }

                       }
                   }
               }
           }
       }
   }
   private func addAudioTrack(composition: AVMutableComposition, videoUrl: URL) {


       let videoUrlAsset = AVURLAsset(url: videoUrl, options: nil)

       let audioTracks = videoUrlAsset.tracks(withMediaType: AVMediaType.audio)

       let compositionAudioTrack:AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: CMPersistentTrackID())!

       for audioTrack in audioTracks {
           try! compositionAudioTrack.insertTimeRange(audioTrack.timeRange, of: audioTrack, at: CMTime.zero)
       }
   }


   func merge(
       video videoPath: String,
       withForegroundImage foregroundImage: UIImage,
       completion: @escaping (URL?) -> Void) -> () {

       let videoUrl = URL(fileURLWithPath: videoPath)
       let videoUrlAsset = AVURLAsset(url: videoUrl, options: nil)

       // Setup `mutableComposition` from the existing video
       let mutableComposition = AVMutableComposition()
       let videoAssetTrack = videoUrlAsset.tracks(withMediaType: AVMediaType.video).first!
       let videoCompositionTrack = mutableComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
       videoCompositionTrack?.preferredTransform = videoAssetTrack.preferredTransform
       try! videoCompositionTrack?.insertTimeRange(CMTimeRange(start:CMTime.zero, duration:videoAssetTrack.timeRange.duration), of: videoAssetTrack, at: CMTime.zero)

       addAudioTrack(composition: mutableComposition, videoUrl: videoUrl)

       let videoSize: CGSize = (videoCompositionTrack?.naturalSize)!
       let frame = CGRect(x: 0.0, y: 0.0, width: videoSize.width, height: videoSize.height)
       let imageLayer = CALayer()
       imageLayer.contents = foregroundImage.cgImage
       imageLayer.frame = CGRect(x: videoSize.width/2 - 140, y: videoSize.height/2 - 140, width:280, height:280)


       let videoLayer = CALayer()
       videoLayer.frame = frame
       let animationLayer = CALayer()
       animationLayer.frame = frame
       animationLayer.addSublayer(videoLayer)
       animationLayer.addSublayer(imageLayer)

       let videoComposition = AVMutableVideoComposition(propertiesOf: (videoCompositionTrack?.asset!)!)
       videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: animationLayer)

       let documentDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
       let documentDirectoryUrl = URL(fileURLWithPath: documentDirectory)
       let destinationFilePath = documentDirectoryUrl.appendingPathComponent("result.mp4")
//            try? documentDirectoryUrl.write(to: destinationFilePath)

       do {

           if FileManager.default.fileExists(atPath: destinationFilePath.path) {

               try FileManager.default.removeItem(at: destinationFilePath)

               print("removed")
           }



       } catch {

           print(error)
       }


       let exportSession = AVAssetExportSession( asset: mutableComposition, presetName: AVAssetExportPresetHighestQuality)!

      exportSession.videoComposition = videoComposition
      exportSession.outputFileType = AVFileType.mp4
       exportSession.outputURL = destinationFilePath
       exportSession.shouldOptimizeForNetworkUse = true
           exportSession.exportAsynchronously(completionHandler: { () -> Void in
                       switch exportSession.status {
                       case  .failed:
                           print("failed \(String(describing: exportSession.error))")
                           completion(nil)
                           break
                       case .cancelled:
                           print("cancelled \(String(describing: exportSession.error))")
                           completion(nil)
                           break
                       default:
                           print("complete")
                           completion(exportSession.outputURL)
                       }
                   })
        }
    
    
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadingLbl.isHidden = true
        downloadingLbl.textColor = .black
        shareTapStr = ""
        
        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
        self.downloadBgVw.isHidden = false
        }
        else{
            self.downloadBgVw.isHidden = true
        }
        
        btnShare.setTitle("", for: .normal)
        downloadBtn.setTitle("", for: .normal)
                             
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        
        shareBgView.layer.cornerRadius = 5
        shareBgView.clipsToBounds = true
    
        downloadBgVw.layer.cornerRadius = 5
        downloadBgVw.clipsToBounds = true
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapped(_:)))
        popUpBgVw.addGestureRecognizer(tap1)
       // self.view.bringSubviewToFront(popUpBgVw)
        
        print("getVideoStatusStr",getVideoStatusStr)
        
//        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
//            btnShare.isHidden = false
//        }
//        else{
//            btnShare.isHidden = true
//        }
        
        getVideoINMp4(fromShare: false)
        seekBar.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
        }
        bambuserPlayer.delegate = self
        bambuserPlayer.applicationId = "dbJx8NwoMFA0kCSbCjXAlQ"
        self.playButton.tintColor = UIColor .white
        self.pauseButton.tintColor = UIColor .white
        playButton.addTarget(self, action: #selector(self.playy), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(self.pausee), for: .touchUpInside)
        self.view.addSubview(bambuserPlayer)
        playButton.setTitle("Play", for: UIControl.State.normal)
        self.view.addSubview(playButton)
        pauseButton.setTitle("Pause", for: UIControl.State.normal)
        self.view.addSubview(pauseButton)
        self.view.addSubview(btnBack)
        
        self.view.addSubview(popUpBgVw)
        
        self.view.addSubview(shareBgView)
        self.view.addSubview(downloadBgVw)
        self.view.addSubview(btnShare)
        self.view.addSubview(downloadBtn)
        self.view.addSubview(downloadingLbl)
        
        self.view.addSubview(imgWaterMark)
        self.playButton.isHidden = true
        if(screenType == "DjSongReviewsVC"){
            bambuserPlayer.playVideo("\(getVideoRlSTr)")
        }
        else{
        bambuserPlayer.playVideo("\(uri)")
        }
        scheduledTimerWithTimeInterval()
    }
    
    @objc func handleTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.popUpBgVw.isHidden = true
        self.verifyPopUpVw.isHidden = true
    }
    
    // MARK:- controls hide show method
    func hideShowTimer(){
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.hideControls), userInfo: nil, repeats: false)
    }
    
    @objc func hideControls(){
        seekBar .isHidden = true
        playButton .isHidden = true
        pauseButton .isHidden = true
        lblStartTime .isHidden = true
        lblEndTime .isHidden = true
    }
    
    func showAll(){
        lblStartTime .isHidden = false
        lblEndTime .isHidden = false
        seekBar .isHidden = false
        if bambuserPlayer.status.rawValue == 0{
            playButton .isHidden = false
        }else if bambuserPlayer.status.rawValue == 1{
            pauseButton .isHidden = false
        }else if bambuserPlayer.status.rawValue == 2{
            pauseButton .isHidden = false
        }else if bambuserPlayer.status.rawValue == 3{
            playButton .isHidden = false
        }
        self.hideShowTimer()
    }
    
    @objc func playy() {
        bambuserPlayer.playVideo()
    }
    
    @objc func pausee() {
        bambuserPlayer.pauseVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.view.bringSubviewToFront(btnShare)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        bambuserPlayer.addGestureRecognizer(tap)
        lblAudioName.text = global.audioName
    }
    
    override func viewWillLayoutSubviews() {
        let statusBarOffset = self.topLayoutGuide.length
        bambuserPlayer.frame = CGRect(x: 0, y: 0 + statusBarOffset, width: self.view.bounds.size.width, height: self.view.bounds.size.height - statusBarOffset)
        playButton.frame = CGRect(x: self.view.frame.width / 2 - 25, y: self.view.frame.height / 2 - 25, width: 50, height: 50)
        playButton.setImage(UIImage(named: "playSample"), for: .normal)
        pauseButton.frame = CGRect(x: self.view.frame.width / 2 - 25, y: self.view.frame.height / 2 - 25, width: 50, height: 50)
        pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        self.view .bringSubviewToFront(seekBar)
        self.view .bringSubviewToFront(lblStartTime)
        self.view .bringSubviewToFront(lblEndTime)
        self.view .bringSubviewToFront(lblAudioName)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.showAll()
    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
            case .moved:
                break
            case .ended:
                bambuserPlayer.seek(to: Double(slider.value));
                currentDuration = Int(slider.value)
                break
            default:
                break
            }
        }
    }
    
    @objc func updateCounting(){
        let totalSeconds = Int(currentDuration)
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        lblStartTime.text = String(format: "%02d:%02d", minutes, seconds)
        if streamType == "Live"{
            seekBar.value = Float(totalDuration)
        }else{
            if seekChange == true{
                currentDuration += 1
                seekBar.value = Float(currentDuration)
            }
        }
    }
    
    
    func durationKnown(_ duration: Double) {
        let totalSeconds = Int(duration)
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        lblEndTime.text = String(format: "%02d:%02d", minutes, seconds)
        seekBar .maximumValue = Float(Int(duration))
        if bambuserPlayer.live {
            self.streamType = "Live"
            totalDuration = Int(duration)
        }else{
            self.streamType = "Recorded"
        }
    }
    
    @objc func rewind2() {
        bambuserPlayer.seek(to: 0.0);
    }
    
    func playbackStatusChanged(_ status: BambuserPlayerState) {
        switch status {
        case kBambuserPlayerStatePlaying:
            playButton .isHidden = true
            pauseButton .isHidden = false
            seekChange = true
            hideControls()
            break
        case kBambuserPlayerStatePaused:
            playButton .isHidden = false
            pauseButton .isHidden = true
            seekChange = false
            hideControls()
            if(screenCnnect == "DJScreen"){
                self.popUpBgVw.isHidden = true
                self.verifyPopUpVw.isHidden = true
            }else{
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
            break
        case kBambuserPlayerStateStopped:
            playButton .isHidden = false
            pauseButton .isHidden = true
            seekChange = false
            currentDuration = 0
            hideControls()
            if(screenCnnect == "DJScreen"){
                self.popUpBgVw.isHidden = true
                self.verifyPopUpVw.isHidden = true
            }else{
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
            break
        case kBambuserPlayerStateError:
            seekChange = false
            playButton .isHidden = false
            currentButton = "play"
            hideControls()
            break
        case kBambuserPlayerStateBuffering:
            playButton .isHidden = true
            pauseButton .isHidden = false
            hideControls()
            break
        default:
            break
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnShareAction(_ sender: UIButton) {
        shareTapStr = "Sharetap"
        if shareToLink != nil{
            //shareLink()
            self.shareClicked(videoLinkStr: "\(shareToLink!)")
        }else{
            getVideoINMp4(fromShare: true)
        }
    }
    
    func shareLink(){
        
        //shareClicked()
        let urlData = NSData(contentsOf: URL(string:"\(shareToLink!)")!)
        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
            verifyTxtLbl.text = ""
            self.popUpBgVw.isHidden = true
            self.verifyPopUpVw.isHidden = true
        if ((urlData) != nil){
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyyMMdd_HHmmss"
            let timestamp = format.string(from: date)

            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let docDirectory = paths[0]
            let filePath = "\(docDirectory)/Video_\(timestamp).mp4"
            urlData?.write(toFile: filePath, atomically: true)
            // file saved
            let videoLink = NSURL(fileURLWithPath: filePath)

            let objectsToShare = [videoLink] //comment!, imageData!, myWebsite!]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.openInIBooks,

            ]
            self.present(activityVC, animated: true, completion: nil)
        }
        }
        else{
            verifyTxtLbl.text = "This function cannot be performed until you verify the video. Click to verify and complete this project."
            self.popUpBgVw.isHidden = false
            self.verifyPopUpVw.isHidden = false
        }
        
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        if timer != nil {
            timer.invalidate()
        }
        bambuserPlayer.stopVideo()
        if backType == "profile" || backType == "edit_profile"{
            navigationController?.popViewController(animated: true)
        }else if isFromProjectDetail{
            navigationController?.popViewController(animated: true)
        }
        else if(backType == "DjSongReviewsVC"){
            navigationController?.popViewController(animated: true)
        }
        else{
            let homeSB = UIStoryboard(name: "EditProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetProfileDataVC") as! GetProfileDataVC
            desiredViewController.buttonSelected = "media"
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType(rawValue: "push")
            transition.subtype = CATransitionSubtype.fromLeft
            self.navigationController?.view.layer.add(transition, forKey: kCATransition)
            self.navigationController?.pushViewController(desiredViewController, animated: true)
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
                            //self.shareLink() // ashitesh previous
                            self.shareClicked(videoLinkStr: "\(self.shareToLink ?? "")")
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
    
    func getLink(){
        if getReachabilityStatus(){
            let headers = [
                "Accept":"application/vnd.bambuser.v1+json",
                "Authorization":"Bearer GMSWiinwYhbj81RcnuhpP7"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(self.broadCastID)/downloads"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    if let data = response.result.value{
                        if  (data as? [String : AnyObject]) != nil{
                            let dataa = data as! [String : AnyObject]
                            if let link = dataa["url"] {
                                self.downloadLink = "\(link)"
                                //self.shareLink()
                                self.shareClicked(videoLinkStr: "\(self.downloadLink)")
                            }
                            
                        }
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
    
    func callVideoVerifyWebservice(audioId : String){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audioid":"\(audioId)",
                "type":"project",
                "dj_id":getSenderidStr,
                "alert_id":getalertIdStr
                
            ]
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.videoVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let videoVerifyModel = response.result.value!
                    if videoVerifyModel.success == 1{
                        self.view.makeToast(videoVerifyModel.message)
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
    
    func callrejectProjectVerificationAPI(){
        
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "sender_id":getSenderidStr,
                "alert_id":getalertIdStr
            ]
            
            
            print("disputeParameter123",parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.rejectReviewVerificationAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let cancelVideoAfterVerify = response.result.value!
                    if cancelVideoAfterVerify.success == 1{
                        self.view.makeToast(cancelVideoAfterVerify.message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.navigationController?.popViewController(animated: false)
                        })
                        
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
    
}
