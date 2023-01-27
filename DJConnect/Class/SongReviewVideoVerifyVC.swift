//
//  SongReviewVideoVerifyVC.swift
//  DJConnect
//
//  Created by mac on 28/09/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class SongReviewVideoVerifyVC: UIViewController,BambuserViewDelegate{
    
    //MARK: - OUTLETS
    @IBOutlet weak var btnBroadCast: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var btnCameraDirection: UIButton!
    @IBOutlet weak var lblVerify: UILabel!
    @IBOutlet weak var lblTimeCountDown: UILabel!
    @IBOutlet weak var lblConnecting: UILabel!
    @IBOutlet weak var imgDjLogo: UIImageView!
    @IBOutlet weak var vwBroadcastButton: viewProperties!
    @IBOutlet weak var cnsBroadcastTop: NSLayoutConstraint!
    @IBOutlet weak var cnsBroadcastLeading: NSLayoutConstraint!
    @IBOutlet weak var cnsBroadcastBottom: NSLayoutConstraint!
    @IBOutlet weak var cnsBroadcastTrailing: NSLayoutConstraint!
    
    //MARK: - GLOBAL VARIABLES
    var bambuserView : BambuserView
    var broadcast_Id = String()
    var artist_id = String()
    var project_id = String()
    var timeLeft = 60
    var media_Id = String()
    var readyTimeLeft = 3
    var timer = Timer()
    var video_url = String()
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var usingFrontCamera = false
    
    required init?(coder aDecoder: NSCoder) {
        bambuserView = BambuserView(preparePreset: kSessionPresetAuto)
        super.init(coder: aDecoder)
        bambuserView.delegate = self
        bambuserView.applicationId = "dbJx8NwoMFA0kCSbCjXAlQ"
    }
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bambuserView.orientation = UIApplication.shared.statusBarOrientation
        self.view.addSubview(bambuserView.view)
        bambuserView.startCapture()
        
        btnBroadCast.setTitle("Broadcast", for: UIControl.State.normal)
        self.view.addSubview(vwTop)
        self.view.addSubview(vwBottom)
        self.vwBroadcastButton.addSubview(btnBroadCast)
        self.vwTop.addSubview(btnCameraDirection)
        self.vwTop.addSubview(lblTimeCountDown)
        self.view.addSubview(imgDjLogo)
        self.view.addSubview(btnBack)
        
        self.cnsBroadcastLeading.constant = 7
        self.cnsBroadcastTop.constant = 7
        self.cnsBroadcastBottom.constant = 7
        self.cnsBroadcastTrailing.constant = 7
    }
    
    override func viewWillLayoutSubviews() {
        var statusBarOffset : CGFloat = 0.0
        statusBarOffset = CGFloat(self.topLayoutGuide.length)
        bambuserView.previewFrame = CGRect(x: 0.0, y: 0.0 + statusBarOffset, width: self.view.bounds.size.width, height: self.view.bounds.size.height - statusBarOffset)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func btnMain_Action(_ sender: UIButton) {
        if self.lblVerify.text == "Click to Stop"{
            self.btnBroadCast.layer.cornerRadius = 20.5
            self.cnsBroadcastLeading.constant = 7
            self.cnsBroadcastTop.constant = 7
            self.cnsBroadcastBottom.constant = 7
            self.cnsBroadcastTrailing.constant = 7
            self.btnBroadCast.backgroundColor = .white
            self.lblVerify.text = "Click to Verify"
            self.btnBroadCast.isUserInteractionEnabled = false
            bambuserView.stopBroadcasting()
            callDJLiveWebservice()
        }else{
            getReadyTimer()
        }
        
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.bambuserView.stopBroadcasting()
        self.callDJLiveWebservice()
        navigationController?.popViewController(animated: true)    }
    
    //MARK: - SELECTORS
    @objc func broadcast() {
        btnBroadCast.addTarget(bambuserView, action: #selector(bambuserView.stopBroadcasting), for: UIControl.Event.touchUpInside)
        bambuserView.startBroadcasting()
        self.lblConnecting.isHidden = false
        self.btnBroadCast.setTitle("1", for: .normal)
        self.btnBroadCast.backgroundColor = .clear
    }
    //MARK: - ACTIONS
    @IBAction func btnCameraAction(_ sender: UIButton) {
        if bambuserView.cameraPosition == .back{
            bambuserView.cameraPosition = .front
        }else{
            bambuserView.cameraPosition = .back
        }
    }
    
    //MARK: - OTHER METHODS
    func broadcastStarted() {
        callArtistVideoWebService(broadcast_Id)
        btnBroadCast.addTarget(bambuserView, action: #selector(bambuserView.stopBroadcasting), for: UIControl.Event.touchUpInside)
        self.setTimer()
        self.lblConnecting.isHidden = true
        self.btnBroadCast.layer.cornerRadius = 0
        self.cnsBroadcastLeading.constant = 12
        self.cnsBroadcastTop.constant = 12
        self.cnsBroadcastBottom.constant = 12
        self.cnsBroadcastTrailing.constant = 12
        self.btnBroadCast.backgroundColor = .white
        self.lblVerify.text = "Click to Stop"
    }
    
    func broadcastStopped() {
        btnBroadCast.addTarget(self, action: #selector(self.broadcast), for: UIControl.Event.touchUpInside)
    }
    
    func broadcastIdReceived(_ broadcastId: String?) {
        broadcast_Id = broadcastId!
    }
    
    func setTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timer = timer
            self.timeLeft -= 1
            self.lblTimeCountDown.isHidden = false
            self.lblTimeCountDown.text = "00 min \(self.timeLeft) sec"
            self.btnBroadCast.isEnabled = (timer.isValid)
            
            if(self.timeLeft==0){
                self.lblTimeCountDown.isHidden = true
                self.btnBroadCast.layer.cornerRadius = 20.5
                self.cnsBroadcastLeading.constant = 7
                self.cnsBroadcastTop.constant = 7
                self.cnsBroadcastBottom.constant = 7
                self.cnsBroadcastTrailing.constant = 7
                self.btnBroadCast.backgroundColor = .white
                self.lblVerify.text = "Click to Verify"
                self.btnBroadCast.isUserInteractionEnabled = false
                self.bambuserView.stopBroadcasting()
                self.callDJLiveWebservice()
                timer.invalidate()
            }
        }
    }
    
    func getReadyTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.btnBroadCast.setTitle("\(self.readyTimeLeft)", for: .normal)
            self.btnBroadCast.backgroundColor = .clear
            self.readyTimeLeft -= 1
            if(self.readyTimeLeft <= 0){
                self.broadcast()
                timer.invalidate()
            }
        }
    }
    
    func connectTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            if self.broadcast_Id.isEmpty == false{
                self.lblConnecting.isHidden = true
                self.setTimer()
                self.broadcast()
                self.btnBroadCast.layer.cornerRadius = 0
                self.cnsBroadcastLeading.constant = 12
                self.cnsBroadcastTop.constant = 12
                self.cnsBroadcastBottom.constant = 12
                self.cnsBroadcastTrailing.constant = 12
                self.btnBroadCast.backgroundColor = .white
                self.lblVerify.text = "Click to Stop"
                timer.invalidate()
            }else{
                self.lblConnecting.isHidden = false
                self.btnBroadCast.setTitle("1", for: .normal)
                self.btnBroadCast.backgroundColor = .clear
            }
        }
    }
    
    func generateAlert(){
        
        self.showAlertView("You have 60 sec and one take for Video Verification","GO LIVE?", defaultTitle: "Start", cancelTitle: "Cancel", completionHandler: { (finish) in
            if(finish){
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
                self.vwBroadcastButton.addSubview(btnBroadCast)
                self.vwTop.addSubview(btnCameraDirection)
                self.vwTop.addSubview(lblTimeCountDown)
                self.view.addSubview(imgDjLogo)
                self.vwTop.addSubview(btnBack)
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
    
    //MARK: - WEBSERVICES
    func callDJLiveWebservice(){
        if getReachabilityStatus(){
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "dj_id":"\(UserModel.sharedInstance().userId!)",
                "artist_id":"\(artist_id)",
                "project_id":"\(project_id)",
                "broadcastID":"\(broadcast_Id)",
                "id_for_verify":"\(media_Id)",
                "type":"review"
            ]
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addDjLiveAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let addLiveModel = response.result.value!
                    if addLiveModel.success == 1{
                        self.view.makeToast(addLiveModel.message)
                        self.navigationController?.popViewController(animated: true)
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(addLiveModel.message)
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
                    let url = videoModelProfile.resourceUri
                    self.video_url = url!
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
