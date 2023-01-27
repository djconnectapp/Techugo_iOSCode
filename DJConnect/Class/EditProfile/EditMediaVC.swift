//
//  MediaServiceVC.swift
//  DJConnect
//
//  Created by My Mac on 27/03/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import MediaPlayer
import AVKit

class EditMediaVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var lblAddMediaVideo: UILabel!
    @IBOutlet weak var lblAudio_AddMedia: UILabel!
    @IBOutlet weak var lblVideo_AddMedia: UILabel!
    @IBOutlet weak var lblAddMediaAudio: UILabel!
    @IBOutlet weak var lblClickMessage_AddAudio: UILabel!
    @IBOutlet weak var lblAddMediaMyMedia: UILabel!
    
    @IBOutlet weak var viewAddMedia: UIView!
    @IBOutlet var viewActionSheet: UIView!
    
    @IBOutlet var viewNameAudio: UIView!
    @IBOutlet weak var viewMediaPage: UIView!
    //nameofaudio
    @IBOutlet weak var lblAddAudio: UILabel!
    @IBOutlet weak var lblNameOfAudio: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtFieldAudioName: textFieldProperties!
    
    //mediapage
    @IBOutlet weak var lblMyMedia: UILabel!
    @IBOutlet weak var lblAudio_Media: UILabel!
    @IBOutlet weak var lblVideo_Media: UILabel!
    @IBOutlet weak var lblMediaAudio: UILabel!
    @IBOutlet weak var lblMediaVideo: UILabel!
    @IBOutlet weak var lblMediaVideoDetail: UILabel!
    
    //VWDJMEDIA
    @IBOutlet weak var vwDjMedia: UIView!
    @IBOutlet weak var lblSampleName: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var lblmediaReplace: UILabel!
    @IBOutlet weak var imgProfileImg: UIImageView!
    @IBOutlet weak var audioSeekBar: UISlider!
    @IBOutlet weak var lblMinTime: UILabel!
    
    //viewVideo
    @IBOutlet var viewVideo: UIView!
    @IBOutlet weak var imgVi_Thumbnail: UIImageView!
    @IBOutlet weak var lblVi_holderName: UILabel!
    @IBOutlet weak var lblVi_ProjName: UILabel!
    @IBOutlet weak var lblVi_byName: UILabel!
    @IBOutlet weak var lblVi_GenreName: UILabel!
    @IBOutlet weak var lblLo_AutoDeleteVideo: UILabel!
    @IBOutlet weak var lblVi_AutodeleteTime: UILabel!
    
    //vwArtistMedia
    @IBOutlet weak var vwArtistMedia: UIView!
    @IBOutlet weak var lblUserNoAudio: UILabel!
    
    @IBOutlet weak var viewAddAudioBlur: UIView!
    
    @IBOutlet weak var artistSaveBtn: UIButton!
    //MARK:- GLOBAL VARIABLE
    var songData : NSData? = nil
    var audioPlayer: AVAudioPlayer?
    var apiSongData = String()
    var isPlaying = false
    var minuteString = String()
    var secondString = String()
    var video_broadcastId = String()
    var apiVideoData = String()
    var videoType = String()
    var video_verify_Id = String()
    var profileMedia : ProfileDataModel?
    var mediaRemainingTime = String()
    var mediaReleaseDate: NSDate?
    var mediaCountDownTimer = Timer()
    
    //Ashitesh
    var brodcastIDStr : String?
    var uriStr : String?
    var video_verify_IdStr : String?
    var videoTypeStr : String?
    
    @IBOutlet weak var rateLbl: UILabel!
    
    @IBOutlet weak var rateBtn: UIButton!
    
    @IBOutlet weak var dowloadLbl: UILabel!
    
    @IBOutlet weak var dowloadBtn: UIButton!
    
    @IBAction func rateBtnTapped(_ sender: Any) {
    }
    
    @IBAction func downloadBtnTapped(_ sender: Any) {
    }

    @IBOutlet weak var saveBtn: UIButton!
    var saveButtonCallback: ((_ addObj: String)->Void)?
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        saveBtn.layer.cornerRadius = saveBtn.frame.size.height/2
        saveBtn.clipsToBounds = true
        
        artistSaveBtn.layer.cornerRadius = artistSaveBtn.frame.size.height/2
        artistSaveBtn.clipsToBounds = true
        imgProfileImg.layer.cornerRadius = imgProfileImg.frame.size.height/2
        imgProfileImg.clipsToBounds = true
        audioSeekBar.setThumbImage(UIImage(named: "songSlider"), for: .normal)

    }
    
    
    //MARK:- OTHER ACTIONS
    func setup(){
        //localizeElements()
        mediaSetup()
    }
    
    func localizeElements(){
        //localize variable - media
        lblMyMedia.text = "my media".localize
        lblMediaAudio.text = "media audio".localize
        lblMediaVideo.text = "media video".localize
        lblmediaReplace.text = "replace".localize
        lblUserNoAudio.text = "user_no_audio".localize
        
        //localize variable - add media
        lblAddMediaMyMedia.text = "my media".localize
        lblAddMediaAudio.text = "media audio".localize
        lblAddMediaVideo.text = "media video".localize
        
        //localize variable - name audio
        lblAddAudio.text = "Add Audio".localize
        lblNameOfAudio.text = "name of audio".localize
        btnBack.setTitle("Back".localize, for: .normal)
        btnAdd.setTitle("Add".localize, for: .normal)
    }
    
    func savemediaValidation(){
        txtFieldAudioName.resignFirstResponder() 
    }
    
    func mediaSetup(){
        if UserModel.sharedInstance().userType! == "DJ"{
            
            if profileMedia != nil{
                if let audioName = profileMedia!.media_audio_name{
                    lblSampleName.text = audioName
                }
                if let byName = profileMedia!.media_audio_by{
                    lblDjName.text = "by \(byName)"
                }
                if let genre = profileMedia!.media_audio_genre{
                    lblGenre.text = "\(genre)"
                }
                if let audioFileName = profileMedia!.media_audio{
                    let songURL = URL(string: audioFileName)
                    apiSongData = audioFileName
                    preparePlayer(songURL)
                }
                if let videoFile = profileMedia!.media_video{
                    if let id = profileMedia!.media_broadcastID{
                        if id.isEmpty == false{
                            viewVideo.isHidden = false
                            lblMediaVideoDetail.isHidden = true
                            lblVi_holderName.text = "\(profileMedia!.username!)"
                            lblVi_byName.text = "By \(profileMedia!.media_video_by!)"
                            lblVi_ProjName.text = "\(profileMedia!.media_video_project!)"
                            lblVi_GenreName.text = "\(profileMedia!.media_video_genre!)"
                            if profileMedia!.media_ending!.isEmpty == false{
                                globalObjects.shared.isDjVideoTimer = true
                                mediaRemainingTime = profileMedia!.media_ending!.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                                startMediaTimer()
                            }
                            //apiVideoData = videoFile
                        }
                    }else if videoFile.isEmpty == false{
                        viewVideo.isHidden = false
                        lblMediaVideoDetail.isHidden = true
                        lblVi_holderName.text = "\(profileMedia!.username!)"
                        lblVi_byName.text = "By \(profileMedia!.media_video_by!)"
                        lblVi_ProjName.text = "\(profileMedia!.media_video_project!)"
                        lblVi_GenreName.text = "\(profileMedia!.media_video_genre!)"
                        apiVideoData = videoFile
                        
                    }else{
                        viewVideo.isHidden = true
                        lblMediaVideoDetail.isHidden = false
                    }
                }
                
                if apiSongData.isEmpty == true{
                    vwDjMedia.isHidden = true
                    vwArtistMedia.isHidden = false
                    mediaPageCalled()
                }else{
                    vwDjMedia.isHidden = false
                    vwArtistMedia.isHidden = true
                    addMediaView()
                }
            }
            if apiSongData.isEmpty{
                mediaPageCalled()
            }else{
                viewAddMedia.isHidden = true
                viewAddAudioBlur.isHidden = true
                viewNameAudio.isHidden = true
                viewActionSheet.isHidden = true
                viewMediaPage.isHidden = false
                let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
                imgProfileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            }
            vwDjMedia.isHidden = false
            vwArtistMedia.isHidden = true
            if apiVideoData.isEmpty == false || video_broadcastId.isEmpty == false{
                viewVideo.isHidden = false
                lblMediaVideoDetail.isHidden = true
            }else{
                viewVideo.isHidden = true
                lblMediaVideoDetail.isHidden = false
            }
        }else{
            if profileMedia != nil{
                video_verify_Id = "\(profileMedia!.media_video_id!)"
                global.audioName = profileMedia!.media_audio_name!
                video_broadcastId = profileMedia!.media_broadcastID!
                videoType = profileMedia!.media_video_project!
                if let videoFile = profileMedia!.media_audio{
                    if let id = profileMedia!.media_broadcastID{
                        if id.isEmpty == false{
                            viewVideo.isHidden = false
                            lblMediaVideoDetail.isHidden = true
                            lblVi_holderName.text = "\(profileMedia!.username!)"
                            lblVi_byName.text = "By \(profileMedia!.media_video_by!)"
                            lblVi_ProjName.text = "\(profileMedia!.media_video_project!)"
                            lblVi_GenreName.text = "\(profileMedia!.media_video_genre!)"
                            if profileMedia!.media_ending!.isEmpty == false{
                                globalObjects.shared.isArVideoTimer = true
                                mediaRemainingTime = profileMedia!.media_ending!.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                                startMediaTimer()
                            }
                        }
                    }else if videoFile.isEmpty == false{
                        viewVideo.isHidden = false
                        lblMediaVideoDetail.isHidden = true
                        lblVi_holderName.text = "\(profileMedia!.username!)"
                        lblVi_byName.text = "By \(profileMedia!.media_video_by!)"
                        lblVi_ProjName.text = "\(profileMedia!.media_video_project!)"
                        lblVi_GenreName.text = "\(profileMedia!.media_video_genre!)"
                        apiVideoData = videoFile
                        if profileMedia!.media_ending!.isEmpty == false{
                            globalObjects.shared.isArVideoTimer = true
                            mediaRemainingTime = profileMedia!.media_ending!.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                            startMediaTimer()
                        }
                    }else{
                        viewVideo.isHidden = true
                        lblMediaVideoDetail.isHidden = false
                    }
                }
            }
            if apiSongData.isEmpty == false{
                viewAddMedia.isHidden = true
                viewAddAudioBlur.isHidden = true
                viewNameAudio.isHidden = true
                viewActionSheet.isHidden = true
                viewMediaPage.isHidden = false
                let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
                imgProfileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                vwDjMedia.isHidden = false
                vwArtistMedia.isHidden = true
            }else{
                addMediaView()
                vwDjMedia.isHidden = true
                vwArtistMedia.isHidden = false
            }
            if apiVideoData.isEmpty == false || video_broadcastId.isEmpty == false{
                viewVideo.isHidden = false
                lblMediaVideoDetail.isHidden = true
            }else{
                viewVideo.isHidden = true
                lblMediaVideoDetail.isHidden = false
            }
        }
    }
    func mediaPageCalled() {
        viewMediaPage.isHidden = true
        viewAddMedia.isHidden = false
    }
    
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
            audioSeekBar.maximumValue = Float(Double(audioPlayer!.duration))
            audioPlayer?.currentTime = Double(audioSeekBar.value)
            lblMinTime.text = String(audioSeekBar.value)
            lblMaxTime.text = "\(minuteString):\(secondString)"
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }
    func addMediaView(){
        viewAddMedia.isHidden = true
        viewAddAudioBlur.isHidden = true
        viewNameAudio.isHidden = true
        viewActionSheet.isHidden = true
        viewMediaPage.isHidden = false
        if UserModel.sharedInstance().userProfileUrl != nil{
            let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
            imgProfileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        }else{
            imgProfileImg.setImage(UIImage(named: "user-profile")!)
        }
    }
    
    func startMediaTimer() {
        let releaseDateString = "\(mediaRemainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd"
        mediaReleaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        mediaCountDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMediaTime), userInfo: nil, repeats: true)
    }
    @objc func updateMediaTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: mediaReleaseDate! as Date)
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        if((diffDateComponents.day ?? 0) <= 0 && (diffDateComponents.hour ?? 0) <= 0 && (diffDateComponents.minute ?? 0) <= 0 && (diffDateComponents.hour ?? 0) <= 0){
            
            mediaCountDownTimer.invalidate()
            
            lblVi_AutodeleteTime.text = "0 DAY 0 HR 0 MIN 0 SEC"
            lblVi_AutodeleteTime.isHidden = true
            lblLo_AutoDeleteVideo.isHidden = true
            rateBtn.isHidden = true
            dowloadBtn.isHidden = true
            rateLbl.isHidden = true
            dowloadLbl.isHidden = true
            
        }
        else{
            lblLo_AutoDeleteVideo.isHidden = false
            lblVi_AutodeleteTime.isHidden = false
            rateBtn.isHidden = false           // "-18906 DAY -10 HR -52 MIN -2 SEC"
            dowloadBtn.isHidden = false
            rateLbl.isHidden = false
            dowloadLbl.isHidden = false
            lblVi_AutodeleteTime.text = countdown //1st time "-18906 DAY -10 HR -23 MIN -21 SEC" //  ashitesh
        }                                        // // second time- "-18906 DAY -10 HR -52 MIN -2 SEC"
        
    }
    //MARK:- SELECTOR ACTION
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
    //MARK:- BUTTON ACTION
    @IBAction func btnVi_PlayAction(_ sender: UIButton) {
        if UserModel.sharedInstance().userType == "AR"{
            if videoType == "SongReviewLive"{
                callArtistVideoWebService("\(video_broadcastId)")
            }
            if videoType == "SongReview"{
                let file = apiVideoData
                let videoURL = URL(string: "\(file)")
                let player = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                callVideoVerifyWebservice(audioId: "\(video_verify_Id)", type: "review")
            }
            if videoType == "project"{
                callArtistVideoWebService("\(video_broadcastId)")
            }
        }
    }
    @IBAction func btnReplaceAction(_ sender: UIButton) {
        
        viewAddMedia.isHidden = false
        viewMediaPage.isHidden = false
        viewNameAudio.isHidden = true
        viewActionSheet.isHidden = false
        viewAddAudioBlur.isHidden = false
        viewActionSheet.alpha = 1.0
        let screenRect = UIScreen.main.bounds
        let screenHeight = screenRect.size.height
        viewActionSheet.frame = CGRect(x: 0, y: (screenHeight - viewActionSheet.frame.height) , width: viewAddAudioBlur.frame.width, height: 250)
        viewAddAudioBlur.addSubview(viewActionSheet)
    }
    
    @IBAction func btnAudioSeekbarAction(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(audioSeekBar.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    @IBAction func btnAddAudioAction(_ sender: UIButton) {
        viewActionSheet.isHidden = false
        viewAddAudioBlur.isHidden = false
        
        viewActionSheet.alpha = 1.0
        let screenRect = UIScreen.main.bounds
        let screenHeight = screenRect.size.height
        viewActionSheet.frame = CGRect(x: 0, y: (screenHeight - viewActionSheet.frame.height) , width: viewAddAudioBlur.frame.width, height: 250)
        viewAddAudioBlur.addSubview(viewActionSheet)
    }
    
    @IBAction func btnOnlineStorageAction(_ sender: UIButton) {
        viewActionSheet.isHidden = true
        viewNameAudio.isHidden = false
        viewAddAudioBlur.isHidden = false
        viewNameAudio.alpha = 1.0
        NotificationCenter.default.post(name: Notification.Name(rawValue: "openDocumentPicker"), object: nil)
    }
    
    @IBAction func btnCancelAddAudioAction(_ sender: UIButton) {
        viewNameAudio.isHidden = true
        viewAddAudioBlur.isHidden = true
        viewAddMedia.isHidden = false
        viewActionSheet.removeFromSuperview()
    }
    
    @IBAction func btnBackofNameAudio(_ sender: UIButton) {
        viewNameAudio.isHidden = true
        viewActionSheet.isHidden = false
        viewAddAudioBlur.isHidden = false
        viewMediaPage.isHidden = true
        let screenRect = UIScreen.main.bounds
        let screenHeight = screenRect.size.height
        viewActionSheet.frame = CGRect(x: 0, y: (screenHeight - viewActionSheet.frame.height) , width: viewAddAudioBlur.frame.width, height: 250)
        viewAddAudioBlur.addSubview(viewActionSheet)
    }
    
    @IBAction func btnAddofNameAction(_ sender: UIButton) {
        callAddAudioWebService()
        viewAddMedia.isHidden = true
        viewAddAudioBlur.isHidden = true
        viewNameAudio.isHidden = true
        viewActionSheet.isHidden = true
        viewMediaPage.isHidden = false
        lblSampleName.text = txtFieldAudioName.text
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "Button - Play"){
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }else{
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "Button - Play"), for: .normal)
        }
    }
    
    //MARK:- WEBSERVICE CALLING
    func callVideoVerifyWebservice(audioId : String, type: String){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "audioid":"\(audioId)",
                "type":"\(type)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.videoVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let videoVerifyModel = response.result.value!
                    self.view.makeToast(videoVerifyModel.message)
                case .failure(let error):
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            view.makeToast("Please check your Internet Connection".localize)
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
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(brodcastID)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { [self] (response:DataResponse<VideoVerifyModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let videoModelProfile = response.result.value!
                    let uri = videoModelProfile.resourceUri
                    
                    let userDic = ["broadCastID: \(brodcastID), uri:\(uri!), video_verify_Id:\(self.video_verify_Id),videoType:\(self.videoType)"]
                    print("userDic",userDic)
                    
                     brodcastIDStr = brodcastID
                     uriStr = uri
                     video_verify_IdStr = self.video_verify_Id
                     videoTypeStr = self.videoType
                    
                    
                    //NotificationCenter.default.post(name: Notification.Name(rawValue: "openVideoView"), object: nil, userInfo: userdic)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "openVideoView"), object:userDic)
                    
                    //self.playVideoMedia()
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func playVideoMedia(){
        let broadCastID = brodcastIDStr
        let uri = uriStr
        let video_verify_Id = video_verify_IdStr
        let videoType = videoTypeStr
        
//        let next1 = UIStoryboard.init(name: "DJProfile", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as? ArtistBambUserPlayerVC
        
        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as? ArtistBambUserPlayerVC

        next1?.backType = "edit_profile"
     navigationController?.pushViewController(next1!, animated: false)
        
//        next1!.broadCastID = broadCastID!
//        next1!.uri = uri!
//        next1!.id = video_verify_Id!
//        if videoType == "SongReviewLive"{
//            next1?.videoType = "review"
//        }
//        if videoType == "project"{
//            next1?.videoType = "project"
//        }
        
        //self.navigationController?.pushViewController(next1!, animated: true)
        
        
        //let storyBoard = UIStoryboard(name: "DJProfile", bundle: Bundle.main)
        //let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as? ArtistBambUserPlayerVC
        
//        next1?.broadCastID = broadCastID!
//        next1?.uri = uri!
//        next1?.id = video_verify_Id!
//        if videoType == "SongReviewLive"{
//            next1?.videoType = "review"
//        }
//        if videoType == "project"{
//            next1?.videoType = "project"
//        }
        //next1?.backType = "edit_profile"
    // navigationController?.pushViewController(next1!, animated: false)
    }
    
    func callAddAudioWebService(){
        
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "media_audio_name":"\(txtFieldAudioName.text!)",
            ]
            
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addMediaAudioAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    multipartFormData.append(self.songData! as Data, withName: "media_audio", fileName: "audio.mp3", mimeType: "audio/mp3")
                }
            }, to: serviceURL) { (result) in
                switch result {
                case .success(let upload,_,_):
                    upload.uploadProgress(closure: { (progress) in
                        CommonFunctions.shared.showProgress(progress: CGFloat(progress.fractionCompleted))
                    })
                    upload.responseObject(completionHandler: { (response:DataResponse<AddMediaModel>) in
                        switch response.result {
                        case .success(_):
                            CommonFunctions.shared.hideLoader()
                            let addMediaProfile = response.result.value!
                            if addMediaProfile.success == 1{
                                self.view.makeToast(addMediaProfile.message)
                                self.apiSongData = (addMediaProfile.audioData)!
                                self.lblMinTime.text = "00:00"
                                self.lblMaxTime.text = self.minuteString + ":" + self.secondString
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
            view.makeToast("Please check your Internet Connection".localize)
        }
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        //callEditProfileWebService()
        if let call = self.saveButtonCallback{
            call("save")
            
        }
        
    }
    
    func callEditProfileWebService(){

//        if getReachabilityStatus(){
//            if(UserModel.sharedInstance().countryServiceName == "" || UserModel.sharedInstance().countryServiceName == nil){
//            }
//
//            let parameters = [
//                "usertype":"\(UserModel.sharedInstance().userType!)",
//                "userid":"\(UserModel.sharedInstance().userId!)",
//                "token":"\(UserModel.sharedInstance().token!)",
//
//                "genre_ids":"\(self.genreIds)",
//               // "name":"\(vwProfilePage!.textfieldDjname.text!)", //  now coomented
//
//                /* previous commented below */
////                "city":"\(vwProfilePage!.textfieldCurrentcity.text!)",
// //               "name":"\(UserModel.sharedInstance().uniqueUserName ?? "")",
//                //"city":"\(UserModel.sharedInstance().cityServiceName!)",
//                //"country":"\(UserModel.sharedInstance().countryServiceName!)",
//                //"latitude":"\(UserModel.sharedInstance().serviceLatitude ?? 0.0)",
//                //"longitude":"\(UserModel.sharedInstance().serviceLongitude ?? 0.0)",
//                //"bio":"\(vwProfilePage!.textfieldYourBio.text!)",
//                /* previous commented upper */
//
//                "city":"\(djCurrentCity)",
//                "state":"",
//                "state_code":"",
//                "country":getCountry!,
//                "postalcode":"110062",
//                "profileid":"\(UserModel.sharedInstance().userId!)",
//                "username":"\(UserModel.sharedInstance().uniqueUserName ?? "")",
//                "bio":"\(djYourBio)",
//                "latitude":"\(getLatVal ?? 0.0)",
//                "longitude":"\(getLongVal ?? 0.0)",
//
//                // now commented
////                "facebook_link":"\(vwProfilePage!.tfFacebookLink.text ?? "")",
////                "twitter_link":"\(vwProfilePage!.tfTwitterLink.text!)",
////                "instagram_link":"\(vwProfilePage!.tfInstagramLink.text!)",
////                "youtube_link":"\(vwProfilePage!.tfYoutubeLink.text!)",
//                "media_audio_name":"",
//                "dj_feedback":"",
//                "dj_feedback_status":"",
//                "dj_feedback_currency":"",
//                "dj_feedback_price":"0",
//                "is_dj_feedback_varying":"0",
//                "dj_feedback_range1":"0",
//                "dj_feedback_range2":"0",
//                "dj_drops":"",
//                "dj_drops_status":"off",
//                "dj_drops_currency":"INR",
//                "dj_drops_price":"0",
//                "is_dj_drop_varying":"0",
//                "dj_drop_range1":"0",
//                "dj_drop_range2":"0",
//                "dj_remix":"",
//                "dj_remix_status":"",
//                "dj_remix_currency":"",
//                "dj_remix_price":"0",
//                "is_dj_remix_varying" : "0",
//                "dj_remix_range1":"0",
//                "dj_remix_range2":"0",
//            ]
//            Loader.shared.show()
//            print("EditProfile:",parameters)
//           // let profileImage = self.imgProfile.image?.jpegData(compressionQuality: 0.5) //now
//            let serviceURL = URL(string: "\(webservice.url)\(webservice.saveProfileAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
//            Alamofire.upload(multipartFormData: { (multipartFormData) in
//
////                if profileImage != nil {
////                    multipartFormData.append(profileImage!, withName: "profile_image",fileName: "image.png", mimeType: "image/png")
////                } // now
//
//                for (key, value) in parameters {
//                    print("key \(key) and value \(value)")
//                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//
//                    if self.songData != nil {
//                        multipartFormData.append(self.songData! as Data, withName: "media_audio", fileName: "audio.mp3", mimeType: "audio/mp3")
//                    }
//                }
//            }, to: serviceURL) { (result) in
//                switch result {
//                case .success(let upload,_,_):
//
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//
//                    upload.responseObject(completionHandler: { (response:DataResponse<EditProfileModel>) in
//                        switch response.result {
//                        case .success(_):
//                            Loader.shared.hide()
//                            if(self.isProfileImgSelected == true){
//                            self.view.makeToast("Profile Pic is updated")
//                            }
//
//                            let editProfileModel = response.result.value!
//                            if editProfileModel.success == 1{
//
//                                self.view.makeToast(editProfileModel.message)
//                                if UserModel.sharedInstance().finishProfile == true{
//                                    self.changeRoot()
//                                }else{
//                                    self.btnClose_Action(UIButton())
//                                }
//                                UserModel.sharedInstance().finishProfile = false
//                               // UserModel.sharedInstance().genereList = self.vwProfilePage!.textfieldMusicgenre.text! // now coomntd
//                                UserModel.sharedInstance().genereList = UserModel.sharedInstance().genrePro
//                               // UserModel.sharedInstance().uniqueUserName = self.vwProfilePage!.textfieldDjname.text! // now coomntd
//                               // UserModel.sharedInstance().bioServiceName = self.vwProfilePage!.textfieldYourBio.text! // now coomntd
//
//
//                                UserModel.sharedInstance().countryServiceName = self.djCurrentCity
//                                globalObjects.shared.profileCompleted = true
//                                UserModel.sharedInstance().synchroniseData()
//
//                                self.callGetProfileWebService()
//                            }else{
//                                Loader.shared.hide()
//                                self.view.makeToast(editProfileModel.message)
//                            }
//                        case .failure(let error):
//                            Loader.shared.hide()
//                            debugPrint(error)
//                            print("Error")
//                        }
//
//                    })
//                case .failure(let error):
//                    Loader.shared.hide()
//                    print(error)
//                    break
//                }
//            }
//        }else{
//            self.view.makeToast("Please check your Internet Connection".localize)
//        }
    }
    
}
extension EditMediaVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlayPause.setImage(UIImage(named:"audio-play"),for: .normal)
    }
}
