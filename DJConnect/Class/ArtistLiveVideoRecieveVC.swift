//
//  ArtistLiveVideoRecieveVC.swift
//  ADCountryPicker
//
//  Created by My Mac on 22/09/20.
//

import UIKit
import Alamofire
import AVFoundation
import AVKit
import CoreMedia
import AssetsLibrary
import Photos

enum QUWatermarkPosition {
    case TopLeft
    case TopRight
    case BottomLeft
    case BottomRight
    case Default
}


class ArtistLiveVideoRecieveVC: UIViewController, BambuserPlayerDelegate {
    
    @IBOutlet weak var imgWaterMark: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    var bambuserPlayer: BambuserPlayer
    
    
    @IBOutlet weak var videoBgvw: UIView!
    @IBOutlet weak var shareBgVw: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var downloadBgVw: UIView!
    @IBOutlet weak var downloadBtn: UIButton!
    
    @IBOutlet weak var endTimeLbl: UILabel!
    
    @IBOutlet weak var startTimeLbl: UILabel!
    
    @IBOutlet weak var seekBarV: UISlider!
    var isFromNotification = false
    
    var id = ""
    var uri = ""
    var broadCastID = ""
    

    var playButton: UIButton
    var pauseButton: UIButton
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

    var minValue = 0.0
    var maxValue = 0.0
    
    var projectIdStr = String()
    var getAlertId = String()
    var shareBtnTap = String()
    var getVideoStatusStr = String()
    var getSenderIdStr = String()
    
    @IBOutlet weak var popUpBgVw: UIView!
    @IBOutlet weak var verifyPopUpVw: UIView!
    
    
    @IBOutlet weak var verifyTxtLbl: UILabel!
    @IBOutlet weak var verifyBtn: UIButton!
    @IBOutlet weak var disputeBtn: UIButton!
    
    @IBOutlet weak var downloadingLbl: UILabel!
    
    
    var songUrStr = String()
    var shareTapStr = ""
    
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
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
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
    
    
    func callrejectProjectVerificationAPI(){
        
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "projectid":"\(projectIdStr)",
                "alert_id":"\(getAlertId)"
            ]
            
            print("disputeParameter",parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.rejectProjectVerificationAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let cancelVideoAfterVerify = response.result.value!
                    if cancelVideoAfterVerify.success == 1{
                        self.view.makeToast(cancelVideoAfterVerify.message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//                            let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
//                            let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
//                            self.sideMenuController()?.setContentViewController(next1!)
                            self.navigationController?.popViewController(animated: false)
                        })
                        
                        
                        
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
    
    
    required init?(coder aDecoder: NSCoder) {
        
        //commented by ashitesh
       // bambuserPlayer = BambuserPlayer()
        ////bambuserPlayer.playbackPosition
       // print("\(bambuserPlayer.seekableStart)")
        //super.init(coder: aDecoder)
        
        bambuserPlayer = BambuserPlayer()
        playButton = UIButton(type: UIButton.ButtonType.system)
        pauseButton = UIButton(type: UIButton.ButtonType.system)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBtnTap = ""
        //This function cannot be performed until you verify the video. Click to verify and complete this project.
                
        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
        self.downloadBgVw.isHidden = false
        }
        else{
            self.downloadBgVw.isHidden = true
        }
        
        downloadingLbl.isHidden = true
        downloadingLbl.textColor = .black
        shareTapStr = ""
        shareBtn.setTitle("", for: .normal)
        downloadBtn.setTitle("", for: .normal)
        shareBgVw.layer.cornerRadius = 5
        shareBgVw.clipsToBounds = true
        downloadBgVw.layer.cornerRadius = 5
        downloadBgVw.clipsToBounds = true
        
        popUpBgVw.isHidden = true
        verifyPopUpVw.isHidden = true
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapped(_:)))
        popUpBgVw.addGestureRecognizer(tap1)
        
        popUpBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        verifyPopUpVw.layer.cornerRadius = 20;
        verifyPopUpVw.layer.masksToBounds = true;
        
        verifyBtn.layer.cornerRadius = disputeBtn.frame.size.height/2
        verifyBtn.layer.masksToBounds = true;
        
        disputeBtn.layer.cornerRadius = disputeBtn.frame.size.height/2
        disputeBtn.layer.masksToBounds = true;
        disputeBtn.layer.borderWidth = 1
        disputeBtn.layer.borderColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1).cgColor
        
        getVideoINMp4(fromShare: false)
        seekBarV.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        
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
        //self.view.addSubview(bambuserPlayer)
        videoBgvw.addSubview(bambuserPlayer)
        playButton.setTitle("Play", for: UIControl.State.normal)
        //self.view.addSubview(playButton)
        videoBgvw.addSubview(playButton)
        pauseButton.setTitle("Pause", for: UIControl.State.normal)
        videoBgvw.addSubview(pauseButton)
        videoBgvw.addSubview(btnBack)
                
        videoBgvw.addSubview(shareBgVw)
        videoBgvw.addSubview(downloadBgVw)
        videoBgvw.addSubview(shareBtn)
        videoBgvw.addSubview(downloadBtn)
        videoBgvw.addSubview(downloadingLbl)
        
        self.playButton.isHidden = true
        
        bambuserPlayer.playVideo("\(uri)")

        //ashitesh
//         if isFromNotification{
//             callArtistVideoWebService("\(broadCastID)")
//         }else{
//             bambuserPlayer.playVideo("\(uri)")
//             callVideoVerifyWebservice(audioId: id)
//         }
        
        // new commneted ashtesh
       // callVideoVerifyWebservice(audioId: "\(id)")
        scheduledTimerWithTimeInterval()
        print("uri",uri)
    }
    
    @objc func handleTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.popUpBgVw.isHidden = true
        self.verifyPopUpVw.isHidden = true
    }
    
    // MARK:- controls hide show method
    func hideShowTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideControls), userInfo: nil, repeats: false)
    }
    
    @objc func hideControls(){
        seekBarV .isHidden = true
        playButton .isHidden = true
        pauseButton .isHidden = true
        startTimeLbl .isHidden = true
        endTimeLbl .isHidden = true
    }
    
    func showAll(){
        startTimeLbl .isHidden = false
        endTimeLbl .isHidden = false
        seekBarV .isHidden = false
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
        if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
        verifyTxtLbl.text = ""
        self.popUpBgVw.isHidden = true
        self.verifyPopUpVw.isHidden = true
        }
        else{
            verifyTxtLbl.text = "Click to verify and complete this project." // 1 ashitesh verify
            self.popUpBgVw.isHidden = false
            self.verifyPopUpVw.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        shareBtnTap = ""
        videoBgvw.bringSubviewToFront(shareBtn)

        //self.view.bringSubviewToFront(shareBtn)
        self.view.bringSubviewToFront(popUpBgVw)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        bambuserPlayer.addGestureRecognizer(tap)
       // lblAudioName.text = global.audioName
    }
    
    override func viewWillLayoutSubviews() {
        let statusBarOffset = self.topLayoutGuide.length
        bambuserPlayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        playButton.frame = CGRect(x: self.view.frame.width / 2 - 25, y: self.view.frame.height / 2 - 25, width: 50, height: 50)
        playButton.setImage(UIImage(named: "playSample"), for: .normal)
        pauseButton.frame = CGRect(x: self.view.frame.width / 2 - 25, y: self.view.frame.height / 2 - 25, width: 50, height: 50)
        pauseButton.setImage(UIImage(named: "pause"), for: .normal)
        
        videoBgvw.bringSubviewToFront(seekBarV)
        videoBgvw.bringSubviewToFront(startTimeLbl)
        videoBgvw.bringSubviewToFront(endTimeLbl)
//        self.view .bringSubviewToFront(seekBarV)
//        self.view .bringSubviewToFront(startTimeLbl)
//        self.view .bringSubviewToFront(endTimeLbl)
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
        startTimeLbl.text = String(format: "%02d:%02d", minutes, seconds)
        if streamType == "Live"{
            seekBarV.value = Float(totalDuration)
        }else{
            if seekChange == true{
               // print("minValue",minValue)
                              // print("maxValue",maxValue)
                               if(minValue != maxValue && minValue < maxValue){
                               currentDuration += 1
                               seekBarV.value = Float(currentDuration)
                               minValue = Double(Float(currentDuration))
                                print("minValue1",minValue)
                                print("maxValue1",maxValue)
                                if(minValue == maxValue){
                                    print("minValue",minValue)
                                    print("maxValue",maxValue)
                                    minValue = 0
                                 maxValue = 0
                                    timer.invalidate()
                                    
                                    if(self.getVideoStatusStr == "1" || self.getVideoStatusStr == "2"){
                                        self.verifyTxtLbl.text = ""
                                    self.popUpBgVw.isHidden = true
                                    self.verifyPopUpVw.isHidden = true
                                    }
                                    else{
                                        self.verifyTxtLbl.text = "Click to verify and complete this project."
                                 self.popUpBgVw.isHidden = false
                                 self.verifyPopUpVw.isHidden = false
                                    }
                                }
                               }else{
                                   minValue = 0
                                maxValue = 0
                                   timer.invalidate()
                                if(self.getVideoStatusStr == "1" || self.getVideoStatusStr == "2"){
                                    self.verifyTxtLbl.text = ""
                                self.popUpBgVw.isHidden = true
                                self.verifyPopUpVw.isHidden = true
                                }else{
                                    self.verifyTxtLbl.text = "Click to verify and complete this project."
                                self.popUpBgVw.isHidden = false
                                self.verifyPopUpVw.isHidden = false
                               }
                               }
            }
        }

    }
    
    
    func durationKnown(_ duration: Double) {
        let totalSeconds = Int(duration)
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        endTimeLbl.text = String(format: "%02d:%02d", minutes, seconds)
        seekBarV.maximumValue = Float(Int(duration))
        maxValue = Double(Float(seekBarV.maximumValue))
        if bambuserPlayer.live {
            self.streamType = "Live"
            totalDuration = Int(duration)
        }else{
            self.streamType = "Recorded"
        }
    }
    
    @objc func rewind() {
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
            break
        case kBambuserPlayerStateStopped:
            playButton .isHidden = false
            pauseButton .isHidden = true
            seekChange = false
            currentDuration = 0
            hideControls()
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

    @IBAction func shareBtntapped(_ sender: Any) {
        
        shareBtnTap = "share"
        shareTapStr = "Sharetap"
        if shareToLink != nil{
            shareClicked(videoLinkStr: "\(shareToLink!)")
        }else{
            getVideoINMp4(fromShare: true)
        }
    }
    @IBAction func downloadBtnTapped(_ sender: Any) {
        
        if(shareToLink != nil){
        shareClicked(videoLinkStr: "\(shareToLink!)")
        }
    }
    
    //logo
    func shareLink(){
       // print("songUrStr",songUrStr)
//        let url = URL(string:"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
        //addWatermarkToVideo(url: url as NSURL)
        if(shareToLink != "" ){
            let urlData = NSData(contentsOf: URL(string:shareToLink ?? "")!)
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
            if(getVideoStatusStr == "1" || getVideoStatusStr == "2"){
            
            }
            else{
                activityVC.excludedActivityTypes = [
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.print,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.openInIBooks,
                ]
            }
           
            self.present(activityVC, animated: true, completion: nil)
        }
        }
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnBack_Action(_ sender: UIButton) {
        
        if timer != nil {
            timer.invalidate()
        }
        bambuserPlayer.stopVideo()
        if isFromNotification == true{
            backNotificationView()
        }else{
//            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
//            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
//            sideMenuController()?.setContentViewController(next1!)
            self.navigationController?.popViewController(animated: false)
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
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(broadCastID)/downloads"), method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseObject { [self] (response:DataResponse<VideoChangeFormate>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let videoModelProfile = response.result.value!
                    if videoModelProfile.status == "ok"{
                        self.shareToLink = videoModelProfile.url as? String
                        if fromShare{
                            //self.shareLink()
                            self.shareClicked(videoLinkStr: "\(shareToLink ?? "")")
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
                               // self.shareLink()
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
    
    //MARK:- Webservice
//    func callArtistVideoWebService(_ brodcastID : String){
//        let url = getBroadCastVideoLink(brodcastID: brodcastID)
//        bambuserPlayer.playVideo("\(url)")
//        callVideoVerifyWebservice(audioId: id)
//    }
    
    func callVideoVerifyWebservice(audioId : String){
        self.popUpBgVw.isHidden = true
        self.verifyPopUpVw.isHidden = true
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audioid":"\(audioId)",
                "type":"project",
                "dj_id":getSenderIdStr,
                "alert_id":"\(getAlertId)"
            ]
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.videoVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let videoVerifyModel = response.result.value!
                    self.view.makeToast(videoVerifyModel.message)
                    if(self.shareBtnTap == "share"){
                        if self.shareToLink != nil{
                            //self.shareLink()
                            self.shareClicked(videoLinkStr: "\(String(describing: self.shareToLink))")
                        }else{
                            self.getVideoINMp4(fromShare: true)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                        self.navigationController?.popViewController(animated: false)
                            })
                    
                    
                case .failure(let error):
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
}
