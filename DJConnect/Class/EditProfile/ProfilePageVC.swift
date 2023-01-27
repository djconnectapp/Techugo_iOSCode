//
//  djProfilePageVC.swift
//  DJConnect
//
//  Created by mac on 10/12/19.
//  Copyright © 2019 mac. All rights reserved.
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

class generecell : UITableViewCell {
    
    @IBOutlet weak var lbl_genereName: UILabel!
    @IBOutlet weak var btn_check: UIButton!

}

class ProfilePageVC: UIViewController,UIPopoverControllerDelegate{
    
    //MARK: - OUTLETS
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var textfieldDjname: UITextField!
    @IBOutlet weak var textfieldCurrentcity: UITextField!
    @IBOutlet weak var textfieldMusicgenre: UITextField!
    @IBOutlet weak var textfieldYourBio: UITextView!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var imgProfileImage: imageProperties!
    @IBOutlet weak var lblNameofUser: UILabel!
    
    @IBOutlet weak var cnsProfileHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsServiceHeight: NSLayoutConstraint!
    @IBOutlet weak var cnsmediaHeight: NSLayoutConstraint!
    
    @IBOutlet var viewProfilePage: UIView!
    @IBOutlet var viewCalendarPage: UIView!
    @IBOutlet var viewServicePage: UIView!
    @IBOutlet var viewMediaPage: UIView!
    
    @IBOutlet var viewArtistService: UIView!
    @IBOutlet var viewAddMedia: UIView!
    @IBOutlet var viewNameAudio: UIView!
    @IBOutlet var viewVideo: UIView!
    @IBOutlet var viewActionSheet: UIView!
    @IBOutlet weak var viewAddAudioBlur: UIView!
    @IBOutlet var viewPopUpProfile: UIView!
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var viewCollectionView: UICollectionView!
    @IBOutlet weak var selectedDate: UILabel!
    
    @IBOutlet weak var btnProfileImage: UIButton!
    var picker: UIImagePickerController = UIImagePickerController()

    @IBOutlet weak var txtFieldAudioName: textFieldProperties!
    
    //audio data outlet
    @IBOutlet weak var imgProfileImg: UIImageView!
    @IBOutlet weak var lblSampleName: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var audioSeekBar: UISlider!
    
    //profile incomplete popup outlets
    @IBOutlet weak var lblProfileInc_Main: UILabel!
    @IBOutlet weak var lblProfileInc_Profile: UILabel!
    @IBOutlet weak var lblProfileInc_Payment: UILabel!
    @IBOutlet weak var view_Artisprofile: UIView!
    @IBOutlet weak var btn_popup_FinishProfile: UIButton!
    @IBOutlet weak var btnCloseProfile: UIButton!
    //media page label outlets
    @IBOutlet weak var lblAudio_AddMedia: UILabel!
    @IBOutlet weak var lblVideo_AddMedia: UILabel!
    @IBOutlet weak var lblAudio_Media: UILabel!
    @IBOutlet weak var lblVideo_Media: UILabel!
    @IBOutlet weak var lblVideoMsg_AddMedia: UILabel!
    @IBOutlet weak var lblClickMessage_AddAudio: UILabel!
    @IBOutlet weak var scr_main: UIScrollView!
    
    //localize - main
    @IBOutlet weak var lblEdit: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblMedia: UILabel!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnMedia: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    //height constraint
    @IBOutlet weak var cnsViewMainHeight: NSLayoutConstraint!
        
    //profilepage
    @IBOutlet weak var lblProfileCurrentCity: UILabel!
    @IBOutlet weak var lblProfileMusicGenre: UILabel!
    @IBOutlet weak var lblProfileBio: UILabel!
    @IBOutlet weak var lblprofileConnect: UILabel!
    @IBOutlet weak var tfFacebookLink: UITextField!
    @IBOutlet weak var tfTwitterLink: UITextField!
    @IBOutlet weak var tfInstagramLink: UITextField!
    @IBOutlet weak var tfYoutubeLink: UITextField!
    
    //service song review page
    @IBOutlet weak var lblServiceFeedback: UILabel!
    @IBOutlet weak var lblServiceAbtFeedback: UILabel!
    @IBOutlet weak var lblServiceFeedbackCurrency: UILabel!
    @IBOutlet weak var lblServiceFeedbackPrice: UILabel!
    @IBOutlet weak var lblFeedbackCurrSymbol: UILabel!
    @IBOutlet weak var btnFeedbackCurrency: UIButton!
    @IBOutlet weak var textViewFeedBackDetail: UITextView!
    @IBOutlet weak var lblFeedbackCount: UILabel!
    @IBOutlet weak var lblFeedbackPlaceholder: UILabel!
    @IBOutlet weak var viewFeedbackDropDown: UIView!
    @IBOutlet weak var textFieldFeedbackPrice: UITextField!
    @IBOutlet weak var txtFieldFeedback: UITextField!
    @IBOutlet weak var vwFixedSongReview: UIView!

    //service song drop page
    @IBOutlet weak var lblServiceDrops: UILabel!
    @IBOutlet weak var lblServiceAbtDrop: UILabel!
    @IBOutlet weak var lblServiceDropCurr: UILabel!
    @IBOutlet weak var lblServiceDropPrice: UILabel!
    @IBOutlet weak var lblDropCurrSymbol: UILabel!
    @IBOutlet weak var btnDropCurrency: UIButton!
    @IBOutlet weak var textViewDropDetail: UITextView!
    @IBOutlet weak var textFieldDropPrice: UITextField!
    @IBOutlet weak var lblDropCount: UILabel!
    @IBOutlet weak var lblDropPlaceholder: UILabel!
    @IBOutlet weak var viewDropDropDown: UIView!
    @IBOutlet weak var txtFieldDrop: UITextField!
    @IBOutlet weak var vwFixedDrop: UIView!
    
    //service remix page
    @IBOutlet weak var lblServiceRemix: UILabel!
    @IBOutlet weak var lblServiceAbtRemix: UILabel!
    @IBOutlet weak var lblRemixCount: UILabel!
    @IBOutlet weak var textViewRemixDetail: UITextView!
    @IBOutlet weak var lblRemixPlaceholder: UILabel!
    @IBOutlet weak var viewRemixDropDown: UIView!
    @IBOutlet weak var vwFixedRemix: UIView!
    @IBOutlet weak var lblServiceRemixCurrency: UILabel!
    @IBOutlet weak var txtFieldRemix: UITextField!
    @IBOutlet weak var btnRemixCurrency: UIButton!
    @IBOutlet weak var textFieldRemixPrice: UITextField!
    @IBOutlet weak var lblServiceRemixPrice: UILabel!
    @IBOutlet weak var lblRemixCurrSymbol: UILabel!
    
    //service - remix range view
    @IBOutlet weak var vwRangeRemix: UIView!
    @IBOutlet weak var lblRemixRangePrice: UILabel!
    @IBOutlet weak var lblRemixRangeSymbol1: UILabel!
    @IBOutlet weak var txfRemixMin: UITextField!
    @IBOutlet weak var lblRemixRangeSymbol2: UILabel!
    @IBOutlet weak var txfRemixMax: UITextField!
        
    //service - song review range view
    @IBOutlet weak var vwRangeSongReview: UIView!
    @IBOutlet weak var lblSongReviewRangePrice: UILabel!
    @IBOutlet weak var lblSongReviewRangeSymbol1: UILabel!
    @IBOutlet weak var txfSongReviewMin: UITextField!
    @IBOutlet weak var lblSongReviewRangeSymbol2: UILabel!
    @IBOutlet weak var txfSongReviewMax: UITextField!
    
    //service - drop range view
    @IBOutlet weak var vwRangeDrop: UIView!
    @IBOutlet weak var lblDropRangePrice: UILabel!
    @IBOutlet weak var lblDropRangeSymbol1: UILabel!
    @IBOutlet weak var txfDropMin: UITextField!
    @IBOutlet weak var lblDropRangeSymbol2: UILabel!
    @IBOutlet weak var txfDropMax: UITextField!
    
    //mediapage
    @IBOutlet weak var lblMyMedia: UILabel!
    @IBOutlet weak var lblMediaAudio: UILabel!
    @IBOutlet weak var lblMediaVideo: UILabel!
    @IBOutlet weak var lblMediaVideoDetail: UILabel!
    @IBOutlet weak var lblmediaReplace: UILabel!
    @IBOutlet weak var vwArtistMedia: UIView!
    @IBOutlet weak var vwDjMedia: UIView!
    //video view
    @IBOutlet weak var imgVi_Thumbnail: UIImageView!
    @IBOutlet weak var lblVi_holderName: UILabel!
    @IBOutlet weak var lblVi_ProjName: UILabel!
    @IBOutlet weak var lblVi_byName: UILabel!
    @IBOutlet weak var lblVi_GenreName: UILabel!
    @IBOutlet weak var lblVi_AutodeleteTime: UILabel!
    
    //popup
    @IBOutlet weak var lblProfileInc: UILabel!
    @IBOutlet weak var lblProfIncText: UILabel!
    @IBOutlet weak var lblPaymentIncText: UILabel!
    
    //artistservicepage
    @IBOutlet weak var lblNoService: UILabel!
    @IBOutlet weak var lblNoServiceDetail: UILabel!
    
    //addmediapage
    @IBOutlet weak var lblAddMediaMyMedia: UILabel!
    @IBOutlet weak var lblAddMediaAudio: UILabel!
    @IBOutlet weak var lblAddMediaVideo: UILabel!
    
    //nameofaudio
    @IBOutlet weak var lblAddAudio: UILabel!
    @IBOutlet weak var lblNameOfAudio: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    //actionsheet
    @IBOutlet weak var lblActionSheetAddAudio: UILabel!
    @IBOutlet weak var btnOnlineStorage: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    //segment control
    @IBOutlet weak var FeedbackSegmentControl: UISegmentedControl!
    @IBOutlet weak var DropSegmentControl: UISegmentedControl!
    @IBOutlet weak var RemixSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var lblUserNoAudio: UILabel!
    @IBOutlet weak var lblLo_AutoDeleteVideo: UILabel!
    
    //MARK: - ENUMS
    enum image: String {
        case profileImage
        case coverImage
    }
    enum buttonChoosen {
        case profile
        case calendar
        case service
        case media
    }
    enum cityColumn{
        case home_city
        case current_city
    }
    
    // MARK: - GLOBAL VARIABLES
  
    let startingIndex = 400
    var imageViewSelected = image.profileImage
    var calendarCellWidth = 35
    var buttonSelected = String()
    let feedbackCurrDropDown = DropDown()
    let dropCurrDropDown = DropDown()
    let remixCurrDropDown = DropDown()
    var audioPlayer: AVAudioPlayer?
    var isSearchEnabled = false
    var genreIndex = [String]()
    var citySelected = cityColumn.home_city
    
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
    
    //Genere variable
    var genreNames = "Rock"
    var genreIds = "1"
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(genreList(_:)), name: Notification.Name(rawValue: "genreProfile"), object: nil)
        picker.delegate = self
      
        txtFieldDrop.isUserInteractionEnabled = false
        txtFieldFeedback.isUserInteractionEnabled = false
        txtFieldRemix.isUserInteractionEnabled = false
        dj_feedback_varying = 0
        dj_drop_varying = 0
        userSelection()
        localizeElements()
        
        textfieldDjname.text = UserModel.sharedInstance().uniqueUserName!
        if UserModel.sharedInstance().isSignup! &&  UserModel.sharedInstance().finishPopup == false
        {
            self.viewAddAudioBlur.isHidden = false
            self.viewPopUpProfile.isHidden = false
            self.viewPopUpProfile.frame.size.width = self.view.frame.size.width * 0.8
            self.viewPopUpProfile.frame.size.height = self.view.frame.size.height * 0.5
            self.viewPopUpProfile.layer.cornerRadius = 12.0
            self.viewPopUpProfile.center = self.view.center
            self.viewPopUpProfile.alpha = 1.0
            self.view.addSubview(viewPopUpProfile)
        }else{
            self.viewAddAudioBlur.isHidden = true
            self.viewPopUpProfile.isHidden = true
        }

       FeedbackSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        FeedbackSegmentControl.selectedSegmentIndex = 1
        DropSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        DropSegmentControl.selectedSegmentIndex = 1
        RemixSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        RemixSegmentControl.selectedSegmentIndex = 1
        setFeedbackOFF()
        setDropOFF()
        setRemixOFF()
        
        feedbackCurrDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.txtFieldFeedback.text = self.feedbackCurrDropDown.selectedItem
            let x = self.feedbackCurrDropDown.indexForSelectedRow
            if x == 0 {
                self.vwFixedSongReview.isHidden = false
                self.vwRangeSongReview.isHidden = true
                self.dj_feedback_varying = 0
            }else{
                self.vwFixedSongReview.isHidden = true
                self.vwRangeSongReview.isHidden = false
                self.dj_feedback_varying = 1
            }
        }
        
        dropCurrDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.txtFieldDrop.text = self.dropCurrDropDown.selectedItem
            let x = self.dropCurrDropDown.indexForSelectedRow
            if x == 0 {
                self.vwFixedDrop.isHidden = false
                self.vwRangeDrop.isHidden = true
                self.dj_drop_varying = 0
            }else{
                self.vwFixedDrop.isHidden = true
                self.vwRangeDrop.isHidden = false
                self.dj_drop_varying = 1
            }
        }
        
        remixCurrDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.txtFieldRemix.text = self.remixCurrDropDown.selectedItem
            let x = self.remixCurrDropDown.indexForSelectedRow
            if x == 0 {
                self.vwFixedRemix.isHidden = false
                self.vwRangeRemix.isHidden = true
                self.dj_remix_varying = 0
            }else{
                self.vwFixedRemix.isHidden = true
                self.vwRangeRemix.isHidden = false
                self.dj_remix_varying = 1
            }
        }
        
        callCurrencyListWebService()
        if UserModel.sharedInstance().finishProfile == false{
            if UserModel.sharedInstance().userType == "DJ"{
                callGetProfileWebService()
            }else{
                callArtistGetProfileWebService()
            }
        }
        if globalObjects.shared.profileCompleted == false{
            btnCloseProfile.isEnabled = false
        }else{
            btnCloseProfile.isEnabled = true
        }
    }
    
    override func viewDidLayoutSubviews() {
           scr_main.isScrollEnabled = true
           scr_main.contentSize = CGSize(width: self.view.frame.width, height: 350 + cnsViewMainHeight.constant)
       }
       
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            
            let statusbarView = UIView(frame: app.statusBarFrame)
            statusbarView.backgroundColor = UIColor.black
            app.statusBarUIView?.addSubview(statusbarView)
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.black
        }
        self.audioSeekBar.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        
    }
   
    //MARK: - OTHER METHODS
    func ChangeRoot() {
        let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SideMenuNavigation") as! UINavigationController
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
    
    func servicePgeCalled() {
        btnProfileImage.isHidden = true
        btnProfile.backgroundColor = .white
        btnService.backgroundColor = .clear
        btnMedia.backgroundColor = .white
        btnProfile.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnService.setTitleColor(UIColor.white, for: .normal)
        btnMedia.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        
        self.viewMediaPage.isHidden = true
        self.viewProfilePage.isHidden = true
        self.viewServicePage.isHidden = false
        self.viewAddMedia.isHidden = true
        
        if UserModel.sharedInstance().userType == "DJ" {
            self.viewArtistService.isHidden = true
            self.viewServicePage.isHidden = false
            self.viewServicePage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 577)
            viewServicePage.alpha = 0.0
            
            UIView.animate(withDuration: 1) {
                self.viewServicePage.alpha = 1.0
                self.viewMain.addSubview(self.viewServicePage)
            }
            cnsViewMainHeight.constant = cnsServiceHeight.constant
        }else {
            self.viewArtistService.isHidden = false
            self.viewServicePage.isHidden = true
            self.viewArtistService.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.viewMain.frame.height)
            viewArtistService.alpha = 0.0
            
            UIView.animate(withDuration: 1) {
                self.viewArtistService.alpha = 1.0
                self.viewMain.addSubview(self.viewArtistService)
            }
            cnsViewMainHeight.constant = cnsServiceHeight.constant
        }
    }
    
    func mediaPageCalled() {
        
        btnProfileImage.isHidden = true
        btnProfile.backgroundColor = .white
        btnService.backgroundColor = .white
        btnMedia.backgroundColor = .clear
        btnProfile.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnMedia.setTitleColor(UIColor.white, for: .normal)
        
        self.viewServicePage.isHidden = true
        self.viewProfilePage.isHidden = true
        self.viewMediaPage.isHidden = true
        self.viewAddMedia.isHidden = false
        self.viewArtistService.isHidden = true
        
        self.viewAddMedia.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.viewMain.frame.height)
        viewAddMedia.alpha = 0.0
        
        UIView.animate(withDuration: 1) {
            self.viewAddMedia.alpha = 1.0
            self.viewMain.addSubview(self.viewAddMedia)
        }
        cnsViewMainHeight.constant = cnsmediaHeight.constant + 20
    }
    
    func ChangeRootUsingFlip() {
        if UserModel.sharedInstance().userType == "DJ"{
            let homeSB = UIStoryboard(name: "DJPProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationProfile") as! UINavigationController
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
        }else{
            let homeSB = UIStoryboard(name: "ArtistPRofile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationArtistProfile") as! UINavigationController
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
    
    func userSelection() {
        if UserModel.sharedInstance().userType == "DJ" {
            lblProfileInc_Main.text = "popup dj ack".localize
            lblProfileInc_Profile.text = "dj profile text".localize
            lblProfileInc_Payment.text = "dj payment text".localize
            
            let djAudioAddMediaString = NSMutableAttributedString()
            djAudioAddMediaString.normal("Audio - ".localize).bold("dj_media audio ack".localize)
            lblAudio_AddMedia.attributedText = djAudioAddMediaString
            lblAudio_Media.attributedText = djAudioAddMediaString
            
            let djVideoAddMediaString = NSMutableAttributedString()
            djVideoAddMediaString.normal("Video - ".localize).bold("dj_media video ack".localize)
            lblVideo_AddMedia.attributedText = djVideoAddMediaString
            lblVideo_Media.attributedText = djVideoAddMediaString
            lblMediaVideoDetail.text = "media video detail dj".localize
            lblClickMessage_AddAudio.text = "dj click button".localize
            lblNameofUser.text = "Profile Dj Name".localize
        }else {
            lblProfileInc_Main.text = "popup artist ack".localize
            lblProfileInc_Profile.text = "artist finish profile".localize
            lblProfileInc_Payment.text = "artist payment text".localize
            let arAudioAddMediaString = NSMutableAttributedString()
            arAudioAddMediaString.normal("Audio - ".localize).bold("ar_media audio ack".localize)
            lblAudio_AddMedia.attributedText = arAudioAddMediaString
            lblAudio_Media.attributedText = arAudioAddMediaString
            
            let arVideoAddMediaString = NSMutableAttributedString()
            arVideoAddMediaString.normal("Video - ".localize).bold("ar_media video ack".localize)
            lblVideo_AddMedia.attributedText = arVideoAddMediaString
            lblVideo_Media.attributedText = arVideoAddMediaString
            lblMediaVideoDetail.text = "media video detail ar".localize
            lblClickMessage_AddAudio.text = "artist click button".localize
            lblNameofUser.text = "Profile Artist Name".localize
        }
    }
    
    func chanRootUsingsignUp() {
        if UserModel.sharedInstance().userType == "DJ"{
            let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationProfile") as! UINavigationController
            
            let appdel = UIApplication.shared.delegate as! AppDelegate
            let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
            desiredViewController.view.addSubview(snapshot);
            appdel.window?.rootViewController = desiredViewController;
            
            UIView.animate(withDuration: 0.3, animations: {() in
                snapshot.layer.opacity = 0;
                snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
            }, completion: {
                (value: Bool) in
                snapshot.removeFromSuperview();
            });
        }else{
            let homeSB = UIStoryboard(name: "artistProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationArtistProfile") as! UINavigationController
            let appdel = UIApplication.shared.delegate as! AppDelegate
            let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
            desiredViewController.view.addSubview(snapshot);
            appdel.window?.rootViewController = desiredViewController;
            
            UIView.animate(withDuration: 0.3, animations: {() in
                snapshot.layer.opacity = 0;
                snapshot.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
            }, completion: {
                (value: Bool) in
                snapshot.removeFromSuperview();
            });
        }
    }
    
    func ChangeRootUsingFlipLogin() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "flip")
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: true)
    }
   
    func setFeedbackON(){
        self.FeedbackSegmentControl.selectedSegmentIndex = 0
        self.textViewFeedBackDetail.textColor = .black
        self.textViewFeedBackDetail.isEditable = true
        self.lblServiceFeedback.textColor = .white
        self.txtFieldFeedback.textColor = .black
        self.txtFieldFeedback.isEnabled = true
        self.textFieldFeedbackPrice.textColor = .black
        self.textFieldFeedbackPrice.isEnabled = true
        self.lblFeedbackCurrSymbol.textColor = .black
        self.lblFeedbackPlaceholder.textColor = .black
        self.txfSongReviewMin.textColor = .black
        self.txfSongReviewMax.textColor = .black
        self.lblSongReviewRangeSymbol1.textColor = .black
        self.lblSongReviewRangeSymbol2.textColor = .black
    }
    
    func setFeedbackOFF(){
        self.FeedbackSegmentControl.selectedSegmentIndex = 1
        self.textViewFeedBackDetail.textColor = .lightGray
        self.textViewFeedBackDetail.isEditable = false
        self.lblServiceFeedback.textColor = .lightGray
        self.txtFieldFeedback.textColor = .lightGray
        self.txtFieldFeedback.isEnabled = false
        self.textFieldFeedbackPrice.textColor = .lightGray
        self.textFieldFeedbackPrice.isEnabled = false
        self.lblFeedbackCurrSymbol.textColor = .lightGray
        self.lblFeedbackPlaceholder.textColor = .lightGray
        self.txfSongReviewMin.textColor = .lightGray
        self.txfSongReviewMax.textColor = .lightGray
        self.lblSongReviewRangeSymbol1.textColor = .lightGray
        self.lblSongReviewRangeSymbol2.textColor = .lightGray
    }
    
    func setDropON(){
        self.DropSegmentControl.selectedSegmentIndex = 0
        self.textViewDropDetail.textColor = .black
        self.textViewDropDetail.isEditable = true
        self.lblServiceDrops.textColor = .white
        self.txtFieldDrop.textColor = .black
        self.txtFieldDrop.isEnabled = true
        self.textFieldDropPrice.textColor = .black
        self.textFieldDropPrice.isEnabled = true
        self.lblDropCurrSymbol.textColor = .black
        self.lblDropPlaceholder.textColor = .black
        self.txfDropMin.textColor = .black
        self.txfDropMax.textColor = .black
        self.lblDropRangeSymbol1.textColor = .black
        self.lblDropRangeSymbol2.textColor = .black
    }
    
    func setDropOFF(){
        self.DropSegmentControl.selectedSegmentIndex = 1
        self.textViewDropDetail.textColor = .lightGray
        self.textViewDropDetail.isEditable = false
        self.lblServiceDrops.textColor = .lightGray
        self.txtFieldDrop.textColor = .lightGray
        self.txtFieldDrop.isEnabled = false
        self.textFieldDropPrice.textColor = .lightGray
        self.textFieldDropPrice.isEnabled = false
        self.lblDropCurrSymbol.textColor = .lightGray
        self.lblDropPlaceholder.textColor = .lightGray
        self.txfDropMin.textColor = .lightGray
        self.txfDropMax.textColor = .lightGray
        self.lblDropRangeSymbol1.textColor = .lightGray
        self.lblDropRangeSymbol2.textColor = .lightGray
    }
    
    func setRemixON(){
        self.RemixSegmentControl.selectedSegmentIndex = 0
        self.textViewRemixDetail.textColor = .black
        self.textViewRemixDetail.isEditable = true
        self.lblServiceRemix.textColor = .white
        self.txtFieldRemix.textColor = .black
        self.txtFieldRemix.isEnabled = true
        self.textFieldRemixPrice.textColor = .black
        self.textFieldRemixPrice.isEnabled = true
        self.lblRemixCurrSymbol.textColor = .black
        self.lblRemixPlaceholder.textColor = .black
        self.txfRemixMin.textColor = .black
        self.txfRemixMax.textColor = .black
        self.lblRemixRangeSymbol1.textColor = .black
        self.lblRemixRangeSymbol2.textColor = .black
    }
    
    func setRemixOFF(){
        self.RemixSegmentControl.selectedSegmentIndex = 1
        self.textViewRemixDetail.textColor = .lightGray
        self.textViewRemixDetail.isEditable = false
        self.lblServiceRemix.textColor = .lightGray
        self.txtFieldRemix.textColor = .lightGray
        self.txtFieldRemix.isEnabled = false
        self.textFieldRemixPrice.textColor = .lightGray
        self.textFieldRemixPrice.isEnabled = false
        self.lblRemixCurrSymbol.textColor = .lightGray
        self.lblRemixPlaceholder.textColor = .lightGray
        self.txfRemixMin.textColor = .lightGray
        self.txfRemixMax.textColor = .lightGray
        self.lblRemixRangeSymbol1.textColor = .lightGray
        self.lblRemixRangeSymbol2.textColor = .lightGray
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
            self.audioSeekBar.maximumValue = Float(Double(self.audioPlayer!.duration))
            self.audioPlayer?.currentTime = Double(self.audioSeekBar.value)
            lblMinTime.text = String(self.audioSeekBar.value)
            lblMaxTime.text = "\(minuteString):\(secondString)"
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }
    
    func updateTime() {
        let currentTime = Int(audioPlayer!.currentTime)
        let duration = Int(audioPlayer!.duration)
        let total = currentTime - duration
        let totalString = String(total)
        
        let minutes = currentTime/60
        let seconds = currentTime - minutes / 60
        
        lblMaxTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    func addMediaView(){
        self.viewServicePage.isHidden = true
        self.viewProfilePage.isHidden = true
        self.viewAddMedia.isHidden = true
        
        self.viewAddAudioBlur.isHidden = true
        self.viewNameAudio.isHidden = true
        self.viewActionSheet.isHidden = true
        self.viewMediaPage.isHidden = false
        
        btnProfile.backgroundColor = .white
        btnService.backgroundColor = .white
        btnMedia.backgroundColor = .clear
        btnProfile.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnMedia.setTitleColor(UIColor.white, for: .normal)
        cnsViewMainHeight.constant = cnsmediaHeight.constant + 20
        var media_height = CGFloat()
        if apiVideoData.isEmpty == false || video_broadcastId.isEmpty == false{
            media_height = 490
        }else{
            media_height = 380
        }
        self.viewMediaPage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: media_height)
        self.viewMain.addSubview(viewMediaPage)
        let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
        self.imgProfileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
    }
    
    func localizeElements(){
        //localize variable - main
        lblEdit.text = "EDIT".localize
        lblProfile.text = "Profile".localize
        lblService.text = "Services".localize
        lblMedia.text = "Media".localize
        btnSave.setTitle("SAVE".localize, for: .normal)
        btnProfile.setTitle("P".localize, for: .normal)
        btnService.setTitle("S".localize, for: .normal)
        btnMedia.setTitle("M".localize, for: .normal)
        
        //localize variable - profile
        lblProfileCurrentCity.text = "Current City".localize
        lblProfileMusicGenre.text = "Music genre".localize
        lblProfileBio.text = "Profile bio".localize
        lblprofileConnect.text = "Connect your social".localize
        
        //localize variable - service
        lblServiceFeedback.text = "service dj feedback".localize
        lblServiceAbtFeedback.text = "About Feedback".localize
        lblServiceFeedbackCurrency.text = "Currency".localize
        lblServiceFeedbackPrice.text = "Price (USD)".localize
        lblServiceDropCurr.text = "Currency".localize
        lblServiceDropPrice.text = "Price (USD)".localize
        lblServiceRemixPrice.text = "Price (USD)".localize
        lblServiceDrops.text = "service dj drop".localize
        lblServiceAbtDrop.text = "About drop".localize
        lblServiceRemixCurrency.text = "Currency".localize
        
        //localize variable - media
        lblMyMedia.text = "my media".localize
        lblMediaAudio.text = "media audio".localize
        lblMediaVideo.text = "media video".localize
        lblmediaReplace.text = "replace".localize
        lblUserNoAudio.text = "user_no_audio".localize
        
        //localize variable - popup
        lblProfileInc.text = "profile incomplete".localize
        lblProfIncText.text = "profile_incomplete".localize
        btn_popup_FinishProfile.setTitle("finish profile".localize, for: .normal)
        lblPaymentIncText.text = "payment_incomplete".localize
        btnSkip.setTitle("Skip".localize, for: .normal)
        
        //localize variable - artist service
        lblNoService.text = "no service".localize
        lblNoServiceDetail.text = "no service detail".localize
        
        //localize variable - add media
        lblAddMediaMyMedia.text = "my media".localize
        lblAddMediaAudio.text = "media audio".localize
        lblAddMediaVideo.text = "media video".localize
        
        //localize variable - name audio
        lblAddAudio.text = "Add Audio".localize
        lblNameOfAudio.text = "name of audio".localize
        btnBack.setTitle("Back".localize, for: .normal)
        btnAdd.setTitle("Add".localize, for: .normal)
        
        //localize variable - action sheet
        lblActionSheetAddAudio.text = "Add Audio".localize
        btnOnlineStorage.setTitle("Online Storage".localize, for: .normal)
        btnCancel.setTitle("Cancel".localize, for: .normal)
        
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
    
    func startMediaTimer() {
        let releaseDateString = "\(mediaRemainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        mediaReleaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        mediaCountDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMediaTime), userInfo: nil, repeats: true)
    }
    
    func checkSongReviewRange() -> Bool{
        if txfSongReviewMin.text?.isEmpty == false && txfSongReviewMax.text?.isEmpty == false{
            let  range1 = Int(txfSongReviewMin.text!) ?? 0
            let  range2 = Int(txfSongReviewMax.text!) ?? 0
            if range2 == 0{
                return false
            }else if range1 > range2{
                return false
            }else{
                dj_feedback_range1 = Int(txfSongReviewMin.text!) ?? 0
                dj_feedback_range2 = Int(txfSongReviewMax.text!) ?? 0
                return true
            }
        }else{
            dj_feedback_range1 = Int(txfSongReviewMin.text!) ?? 0
            dj_feedback_range2 = Int(txfSongReviewMax.text!) ?? 0
            return false
        }
    }
    
    func checkDropRange() -> Bool{
        if txfDropMin.text?.isEmpty == false && txfDropMax.text?.isEmpty == false{
            let  range1 = Int(txfDropMin.text!) ?? 0
            let  range2 = Int(txfDropMax.text!) ?? 0
            if range2 == 0{
                return false
            }else if range1 > range2{
                return false
            }else{
                dj_drop_range1 = Int(txfDropMin.text!) ?? 0
                dj_drop_range2 = Int(txfDropMax.text!) ?? 0
                return true
            }
        }else{
            dj_drop_range1 = Int(txfDropMin.text!) ?? 0
            dj_drop_range2 = Int(txfDropMax.text!) ?? 0
            return false
        }
    }
    
    func checkRemixRange() -> Bool{
        if txfRemixMin.text?.isEmpty == false && txfRemixMax.text?.isEmpty == false{
            let  range1 = Int(txfRemixMin.text!) ?? 0
            let  range2 = Int(txfRemixMax.text!) ?? 0
            if range2 == 0{
                return false
            }else if range1 > range2{
                return false
            }else{
                dj_remix_range1 = Int(txfRemixMin.text!) ?? 0
                dj_remix_range2 = Int(txfRemixMax.text!) ?? 0
                return true
            }
        }else{
            dj_remix_range1 = Int(txfRemixMin.text!) ?? 0
            dj_remix_range2 = Int(txfRemixMax.text!) ?? 0
            return false
        }
    }
    
    func setView(){
        if buttonSelected == "calendar" {
            btnProfileImage.isHidden = false
            btnProfile.backgroundColor = .clear
            btnService.backgroundColor = .white
            btnMedia.backgroundColor = .white
            btnProfile.setTitleColor(.white, for: .normal)
            btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
            btnMedia.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
            
            self.viewProfilePage.isHidden = false
            self.viewServicePage.isHidden = true
            self.viewMediaPage.isHidden = true
            self.viewAddMedia.isHidden = true
            self.viewArtistService.isHidden = true
            
            cnsViewMainHeight.constant = cnsProfileHeight.constant
            self.viewProfilePage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 577)
            viewProfilePage.alpha = 0.0
            
            UIView.animate(withDuration: 1) {
                self.viewProfilePage.alpha = 1.0
                self.viewMain.addSubview(self.viewProfilePage)
            }
        }else if buttonSelected == "media" {
            if apiSongData.isEmpty{
                mediaPageCalled()
            }else{
                self.viewServicePage.isHidden = true
                self.viewProfilePage.isHidden = true
                self.viewAddMedia.isHidden = true
                
                self.viewAddAudioBlur.isHidden = true
                self.viewNameAudio.isHidden = true
                self.viewActionSheet.isHidden = true
                self.viewMediaPage.isHidden = false
                
                btnProfile.backgroundColor = .white
                btnService.backgroundColor = .white
                btnMedia.backgroundColor = .clear
                btnProfile.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
                btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
                btnMedia.setTitleColor(.white, for: .normal)
                
                cnsViewMainHeight.constant = cnsmediaHeight.constant + 20
                self.viewMediaPage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.viewMain.frame.height)
                self.viewMain.addSubview(viewMediaPage)
                
            }
        }else if buttonSelected == "service"{
            servicePgeCalled()
        }else {
            btnProfileImage.isHidden = false
            btnProfile.backgroundColor = .clear
            btnService.backgroundColor = .white
            btnMedia.backgroundColor = .white
            btnProfile.setTitleColor(UIColor.white, for: .normal)
            btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
            btnMedia.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
            
            self.viewProfilePage.isHidden = false
            self.viewServicePage.isHidden = true
            self.viewMediaPage.isHidden = true
            self.viewAddMedia.isHidden = true
            self.viewArtistService.isHidden = true
            
            cnsViewMainHeight.constant = cnsProfileHeight.constant
            self.viewProfilePage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 577)
            viewProfilePage.alpha = 0.0
            
            UIView.animate(withDuration: 1) {
                self.viewProfilePage.alpha = 1.0
                self.viewMain.addSubview(self.viewProfilePage)
            }
        }
    }
    
    //MARK: - SELECTOR METHODS
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
    
    @objc func updateMediaTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: mediaReleaseDate! as Date)
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        //lblVi_AutodeleteTime.text = countdown // ashitesh
        
        if((diffDateComponents.day ?? 0) <= 0 && (diffDateComponents.hour ?? 0) <= 0 && (diffDateComponents.minute ?? 0) <= 0 && (diffDateComponents.hour ?? 0) <= 0){
            mediaCountDownTimer.invalidate()
            
            lblVi_AutodeleteTime.text = "0 DAY 0 HR 0 MIN 0 SEC"
            lblVi_AutodeleteTime.isHidden = true
            
        }
        else{
            lblVi_AutodeleteTime.isHidden = false
            lblVi_AutodeleteTime.text = countdown // "-18906 DAY -10 HR -23 MIN -21 SEC"
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @objc func genreList(_ notification : Notification){
        guard let names = notification.userInfo?["names"] as? String else { return }
        guard let ids = notification.userInfo?["ids"] as? String else { return }
        self.genreNames = names
        self.genreIds = ids
        textfieldMusicgenre.text = self.genreNames
    }
   
      //MARK: - ACTIONS
        @IBAction func btnChosseLocation_Action(_ sender: UIButton) {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation_map")
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func btnClose_Action(_ sender: UIButton) {
        
        textfieldDjname.resignFirstResponder()
        textfieldMusicgenre.resignFirstResponder()
        textfieldCurrentcity.resignFirstResponder()
        textfieldYourBio.resignFirstResponder()
        tfFacebookLink.resignFirstResponder()
        tfTwitterLink.resignFirstResponder()
        tfYoutubeLink.resignFirstResponder()
        tfInstagramLink.resignFirstResponder()
        
        textViewFeedBackDetail.resignFirstResponder()
        textFieldFeedbackPrice.resignFirstResponder()
        textViewDropDetail.resignFirstResponder()
        textViewRemixDetail.resignFirstResponder()
        textFieldDropPrice.resignFirstResponder()
        textFieldRemixPrice.resignFirstResponder()
        txtFieldAudioName.resignFirstResponder()
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType(rawValue: "fade")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        textfieldDjname.resignFirstResponder()
        textfieldMusicgenre.resignFirstResponder()
        textfieldCurrentcity.resignFirstResponder()
        textfieldYourBio.resignFirstResponder()
        tfFacebookLink.resignFirstResponder()
        tfTwitterLink.resignFirstResponder()
        tfYoutubeLink.resignFirstResponder()
        tfInstagramLink.resignFirstResponder()
        
        textViewFeedBackDetail.resignFirstResponder()
        textFieldFeedbackPrice.resignFirstResponder()
        textViewDropDetail.resignFirstResponder()
        textViewRemixDetail.resignFirstResponder()
        textFieldDropPrice.resignFirstResponder()
        textFieldRemixPrice.resignFirstResponder()
        txtFieldAudioName.resignFirstResponder()
        
    }
    
    @IBAction func btnAddProfileImage(_ sender: UIButton) {
        imageViewSelected = .profileImage
        choosePhoto()
    }
    
    @IBAction func btnProfileAction(_ sender: UIButton) {
        btnProfileImage.isHidden = false
        btnProfile.backgroundColor = .clear
        btnService.backgroundColor = .white
        btnMedia.backgroundColor = .white
        btnProfile.setTitleColor(UIColor.white, for: .normal)
        btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnMedia.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        
        self.viewProfilePage.isHidden = false
        self.viewServicePage.isHidden = true
        self.viewMediaPage.isHidden = true
        self.viewAddMedia.isHidden = true
        self.viewArtistService.isHidden = true
        
        cnsViewMainHeight.constant = cnsProfileHeight.constant
        self.viewProfilePage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 577)
        viewProfilePage.alpha = 0.0
        
        UIView.animate(withDuration: 1) {
            self.viewProfilePage.alpha = 1.0
            self.viewMain.addSubview(self.viewProfilePage)
        }
    }
   
    @IBAction func btnServiceAction(_ sender: UIButton) {
        servicePgeCalled()
    }
    
    @IBAction func btnMediaAction(_ sender: UIButton) {
        if UserModel.sharedInstance().userType! == "DJ"{
        if apiSongData.isEmpty{
            mediaPageCalled()
        }else{
            self.viewServicePage.isHidden = true
            self.viewProfilePage.isHidden = true
            self.viewAddMedia.isHidden = true
            
            self.viewAddAudioBlur.isHidden = true
            self.viewNameAudio.isHidden = true
            self.viewActionSheet.isHidden = true
            self.viewMediaPage.isHidden = false
            
            btnProfile.backgroundColor = .white
            btnService.backgroundColor = .white
            btnMedia.backgroundColor = .clear
            btnProfile.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
            btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
            btnMedia.setTitleColor(UIColor.white, for: .normal)
            
            self.viewMediaPage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.viewMain.frame.height)
            self.viewMain.addSubview(viewMediaPage)
            let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
            self.imgProfileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        }
            vwDjMedia.isHidden = false
            vwArtistMedia.isHidden = true
            if apiVideoData.isEmpty == false || video_broadcastId.isEmpty == false{
                self.viewVideo.isHidden = false
                self.lblMediaVideoDetail.isHidden = true
            }else{
                self.viewVideo.isHidden = true
                self.lblMediaVideoDetail.isHidden = false
            }
        }else{
            if apiSongData.isEmpty == false{
                self.viewServicePage.isHidden = true
                self.viewProfilePage.isHidden = true
                self.viewAddMedia.isHidden = true
                
                self.viewAddAudioBlur.isHidden = true
                self.viewNameAudio.isHidden = true
                self.viewActionSheet.isHidden = true
                self.viewMediaPage.isHidden = false
                
                btnProfile.backgroundColor = .white
                btnService.backgroundColor = .white
                btnMedia.backgroundColor = .clear
                btnProfile.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
                btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
                btnMedia.setTitleColor(UIColor.white, for: .normal)
                var media_height = CGFloat()
                if apiVideoData.isEmpty == false || video_broadcastId.isEmpty == false{
                    media_height = 490
                }else{
                    media_height = 380
                }
                self.viewMediaPage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: media_height)

                self.viewMain.addSubview(viewMediaPage)
                let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
                self.imgProfileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                vwDjMedia.isHidden = false
                vwArtistMedia.isHidden = true
            }else{
                addMediaView()
                vwDjMedia.isHidden = true
                vwArtistMedia.isHidden = false
            }
            if apiVideoData.isEmpty == false || video_broadcastId.isEmpty == false{
                self.viewVideo.isHidden = false
                self.lblMediaVideoDetail.isHidden = true
            }else{
                self.viewVideo.isHidden = true
                self.lblMediaVideoDetail.isHidden = false
            }
        }
    }
    
    @IBAction func btnAddAudioAction(_ sender: UIButton) {
        self.viewServicePage.isHidden = true
        self.viewProfilePage.isHidden = true
        self.viewAddMedia.isHidden = false
        self.viewMediaPage.isHidden = false
        self.viewNameAudio.isHidden = true
        
        self.viewActionSheet.isHidden = false
        self.viewAddAudioBlur.isHidden = false
        
        self.viewActionSheet.alpha = 1.0
        self.viewActionSheet.frame = CGRect(x: 0, y: self.view.frame.height + 1, width: self.viewAddAudioBlur.frame.width, height: self.viewAddAudioBlur.frame.height)
        self.viewAddAudioBlur.addSubview(viewActionSheet)
        
        //animation code
        UIView.transition(with: viewActionSheet,
                          duration: 0.6,
                          options: .curveLinear,
                          animations: { self.viewActionSheet.frame = CGRect(x: 0, y: 0, width: self.viewAddAudioBlur.frame.size.width, height: self.viewAddAudioBlur.frame.size.height)},
                          completion:{finished in
        })
    }
    
    @IBAction func btnOnlineStorageAction(_ sender: UIButton) {
        self.viewActionSheet.isHidden = true
        self.viewNameAudio.isHidden = false
        self.viewAddAudioBlur.isHidden = false
        
        self.viewNameAudio.alpha = 1.0
        // fade animation
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnCancelAddAudioAction(_ sender: UIButton) {
        self.viewNameAudio.isHidden = true
        self.viewAddAudioBlur.isHidden = true
        self.viewAddMedia.isHidden = false
        self.viewActionSheet.removeFromSuperview()
    }
    
    @IBAction func btnBackofNameAudio(_ sender: UIButton) {
        self.viewNameAudio.isHidden = true
        self.viewActionSheet.isHidden = false
        self.viewAddAudioBlur.isHidden = false
        
        self.viewActionSheet.frame = CGRect(x: -321, y: 0, width: self.viewAddAudioBlur.frame.width, height: self.viewAddAudioBlur.frame.height)
        self.viewAddAudioBlur.addSubview(viewActionSheet)
        
        UIView.transition(with: viewActionSheet,
                          duration: 1,
                          options: .curveLinear,
                          animations: { self.viewActionSheet.frame = CGRect(x: 0, y: 0, width: self.viewAddAudioBlur.frame.size.width, height: self.viewAddAudioBlur.frame.size.height)},
                          completion:{finished in
        })
    }
    
    @IBAction func btnAddofNameAction(_ sender: UIButton) {
        callAddAudioWebService()
        self.viewServicePage.isHidden = true
        self.viewProfilePage.isHidden = true
        self.viewAddMedia.isHidden = true
        self.viewAddAudioBlur.isHidden = true
        self.viewNameAudio.isHidden = true
        self.viewActionSheet.isHidden = true
        self.viewMediaPage.isHidden = false
        btnProfile.backgroundColor = .white
        btnService.backgroundColor = .white
        btnMedia.backgroundColor = .clear
        btnProfile.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnService.setTitleColor(UIColor(red: 122/255, green: 0/255, blue: 239/255, alpha: 1.0), for: .normal)
        btnMedia.setTitleColor(UIColor.white, for: .normal)
        lblSampleName.text = txtFieldAudioName.text
        
        self.viewMediaPage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.viewMain.frame.height)
        self.viewMain.addSubview(viewMediaPage)
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "audio-play"){
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
        
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)

        }else{
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }
    }
    
    @IBAction func btnReplaceAction(_ sender: UIButton) {
        self.viewServicePage.isHidden = true
        self.viewProfilePage.isHidden = true
        self.viewAddMedia.isHidden = false
        self.viewMediaPage.isHidden = false
        self.viewNameAudio.isHidden = true
        self.viewActionSheet.isHidden = false
        self.viewAddAudioBlur.isHidden = false
        self.viewActionSheet.alpha = 1.0
        self.viewActionSheet.frame = CGRect(x: 0, y: self.view.frame.height + 1, width: self.viewAddAudioBlur.frame.width, height: self.viewAddAudioBlur.frame.height)
        self.viewAddAudioBlur.addSubview(viewActionSheet)
        //animation code
        UIView.transition(with: viewActionSheet,
                          duration: 0.6,
                          options: .curveLinear,
                          animations: { self.viewActionSheet.frame = CGRect(x: 0, y: 0, width: self.viewAddAudioBlur.frame.size.width, height: self.viewAddAudioBlur.frame.size.height)},
                          completion:{finished in
        })
    }
    
    @IBAction func btnAudioSeekbarAction(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(audioSeekBar.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    @IBAction func btnFinishProfileAction(_ sender: UIButton) {
        UserModel.sharedInstance().finishPopup = true
        UserModel.sharedInstance().finishProfile = true
        UserModel.sharedInstance().synchroniseData()
        self.viewAddAudioBlur.isHidden = true
        self.viewPopUpProfile.removeFromSuperview()
    }
    
    @IBAction func btnAddpaymentAction(_ sender: UIButton) {
        self.viewAddAudioBlur.isHidden = true
        self.viewPopUpProfile.removeFromSuperview()
    }

    @IBAction func btnCurrentCityClicked(_ sender: UIButton) {
        let locationPicker = LocationPicker()
        var add = [String]()
        locationPicker.pickCompletion = { (pickedLocationItem) in
            // location the user picked.
            let lat = pickedLocationItem.coordinate?.latitude
            let lon = pickedLocationItem.coordinate?.longitude
            if let city = pickedLocationItem.addressDictionary!["City"]{
                add.append(city as! String + ", ")
            }
            
            // Country
            if let state = pickedLocationItem.addressDictionary!["State"]{
                add.append(state as! String)
            }
            
            if add.count != 0 {
                 self.textfieldCurrentcity.text = add[0] + add[1]
            }
           
            globalObjects.shared.addLat = lat
            globalObjects.shared.addLong = lon
            
        }
        locationPicker.addBarButtons()
        // Call this method to add a done and a cancel button to navigation bar.
        let navigationController = UINavigationController(rootViewController: locationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func FeedbackSegmentAction(_ sender: UISegmentedControl) {
        if  sender.selectedSegmentIndex == 0 {
            feedbackStatus = "on"
            setFeedbackON()
        }else{
            feedbackStatus = "off"
            setFeedbackOFF()
        }
    }
    
    @IBAction func DropSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dropStatus = "on"
            setDropON()
        }else{
            dropStatus = "off"
            setDropOFF()
        }
    }
    
    @IBAction func RemixSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            remixStatus = "on"
            setRemixON()
        }else{
            remixStatus = "off"
            setRemixOFF()
        }
    }
    
    @IBAction func btnSelectMusicGenreAction(_ sender: UIButton) {
        let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GerneSelectorVC") as! GerneSelectorVC
        desiredViewController.oldSelectedIds = self.genreIds
        desiredViewController.notificationName = "genreProfile"
        desiredViewController.view.frame = (self.view.bounds)
        self.view.addSubview(desiredViewController.view)
        self.addChild(desiredViewController)
        desiredViewController.didMove(toParent: self)
    }
    
    @IBAction func btnVi_PlayAction(_ sender: UIButton) {
        if UserModel.sharedInstance().userType == "AR"{
            if self.videoType == "SongReviewLive"{
                callArtistVideoWebService("\(video_broadcastId)")
            }
            if self.videoType == "SongReview"{
                let file = self.apiVideoData
                let videoURL = URL(string: "\(file)")
                let player = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                callVideoVerifyWebservice(audioId: "\(video_verify_Id)", type: "review")
            }
            if self.videoType == "project"{
                callArtistVideoWebService("\(video_broadcastId)")
            }
        }
    }

    @IBAction func btnFeedbackCurrAction(_ sender: UIButton) {
        feedbackCurrDropDown.anchorView = btnFeedbackCurrency
        feedbackCurrDropDown.dataSource = ["Fixed", "Varies"]
        if FeedbackSegmentControl.selectedSegmentIndex == 0{
            feedbackCurrDropDown.show()
        }else{
            feedbackCurrDropDown.hide()
        }
        feedbackCurrDropDown.width = viewFeedbackDropDown.frame.width
        feedbackCurrDropDown.direction = .bottom
        feedbackCurrDropDown.bottomOffset = CGPoint(x: 0, y:(feedbackCurrDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    @IBAction func btnDropCurrAction(_ sender: UIButton) {
        dropCurrDropDown.anchorView = btnDropCurrency
        dropCurrDropDown.dataSource = ["Fixed", "Varies"]
        if FeedbackSegmentControl.selectedSegmentIndex == 0{
            dropCurrDropDown.show()
        }else{
            dropCurrDropDown.hide()
        }
        dropCurrDropDown.width = viewDropDropDown.frame.width
        dropCurrDropDown.direction = .bottom
        dropCurrDropDown.bottomOffset = CGPoint(x: 0, y:(dropCurrDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    @IBAction func btnRemixCurrAction(_ sender: UIButton) {
        remixCurrDropDown.anchorView = btnRemixCurrency
        remixCurrDropDown.dataSource = ["Fixed", "Varies"]
        if RemixSegmentControl.selectedSegmentIndex == 0{
            remixCurrDropDown.show()
        }else{
            remixCurrDropDown.hide()
        }
        remixCurrDropDown.width = viewRemixDropDown.frame.width
        remixCurrDropDown.direction = .bottom
        remixCurrDropDown.bottomOffset = CGPoint(x: 0, y:(remixCurrDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    //MARK: - WEBSERVICES
    func callEditProfileWebService(){
        if textFieldFeedbackPrice.text?.isEmpty == true{
            textFieldFeedbackPrice.text = "50"
        }
        if textFieldDropPrice.text?.isEmpty == true{
            textFieldDropPrice.text = "150"
        }
        if textFieldRemixPrice.text?.isEmpty == true{
            textFieldRemixPrice.text = "150"
        }
        if textViewFeedBackDetail.text?.isEmpty == true{
            textViewFeedBackDetail.text = lblFeedbackPlaceholder.text
        }
        if textViewDropDetail.text?.isEmpty == true{
            textViewDropDetail.text = lblDropPlaceholder.text
        }
        if textViewRemixDetail.text?.isEmpty == true{
            textViewRemixDetail.text = lblRemixPlaceholder.text
        }
        
        if getReachabilityStatus(){
            let parameters = [
                "profileid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "username":"\(textfieldDjname.text!)",
                "genre_ids":"\(self.genreIds)",
                "bio":"\(textfieldYourBio.text!)",
                "city":"\(textfieldCurrentcity.text!)",
                "state":"",
                "state_code":"",
                "country":"",
                "postalcode":"\(codePostal)",
                "latitude":"\(globalObjects.shared.addLat!)",
                "longitude":"\(globalObjects.shared.addLong!)",
                "facebook_link":"\(tfFacebookLink.text!)",
                "twitter_link":"\(tfTwitterLink.text!)",
                "instagram_link":"\(tfInstagramLink.text!)",
                "youtube_link":"\(tfYoutubeLink.text!)",
                "dj_feedback":"\(textViewFeedBackDetail.text!)",
                "dj_feedback_status":"\(feedbackStatus)",
                "dj_feedback_currency":"\(feedback_currency_name)",
                "dj_feedback_price":"\(textFieldFeedbackPrice.text!)",
                "dj_drops":"\(textViewDropDetail.text!)",
                "dj_drops_status":"\(dropStatus)",
                "dj_drops_currency":"\(drop_currency_name)",
                "dj_drops_price":"\(textFieldDropPrice.text!)",
                "dj_remix":"\(textViewRemixDetail.text!)",
                "dj_remix_status":"\(remixStatus)",
                "dj_remix_currency":"\(remix_currency_name)",
                "dj_remix_price":"\(textFieldRemixPrice.text!)",
                "media_audio_name":"\(txtFieldAudioName.text!)",
                "usertype":"\(UserModel.sharedInstance().userType!)",
                // for feedback varies use is_dj_feedback_varying = dj_feedback_varying
                "is_dj_feedback_varying":"\(dj_feedback_varying)",
                "dj_feedback_range1":"\(dj_feedback_range1)",
                "dj_feedback_range2":"\(dj_feedback_range2)",
                // for drop varies use is_dj_drop_varying = dj_drop_varying
                "is_dj_drop_varying":"\(dj_drop_varying)",
                "dj_drop_range1":"\(dj_drop_range1)",
                "dj_drop_range2":"\(dj_drop_range2)"
                
            ]
            Loader.shared.show()
            print(parameters)
            let profileImage = self.imgProfileImage.image?.jpegData(compressionQuality: 0.7)
            let serviceURL = URL(string: "\(webservice.url)\(webservice.saveProfileAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if profileImage != nil {
                    multipartFormData.append(profileImage!, withName: "profile_image",fileName: "image.png", mimeType: "image/png")
                }
                for (key, value) in parameters {
                    print("key \(key) and value \(value)")
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    
                    if self.songData != nil {
                        multipartFormData.append(self.songData! as Data, withName: "media_audio", fileName: "audio.mp3", mimeType: "audio/mp3")
                    }
                }
            }, to: serviceURL) { (result) in
                switch result {
                case .success(let upload,_,_):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseObject(completionHandler: { (response:DataResponse<EditProfileModel>) in
                        switch response.result {
                        case .success(_):
                            Loader.shared.hide()
                            let editProfileModel = response.result.value!
                            if editProfileModel.success == 1{
                                self.view.makeToast(editProfileModel.message)
                                if UserModel.sharedInstance().finishProfile == true{
                                    self.ChangeRoot()
                                }else{
                                    let transition = CATransition()
                                    transition.duration = 0.3
                                    transition.type = CATransitionType(rawValue: "fade")
                                    transition.subtype = CATransitionSubtype.fromLeft
                                    self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                                    self.navigationController?.popViewController(animated: true)
                                }
                                UserModel.sharedInstance().finishProfile = false
                                UserModel.sharedInstance().genereList = self.textfieldMusicgenre.text!
                                UserModel.sharedInstance().uniqueUserName = self.textfieldDjname.text!
                                UserModel.sharedInstance().userProfileUrl = editProfileModel.profile_picture!
                                globalObjects.shared.profileCompleted = true
                                UserModel.sharedInstance().synchroniseData()
                            }else{
                                Loader.shared.hide()
                                self.view.makeToast(editProfileModel.message)
                            }
                        case .failure(let error):
                            Loader.shared.hide()
                            debugPrint(error)
                            print("Error")
                        }
                        
                    })
                case .failure(let error):
                    Loader.shared.hide()
                    print(error)
                    break
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
                        self.lblFeedbackPlaceholder.isHidden = true
                        self.lblDropPlaceholder.isHidden = true
                        self.lblRemixPlaceholder.isHidden = true
                        UserModel.sharedInstance().finishProfile = false
                        self.textfieldDjname.text = getProfile.Profiledata![0].username!
                        self.textfieldCurrentcity.text = getProfile.Profiledata![0].city!
                        self.textfieldYourBio.text = getProfile.Profiledata![0].bio!
            
                        if let lat = getProfile.Profiledata![0].latitude{
                            if lat.isEmpty == true{
                                globalObjects.shared.addLat = UserModel.sharedInstance().currentLatitude!
                            }else{
                                globalObjects.shared.addLat = Double(lat)
                            }
                        }
                        if let long = getProfile.Profiledata![0].longitude {
                            if long.isEmpty == true{
                                globalObjects.shared.addLong = UserModel.sharedInstance().currentLongitude!
                            }else{
                                globalObjects.shared.addLong = Double(long)
                            }
                        }
                        if let profileImageUrl = getProfile.Profiledata![0].profile_picture{
                            
                            let url = URL(string: profileImageUrl)
                             self.imgProfileImage.kf.setImage(with: url, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        }
                        if let x = UserModel.sharedInstance().userProfileUrl{
                            if let userProfileImageUrl = URL(string: x){
                                self.imgProfileImg.kf.setImage(with: userProfileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                            }
                        }
                        if let feedbackDetail = getProfile.Profiledata?[0].dj_feedback_drops{
                            if feedbackDetail.count > 0{
                                
                                if let dj_feedback = feedbackDetail[0].dj_feedback{
                                    self.textViewFeedBackDetail.text = dj_feedback
                                    let x : String = self.textViewFeedBackDetail.text!
                                    self.lblFeedbackCount.text = "\(x.count)/200"
                                    if dj_feedback.isEmpty == true{
                                        self.lblFeedbackPlaceholder.isHidden = false
                                    }
                                }
                                if let dj_feedback_currency = feedbackDetail[0].dj_feedback_currency{
                                    self.lblServiceFeedbackPrice.text = "Price(" + dj_feedback_currency + ")"
                                    self.lblSongReviewRangePrice.text = "Price(" + dj_feedback_currency + ")"
                                }
                                
                                if let feedback_vary = feedbackDetail[0].is_dj_feedback_varying{
                                    if feedback_vary == 0{
                                        self.txtFieldFeedback.text = "Fixed"
                                        self.vwFixedSongReview.isHidden = false
                                        self.vwRangeSongReview.isHidden = true
                                        self.dj_feedback_varying = 0
                                    }else{
                                        self.txtFieldFeedback.text = "Varies"
                                        self.vwFixedSongReview.isHidden = true
                                        self.vwRangeSongReview.isHidden = false
                                        self.dj_feedback_varying = 1
                                    }
                                }
                                
                                if let SongReviewRange1 = feedbackDetail[0].dj_feedback_range1{
                                    self.txfSongReviewMin.text = "\(SongReviewRange1)"
                                }
                                
                                if let SongReviewRange2 = feedbackDetail[0].dj_feedback_range2{
                                    self.txfSongReviewMax.text = "\(SongReviewRange2)"
                                }
                                
                                if var dj_feedback_price = feedbackDetail[0].dj_feedback_price{
                                    let removedSymbol = dj_feedback_price.removeFirst()
                                    self.lblFeedbackCurrSymbol.text = "\(removedSymbol)"
                                    self.textFieldFeedbackPrice.text = dj_feedback_price
                                }
                                
                                if let dj_drops = feedbackDetail[0].dj_drops{
                                    self.textViewDropDetail.text = dj_drops
                                    let x : String = self.textViewDropDetail.text!
                                    self.lblDropCount.text = "\(x.count)/200"
                                }
                                
                                if let dj_drops_currency = feedbackDetail[0].dj_drops_currency{
                                     self.lblServiceDropPrice.text = "Price(" + dj_drops_currency + ")"
                                    self.lblDropRangePrice.text = "Price(" + dj_drops_currency + ")"
                                }
                                
                                if let drop_vary = feedbackDetail[0].is_dj_drop_varying{
                                    if drop_vary == 0{
                                        self.txtFieldDrop.text = "Fixed"
                                        self.vwFixedDrop.isHidden = false
                                        self.vwRangeDrop.isHidden = true
                                        self.dj_drop_varying = 0

                                    }else{
                                        self.txtFieldDrop.text = "Varies"
                                        self.vwFixedDrop.isHidden = true
                                        self.vwRangeDrop.isHidden = false
                                        self.dj_drop_varying = 1

                                    }
                                }
                                
                                if let DropRange1 = feedbackDetail[0].dj_drop_range1{
                                    self.txfDropMin.text = "\(DropRange1)"
                                }
                                
                                if let DropRange2 = feedbackDetail[0].dj_drop_range2{
                                    self.txfDropMax.text = "\(DropRange2)"
                                }
                                
                                if var dj_drops_price = feedbackDetail[0].dj_drops_price{
                                    let removedPriceSymbol = dj_drops_price.removeFirst()
                                    self.lblDropCurrSymbol.text = "\(removedPriceSymbol)"
                                    self.textFieldDropPrice.text = dj_drops_price
                                }
                                
                                if let fbckStatus = feedbackDetail[0].dj_feedback_status{
                                    if fbckStatus == "on" {
                                        self.feedbackStatus = "on"
                                        self.setFeedbackON()
                                    }else{
                                        self.feedbackStatus = "off"
                                        self.setFeedbackOFF()
                                    }
                                }
                                if let drpStatus = feedbackDetail[0].dj_drops_status{
                                    if drpStatus == "on" {
                                        self.dropStatus = "on"
                                        self.setDropON()
                                    }else{
                                        self.dropStatus = "off"
                                        self.setDropOFF()
                                    }
                                }
                                
                                if var dj_remix_price = feedbackDetail[0].dj_remix_price{
                                    let removedPriceSymbol = dj_remix_price.removeFirst()
                                    self.lblRemixCurrSymbol.text = "\(removedPriceSymbol)"
                                    self.textFieldRemixPrice.text = dj_remix_price
                                }
                                
                                if let dj_remix = feedbackDetail[0].dj_remix{
                                    self.textViewRemixDetail.text = dj_remix
                                    let x : String = self.textViewRemixDetail.text!
                                    self.lblRemixCount.text = "\(x.count)/200"
                                }
                                
                                if let remixStatus = feedbackDetail[0].dj_remix_status{
                                    
                                    if remixStatus == "on" {
                                        self.remixStatus = "on"
                                        self.setRemixON()
                                    }else{
                                        self.remixStatus = "off"
                                        self.setRemixOFF()
                                    }
                                }
                                
                                if let drop_vary = feedbackDetail[0].is_dj_remix_varying{
                                    if drop_vary == 0{
                                        self.txtFieldRemix.text = "Fixed"
                                        self.vwFixedRemix.isHidden = false
                                        self.vwRangeRemix.isHidden = true
                                        self.dj_remix_varying = 0

                                    }else{
                                        self.txtFieldRemix.text = "Varies"
                                        self.vwFixedDrop.isHidden = true
                                        self.vwRangeDrop.isHidden = false
                                        self.dj_remix_varying = 1

                                    }
                                }
                                
                                if let DropRange1 = feedbackDetail[0].dj_drop_range1{
                                    self.txfRemixMin.text = "\(DropRange1)"
                                }
                                
                                if let DropRange2 = feedbackDetail[0].dj_drop_range2{
                                    self.txfRemixMax.text = "\(DropRange2)"
                                }
                                
                                if let dj_remix_currency = feedbackDetail[0].dj_remix_currency{
                                    self.lblServiceRemixPrice.text = "Price(" + dj_remix_currency + ")"
                                    self.lblRemixRangePrice.text = "Price(" + dj_remix_currency + ")"
                                }
                            }
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
                            self.tfYoutubeLink.text = youTubeLink
                        }
                       
                        self.genreIds = (getProfile.Profiledata?[0].genre_ids!) ?? "1"
                        self.genreNames = (getProfile.Profiledata?[0].genre!) ?? "Rock"
                        self.textfieldMusicgenre.text = self.genreNames
                        self.lblGenre.text = self.genreNames
                        
                        if let audioName = getProfile.Profiledata![0].media_audio_name{
                            self.lblSampleName.text = audioName
                        }
                        if let byName = getProfile.Profiledata![0].media_audio_by{
                            self.lblDjName.text = "by \(byName)"
                        }
                        if let genre = getProfile.Profiledata![0].media_audio_genre{
                            self.lblGenre.text = "\(genre)"
                        }
                        if let audioFileName = getProfile.Profiledata![0].media_audio{
                            let songURL = URL(string: audioFileName)
                            self.apiSongData = audioFileName
                            self.preparePlayer(songURL)
                        }
                        if let videoFile = getProfile.Profiledata![0].media_video{
                            if let id = getProfile.Profiledata![0].media_broadcastID{
                                if id.isEmpty == false{
                                    self.viewVideo.isHidden = false
                                    self.lblMediaVideoDetail.isHidden = true
                                    self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
                                    self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
                                    self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
                                    self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
                                    if getProfile.Profiledata![0].media_ending!.isEmpty == false{
                                        globalObjects.shared.isDjVideoTimer = true
                                        self.mediaRemainingTime = getProfile.Profiledata![0].media_ending!.localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                                        self.startMediaTimer()
                                    }
                                }
                            }else if videoFile.isEmpty == false{
                                self.viewVideo.isHidden = false
                                self.lblMediaVideoDetail.isHidden = true
                                self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
                                self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
                                self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
                                self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
                                self.apiVideoData = videoFile
                            }else{
                                self.viewVideo.isHidden = true
                                self.lblMediaVideoDetail.isHidden = false
                                if self.buttonSelected == "media"{
                                    self.cnsViewMainHeight.constant = 445
                                }
                            }
                        }
                        if self.buttonSelected == "media"{
                                if self.apiSongData.isEmpty == true{
                                    self.vwDjMedia.isHidden = true
                                    self.vwArtistMedia.isHidden = false
                                    self.mediaPageCalled()
                                }else{
                                    self.vwDjMedia.isHidden = false
                                    self.vwArtistMedia.isHidden = true
                                    self.addMediaView()
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
    
    func callCurrencyListWebService(){
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
//            self.feedback_currency_name = UserModel.sharedInstance().currency_name!
//            self.lblServiceFeedbackPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//            self.lblSongReviewRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            self.lblFeedbackCurrSymbol.text = currencySymbol
            self.lblSongReviewRangeSymbol1.text = currencySymbol
            self.lblSongReviewRangeSymbol2.text = currencySymbol
//            self.drop_currency_name = UserModel.sharedInstance().currency_name!
//            self.remix_currency_name = UserModel.sharedInstance().currency_name!
//            self.lblServiceDropPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
//            self.lblDropRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            self.lblDropCurrSymbol.text = currencySymbol
            self.lblDropRangeSymbol1.text = currencySymbol
            self.lblDropRangeSymbol2.text = currencySymbol
//            self.lblServiceRemixPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            self.lblRemixCurrSymbol.text = currencySymbol
            
            if(UserModel.sharedInstance().currency_name == "IN"){
                UserModel.sharedInstance().currency_name = "INR"
                
                self.lblServiceRemixPrice.text = "Price(" + "INR" + ")"
                self.drop_currency_name = "INR"
                self.remix_currency_name = "INR"
                self.lblServiceDropPrice.text = "Price(" + "INR" + ")"
                self.lblDropRangePrice.text = "Price(" + "INR" + ")"
                self.feedback_currency_name = "INR"
                self.lblServiceFeedbackPrice.text = "Price(" + "INR" + ")"
                self.lblSongReviewRangePrice.text = "Price(" + "INR" + ")"
                
            }
            else{
                self.lblServiceRemixPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
                self.drop_currency_name = UserModel.sharedInstance().currency_name!
                self.remix_currency_name = UserModel.sharedInstance().currency_name!
                self.lblServiceDropPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
                self.lblDropRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
                self.feedback_currency_name = UserModel.sharedInstance().currency_name!
                self.lblServiceFeedbackPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
                self.lblSongReviewRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            }
        }
    }
    
    func callAddAudioWebService(){
        
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "usertype":"\(UserModel.sharedInstance().userType!)",
                "media_audio_name":"\(txtFieldAudioName.text!)",
            ]
            
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addMediaAudioAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    multipartFormData.append(self.songData as! Data, withName: "media_audio", fileName: "audio.mp3", mimeType: "audio/mp3")
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
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
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
                        self.textfieldDjname.text = getProfile.Profiledata![0].username!
                            self.textfieldCurrentcity.text = getProfile.Profiledata![0].city!
                        self.video_verify_Id = "\(getProfile.Profiledata![0].media_video_id!)"
                        global.audioName = getProfile.Profiledata![0].media_audio_name!
                        self.video_broadcastId = getProfile.Profiledata![0].media_broadcastID!
                        self.videoType = getProfile.Profiledata![0].media_video_project!
                        
                        self.textfieldYourBio.text = getProfile.Profiledata![0].bio!
                        if let profileImageUrl = getProfile.Profiledata![0].profile_picture{
                            let url = URL(string: profileImageUrl)
                            self.imgProfileImage.kf.setImage(with: url, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        }
                        if let userProfileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!){
                            self.imgProfileImg.kf.setImage(with: userProfileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
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
                            self.tfYoutubeLink.text = youTubeLink
                        }
                        
                        self.genreIds = (getProfile.Profiledata?[0].genre_ids!) ?? "1"
                        self.genreNames = (getProfile.Profiledata?[0].genre!) ?? "Rock"
                        self.textfieldMusicgenre.text = self.genreNames
                        self.lblGenre.text = self.genreNames
                        
                        if let audioName = getProfile.Profiledata![0].media_audio_name{
                            self.lblSampleName.text = audioName
                        }
                        if let byName = getProfile.Profiledata![0].media_audio_by{
                            self.lblDjName.text = "by \(byName)"
                        }
                        if let genre = getProfile.Profiledata![0].media_audio_genre{
                            self.lblGenre.text = "\(genre)"
                        }
                        if let audioFileName = getProfile.Profiledata![0].media_audio{
                            let songURL = URL(string: audioFileName)
                            self.apiSongData = audioFileName
                            self.preparePlayer(songURL)

                        }
                        if let lat = getProfile.Profiledata![0].latitude{
                            if lat.isEmpty == true{
                                globalObjects.shared.addLat = UserModel.sharedInstance().currentLatitude!
                            }else{
                                globalObjects.shared.addLat = Double(lat)
                            }
                        }
                        if let long = getProfile.Profiledata![0].longitude {
                            if long.isEmpty == true{
                                globalObjects.shared.addLong = UserModel.sharedInstance().currentLongitude!
                            }else{
                                globalObjects.shared.addLong = Double(long)
                            }
                        }
                        if let videoFile = getProfile.Profiledata![0].media_video{
                            if let id = getProfile.Profiledata![0].media_broadcastID{
                                if id.isEmpty == false{
                                    self.viewVideo.isHidden = false
                                    self.lblMediaVideoDetail.isHidden = true
                                    self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
                                    self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
                                    self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
                                    self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
                                    if getProfile.Profiledata![0].media_ending!.isEmpty == false{
                                        globalObjects.shared.isArVideoTimer = true
                                        self.mediaRemainingTime = getProfile.Profiledata![0].media_ending!.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                                        self.startMediaTimer()
                                    }
                                }
                            }else if videoFile.isEmpty == false{
                                self.viewVideo.isHidden = false
                                self.lblMediaVideoDetail.isHidden = true
                                self.lblVi_holderName.text = "\(getProfile.Profiledata![0].username!)"
                                self.lblVi_byName.text = "By \(getProfile.Profiledata![0].media_video_by!)"
                                self.lblVi_ProjName.text = "\(getProfile.Profiledata![0].media_video_project!)"
                                self.lblVi_GenreName.text = "\(getProfile.Profiledata![0].media_video_genre!)"
                                self.apiVideoData = videoFile
                                let url = URL(string: "\(videoFile)")
                                if getProfile.Profiledata![0].media_ending!.isEmpty == false{
                                    globalObjects.shared.isArVideoTimer = true
                                    self.mediaRemainingTime = getProfile.Profiledata![0].media_ending!.UTCToLocal(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
                                    self.startMediaTimer()
                                }
                            }else{
                                self.viewVideo.isHidden = true
                                self.lblMediaVideoDetail.isHidden = false
                            }
                        }
                        if self.buttonSelected == "media"{
                            if self.apiSongData.isEmpty == false{
                                self.addMediaView()
                                self.vwArtistMedia.isHidden = true
                                self.vwDjMedia.isHidden = false
                            }else{
                                self.addMediaView()
                                self.vwArtistMedia.isHidden = false
                                self.vwDjMedia.isHidden = true
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
                    let uri = videoModelProfile.resourceUri
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as? ArtistBambUserPlayerVC
                    next1?.broadCastID = brodcastID
                    next1?.uri = uri!
                    next1?.id = self.video_verify_Id
                    if self.videoType == "SongReviewLive"{
                        next1?.videoType = "review"
                    }
                    if self.videoType == "project"{
                        next1?.videoType = "project"
                    }
                    next1?.backType = "edit_profile"
                    self.sideMenuController()?.setContentViewController(next1!)
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
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
}

extension ProfilePageVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
       
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        imgProfileImage.image = chosenImage
        imgProfileImage.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
}

extension ProfilePageVC: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        songData = try! Data(contentsOf: url) as NSData
        
        self.viewNameAudio.frame = CGRect(x: 0, y: 0, width: self.viewAddAudioBlur.frame.width, height: self.viewAddAudioBlur.frame.height)
        self.viewNameAudio.alpha = 0.0
        self.viewAddAudioBlur.addSubview(self.viewNameAudio)
        UIView.animate(withDuration: 1) {
            self.viewNameAudio.alpha = 1.0
        }
        self.lblDjName.text = UserModel.sharedInstance().uniqueUserName!
        self.lblGenre.text = UserModel.sharedInstance().genereList!
        preparePlayer(url)
      
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.viewAddAudioBlur.isHidden = true
        mediaPageCalled()
    }
    
}


extension ProfilePageVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if textView == textViewFeedBackDetail{
            lblFeedbackPlaceholder.isHidden = true
            let len = textView.text.count
            lblFeedbackCount.text = "\(len)/200"
            if textViewFeedBackDetail.text.count == 0{
                lblFeedbackPlaceholder.isHidden = false
            }
        }
        if textView == textViewDropDetail{
            lblDropPlaceholder.isHidden = true
            let len = textView.text.count
            lblDropCount.text = "\(len)/200"
            if textViewDropDetail.text.count == 0{
                lblDropPlaceholder.isHidden = false
            }
        }
        if textView == textViewRemixDetail{
            lblRemixPlaceholder.isHidden = true
            let len = textView.text.count
            lblRemixCount.text = "\(len)/200"
            if textViewRemixDetail.text.count == 0{
                lblRemixPlaceholder.isHidden = false
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == textViewFeedBackDetail{
            
            if text.count == 0 {
                if textView.text.count != 0 {
                    return true
                }
            } else if textView.text.count > 199 {
                return false
            }
            return true
        }else if textView == textViewDropDetail{
            
            if text.count == 0 {
                if textView.text.count != 0 {
                    return true
                }
            } else if textView.text.count > 199 {
                return false
            }
            return true
        }else if textView == textViewRemixDetail{
            
            if text.count == 0 {
                if textView.text.count != 0 {
                    return true
                }
            } else if textView.text.count > 199 {
                return false
            }
            return true
        }else{
            return false
        }
    }
}
extension ProfilePageVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlayPause.setImage(UIImage(named:"audio-play"),for: .normal)
    }
}
