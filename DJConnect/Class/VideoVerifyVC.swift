
//
//  VideoVerifyVC.swift
//  DJConnect
//
//  Created by mac on 07/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import MediaWatermark

class VideoVerifyVC: UIViewController,BambuserViewDelegate{
    
    //MARK: - OUTLETS
    @IBOutlet weak var broadcastButton: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var btnCameraDirection: UIButton!
    @IBOutlet weak var lblVerify: UILabel!
    @IBOutlet weak var lblTimeCountDown: UILabel!
    @IBOutlet weak var imgDJLogo: UIImageView!
    @IBOutlet weak var vwBroadcastButton: viewProperties!
    @IBOutlet weak var cnsBroadcastLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsBroadcastBottom: NSLayoutConstraint!
    @IBOutlet weak var cnsBroadcastTop: NSLayoutConstraint!
    @IBOutlet weak var cnsBroadcastTrailing: NSLayoutConstraint!
    @IBOutlet weak var lblConnecting: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var bambuserView : BambuserView
    // var broadcastButton : UIButton
    var broadcast_Id : String?
    var artist_id = String()
    var project_id = String()
    var video_url = String()
    var timeLeft = 60
    var readyTimeLeft = 3
    var media_Id = String()
    var isBroadcasted = false
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var usingFrontCamera = false
    var timer = Timer()
    var liveType = ""
    
    var resourceUri = String()
    var previewImage = String()
    
    required init?(coder aDecoder: NSCoder) {
        bambuserView = BambuserView(preparePreset: kSessionPresetAuto)
        super.init(coder: aDecoder)
        bambuserView.delegate = self
        bambuserView.applicationId = "dbJx8NwoMFA0kCSbCjXAlQ"
        //bambuserView.applicationId = "GFZalqkR5iyZcIgaolQmA"
    }
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        bambuserView.orientation = UIApplication.shared.statusBarOrientation
        self.view.addSubview(bambuserView.view)
        bambuserView.startCapture()
        
        self.view.addSubview(vwTop)
        self.view.addSubview(vwBottom)
        self.vwBroadcastButton.addSubview(broadcastButton)
        self.vwTop.addSubview(btnCameraDirection)
        self.vwTop.addSubview(lblTimeCountDown)
        self.view.addSubview(imgDJLogo)
        self.view.addSubview(lblConnecting)
        
        self.cnsBroadcastLeading.constant = 7
        self.cnsBroadcastTop.constant = 7
        self.cnsBroadcastBottom.constant = 7
        self.cnsBroadcastTrailing.constant = 7
        self.broadcastButton.isUserInteractionEnabled = true
    }
    
    override func viewWillLayoutSubviews() {
        var statusBarOffset : CGFloat = 0.0
        statusBarOffset = CGFloat(self.topLayoutGuide.length)
        bambuserView.previewFrame = CGRect(x: 0.0, y: 0.0 + statusBarOffset, width: self.view.bounds.size.width, height: self.view.bounds.size.height - statusBarOffset)
    }
    
    //MARK: - ACTIONS
    @IBAction func btnMain_Action(_ sender: UIButton) {
        if self.lblVerify.text == "Click to Stop"{
            self.broadcastButton.layer.cornerRadius = 20.5
            self.cnsBroadcastLeading.constant = 7
            self.cnsBroadcastTop.constant = 7
            self.cnsBroadcastBottom.constant = 7
            self.cnsBroadcastTrailing.constant = 7
            self.broadcastButton.backgroundColor = .white
            self.lblVerify.text = "Click to Verify"
            self.broadcastButton.isUserInteractionEnabled = false
            bambuserView.stopBroadcasting()
            onchangeVC()
            
            print("resourceUri1",resourceUri)
            // using mediaitem third party library
            let url = URL(string: resourceUri)

            //self.isBroadcasted = false
           // self.navigationController?.popViewController(animated: true)
           // self.callDJLiveWebservice(videoURL: resourceUri, VideoImag: previewImage )
        }else{
            getReadyTimer()
        }
    }
    
    
    public func addWatermarkToVideo(url: NSURL) {
        let videoAsset = AVURLAsset(url: url as URL)
        print("videoAsset",videoAsset)
        let mixComposition = AVMutableComposition()
        let compositionVideoTrack = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let clipVideoTrack: AVAssetTrack = videoAsset.tracks(withMediaType: AVMediaType.video)[0]
            do {
                try compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: clipVideoTrack, at: CMTime.zero)
            } catch {
                print(error)
            }

        compositionVideoTrack?.preferredTransform = videoAsset.tracks(withMediaType: AVMediaType.video)[0].preferredTransform

        //Add watermark
        guard let myImage = UIImage(named: "logo") else {
            //completion(url: nil)
            return
        }
        let aLayer = CALayer()
    aLayer.contents = myImage.cgImage
    aLayer.frame = CGRect(x: 5, y: 100, width: 50, height: 50)
        aLayer.opacity = 0.65

        let videoSize = videoAsset.tracks(withMediaType: AVMediaType.video)[0].naturalSize
            let parentLayer = CALayer()
            let videoLayer = CALayer()
        parentLayer.frame = CGRect(x: 0, y: 0, width: videoSize.width, height: videoSize.height)
            videoLayer.frame = CGRect(x: 0, y: 0, width: videoSize.width, height: videoSize.height)
            parentLayer.addSublayer(videoLayer)
            parentLayer.addSublayer(aLayer)

        let videoComp = AVMutableVideoComposition()
            videoComp.renderSize = videoSize
        videoComp.frameDuration = CMTimeMake(value: 1,timescale: 30)
        videoComp.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)

            let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: mixComposition.duration)
        let videoTrack = mixComposition.tracks(withMediaType: AVMediaType.video)[0]
            let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
            instruction.layerInstructions = [layerInstruction]
            videoComp.instructions = [instruction]
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = path.first! as NSString
        let dataPath = documentsDirectory.appendingPathComponent("VideoCache")

        let tempURL = NSURL(fileURLWithPath: dataPath)
        let completeMovieUrl = tempURL.appendingPathComponent("tether-\(NSDate()).mov")

        if let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) {
            exporter.outputURL = completeMovieUrl
            exporter.outputFileType = AVFileType.mp4
            exporter.videoComposition = videoComp
            exporter.exportAsynchronously(completionHandler: { () -> Void in
                switch exporter.status {
                case  .failed:
                    print("failed \(exporter.error)")
                    //completion(url: nil)
                    break
                case .cancelled:
                    print("cancelled \(exporter.error)")
                    //completion(url: nil)
                    break
                default:
                    print("complete")
                    print("getFinalVieoUrl",exporter.outputURL)
                    //completion(url: exporter.outputURL)
                }
            })
        }
    }
    
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.bambuserView.stopBroadcasting()
        onchangeVC()
    }
    
    @IBAction func btnChangeCameraDirection_Action(_ sender: UIButton) {
        if bambuserView.cameraPosition == .back{
            bambuserView.cameraPosition = .front
        }else{
            bambuserView.cameraPosition = .back
        }
    }
    
    //MARK: - SELECTORS
    @objc func broadcast() {
        broadcastButton.addTarget(bambuserView, action: #selector(bambuserView.stopBroadcasting), for: UIControl.Event.touchUpInside)
        bambuserView.startBroadcasting()
        self.lblConnecting.isHidden = false
        self.broadcastButton.setTitle("1", for: .normal)
        self.broadcastButton.backgroundColor = .clear
    }   
    
    //MARK: - OTHER METHODS
    func broadcastStarted() {
        broadcastButton.addTarget(bambuserView, action: #selector(bambuserView.stopBroadcasting), for: UIControl.Event.touchUpInside)
        self.setTimer()
        self.lblConnecting.isHidden = true
        self.broadcastButton.layer.cornerRadius = 0
        self.cnsBroadcastLeading.constant = 12
        self.cnsBroadcastTop.constant = 12
        self.cnsBroadcastBottom.constant = 12
        self.cnsBroadcastTrailing.constant = 12
        self.broadcastButton.backgroundColor = .white
        self.lblVerify.text = "Click to Stop"
    }
    
    func broadcastStopped() {
        broadcastButton.addTarget(self, action: #selector(self.broadcast), for: UIControl.Event.touchUpInside)
    }
    
    func broadcastIdReceived(_ broadcastId: String?) {
        print(broadcastId!)
        broadcast_Id = broadcastId!
        callArtistVideoWebService(broadcast_Id!)
    }
    
    func setTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timer = timer
            self.timeLeft -= 1
            self.lblTimeCountDown.isHidden = false
            self.lblTimeCountDown.text = "00 min \(self.timeLeft) sec"
            self.broadcastButton.isEnabled = (timer.isValid)
            
            if(self.timeLeft==0){
                self.lblTimeCountDown.isHidden = true
                self.broadcastButton.layer.cornerRadius = 20.5
                self.cnsBroadcastLeading.constant = 7
                self.cnsBroadcastTop.constant = 7
                self.cnsBroadcastBottom.constant = 7
                self.cnsBroadcastTrailing.constant = 7
                self.broadcastButton.backgroundColor = .white
                self.lblVerify.text = "Click to Verify"
                self.broadcastButton.isUserInteractionEnabled = false
                self.bambuserView.stopBroadcasting()
                self.onchangeVC()
                timer.invalidate()
                
            }
        }
    }
    
    func getReadyTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            self.broadcastButton.setTitle("\(self.readyTimeLeft)", for: .normal)
            self.broadcastButton.backgroundColor = .clear
            self.readyTimeLeft -= 1
            if(self.readyTimeLeft < 1){
                self.broadcast()
                timer.invalidate()
            }
        }
    }
    
    func connectTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.broadcast_Id!.isEmpty == false{
                self.lblConnecting.isHidden = true
                self.setTimer()
                self.broadcast()
                self.broadcastButton.layer.cornerRadius = 0
                self.cnsBroadcastLeading.constant = 12
                self.cnsBroadcastTop.constant = 12
                self.cnsBroadcastBottom.constant = 12
                self.cnsBroadcastTrailing.constant = 12
                self.broadcastButton.backgroundColor = .white
                self.lblVerify.text = "Click to Stop"
                timer.invalidate()
            }else{
                self.lblConnecting.isHidden = false
                self.broadcastButton.setTitle("1", for: .normal)
                self.broadcastButton.backgroundColor = .clear
            }
        }
    }
    
    func generateAlert(){
        self.showAlertView("You have 60 sec and one take for Video Verification", "GO LIVE?", defaultTitle: "Start", cancelTitle: "Cancel", completionHandler: { (ACTION) in
            if ACTION{
                self.setTimer()
                self.broadcast()
            }
        })
    }
    
    func xyz(type: Bool){
        session = AVCaptureSession()
        output = AVCaptureStillImageOutput()
        var camera : AVCaptureDevice?
        if type == false{
            camera = getDevice(position: .back)
        }else{
            camera = getDevice(position: .front)
        }
        
        do {
            input = try AVCaptureDeviceInput(device: camera!)
        } catch let error as NSError {
            print(error)
            input = nil
        }
        if(session?.canAddInput(input!) == true){
            session?.addInput(input!)
            output?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            if(session?.canAddOutput(output!) == true){
                session?.addOutput(output!)
                previewLayer = AVCaptureVideoPreviewLayer(session: session!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer?.connection!.videoOrientation = AVCaptureVideoOrientation.portrait
                previewLayer?.frame = self.view.bounds
                self.view.addSubview(bambuserView.view)
                self.view.layer.addSublayer(previewLayer!)
                self.view.addSubview(vwTop)
                self.view.addSubview(vwBottom)
                self.vwBroadcastButton.addSubview(broadcastButton)
                self.vwTop.addSubview(btnCameraDirection)
                self.vwTop.addSubview(lblTimeCountDown)
                self.view.addSubview(imgDJLogo)
                self.view.addSubview(lblConnecting)
                session?.startRunning()
            }
        }
    }
    
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray;
        for de in devices {
            let deviceConverted = de as! AVCaptureDevice
            if(deviceConverted.position == position){
                return deviceConverted
            }
        }
        return nil
    }
    
    func onchangeVC(){
        if broadcast_Id != nil {
            self.isBroadcasted = true
        }else{
            self.isBroadcasted = false
        }
        Loader.shared.show()
        let userdic = ["isBroadcast":self.isBroadcasted, "broadcastId":self.broadcast_Id, "videoURLSt":self.resourceUri, "VideoImagSt":self.previewImage, "artsistIdInt":"\(artist_id)", "mediaIdInt":"\(media_Id)"] as [String : Any]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "isBroadcast"), object: nil, userInfo: userdic)
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "BackLive"), object: nil)
    }
    
    
    //MARK: - WEBSERVICES
    func callDJLiveWebservice(videoURL : String, VideoImag : String){
        if getReachabilityStatus(){
            Loader.shared.show()
            var project_ID = "0"
                        if project_id != "null"{
                            project_ID = "\(project_id)"
                        }
            print("broadcast_Id 12:", broadcast_Id ?? "")
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "dj_id":"\(UserModel.sharedInstance().userId!)",
                "artist_id":"\(artist_id)",
                "project_id":"\(project_ID)",
                "broadcastID":"\(broadcast_Id ?? "")",
                "id_for_verify":"\(media_Id)",
                "videoURL":"\(videoURL)",
                "videoImg":"\(VideoImag)",
                "type":"\(liveType)"
            ]
            print("making live video parameter",parameters)
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addDjLiveAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                   // Loader.shared.hide()//
                    Loader.shared.show()
                    let addLiveModel = response.result.value!
                    if addLiveModel.success == 1{
                        self.navigationController?.popViewController(animated: true)
                    }else{
                        Loader.shared.hide()
                        self.isBroadcasted = false
                        self.navigationController?.popViewController(animated: true)
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
//                    if let resourceUri = videoModelProfile.resourceUri{
//                        let previewImage = videoModelProfile.preview
//                        self.callDJLiveWebservice(videoURL: resourceUri, VideoImag: previewImage ?? "")
                
                    self.resourceUri = videoModelProfile.resourceUri
                    self.previewImage = videoModelProfile.preview
                        
                   // }
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
}
