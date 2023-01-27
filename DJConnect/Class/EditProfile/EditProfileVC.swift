//
//  ProfileVC.swift
//  DJConnect
//
//  Created by My Mac on 13/03/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import DropDown
import AVFoundation
import Alamofire
import AlamofireObjectMapper
import MediaPlayer
import LocationPickerViewController
import MobileCoreServices
import AVKit



class EditProfileVC: UIViewController, UIPopoverControllerDelegate {

    //MARK:- OUTLETS
//    @IBOutlet weak var lblUserName: UILabel!
//    @IBOutlet weak var lblProfileCurrentCity: UILabel!
//    @IBOutlet weak var lblMusicGenere: UILabel!
//    @IBOutlet weak var lblCurrentCity: UILabel!
//    @IBOutlet weak var lblProfileMusicGenre: UILabel!
//    @IBOutlet weak var lblProfileBio: UILabel!
//    @IBOutlet weak var lblprofileConnect: UILabel!
    @IBOutlet weak var tfFacebookLink: UITextField!
    @IBOutlet weak var tfTwitterLink: UITextField!
    @IBOutlet weak var tfInstagramLink: UITextField!
    @IBOutlet weak var tfYoutubeLink: UITextField!
//    @IBOutlet weak var textfieldDjname: UITextField!
//    @IBOutlet weak var textfieldCurrentcity: UITextField!
//    @IBOutlet weak var textfieldMusicgenre: UITextField!
//    @IBOutlet weak var textfieldYourBio: UITextView!
    
    @IBOutlet weak var currencyvw: UIView!
    @IBOutlet weak var usernameTxtFld: UITextField!
    @IBOutlet weak var currentCityTxtFld: UITextField!
    @IBOutlet weak var musicGenreTxtFld: UITextField!
    
    @IBOutlet weak var curntCityVw: UIView!
    @IBOutlet weak var musicGenreVw: UIView!
    @IBOutlet weak var yourBioBgVw: UIView!
    @IBOutlet weak var yourBioLbl: UILabel!
    @IBOutlet weak var yourBioTxtVw: UITextView!
    @IBOutlet weak var conctSocialLbl: UILabel!
    @IBOutlet weak var belowLbl: UILabel!
    @IBOutlet weak var fbLinkVw: UIView!
    @IBOutlet weak var twitterLinkVw: UIView!
    @IBOutlet weak var instaLinkVw: UIView!
    @IBOutlet weak var fbLinkBtn: UIButton!
    @IBOutlet weak var twitrLinkBtn: UIButton!
    @IBOutlet weak var instaLinkBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    

    
    let startingIndex = 400
   // var imageViewSelected = image.profileImage
    var calendarCellWidth = 35
    var buttonSelected = String()
    let feedbackCurrDropDown = DropDown()
    let dropCurrDropDown = DropDown()
    let remixCurrDropDown = DropDown()
    var audioPlayer: AVAudioPlayer?
    var isSearchEnabled = false
    var genreIndex = [String]()
    //var citySelected = cityColumn.home_city
    
    var homecity_latitude = String()
    var homecity_longitude = String()
    var homecity_stateName = String()
    var currentcity_latitude = String()
    var currentcity_longitude = String()
    var currentcity_stateName = String()
    var currentcity_country = String()
    var codePostal = String()
    var feedbackStatus = String()
    var dropStatus = String()
    var remixStatus = String()
    var initialName = String()
    var currList = [CurrencyDataDetail]()
    var arrTest = [String]()
    var stringArrayCleaned = String()
    var genreId = String()
    var avMusicPlayer: AVAudioPlayer!
    var mpMediapicker: MPMediaPickerController!
    var mediaItems = [MPMediaItem]()
    let currentIndex = 0
    var songData : NSData? = nil
    var apiSongData = String()
    var isPlaying = false
    var minuteString = String()
    var secondString = String()
    var priceFeedback = String()
    var currencyFeedback = String()
    var priceDrop = String()
    var currencyDrop = String()
    var apiVideoData = String()
    var mediaRemainingTime = String()
    var mediaReleaseDate: NSDate?
    var mediaCountDownTimer = Timer()
    var videoType = String()
    var video_broadcastId = String()
    var video_verify_Id = String()
    var dj_feedback_varying = Int()
    var dj_drop_varying = Int()
    var dj_remix_varying = Int()
    var dj_feedback_range1 = Int()
    var dj_feedback_range2 = Int()
    var dj_drop_range1 = Int()
    var dj_drop_range2 = Int()
    var dj_remix_range1 = Int()
    var dj_remix_range2 = Int()
    var feedback_currency_name = String()
    var drop_currency_name = String()
    var remix_currency_name = String()
    var arrGenereIndex = [String]()
    var arrGenereList = [String]()
    var arrSelectedGenreIndex = [Int]()
    var latitude : Double?
    var longitude : Double?
    var isFromHome : Bool?
    var genreIds = "1"
//    var gerneDataObj = [GenreData]()
    
    //Genere variable
    var genreNames = "Rock"
    var picker: UIImagePickerController = UIImagePickerController()
    
    //MARK:- GLOBAL VARAIBLE
    var profileData : ProfileDataModel?
        
    var callBackCancelBtn: ((_ addObj: String)->Void)?
    var serviceButtonCallback: ((_ addObj: String)->Void)?
    var window: UIWindow?
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //GetGenreList()
       // NotificationCenter.default.addObserver(self, selector: #selector(genreList(_:)), name: Notification.Name(rawValue: "genreProfile"), object: nil)
        //setupData()
        
        //print("profile:", profileData?.genre)
        // api is not running
        setUpVw()
        
        usernameTxtFld.text = UserModel.sharedInstance().uniqueUserName!
        //callCurrencyListWebService()
       // if UserModel.sharedInstance().finishProfile == false{
            if UserModel.sharedInstance().userType == "DJ"{
                callGetProfileWebService()
            }else{
                callArtistGetProfileWebService()
            }
        //}
        if globalObjects.shared.profileCompleted == false{
            //btnCloseProfile.isEnabled = false
        }else{
            //btnCloseProfile.isEnabled = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        //setView()
    }
    
    //Image picker code
    func openGallary()
    {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.mediaTypes = ["public.image"]
        present(picker, animated: true, completion: {self.picker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black})
        
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        }else{
            self.showAlertView("This device has no Camera", "Camera Not Found")
        }
    }
    
    func choosePhoto() {
        let alertController = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let CameraAction = UIAlertAction(title: "Take a Photo", style: .default) { (ACTION) in
            self.openCamera()
        }
        let GalleryAction = UIAlertAction(title: "Open Gallery", style: .default) { (ACTION) in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (ACTION) in
            
        }
        alertController.addAction(CameraAction)
        alertController.addAction(GalleryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
         let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
    
//    @objc func genreList(_ notification : Notification){
//        guard let names = notification.userInfo?["names"] as? String else { return }
//        guard let ids = notification.userInfo?["ids"] as? String else { return }
//        self.genreNames = names
//        self.genreIds = ids
//        textfieldMusicgenre.text = self.genreNames
//    }
    
    
    func callArtistGetProfileWebService(){
        if getReachabilityStatus(){
            //calendar date fetch
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print(dateFormatter.string(from: date))
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&current_date=\(dateFormatter.string(from: date))&profileviewid=\(UserModel.sharedInstance().userId!)&profileviewtype=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        UserModel.sharedInstance().finishProfile = false
                        if(getProfile.Profiledata![0].username == ""){
                            if UserModel.sharedInstance().uniqueUserName != nil{
                                self.usernameTxtFld.text = "\(UserModel.sharedInstance().uniqueUserName!)"
                            }
                        }
                        else{
                        self.usernameTxtFld.text = getProfile.Profiledata![0].username!
                        }
                            self.currentCityTxtFld.text = getProfile.Profiledata![0].city!
                        self.video_verify_Id = "\(getProfile.Profiledata![0].media_video_id!)"
                        global.audioName = getProfile.Profiledata![0].media_audio_name!
                        self.video_broadcastId = getProfile.Profiledata![0].media_broadcastID!
                        self.videoType = getProfile.Profiledata![0].media_video_project!
                        
                        self.yourBioTxtVw.text = getProfile.Profiledata![0].bio!
                        if let profileImageUrl = getProfile.Profiledata![0].profile_picture{
                            let url = URL(string: profileImageUrl)
                           // self.imgProfileImage.kf.setImage(with: url, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        }
                        if let userProfileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!){
                            //self.imgProfileImg.kf.setImage(with: userProfileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        }
                        
                        if let fbLink = getProfile.Profiledata![0].facebook_link{
                            self.tfFacebookLink.text = fbLink
                        }
                        if let tweetLink = getProfile.Profiledata![0].twitter_link{
                            self.tfTwitterLink.text = tweetLink
                        }
                        if let instaLink = getProfile.Profiledata![0].instagram_link{
                            self.tfInstagramLink.text = instaLink
                        }
                        if let youTubeLink = getProfile.Profiledata![0].youtube_link{
                           // self.tfYoutubeLink.text = youTubeLink
                        }
                        
                        self.genreIds = (getProfile.Profiledata?[0].genre_ids!) ?? "1"
                        self.genreNames = (getProfile.Profiledata?[0].genre!) ?? "Rock"
                        self.musicGenreTxtFld.text = self.genreNames
                        //self.lblGenre.text = self.genreNames
                        
                        if let audioName = getProfile.Profiledata![0].media_audio_name{
                            //self.lblSampleName.text = audioName
                        }
                        if let byName = getProfile.Profiledata![0].media_audio_by{
                           // self.lblDjName.text = "by \(byName)"
                        }
                        if let genre = getProfile.Profiledata![0].media_audio_genre{
                            //self.lblGenre.text = "\(genre)"
                        }
                        if let audioFileName = getProfile.Profiledata![0].media_audio{
                            let songURL = URL(string: audioFileName)
                            self.apiSongData = audioFileName
                           // self.preparePlayer(songURL)

                        }
                        if let lat = getProfile.Profiledata![0].latitude{
                            if lat.isEmpty == true{
                                globalObjects.shared.addLat = UserModel.sharedInstance().currentLatitude ?? 0.0
                            }else{
                                globalObjects.shared.addLat = Double(lat)
                            }
                        }
                        if let long = getProfile.Profiledata![0].longitude {
                            if long.isEmpty == true{
                                globalObjects.shared.addLong = UserModel.sharedInstance().currentLongitude ?? 0.0
                            }else{
                                globalObjects.shared.addLong = Double(long)
                            }
                        }
                        if let videoFile = getProfile.Profiledata![0].media_video{
                            if let id = getProfile.Profiledata![0].media_broadcastID{
                                if id.isEmpty == false{
//                                    self.viewVideo.isHidden = false
//                                    self.lblMediaVideoDetail.isHidden = true
//                                    self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
//                                    self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
//                                    self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
//                                    self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
                                    if getProfile.Profiledata![0].media_ending!.isEmpty == false{
                                        globalObjects.shared.isArVideoTimer = true
                                        self.mediaRemainingTime = getProfile.Profiledata![0].media_ending!.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                                        //self.startMediaTimer()
                                    }
                                }
                            }else if videoFile.isEmpty == false{
//                                self.viewVideo.isHidden = false
//                                self.lblMediaVideoDetail.isHidden = true
//                                self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
//                                self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
//                                self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
//                                self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
                                self.apiVideoData = videoFile
                                let url = URL(string: "\(videoFile)")
                                if getProfile.Profiledata![0].media_ending!.isEmpty == false{
                                    globalObjects.shared.isArVideoTimer = true
                                    self.mediaRemainingTime = getProfile.Profiledata![0].media_ending!.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                                   // self.startMediaTimer()
                                }
                            }else{
//                                self.viewVideo.isHidden = true
//                                self.lblMediaVideoDetail.isHidden = false
                            }
                        }
                        if self.buttonSelected == "media"{
                            if self.apiSongData.isEmpty == false{
//                                self.addMediaView()
//                                self.vwArtistMedia.isHidden = true
//                                self.vwDjMedia.isHidden = false
                            }else{
//                                self.addMediaView()
//                                self.vwArtistMedia.isHidden = false
//                                self.vwDjMedia.isHidden = true
                            }
                        }
                        
                        self.genreIds = (getProfile.Profiledata?[0].genre_ids!) ?? "1"
                        self.genreNames = (getProfile.Profiledata?[0].genre!) ?? "Rock"
                       
                    }else{
                        self.view.makeToast(getProfile.message)
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
    
    func callGetProfileWebService(){
        if getReachabilityStatus(){
            //calendar date fetch
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print(dateFormatter.string(from: date))
            //
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&current_date=\(dateFormatter.string(from: date))&profileviewid=\(UserModel.sharedInstance().userId!)&profileviewtype=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        //self.lblFeedbackPlaceholder.isHidden = true
                        //self.lblDropPlaceholder.isHidden = true
                       // self.lblRemixPlaceholder.isHidden = true
                        UserModel.sharedInstance().finishProfile = false
                        if(getProfile.Profiledata![0].username == ""){
                            if UserModel.sharedInstance().uniqueUserName != nil{
                                self.usernameTxtFld.text = "\(UserModel.sharedInstance().uniqueUserName!)"
                            }
                        }
                        else{
                        self.usernameTxtFld.text = getProfile.Profiledata![0].username!
                        }
                        //self.usernameTxtFld.text = getProfile.Profiledata![0].username!
                        self.currentCityTxtFld.text = getProfile.Profiledata![0].city!
                        self.yourBioTxtVw.text = getProfile.Profiledata![0].bio!
            
                        if let lat = getProfile.Profiledata![0].latitude{
                            if lat.isEmpty == true{
                                globalObjects.shared.addLat = UserModel.sharedInstance().currentLatitude ?? 0.0
                            }else{
                                globalObjects.shared.addLat = Double(lat)
                            }
                        }
                        if let long = getProfile.Profiledata![0].longitude {
                            if long.isEmpty == true{
                                globalObjects.shared.addLong = UserModel.sharedInstance().currentLongitude ?? 0.0
                            }else{
                                globalObjects.shared.addLong = Double(long)
                            }
                        }
                        if let profileImageUrl = getProfile.Profiledata![0].profile_picture{
                            
                            let url = URL(string: profileImageUrl)
                             //self.imgProfileImage.kf.setImage(with: url, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        }
                        if let x = UserModel.sharedInstance().userProfileUrl{
                            if let userProfileImageUrl = URL(string: x){
                                //self.imgProfileImg.kf.setImage(with: userProfileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                        }
                        if let feedbackDetail = getProfile.Profiledata?[0].dj_feedback_drops{
                            if feedbackDetail.count > 0{
//
                                if let dj_feedback = feedbackDetail[0].dj_feedback{
//                                    self.textViewFeedBackDetail.text = dj_feedback
//                                    let x : String = self.textViewFeedBackDetail.text!
//                                    self.lblFeedbackCount.text = "\(x.count)/200"
//                                    if dj_feedback.isEmpty == true{
//                                        self.lblFeedbackPlaceholder.isHidden = false
//                                    }
                                }
                            }
                        }
//                                if let dj_feedback_currency = feedbackDetail[0].dj_feedback_currency{
//                                    self.lblServiceFeedbackPrice.text = "Price(" + dj_feedback_currency + ")"
//                                    self.lblSongReviewRangePrice.text = "Price(" + dj_feedback_currency + ")"
//                                }
//
//                                if let feedback_vary = feedbackDetail[0].is_dj_feedback_varying{
//                                    if feedback_vary == 0{
//                                        self.txtFieldFeedback.text = "Fixed"
//                                        self.vwFixedSongReview.isHidden = false
//                                        self.vwRangeSongReview.isHidden = true
//                                        self.dj_feedback_varying = 0
//                                    }else{
//                                        self.txtFieldFeedback.text = "Varies"
//                                        self.vwFixedSongReview.isHidden = true
//                                        self.vwRangeSongReview.isHidden = false
//                                        self.dj_feedback_varying = 1
//                                    }
//                                }
//
//                                if let SongReviewRange1 = feedbackDetail[0].dj_feedback_range1{
//                                    self.txfSongReviewMin.text = "\(SongReviewRange1)"
//                                }
//
//                                if let SongReviewRange2 = feedbackDetail[0].dj_feedback_range2{
//                                    self.txfSongReviewMax.text = "\(SongReviewRange2)"
//                                }
//
//                                if var dj_feedback_price = feedbackDetail[0].dj_feedback_price{
//                                    let removedSymbol = dj_feedback_price.removeFirst()
//                                    self.lblFeedbackCurrSymbol.text = "\(removedSymbol)"
//                                    self.textFieldFeedbackPrice.text = dj_feedback_price
//                                }
//
//                                if let dj_drops = feedbackDetail[0].dj_drops{
//                                    self.textViewDropDetail.text = dj_drops
//                                    let x : String = self.textViewDropDetail.text!
//                                    self.lblDropCount.text = "\(x.count)/200"
//                                }
//
//                                if let dj_drops_currency = feedbackDetail[0].dj_drops_currency{
//                                     self.lblServiceDropPrice.text = "Price(" + dj_drops_currency + ")"
//                                    self.lblDropRangePrice.text = "Price(" + dj_drops_currency + ")"
//                                }
//
//                                if let drop_vary = feedbackDetail[0].is_dj_drop_varying{
//                                    if drop_vary == 0{
//                                        self.txtFieldDrop.text = "Fixed"
//                                        self.vwFixedDrop.isHidden = false
//                                        self.vwRangeDrop.isHidden = true
//                                        self.dj_drop_varying = 0
//
//                                    }else{
//                                        self.txtFieldDrop.text = "Varies"
//                                        self.vwFixedDrop.isHidden = true
//                                        self.vwRangeDrop.isHidden = false
//                                        self.dj_drop_varying = 1
//
//                                    }
//                                }
//
//                                if let DropRange1 = feedbackDetail[0].dj_drop_range1{
//                                    self.txfDropMin.text = "\(DropRange1)"
//                                }
//
//                                if let DropRange2 = feedbackDetail[0].dj_drop_range2{
//                                    self.txfDropMax.text = "\(DropRange2)"
//                                }
//
//                                if var dj_drops_price = feedbackDetail[0].dj_drops_price{
//                                    let removedPriceSymbol = dj_drops_price.removeFirst()
//                                    self.lblDropCurrSymbol.text = "\(removedPriceSymbol)"
//                                    self.textFieldDropPrice.text = dj_drops_price
//                                }
//
//                                if let fbckStatus = feedbackDetail[0].dj_feedback_status{
//                                    if fbckStatus == "on" {
//                                        self.feedbackStatus = "on"
//                                        self.setFeedbackON()
//                                    }else{
//                                        self.feedbackStatus = "off"
//                                        self.setFeedbackOFF()
//                                    }
//                                }
//                                if let drpStatus = feedbackDetail[0].dj_drops_status{
//                                    if drpStatus == "on" {
//                                        self.dropStatus = "on"
//                                        self.setDropON()
//                                    }else{
//                                        self.dropStatus = "off"
//                                        self.setDropOFF()
//                                    }
//                                }
//
//                                if var dj_remix_price = feedbackDetail[0].dj_remix_price{
//                                    let removedPriceSymbol = dj_remix_price.removeFirst()
//                                    self.lblRemixCurrSymbol.text = "\(removedPriceSymbol)"
//                                    self.textFieldRemixPrice.text = dj_remix_price
//                                }
//
//                                if let dj_remix = feedbackDetail[0].dj_remix{
//                                    self.textViewRemixDetail.text = dj_remix
//                                    let x : String = self.textViewRemixDetail.text!
//                                    self.lblRemixCount.text = "\(x.count)/200"
//                                }
//
//                                if let remixStatus = feedbackDetail[0].dj_remix_status{
//
//                                    if remixStatus == "on" {
//                                        self.remixStatus = "on"
//                                        self.setRemixON()
//                                    }else{
//                                        self.remixStatus = "off"
//                                        self.setRemixOFF()
//                                    }
//                                }
//
//                                if let drop_vary = feedbackDetail[0].is_dj_remix_varying{
//                                    if drop_vary == 0{
//                                        self.txtFieldRemix.text = "Fixed"
//                                        self.vwFixedRemix.isHidden = false
//                                        self.vwRangeRemix.isHidden = true
//                                        self.dj_remix_varying = 0
//
//                                    }else{
//                                        self.txtFieldRemix.text = "Varies"
//                                        self.vwFixedDrop.isHidden = true
//                                        self.vwRangeDrop.isHidden = false
//                                        self.dj_remix_varying = 1
//
//                                    }
//                                }
//
//                                if let DropRange1 = feedbackDetail[0].dj_drop_range1{
//                                    self.txfRemixMin.text = "\(DropRange1)"
//                                }
//
//                                if let DropRange2 = feedbackDetail[0].dj_drop_range2{
//                                    self.txfRemixMax.text = "\(DropRange2)"
//                                }
//
//                                if let dj_remix_currency = feedbackDetail[0].dj_remix_currency{
//                                    self.lblServiceRemixPrice.text = "Price(" + dj_remix_currency + ")"
//                                    self.lblRemixRangePrice.text = "Price(" + dj_remix_currency + ")"
//                                }
//                            }
                        //}
                       
                        if let fbLink = getProfile.Profiledata![0].facebook_link{
                            self.tfFacebookLink.text = fbLink
                            //self.fbLinkBtn.setTitle(fbLink, for: .normal)
                        }
                        if let tweetLink = getProfile.Profiledata![0].twitter_link{
                            self.tfTwitterLink.text = tweetLink
                            //self.twitrLinkBtn.setTitle(tweetLink, for: .normal)
                        }
                        if let instaLink = getProfile.Profiledata![0].instagram_link{
                            self.tfInstagramLink.text = instaLink
                            //self.instaLinkBtn.setTitle(instaLink, for: .normal)
                        }
                        if let youTubeLink = getProfile.Profiledata![0].youtube_link{
                            //self.tfYoutubeLink.text = youTubeLink
                        }
                       
                        self.genreIds = (getProfile.Profiledata?[0].genre_ids!) ?? "1"
                        self.genreNames = (getProfile.Profiledata?[0].genre!) ?? "Rock"
                        self.musicGenreTxtFld.text = self.genreNames
                        //self.lblGenre.text = self.genreNames
                        
//                        if let audioName = getProfile.Profiledata![0].media_audio_name{
//                            self.lblSampleName.text = audioName
//                        }
//                        if let byName = getProfile.Profiledata![0].media_audio_by{
//                            self.lblDjName.text = "by \(byName)"
//                        }
//                        if let genre = getProfile.Profiledata![0].media_audio_genre{
//                            self.lblGenre.text = "\(genre)"
//                        }
//                        if let audioFileName = getProfile.Profiledata![0].media_audio{
//                            let songURL = URL(string: audioFileName)
//                            self.apiSongData = audioFileName
//                            self.preparePlayer(songURL)
//                        }
//                        if let videoFile = getProfile.Profiledata![0].media_video{
//                            if let id = getProfile.Profiledata![0].media_broadcastID{
//                                if id.isEmpty == false{
//                                    self.viewVideo.isHidden = false
//                                    self.lblMediaVideoDetail.isHidden = true
//                                    self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
//                                    self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
//                                    self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
//                                    self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
//                                    if getProfile.Profiledata![0].media_ending!.isEmpty == false{
//                                        globalObjects.shared.isDjVideoTimer = true
//                                        self.mediaRemainingTime = getProfile.Profiledata![0].media_ending!.localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
//                                        self.startMediaTimer()
//                                    }
//                                }
//                            }else if videoFile.isEmpty == false{
//                                self.viewVideo.isHidden = false
//                                self.lblMediaVideoDetail.isHidden = true
//                                self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
//                                self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
//                                self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
//                                self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
//                                self.apiVideoData = videoFile
//                            }else{
//                                self.viewVideo.isHidden = true
//                                self.lblMediaVideoDetail.isHidden = false
//                                if self.buttonSelected == "media"{
//                                    self.cnsViewMainHeight.constant = 445
//                                }
//                            }
//                        }
//                        if self.buttonSelected == "media"{
//                                if self.apiSongData.isEmpty == true{
//                                    self.vwDjMedia.isHidden = true
//                                    self.vwArtistMedia.isHidden = false
//                                    self.mediaPageCalled()
//                                }else{
//                                    self.vwDjMedia.isHidden = false
//                                    self.vwArtistMedia.isHidden = true
//                                    self.addMediaView()
//                                }
//                        }
                        self.genreIds = (getProfile.Profiledata?[0].genre_ids!) ?? "1"
                        self.genreNames = (getProfile.Profiledata?[0].genre!) ?? "Rock"
                    }else{
                        self.view.makeToast(getProfile.message)
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
    
//    func callCurrencyListWebService(){
//        if let currencySymbol = UserModel.sharedInstance().userCurrency{
////            self.feedback_currency_name = UserModel.sharedInstance().currency_name!
////            self.lblServiceFeedbackPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
////            self.lblSongReviewRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//            self.lblFeedbackCurrSymbol.text = currencySymbol
//            self.lblSongReviewRangeSymbol1.text = currencySymbol
//            self.lblSongReviewRangeSymbol2.text = currencySymbol
////            self.drop_currency_name = UserModel.sharedInstance().currency_name!
////            self.remix_currency_name = UserModel.sharedInstance().currency_name!
////            self.lblServiceDropPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
////            self.lblDropRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//            self.lblDropCurrSymbol.text = currencySymbol
//            self.lblDropRangeSymbol1.text = currencySymbol
//            self.lblDropRangeSymbol2.text = currencySymbol
////            self.lblServiceRemixPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//            self.lblRemixCurrSymbol.text = currencySymbol
//
//            if(UserModel.sharedInstance().currency_name == "IN"){
//                UserModel.sharedInstance().currency_name = "INR"
//
//                self.lblServiceRemixPrice.text = "Price(" + "INR" + ")"
//                self.drop_currency_name = "INR"
//                self.remix_currency_name = "INR"
//                self.lblServiceDropPrice.text = "Price(" + "INR" + ")"
//                self.lblDropRangePrice.text = "Price(" + "INR" + ")"
//                self.feedback_currency_name = "INR"
//                self.lblServiceFeedbackPrice.text = "Price(" + "INR" + ")"
//                self.lblSongReviewRangePrice.text = "Price(" + "INR" + ")"
//
//            }
//            else{
//                self.lblServiceRemixPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//                self.drop_currency_name = UserModel.sharedInstance().currency_name!
//                self.remix_currency_name = UserModel.sharedInstance().currency_name!
//                self.lblServiceDropPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//                self.lblDropRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//                self.feedback_currency_name = UserModel.sharedInstance().currency_name!
//                self.lblServiceFeedbackPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//                self.lblSongReviewRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//            }
//        }
//    }
    
    @IBAction func openContryPickerbtnTapped(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "openLocationPicker"), object: nil)
    }
    
    @IBAction func genreBtnTapped(_ sender: Any) {
//        let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SelectGenreVC") as! SelectGenreVC
//        desiredViewController.arrGenrelist = self.gerneDataObj
//        desiredViewController.callbackGenreData = {  gerneData in
//            self.gerneDataObj.removeAll()
//            self.gerneDataObj = gerneData
//            dump(self.gerneDataObj)
//
//            var gerneSelectedList = [GenreData]()
//            for data in self.gerneDataObj{
//                if data.isSelected{
//                    gerneSelectedList.append(data)
//                }
//            }
//            let txtgern: [String] = gerneSelectedList.map{$0.title} as? [String] ?? []
//            let data = txtgern.joined(separator: ", ")
//
//            let txtgernId: [String] = gerneSelectedList.map{String($0.id!)} as? [String] ?? []
//            //let dataid = txtgernId.joined(separator: ",")
//            let dataid = txtgernId.joined(separator: ",")
//            print("generIdValue",dataid)
//            self.musicGenreTxtFld.text = data
//            self.genreIds = dataid
//        }
//        self.navigationController?.pushViewController(desiredViewController, animated: false)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "openGenereVC"), object: nil)
    }
    
    //MARK: - OTHER METHODS
//    func GetGenreList() {
//        if getReachabilityStatus(){
//            let requestUrl = "\(webservice.url)\(webservice.getGenreAPI)?token=&userid="
//            
//            Loader.shared.show()
//            Alamofire.request(getServiceURL(requestUrl), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GenreModel>) in
//                
//                switch response.result {
//                case .success(_):
//                    let GenreModel = response.result.value!
//                    if GenreModel.success == 1{
//                        Loader.shared.hide()
//                        self.gerneDataObj = GenreModel.genreList!
//                        
//                        print("GenrelistCount",self.gerneDataObj.count)
//                        
//                        //self.setUpGerne()
//                    }else{
//                        Loader.shared.hide()
//                        self.view.makeToast(GenreModel.message)
//                    }
//                case .failure(let error):
//                    Loader.shared.hide()
//                    debugPrint(error)
//                    print("Error")
//                }
//            }
//        }else{
//            self.view.makeToast("Please check your Internet Connection".localize)
//        }
//    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
       
        if let call = self.callBackCancelBtn{
            call("cancel")
        }

    }
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        if let call = self.serviceButtonCallback{
            call("service")
            
        }
        
    }
    
    func setUpVw(){
         
        currencyvw.layer.cornerRadius = 10.0
        currencyvw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        currencyvw.layer.borderWidth = 0.5
        currencyvw.clipsToBounds = true
        
        curntCityVw.layer.cornerRadius = 10.0
        curntCityVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        curntCityVw.layer.borderWidth = 0.5
        curntCityVw.clipsToBounds = true
        
        musicGenreVw.layer.cornerRadius = 10.0
        musicGenreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        musicGenreVw.layer.borderWidth = 0.5
        musicGenreVw.clipsToBounds = true
        
        yourBioBgVw.layer.cornerRadius = 10.0
        yourBioBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        yourBioBgVw.layer.borderWidth = 0.5
        yourBioBgVw.clipsToBounds = true
        
        fbLinkVw.layer.cornerRadius = 10.0
        fbLinkVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        fbLinkVw.layer.borderWidth = 0.5
        fbLinkVw.clipsToBounds = true
        
        twitterLinkVw.layer.cornerRadius = 10.0
        twitterLinkVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        twitterLinkVw.layer.borderWidth = 0.5
        twitterLinkVw.clipsToBounds = true
        
        instaLinkVw.layer.cornerRadius = 10.0
        instaLinkVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        instaLinkVw.layer.borderWidth = 0.5
        instaLinkVw.clipsToBounds = true
        
        usernameTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        currentCityTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Current City",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        musicGenreTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Music Genre",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        //currentCityTxtFld.text = "Patna"
    }
    
    //MARK:- OTHER FUNCTION
    func saveProfileValidation(){
//        textfieldDjname.resignFirstResponder()
//        textfieldMusicgenre.resignFirstResponder()
//        textfieldCurrentcity.resignFirstResponder()
//        textfieldYourBio.resignFirstResponder()
//        tfFacebookLink.resignFirstResponder()
//        tfTwitterLink.resignFirstResponder()
//        tfYoutubeLink.resignFirstResponder()
//        tfInstagramLink.resignFirstResponder()
       // UserModel.sharedInstance().uniqueUserName = "\(textfieldDjname.text!)"
        //textfieldCurrentcity.text! = UserModel.sharedInstance().cityServiceName ?? ""
       // UserModel.sharedInstance().bioServiceName = textfieldYourBio.text!
       // UserModel.sharedInstance().synchroniseData()
    }
    
    func setupData(){
        localizeElement()
        tfTwitterLink.text = profileData?.twitter_link
        tfFacebookLink.text = profileData?.facebook_link
       // tfYoutubeLink.text = profileData?.youtube_link
        tfInstagramLink.text = profileData?.instagram_link
//        textfieldDjname.text = profileData?.username
//        textfieldCurrentcity.text =  UserModel.sharedInstance().cityServiceName ?? ""
        if(UserModel.sharedInstance().cityServiceName == "" || UserModel.sharedInstance().cityServiceName == nil){
           // textfieldCurrentcity.text = profileData?.city
        }
        
       // textfieldYourBio.text = profileData?.bio
        
        UserModel.sharedInstance().facebookLink = profileData?.twitter_link
        UserModel.sharedInstance().twitterLink = profileData?.facebook_link
        UserModel.sharedInstance().youtubeLink = profileData?.youtube_link
        UserModel.sharedInstance().instagramLink = profileData?.instagram_link
        UserModel.sharedInstance().synchroniseData()
        
        if let genre = profileData?.genre{
           // textfieldMusicgenre.text = genre
            UserModel.sharedInstance().genrePro = genre
            UserModel.sharedInstance().synchroniseData()
            
        }
    }

    func localizeElement(){
//        lblProfileCurrentCity.text = "Current City".localize
//        lblProfileMusicGenre.text = "Music genre".localize
//        lblProfileBio.text = "Profile bio".localize
//        lblprofileConnect.text = "Connect your social".localize
//
//        if UserModel.sharedInstance().userType == "AR"{
//            lblUserName.text = "Profile Artist Name".localize
//        }else{
//            lblUserName.text = "Profile Dj Name".localize
//        }
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func btnGenere_Action(_ sender: buttonProperties) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "openGenereVC"), object: nil)
    }
    
    @IBAction func btnCurrentCity_Action(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "openLocationPicker"), object: nil)
    }
    
    
}
