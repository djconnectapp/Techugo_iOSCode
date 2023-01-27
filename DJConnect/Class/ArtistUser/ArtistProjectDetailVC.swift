//
//  ArtistProjectDetailVC.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 07/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

//Dispute

//Ok, I Accept

import UIKit
import Alamofire
import AlamofireObjectMapper
import AVFoundation
import CoreLocation
import MapKit
import LGSideMenuController
import FirebaseDynamicLinks

class ArtistSongStatusCell : UITableViewCell{
    @IBOutlet weak var imgProfileImage: imageProperties!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongby: UILabel!
    @IBOutlet weak var lblSongGenre: UILabel!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var SliderSong: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblReason: UILabel!
    
}

class projectControlButtonsArtist : UICollectionViewCell{
    @IBOutlet weak var imgControl: UIImageView!
    @IBOutlet weak var lblButtonName: UILabel!
    @IBOutlet weak var btnProjControl: UIButton!
    @IBOutlet weak var lblConnect: UILabel!
    
}

protocol artistDummyViewDelegate: class {
    func artistViewBtnCloseClicked()
    func artistViewBtnMenuClicked()
    
}
class ArtistProjectDetailVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblartistProjName: UILabel!
    @IBOutlet weak var lblartistByName: UILabel!
    @IBOutlet weak var lblartistTopTime: UILabel!
    @IBOutlet weak var lblartistProjEndIn: UILabel!
    @IBOutlet weak var lblartistbio: UILabel!
    @IBOutlet weak var lblartistProjProjType: UILabel!
    @IBOutlet weak var lblartistProjSpin: UILabel!
    @IBOutlet weak var lblarProjInfo: UILabel!
    @IBOutlet weak var lblarProjectType: UILabel!
    @IBOutlet weak var lblarAudience: UILabel!
    @IBOutlet weak var lblarProjVenueInfo: UILabel!
    @IBOutlet weak var lblarVenueName: UILabel!
    @IBOutlet weak var lblarVenueDate: UILabel!
    @IBOutlet weak var lblarVenueTime: UILabel!
    @IBOutlet weak var lblarVenueAdd: UILabel!
    @IBOutlet weak var lblarProjConnectInfo: UILabel!
    @IBOutlet weak var lblarConnectCost: UILabel!
    @IBOutlet weak var lblarConnectGenre: UILabel!
    @IBOutlet weak var lblarConnectRegulation: UILabel!
    @IBOutlet weak var lblarSpecialInfo: UILabel!
    @IBOutlet weak var lblarSpecialnone: UILabel!
    @IBOutlet weak var lblConnectCost: UILabel!
    @IBOutlet weak var lblFavorite: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var imgFavourite: UIImageView!
    @IBOutlet var vwFullImage: UIView!
    @IBOutlet weak var imgFullImage: UIImageView!
    @IBOutlet weak var imgUserProfileImage: UIImageView!
    @IBOutlet weak var imgProjectImage: UIImageView!
    @IBOutlet weak var lblEventDayDate: UILabel!
    @IBOutlet weak var vwProjControls: viewProperties!
    @IBOutlet weak var collectionVwProjControls: UICollectionView!
    @IBOutlet var vwProjectStatus: UIView!
    @IBOutlet weak var cnsVwStatusHeight: NSLayoutConstraint! //ashitesh not found
    @IBOutlet weak var btnAcceptStatus: UIButton!
    @IBOutlet weak var btnWaitStatus: UIButton!
    @IBOutlet weak var btnNotAcceptStatus: UIButton!
    @IBOutlet weak var lblConnectSubmission: UILabel!
    @IBOutlet weak var lblSongStatus: UILabel!
    @IBOutlet weak var lblSongStatusDetail: UILabel!
    @IBOutlet weak var lblSongCount: UILabel!
    @IBOutlet weak var tblSongStatus: UITableView!
    @IBOutlet weak var lblTopCurrentDate: UILabel!
    
    @IBOutlet weak var vwWaitButton: UIView!
    @IBOutlet weak var vwNotAcceptButton: UIView!
    @IBOutlet weak var cnsVwProjControlHeight: NSLayoutConstraint!
    @IBOutlet weak var lblProjectPrice: UILabel!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    
    //localize outlets
    @IBOutlet weak var btnViewFullImage: UIButton!
    
    @IBOutlet weak var dateTimeBgVw: UIView!
    
    @IBOutlet weak var disputeBgVw: UIView!
    @IBOutlet weak var disputeVw: UIView!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var disputeBtn: UIButton!
    @IBOutlet weak var iAcceptBtn: UIButton!
   
    @IBOutlet weak var connectAlertBgVw: UIView!
    @IBOutlet weak var connectAlertInnerVw: UIView!
    @IBOutlet weak var conctAlertLbl: UILabel!
    @IBOutlet weak var conctAlertCancelBtn: UIButton!
    @IBOutlet weak var conctAlertAccptBtn: UIButton!
    
    @IBOutlet weak var mapVenuInfoLbl: UILabel!
    @IBOutlet weak var mapBgVw: UIView!
    @IBOutlet weak var venuMapVw: MKMapView!
    
    
    @IBOutlet weak var scrolHght: NSLayoutConstraint!
    //MARK: - GLOBAL VARIABLES
    
    var locationManager:CLLocationManager!
    weak var delegate: artistDummyViewDelegate?
    var projectId = String()
    var currency = String()
    var currList = [CurrencyDataDetail]()
    var symbol = String()
    var projPrice = String()
    let blurEffectView = UIVisualEffectView(effect: globalObjects.shared.blurEffect)
    var projUserId = String()
//    var lblControlArray = ["Connect","Directions","Share"] // 1 // 2
//    var imgControlArray = ["biglogo","project_direction","Icon feather-share-2"]
    var lblControlArray = [String]()
    var imgControlArray = [String]()
    var isUserDJ = Bool()
    var buttonId = Int()
    var connectCost = String()
    var isFavProj = Bool()
    var getFavValue = Int()
    var getOfferValue = String()
    let blurButton = UIButton()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var remainingTime = String()
    var isCancelled = Bool()
    var projLat = String()
    var projLong = String()
    var statusArray = [artistAppliedProjSongStatus]()
    var artistConnectedArray = [artistAppiledSongDetail]()
    var artistRejectedArray = [artistRejectSongListDetail]()
    var audioPlayer: AVAudioPlayer?
    var indexPathRow = Int()
    var minuteString = String()
    var secondString = String()
    var mintime = [String]()
    var maxtime = [String]()
    var SliderValue = [String]()
    var songStatus = String()
    var artistConnected = Bool()
    var rejectReason = String()
    var projComplete = String()
    var fullDate = String()
    var weekDay = String()
    var djId = String()
    var djImageUrl = String()
    var isOfferOn = Int()
    var isBuyOn = Int()
    var isRejectArray = Bool()
    var waitArray = [appliedAudioDataDetail]()
    var isProjOld = String()
    var isProjCancel = String()
    var isInProgress = String()
    var currentCurrency = String()
    var isFromNotification = false
    var isFromAlert = false
    var projTimezone = String()
    var imgURl = String()
    var audioStatusSTr = String()
    var videoVerifySTr = String()
    var buttonTitleStr = String()
    var is_video_verifyInt = Int()
    var sendDatetime = String()
    var saveEventTimeSTr = String()
    var prStatusSTr = String()
    
    var musicTypeId = String()
    var setProjectNameStr = String()
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrolHght.constant = 1266 + 200
        prStatusSTr = ""
        
    }
    

    @IBAction func conctAlertAccptBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "segueConnectBuy", sender: nil)
    }
    @IBAction func conctAlertCancelBtnTapped(_ sender: Any) {
        connectAlertBgVw.isHidden = true
        connectAlertInnerVw.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        locationManager = CLLocationManager()
               locationManager.delegate = self
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        disputeBgVw.isHidden = true
        disputeVw.isHidden = true
        
        connectAlertBgVw.isHidden = true
        connectAlertInnerVw.isHidden = true
        connectAlertBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        connectAlertInnerVw.layer.cornerRadius = 10;
        connectAlertInnerVw.layer.masksToBounds = true;
        conctAlertLbl.text = "As you purchase or apply to project, there will be currency conversion fees if DJ and Artist are of dfferent countries. As for providing service through this app there will also be $1 additional fees as platform charges."
        conctAlertCancelBtn.layer.borderWidth = 1
        conctAlertCancelBtn.layer.borderColor = UIColor(red: 138/255, green: 62/255, blue: 169/255, alpha: 1.0).cgColor
        conctAlertCancelBtn.layer.cornerRadius = conctAlertCancelBtn.frame.size.height/2
        conctAlertCancelBtn.layer.masksToBounds = true;
        
        conctAlertAccptBtn.layer.cornerRadius = conctAlertAccptBtn.frame.size.height/2
        conctAlertAccptBtn.layer.masksToBounds = true;
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.connecthandleTap(_:)))
        connectAlertBgVw.addGestureRecognizer(tap2)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        disputeBgVw.addGestureRecognizer(tap1)
        
        disputeBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        disputeVw.layer.cornerRadius = 10;
        disputeVw.layer.masksToBounds = true;
        
        dateTimeBgVw.layer.cornerRadius = dateTimeBgVw.frame.size.height/2
        dateTimeBgVw.layer.masksToBounds = true;
        
        disputeBtn.layer.cornerRadius = 10;
        disputeBtn.layer.masksToBounds = true;
        
        iAcceptBtn.layer.cornerRadius = 10;
        iAcceptBtn.layer.masksToBounds = true;
        
        vwProjControls.layer.cornerRadius = vwProjControls.frame.size.height/2
        //disputeBtn.isUserInteractionEnabled = false
        //iAcceptBtn.isUserInteractionEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        btnAcceptStatus.isHidden = true
        btnWaitStatus.isHidden = true
        btnNotAcceptStatus.isHidden = true
        cnsVwStatusHeight.constant = 0 // ashitesh not found
        lblConnectSubmission.isHidden = true
        let date = Date()
        let formatter = DateFormatter()
        //formatter.dateFormat =  "MM/dd/yyyy"
        formatter.dateFormat =  "MMM d, yyyy"
        lblTopCurrentDate.text = "Today's Date : \(formatter.string(from: date))"
        btnAcceptStatus.isEnabled = false
        btnNotAcceptStatus.isEnabled = false
        btnWaitStatus.isEnabled = false
        callAlertApi()
        callGetProjectDetailWebService()
        if globalObjects.shared.searchResultUserType == UserModel.sharedInstance().userType {
            isUserDJ = true
            lblControlArray = ["Directions","Share"]
            imgControlArray = ["Icon feather-map-pin","Icon feather-share-2"]
            self.collectionVwProjControls.reloadData()
        }
        CallGetCurrentCreditsWebService()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            determineCurrentLocation()
        }
    
    func determineCurrentLocation()
        {
            locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                //locationManager.startUpdatingHeading()
                locationManager.startUpdatingLocation()
            }
        }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLocation:CLLocation = locations[0] as CLLocation
            print("Updating location")
            // Call stopUpdatingLocation() to stop listening for location updates,
            // other wise this function will be called every time when user location changes.
           // manager.stopUpdatingLocation()
            
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            venuMapVw.setRegion(region, animated: true)
            
            // Drop a pin at user's Current Location
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
            myAnnotation.title = "Current location"
        venuMapVw.addAnnotation(myAnnotation)
        }
        
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
        {
            print("Error \(error)")
        }
        
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
        {
            if !(annotation is MKPointAnnotation) {
                return nil
            }
            
            let annotationIdentifier = "AnnotationIdentifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                annotationView!.canShowCallout = true
            }
            else {
                annotationView!.annotation = annotation
            }
            
            let pinImage = UIImage(named: "customPinImage")
            annotationView!.image = pinImage
            return annotationView
        }
    //MARK: - ACTIONS
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.disputeBgVw.isHidden = true
        self.disputeVw.isHidden = true
        self.disputeBtn.isUserInteractionEnabled = false
        self.iAcceptBtn.isUserInteractionEnabled = false
    }
    
    @objc func connecthandleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.connectAlertBgVw.isHidden = true
        self.connectAlertInnerVw.isHidden = true
        
    }
    
    @IBAction func disputeBtnTapped(_ sender: Any) {
        //call api for dispute
        if buttonTitleStr == "Dispute"{
       // callrejectProjectVerificationAPI()
        }
        else if buttonTitleStr == "Cancel"{
            self.disputeBgVw.isHidden = true
            self.disputeVw.isHidden = true
            self.disputeBtn.isUserInteractionEnabled = false
            self.iAcceptBtn.isUserInteractionEnabled = false
        }
        
//        self.showToastt(message: "Toast genarated", font: .systemFont(ofSize: 12.0))
//        self.navigationController?.popViewController(animated: false)
//        self.showToastt(message: "Toast genarated", font: .systemFont(ofSize: 12.0))
        
        //navigationController?.popViewController(animated: false)
    }
    
    @IBAction func iAccptBtnTapped(_ sender: Any) {
        self.disputeBgVw.isHidden = true
        self.disputeVw.isHidden = true
        performSegue(withIdentifier: "segueConnectBuy", sender: nil)
    }
    
    @IBAction func btnProfile_Action(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "CalendarVC") as? CalendarVC
        next1?.viewerId = projUserId
        next1?.searchUserType = "DJ"
        globalObjects.shared.searchResultUserType = "DJ"
        next1?.isFromMenu = false
        navigationController?.pushViewController(next1!, animated: true)
    }
    
    @IBAction func BtnMenu_Action(_ sender: UIButton) {
        if globalObjects.shared.isDeeplinkNavigate == true{
            toggleSideMenuView()
        }else{
            delegate?.artistViewBtnCloseClicked()
        }
        globalObjects.shared.isDeeplinkNavigate = false
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
       // if globalObjects.shared.isDeeplinkNavigate == true{
//            let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
//            let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
           // sideMenuController()?.setContentViewController(next1!)
        let getProjectIdStr = UserDefaults.standard.string(forKey: "linkProjectid")
        if(getProjectIdStr != "" && getProjectIdStr != nil){
            UserDefaults.standard.removeObject(forKey: "linkProjectid")
            setUpDrawerArtist()
        }
//            if(navigationController == nil){
//                UserDefaults.standard.removeObject(forKey: "linkProjectid")
//                self.setUpDrawerArtist()
//           // }
//        }
        else if isFromAlert == true{
            backNotificationView()
        }else if isFromNotification == true{
            backNotificationView()
        }else{
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromBottom
            navigationController?.view.layer.add(transition, forKey: nil)
            navigationController?.popViewController(animated: false)
        }
        globalObjects.shared.isDeeplinkNavigate = false
    }
    
    func setUpDrawerArtist() {
        guard let centerController = UIStoryboard.init(name: "ArtistHome", bundle: nil).instantiateViewController(withIdentifier: "NewArtistHomeVC") as? NewArtistHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }

            let navigation = UINavigationController.init(rootViewController: centerController)
            navigation.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
            //sideMenuController.leftViewWidth = 280.0
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle

      self.view.window?.rootViewController = sideMenuController
      self.view.window?.makeKeyAndVisible()
   }
    
    
    @IBAction func btnFavoriteProjectAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnViewImageAction(_ sender: UIButton) {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurButton.frame = view.bounds
        view.addSubview(blurButton)
        blurButton.addTarget(self, action: #selector(btnBlur_Action(_:)), for: .touchUpInside)
        self.vwFullImage.frame = view.bounds
        self.vwFullImage.center = self.view.center
        self.view.addSubview(vwFullImage)
        imgFullImage.image = imgProjectImage.image
    }
    
    @IBAction func btnCloseImageViewAction(_ sender: UIButton) {
        blurButton.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        vwFullImage.removeFromSuperview()
    }
    
    @IBAction func btnWaitAction(_ sender: UIButton) {
        // call one api also call it on load
        vwProjectStatus.frame = view.bounds
        vwProjectStatus.isHidden = false
        view.addSubview(vwProjectStatus)
        lblSongStatus.text = "CONNECT SUBMISSIONS".localize
        lblSongStatusDetail.text = "ar_wait".localize
        lblSongCount.text = "Waiting"
        if songStatus == "0"{
            tblSongStatus.isHidden = false
        }else{
            tblSongStatus.isHidden = true
        }
    }
    
    @IBAction func btnAcceptedAction(_ sender: UIButton) {
        vwProjectStatus.frame = view.bounds
        vwProjectStatus.isHidden = false
        view.addSubview(vwProjectStatus)
        lblSongStatus.text = "CONNECT SUBMISSIONS".localize
        lblSongStatusDetail.text = "ar_accept".localize
        lblSongCount.text = "accepted"
        if songStatus == "1"{
            tblSongStatus.isHidden = false
        }else{
            tblSongStatus.isHidden = true
        }
        if artistConnected == true{
            tblSongStatus.isHidden = false
            lblSongStatus.text = "ARTISTS CONNECTED".localize
            lblSongStatusDetail.text = "ar_connect".localize
            lblSongCount.text = "\(artistConnectedArray.count) Artists Connected"
        }
    }
    
    @IBAction func btnNotAcceptedAction(_ sender: UIButton) {
        vwProjectStatus.frame = view.bounds
        vwProjectStatus.isHidden = false
        view.addSubview(vwProjectStatus)
        lblSongStatus.text = "CONNECT SUBMISSIONS".localize
        lblSongStatusDetail.text = "ar_reject".localize
        lblSongCount.text = "not accepted"
        if songStatus == "2"{
            tblSongStatus.isHidden = false
        }else{
            tblSongStatus.isHidden = true
        }
    }
    
    @IBAction func btnCloseProjectStatus(_ sender: UIButton) {
        audioPlayer?.pause()
        vwProjectStatus.removeFromSuperview()
    }
    
    //MARK: - OTHER METHODS
    
    func localizeElements(){
        lblartistProjEndIn.text = "ENDS IN".localize
        btnViewFullImage.setTitle("View Full Image".localize, for: .normal)
        lblartistProjProjType.text = "PROJECT TYPE".localize
        lblarProjInfo.text = "PROJECT INFO".localize
        lblarProjVenueInfo.text = "VENU INFO".localize
        lblarProjConnectInfo.text = "CONNECT INFO".localize
        lblarSpecialInfo.text = "SPECIAL INFORMATION".localize
        btnViewFullImage.setTitle("View Full Image".localize, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let formatterr = NumberFormatter()
        formatterr.groupingSeparator = "," // or possibly "." / ","
        formatterr.numberStyle = .decimal
        
        if segue.identifier == "segueConnectBuy" {
            let destinationVC = segue.destination as! BuyConnectVC
            destinationVC.userDetailDict["projectId"] = projectId
            destinationVC.userDetailDict["projectName"] = lblartistProjName.text!
            destinationVC.userDetailDict["projectBy"] = lblartistByName.text!
            
//            formatterr.string(from: Int(self.projPrice)! as NSNumber)
//            let string5 = formatterr.string(from: Int(self.projPrice)! as NSNumber)
            formatterr.string(from: Int((Float(self.projPrice)!)) as NSNumber)
            
            let string5 = formatterr.string(from: Int((Float(self.projPrice)!)) as NSNumber)
            destinationVC.userDetailDict["ProjectCost"] = "COST :".localize + " \(self.currentCurrency)" + string5!
            
           // destinationVC.userDetailDict["EventDayandDate"] = weekDay + fullDate
            destinationVC.userDetailDict["EventDayandDate"] = weekDay + sendDatetime
            destinationVC.userDetailDict["eventTime"] = self.saveEventTimeSTr
            destinationVC.userDetailDict["imgUrl"] = imgURl
            destinationVC.userDetailDict["projUserId"] = projUserId
            destinationVC.userDetailDict["is_complete"] = projComplete
            destinationVC.userDetailDict["isBuyOn"] = "\(isBuyOn)"
            destinationVC.userDetailDict["TrialCurrency"] = currentCurrency
            destinationVC.userDetailDict["audio_status"] = audioStatusSTr
        }
        
        if segue.identifier == "segueProjectdetailOffer"{
            let destinationVC = segue.destination as! ArtistOfferVC
            destinationVC.userDetailDict["projectBy"] = lblartistByName.text!
            
//            formatterr.string(from: Int(self.projPrice)! as NSNumber)
//            let string6 = formatterr.string(from: Int(self.projPrice)! as NSNumber)
            
            formatterr.string(from: Int((Float(self.projPrice)!)) as NSNumber)
            let string6 = formatterr.string(from: Int((Float(self.projPrice)!)) as NSNumber)
            
            
            destinationVC.userDetailDict["projectCost"] = "\(self.currentCurrency)" + string6!
            
            destinationVC.userDetailDict["userProfile"] = imgURl
            destinationVC.userDetailDict["projId"] = projectId
            destinationVC.userDetailDict["projUserId"] = projUserId
            destinationVC.userDetailDict["isOfferOn"] = "\(isOfferOn)"
            destinationVC.userDetailDict["currentCurrency"] = currentCurrency
            destinationVC.userDetailDict["projectName"] = lblartistProjName.text!
            
        }
    }
    
    func startTimer() {
        let releaseDateString = "\(remainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func projectFinalized(){
        self.isCancelled = false
        artistConnected = true
        btnAcceptStatus.isEnabled = true
        callArtistSongStatusWebService()
        print("oFFER - \(self.getOfferValue)")
        if self.getOfferValue == "0" || self.getOfferValue.isEmpty == true{
            if self.getFavValue == 0{
                self.isFavProj = true
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }else{
                self.isFavProj = false
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }
        }else{
            if self.getFavValue == 0{
                self.isFavProj = true
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }else{
                self.isFavProj = false
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }
        }
    }
    
    func projectNotCancelled(){
        self.isCancelled = false
        if self.getOfferValue == "0" || self.getOfferValue.isEmpty == true{
            if self.getFavValue == 0{
                self.isFavProj = true
                self.lblControlArray = ["Connect","Directions","Share"] // 1 // 2
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }else{
                self.isFavProj = false
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }
        }else{
            if self.getFavValue == 0{
                self.isFavProj = true
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }else{
                self.isFavProj = false
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
//                self.imgFavourite.image = UIImage(named: "fav_filled_proj_detail")
            }
        }
        self.callDjSongStatusWebService(status: "0")
        self.callDjSongStatusWebService(status: "1")
        self.callDjSongStatusWebService(status: "2")
    }
    
    func projectVisitedNotCancelled(){
        self.isCancelled = false
        if self.getOfferValue == "0"{
            if self.getFavValue == 0{
                self.isFavProj = true
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }else{
                self.isFavProj = false
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }
        }else{
            if self.getFavValue == 0{
                self.isFavProj = true
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
            }else{
                self.isFavProj = false
                self.lblControlArray = ["Connect","Directions","Share"]
                self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                self.collectionVwProjControls.reloadData()
//                self.imgFavourite.image = UIImage(named: "fav_filled_proj_detail")
            }
        }
        self.callDjSongStatusWebService(status: "0")
        self.callDjSongStatusWebService(status: "1")
        self.callDjSongStatusWebService(status: "2")
    }
    
    func OnGoingpreparePlayer(_ songurl: URL?) {
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
            let indexPath1 = IndexPath.init(row: indexPathRow, section: 0)
            let cell = tblSongStatus.cellForRow(at: indexPath1) as! ArtistSongStatusCell
            cell.SliderSong.maximumValue = Float(Double(self.audioPlayer!.duration))
            self.audioPlayer?.currentTime = Double(cell.SliderSong.value)
            cell.lblMinTime.text = String(cell.SliderSong.value)
            cell.lblMaxTime.text = "\(minuteString):\(secondString)"
            
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
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
            print("TOTAL TIMER: \(minuteString):\(secondString)")
            SliderValue.append(String(format: "%.2f", Float(Double(self.audioPlayer!.duration))))
            mintime.append("\(SliderValue)")
            maxtime.append("\(minuteString):\(secondString)")
        } catch {
            print(error)
        }
    }
    
    func verifyEnoughBalance() -> Bool{
        //ashitesh - 51 is added by ashiteshsh, bcoz userCurrentBalance > self.projPrice + 1 transaction
//        if(UserModel.sharedInstance().userCurrency == "$" || self.currentCurrency == "$"){
//
//            if UserModel.sharedInstance().userCurrentBalance! >= (Int(self.projPrice)! + 1){
//                return true
//            }else{
//                return false
//            }
//
//        }
//        else{
//        if UserModel.sharedInstance().userCurrentBalance! >= (Int(self.projPrice)! + 75){
        print("userCurrentBalance",UserModel.sharedInstance().userCurrentBalance ?? 0.0)
        print("self.projPrice",self.projPrice)
        if(UserModel.sharedInstance().userCurrentBalance != nil){
            if (UserModel.sharedInstance().userCurrentBalance ?? 0.0) >= (Float(self.projPrice) ?? 0.0){
            return true
        }else{
            return false
        }
        }
        else{
            return false
        }
    }
    
    func generateAlert(msg: String){
        self.showAlertView(msg, "Alert")
    }
    
    //MARK: - SELECTOR METHODS
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        let indexPath1 = IndexPath(row: indexPathRow, section: 0)
        let cell = tblSongStatus.cellForRow(at: indexPath1) as! ArtistSongStatusCell
        cell.lblMaxTime.text = "\(remMin):\(remSec)"
        cell.lblMinTime.text = "\(minCurrent):\(secCurrent)"
        cell.SliderSong.value = Float(Double((audioPlayer?.currentTime)!))
        
    }
    
    @objc func btnBlur_Action(_ sender: UIButton){
        blurButton.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        vwFullImage.removeFromSuperview()
    }
    
    @objc func btnProjControl_Action(_ sender:UIButton){
        buttonId = sender.tag
        if lblControlArray.count == 2{
            if buttonId == 0{
                
                if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com/")!)) {
                    UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?daddr=\(projLat),\(projLong)&dirflg=d")!, options: [:], completionHandler: nil)
                } else {
                    print("Can't use http://maps.apple.com/")
                }
                print("Directions")
            }
            if buttonId == 1{
                print("Share")
                let items = [URL(string: "https://djconnectapp.com/\(projectId)/ar-project-detail-page")!]
                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                present(ac, animated: true)
            }
        }
        if lblControlArray.count == 3{
            if buttonId == 0{
                if(prStatusSTr == ""){
                print("musicTypeId",musicTypeId)
                print("UserModel.sharedInstance().artist_typeSt",UserModel.sharedInstance().artist_typeSt)
                var getSrtistType1 = ""
                if UserModel.sharedInstance().artist_typeSt != nil {
                   print("getSrtistType1",UserModel.sharedInstance().artist_typeSt!)
                    getSrtistType1 = UserModel.sharedInstance().artist_typeSt!
                }
                if(UserModel.sharedInstance().artist_typeSt == nil || getSrtistType1 == "" || getSrtistType1 == "0"){
//
//                    let alert = UIAlertController(title: "Subscription Alert", message: "You don't have any subscription to purchase this project. So Please add subscription.", preferredStyle: .alert)
//                    let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
//                        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
//                        let next1 = storyBoard.instantiateViewController(withIdentifier: "AddSubscribeVC") as? AddSubscribeVC
//                        self.navigationController?.pushViewController(next1!, animated: true)
//                    }
//                    alert.addAction(action)
//                    self.present(alert, animated: true, completion: nil)
                    
                    self.chooseOptionToBuyProject()


                }
                else{
                    self.openProjectScreen()
                }
            }
            else{
                self.view.makeToast("You have already buy this project.")
            }
                
            }

            if buttonId == 1{
                
                if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com/")!)) {
                    UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?daddr=\(projLat),\(projLong)&dirflg=d")!, options: [:], completionHandler: nil)
                } else {
                    print("Can't use http://maps.apple.com/")
                }
            }
            if buttonId == 2{
//                let items = [URL(string: "https://djconnectapp.com/\(projectId)/ar-project-detail-page")!]
//                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//                present(ac, animated: true)
                
                self.CreateDynamicLink(productId: "\(projectId)")
                
            }
//            if buttonId == 3{
//                if  self.isFavProj == true{
//                    callFavoriteWebservice(type: "project")
//                }else{
//                    callUnFavouriteWebService()
//                }
            }
       // }
        
//        if lblControlArray.count == 4{
//            if buttonId == 0{
//                if isOfferOn == 1{
//                    self.view.makeToast("You have already applied for Offer")
//                }else{// connect action after video verify
//                    if verifyEnoughBalance() == true{ //
//
//                        //self.GetBuyProjectDataWebService() // ashitesh open popup
//                        self.connectAlertBgVw.isHidden = false
//                        self.connectAlertInnerVw.isHidden = false
////                           performSegue(withIdentifier: "segueConnectBuy", sender: nil)
//
//                    }else{
//                        generateAlert(msg: "You don't have enough Connect Cash to buy this project.")
//                    }
//                }
//            }
//
//            if buttonId == 1{
//                if isBuyOn == 1{
//                    self.view.makeToast("You have already Bought this project")
//                }else{
//                    if verifyEnoughBalance() == true{
//                        //performSegue(withIdentifier: "segueProjectdetailOffer", sender: nil)
//                        self.connectAlertBgVw.isHidden = false
//                        self.connectAlertInnerVw.isHidden = false
//                    }else{
//                        generateAlert(msg: "You don't have enough Connect Cash to buy this project.")
//                    }
//                }
//            }
//
//            if buttonId == 2{
//
//                if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com/")!)) {
//                    UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?daddr=\(projLat),\(projLong)&dirflg=d")!, options: [:], completionHandler: nil)
//                } else {
//                    print("Can't use http://maps.apple.com/")
//                }
//            }
//            if buttonId == 3{
//                let items = [URL(string: "https://djconnectapp.com/\(projectId)/ar-project-detail-page")!]
//                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//                present(ac, animated: true)
//            }
////            if buttonId == 4{
////                if  self.isFavProj == true{
////                    callFavoriteWebservice(type: "project")
////                }else{
////                    callUnFavouriteWebService()
////                }
////            }
//        }
    }
    
    func chooseOptionToBuyProject() {
        let alertController = UIAlertController(title: nil, message: "DjConnect", preferredStyle: .actionSheet)
        
        let CameraAction = UIAlertAction(title: "Subscription", style: .default) { (ACTION) in
            self.openSubscriptionScreen()
        }
        let GalleryAction = UIAlertAction(title: "Pay as you Go!", style: .default) { (ACTION) in
            self.openProjectScreen()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (ACTION) in
            
        }
        alertController.addAction(CameraAction)
        alertController.addAction(GalleryAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func openSubscriptionScreen(){
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "AddSubscribeVC") as? AddSubscribeVC
        self.navigationController?.pushViewController(next1!, animated: true)
    }
    
    func openProjectScreen() {
        
        var getSrtistType = ""
        if UserModel.sharedInstance().artist_typeSt != nil {
           print("newartistType",UserModel.sharedInstance().artist_typeSt!)
            getSrtistType = UserModel.sharedInstance().artist_typeSt!
        }
       // if(getSrtistType == "1"){
        
        if(getSrtistType != musicTypeId && getSrtistType != "0"){
                let alert = UIAlertController(title: "Alert", message: "You are not eligible to purchase this project.", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)
    }
    else{
    if verifyEnoughBalance() == true{// open dispute view here
       // self.GetBuyProjectDataWebService()
       
        self.connectAlertBgVw.isHidden = false
        self.connectAlertInnerVw.isHidden = false
            //performSegue(withIdentifier: "segueConnectBuy", sender: nil)
        
    }else{
       // generateAlert(msg: "You don't have enough Connect Cash to buy this project.")
        
        let alertController = UIAlertController(title: "Alert" , message: "You don't have enough Connect Cash to buy this project.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .destructive) { (action:UIAlertAction) in
        
                let vc = UIStoryboard(name: "DJHome", bundle: nil)
                let viewController = vc.instantiateViewController(withIdentifier: "FinancialViewController") as! FinancialViewController
                viewController.screenType = "projectDetail1"
               // callBackFinancialAmount
                viewController.callBackFinancialAmount = {financialAmount in
                    
                    print("financialAmountTotal",financialAmount)
                    self.callGetProjectDetailWebService()
                    self.CallGetCurrentCreditsWebService()
                }

                self.navigationController?.pushViewController(viewController, animated: true)
        
                }
                    alertController.addAction(action1)
                    self.present(alertController, animated: true, completion: nil)
        
    }
    }
      //  }
    }
    
    private func CreateDynamicLink(productId:String) -> URL{
            var deeplinkurl:URL?
            guard let link = URL(string: "https://djconnectapp.com/DJJSON/getapp.php?projectId=\(productId)") else { return URL(string: "")! }
            print(link)
            let dynamicLinksDomainURIPrefix = "https://djconnectnew.page.link"
            let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
            
            linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.DjConnectApp")
            linkBuilder?.iOSParameters?.minimumAppVersion = "1.0"
            linkBuilder?.iOSParameters?.appStoreID = "1601360647"
            linkBuilder?.iTunesConnectParameters = DynamicLinkItunesConnectAnalyticsParameters()
            linkBuilder?.iTunesConnectParameters?.providerToken = "123456"
            linkBuilder?.iTunesConnectParameters?.campaignToken = "example-promo"
            
            linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
            linkBuilder?.socialMetaTagParameters?.title = title
            linkBuilder?.socialMetaTagParameters?.descriptionText = description
            //linkBuilder?.socialMetaTagParameters?.imageURL =
            linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.djconnectapp")
            
            
        guard let longDynamicLink = linkBuilder?.url else {  return URL(string: "")! }
        print("The long URL is: \(longDynamicLink)")
        let options = DynamicLinkComponentsOptions()
        options.pathLength = .short
        linkBuilder?.shorten() { url, warnings, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let shortLink = url {
                print(shortLink)
                deeplinkurl = shortLink
                self.openShareOption(dynamicLink: deeplinkurl!, vc: self)
            }
        }
        let url = URL(string: "https://djconnectnew.page.link/ZCg5")
        
        return deeplinkurl ?? url!
        }
    
    //MARK:- Sharelink
    func openShareOption(dynamicLink:URL,vc:UIViewController){
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [dynamicLink],
            applicationActivities: nil
            
        )
        vc.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        
        if isProjCancel == "1"{
            self.lblRemainingTime.text = "PROJECT CANCELLED".localize
            self.lblRemainingTime.textColor = .red
           // prStatusSTr = "1"
        }else if isProjOld == "1"{
//            self.lblRemainingTime.text = "PROJECT ENDED".localize
//            self.lblRemainingTime.textColor = .red
            countdownTimer.invalidate()
            if(is_video_verifyInt == 0){
                self.lblRemainingTime.text = "IN PROGRESS".localize
                self.lblRemainingTime.textColor = .green
                prStatusSTr = "1"
            }else{
                self.lblRemainingTime.text = "Completed"
                self.lblRemainingTime.textColor = .green
                prStatusSTr = "1"
            }
           // prStatusSTr = "1"
        }else if isInProgress == "in_progress"{
            self.lblartistProjEndIn.text = ""
            self.lblRemainingTime.text = "IN PROGRESS".localize
            self.lblRemainingTime.textColor = .green
            prStatusSTr = "1"
        }else if projComplete == "1"{
            self.lblartistProjEndIn.text = ""
            self.lblRemainingTime.text = "PROJECT COMPLETED".localize
            self.lblRemainingTime.textColor = .red
            prStatusSTr = "1"
        }else{
            if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
                self.lblRemainingTime.text = "0 DAY 0 HR 0 MIN 0 SEC"
                self.lblRemainingTime.textColor = .red
                prStatusSTr = ""
            }else{
                //self.lblartistProjEndIn.text = "ENDS IN"
                self.lblRemainingTime.text = "Ends in " + countdown
                prStatusSTr = ""
                //self.lblRemainingTime.textColor = .red
            }
        }
    }
    
    @objc func btnPlay_Action(_ sender: UIButton){
        indexPathRow = sender.tag
        if artistConnected == false{
            OnGoingpreparePlayer(URL(string: statusArray[sender.tag].audio!))
        }else{
            OnGoingpreparePlayer(URL(string: artistConnectedArray[sender.tag].audiofile!))
        }
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
    }
    
    //MARK: - WEBSERVICES
    func callGetProjectDetailWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
//                    Loader.shared.hide()
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        let startString = detailProject.projectDetails![0].event_start_time!
                                                
                        let dateAsString = startString
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        let date24 = dateFormatter.date(from: dateAsString)

                        dateFormatter.dateFormat = "hh:mm a"
                        let date12 = dateFormatter.string(from: date24!)
                        
                        let startDate12 = date12
                        
                        //let startDate12 = startString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
                        
                        let endString = detailProject.projectDetails![0].event_end_time!
                        let endDate12 = endString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
                        
                        let dateString = detailProject.projectDetails![0].event_day_date!
                        let dateFormatter1 = DateFormatter()
                        dateFormatter1.dateFormat = "MM/dd/yyyy"
                        let date = dateFormatter1.date(from: dateString)
                        self.fullDate = dateString.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "MMM d, yyyy")
                        let weekday = Calendar.current.component(.weekday, from: date!)
                        switch weekday {
                        case 1:
                            self.weekDay = "Sunday - "
                        case 2:
                            self.weekDay = "Monday - "
                        case 3:
                            self.weekDay = "Tuesday - "
                        case 4:
                            self.weekDay = "Wednesday - "
                        case 5:
                            self.weekDay = "Thursday - "
                        case 6:
                            self.weekDay = "Friday - "
                        case 7:
                            self.weekDay = "Saturday - "
                        default:
                            self.weekDay = "Sunday - "
                        }
                        
                        self.projUserId = "\(detailProject.projectDetails![0].userid!)"
                        self.getFavValue = detailProject.projectDetails![0].is_favorite!
                        self.projComplete = "\(detailProject.projectDetails![0].is_completed!)"
                        self.getOfferValue = detailProject.projectDetails![0].artist_offer!
                        self.isOfferOn = detailProject.projectDetails![0].is_buy_offer!
                        self.isBuyOn = detailProject.projectDetails![0].is_buy_project!
                        self.isProjCancel = "\(detailProject.projectDetails![0].is_cancelled!)"
                        self.isProjOld = detailProject.projectDetails![0].is_old!
                        self.is_video_verifyInt = detailProject.projectDetails![0].is_video_verify!
                        self.isInProgress = detailProject.projectDetails![0].project_status!
                        self.projTimezone = detailProject.projectDetails![0].project_timezone!
                        if self.isUserDJ == false {
                            if detailProject.projectDetails![0].is_cancelled! == 1{
                                self.isCancelled = true
                                self.cnsVwProjControlHeight.constant = 0
                            }else if detailProject.projectDetails![0].Applied_Status! == 1{
                                if detailProject.projectDetails![0].is_completed! == 1{
                                    self.projectFinalized()
                                }else{
                                    self.btnAcceptStatus.isHidden = false
                                    self.btnWaitStatus.isHidden = false
                                    self.btnNotAcceptStatus.isHidden = false
                                    self.cnsVwStatusHeight.constant = 30 //ashitesh not found
                                    self.lblConnectSubmission.isHidden = false
                                    self.projectNotCancelled()
                                }
                            }else {
                                if detailProject.projectDetails![0].is_completed! == 1{
                                    self.isCancelled = true
                                    self.cnsVwProjControlHeight.constant = 0
                                }else{
                                    // user has not applied yet or first time visit.
                                    self.projectNotCancelled()
                                }
                            }
                        }
                        Loader.shared.hide()
                        self.audioStatusSTr = detailProject.projectDetails![0].audio_status ?? ""
                        self.videoVerifySTr = String(detailProject.projectDetails![0].is_video_verify ?? 0)
                        self.lblartistProjName.text = detailProject.projectDetails![0].title ?? ""
                        self.setProjectNameStr = detailProject.projectDetails![0].title ?? ""
                        self.lblartistByName.text = "By ".localize + detailProject.projectDetails![0].project_by!
                        self.lblartistbio.text = detailProject.projectDetails![0].project_description
//                        self.lblartistTopTime.text = startDate12 + " to ".localize
//                            + endDate12
//                        self.lblartistTopTime.text = "Starts @" + startDate12
//                        self.lblEventDayDate.text = " | Event on: ".localize + detailProject.projectDetails![0].event_day_date!
                        self.lblartistTopTime.text = detailProject.projectDetails![0].event_day_date!
                        self.lblEventDayDate.text = " | Starts @" + startDate12
                        self.saveEventTimeSTr = " Starts @" + startDate12
                        
                        self.lblarProjectType.text = "TYPE: ".localize + detailProject.projectDetails![0].project_info_type!
                        self.lblarAudience.text = "AUDIENCE (expected): ".localize + detailProject.projectDetails![0].project_info_audiance!
                        self.lblarVenueName.text = "NAME: ".localize + detailProject.projectDetails![0].venue_name!
                        self.lblarVenueDate.text = "DATE: ".localize + detailProject.projectDetails![0].event_date!
//                        self.lblarVenueTime.text = "TIME: ".localize + startDate12 + " to ".localize
//                            + endDate12
                        self.lblarVenueTime.text = "TIME: ".localize + startDate12
                        self.projLat = detailProject.projectDetails![0].latitude!
                        self.projLong = detailProject.projectDetails![0].longitude!
                        
                        
                        let location = CLLocationCoordinate2D(latitude: Double(self.projLat) ?? 0.0,longitude: Double(self.projLong) ?? 0.0)

                        let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
                            let region = MKCoordinateRegion(center: location, span: span)
                        self.venuMapVw.setRegion(region, animated: true)
                        
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            
                        self.venuMapVw.addAnnotation(annotation)
                        
                        self.connectCost = detailProject.projectDetails![0].price!
                        self.callCurrencyListWebService()
                        self.collectionVwProjControls.reloadData()
                        
                        if detailProject.projectDetails![0].venue_address_status!.caseInsensitiveCompare("no") == .orderedSame{
                            self.lblarVenueAdd.text = ""
                        }else{
                            self.lblarVenueAdd.text = "LOCATION: ".localize +  detailProject.projectDetails![0].venue_address!
                        }
                        
                        self.lblarConnectGenre.text = "GENRE(s): ".localize + detailProject.projectDetails![0].genre!
                        
                        self.sendDatetime = detailProject.projectDetails![0].event_day_date!
                        if detailProject.projectDetails![0].special_Information ?? " " == " "{
                            self.lblarSpecialnone.text = "None".localize
                        }else{
                            self.lblarSpecialnone.text = detailProject.projectDetails![0].special_Information!
                        }
                        if let currency = detailProject.projectDetails![0].currency{
                            self.symbol = currency
                        }
                        self.projPrice = detailProject.projectDetails![0].price!
                        //self.remainingTime = detailProject.projectDetails![0].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss") // ashitesh to correct date
                        self.remainingTime = detailProject.projectDetails![0].closing_time!
                        self.startTimer()
                        self.lblarConnectRegulation.text = "RESTRICTIONS: ".localize + detailProject.projectDetails![0].regulation!
                        // profile image, project image
                        let profileImageUrl = URL(string: "\(detailProject.projectDetails![0].profile_image!)")
                        self.imgUserProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        
                        let projectImageUrl = URL(string: "\(detailProject.projectDetails![0].project_image!)")
                        self.imgURl = "\(detailProject.projectDetails![0].project_image!)"
                        self.imgProjectImage.kf.setImage(with: projectImageUrl, placeholder: UIImage(named: "djCrowd"),  completionHandler: nil)
                    }else{
                        Loader.shared.hide()
                        if(detailProject.message == "You are not authorised. Please login again."){
                            self.view.makeToast(detailProject.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                            })
                        }
                        else{
                            self.view.makeToast(detailProject.message)
                        }
                        
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callFavoriteWebservice(type: String){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "favorite_by":"\(UserModel.sharedInstance().userId!)",
                "favorite_to":"\(projectId)",
                "favorite_type":"project",
                "userid": "\(UserModel.sharedInstance().userId!)"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addFavoriteAPI)?"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let favoriteProfile = response.result.value!
                    if favoriteProfile.success == 1{
                        self.view.makeToast(favoriteProfile.message)
                        self.isFavProj = false
                        if self.getOfferValue == "0" || self.getOfferValue.isEmpty == true{
                            self.lblControlArray = ["Connect","Directions","Share"]
                            self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                            self.collectionVwProjControls.reloadData()
                        }else{
                            self.lblControlArray = ["Connect","Directions","Share"]
                            self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                            self.collectionVwProjControls.reloadData()
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(favoriteProfile.message)
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
    
    func callUnFavouriteWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "removeid":"\(projectId)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.removeFavoriteAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let removefavProfile = response.result.value!
                    if removefavProfile.success == 1{
                        self.view.makeToast(removefavProfile.message)
                        self.isFavProj = true
                        if self.getOfferValue == "0" || self.getOfferValue.isEmpty == true{
                            self.lblControlArray = ["Connect","Directions","Share"]
                            self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                            self.collectionVwProjControls.reloadData()
                        }else{
                            self.lblControlArray = ["Connect","Directions","Share"]
                            self.imgControlArray = ["logo","Icon feather-map-pin","Icon feather-share-2"]
                            self.collectionVwProjControls.reloadData()
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(removefavProfile.message)
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
    
    func callArtistSongStatusWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getArtistProjectDetailAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)&projectid=\(projectId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetArtistProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let getStatusProfile = response.result.value!
                    if getStatusProfile.success == 1{
                        if self.artistConnected == false{
                            if let response = getStatusProfile.responseData{
                                self.statusArray = response
                            }
                            
                            for i in 0..<self.statusArray.count{
                                self.preparePlayer(URL(string: getStatusProfile.responseData![0].audio!))
                            }
                            if let Status = getStatusProfile.responseData![0].audio_status{
                                self.songStatus = Status
                                if self.songStatus == "0"{
                                    self.btnWaitStatus.setTitle("1 waiting", for: .normal)
                                }
                                if self.songStatus == "1"{
                                    self.btnAcceptStatus.setTitle("1 accepted", for: .normal)
                                }
                                if self.songStatus == "2"{
                                    self.btnNotAcceptStatus.setTitle("1 not accepted", for: .normal)
                                    self.rejectReason = self.statusArray[0].reason!
                                }
                            }
                            
                        }else{
                            self.lblConnectSubmission.isHidden = false
                            self.lblConnectSubmission.text = "Artist Connected"
                            self.cnsVwStatusHeight.constant = 20 //ashitesh not found
                            self.btnAcceptStatus.isHidden = false
                            self.vwWaitButton.isHidden = true
                            self.vwNotAcceptButton.isHidden = true
                            self.btnNotAcceptStatus.isHidden = true
                            self.btnWaitStatus.isHidden = true
                            self.tblSongStatus.isHidden = false
                            if let response = getStatusProfile.responseData![0].artist_list{
                                self.artistConnectedArray = response
                            }
                            self.btnAcceptStatus.setTitle("\(self.artistConnectedArray.count) Artists", for: .normal)
                            for i in 0..<self.artistConnectedArray.count{
                                self.preparePlayer(URL(string: getStatusProfile.responseData![0].artist_list![i].audiofile!))
                            }
                        }
                        
                    }else{
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
    
    func callDjSongStatusWebService(status: String){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAppliedartistAudioAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)&audio_status=\(status)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SongStatusModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let songStatusProfile = response.result.value!
                    if songStatusProfile.success == 1{
                        self.waitArray = songStatusProfile.appliedAudioData!
                        if status == "0"{
                            self.btnWaitStatus.setTitle("\(self.waitArray.count) waiting", for: .normal)
                        }else if status == "1"{
                            self.btnAcceptStatus.setTitle("\(self.waitArray.count) accepted", for: .normal)
                        }else{
                            self.btnNotAcceptStatus.setTitle("\(self.waitArray.count) not accepted", for: .normal)
                        }
                    }else{
                        Loader.shared.hide()
                        if status == "0"{
                            self.btnWaitStatus.setTitle("0 waiting", for: .normal)
                        }else if status == "1"{
                            self.btnAcceptStatus.setTitle("0 accepted", for: .normal)
                        }else{
                            self.btnNotAcceptStatus.setTitle("0 not accepted", for: .normal)
                        }
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
    
    func CallGetCurrentCreditsWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getCurrentCreditsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    if let jsonData = response.result.value as? [String: AnyObject]{
                        print(jsonData)
                        if jsonData["success"]! as! NSNumber == 1{
                            
                            if let x = (jsonData["total_current_credit"] as? String){
                                UserModel.sharedInstance().userCurrentBalance = Float(x)
                                UserModel.sharedInstance().synchroniseData()
                            }
                        }else{
                            Loader.shared.hide()
                        }
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
            )}else{
                self.view.makeToast("Please check your Internet Connection")
            }
    }
    
    func callCurrencyListWebService(){ // decimalpart
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
            let formatterr = NumberFormatter()
            formatterr.groupingSeparator = "," // or possibly "." / ","
            formatterr.numberStyle = .decimal
//            formatterr.string(from: Int(self.connectCost)! as NSNumber)
//            let string5 = formatterr.string(from: Int(self.connectCost)! as NSNumber)
           // self.lblarConnectCost.text = "COST(Per Project): ".localize + self.currentCurrency + string5!
            //self.lblProjectPrice.text = self.currentCurrency + string5!
            self.lblarConnectCost.text = "COST(Per Spin): ".localize + self.currentCurrency + self.connectCost
            self.lblProjectPrice.text = self.currentCurrency + self.connectCost
        }
    }
    
    func callAlertApi(){
        let notiCount = UserModel.sharedInstance().notificationCount
        if notiCount != nil {
            if notiCount! > 0 {
                self.lblMenuNotifyNumber.isHidden = false
                self.lblMenuNotifyNumber.text = "\(notiCount!)"
            }else{
                self.lblMenuNotifyNumber.isHidden = true
            }
        }
    }
    
    func callrejectProjectVerificationAPI(){
        
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "projectid":"\(projectId)"
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
                            let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
                            let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
                            self.sideMenuController()?.setContentViewController(next1!)
                        })
                        
                        
//                        self.navigationController?.popViewController(animated: false)
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
    
    func GetBuyProjectDataWebService(){
        
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getStepsProjectAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(projectId)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetBuyProjStepsModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStepModel = response.result.value!
                    if buyStepModel.success == 0{
                        
                    }
                    else if(buyStepModel.success == 1){
                        
                        if buyStepModel.step2 != "1"{
                            self.disputeBgVw.isHidden = false
                            self.disputeVw.isHidden = false
                            self.disputeBtn.setTitle("Cancel", for: .normal)
                            self.buttonTitleStr = "Cancel"
                            self.iAcceptBtn.setTitle("Ok, I Accept", for: .normal)
                            self.noteLbl.text = "As you purchase or apply to project, there will be currency conversion fees if DJ and Artist are of dfferent countries. As for providing service through this app there will also be $1 additional fees as platform charges."
                            self.disputeBtn.isUserInteractionEnabled = true
                            self.iAcceptBtn.isUserInteractionEnabled = true
                        }
                       
                        else if buyStepModel.is_completed! == 1{
                            
                            if buyStepModel.step3!.is_video_verify! == 1{
                                if(buyStepModel.step5!.review == ""){
                                    self.disputeBgVw.isHidden = false
                                    self.disputeVw.isHidden = false
                                    self.disputeBtn.setTitle("Dispute", for: .normal)
                                    self.iAcceptBtn.setTitle("Ok, I Accept", for: .normal)
                                    self.buttonTitleStr = "Dispute"
                                    self.noteLbl.text = "If you want to move futher with OK Accept button and your steps will complete and able to rate this project. And you can dispute this process also by clicking on Dispute button."
                                    self.disputeBtn.isUserInteractionEnabled = true
                                    self.iAcceptBtn.isUserInteractionEnabled = true
                                }
                                else{
                                    self.performSegue(withIdentifier: "segueConnectBuy", sender: nil)
                                }
                            }
                            else{
                                self.performSegue(withIdentifier: "segueConnectBuy", sender: nil)
                            }
                        }else{
                        self.performSegue(withIdentifier: "segueConnectBuy", sender: nil)
                        }
                        
                    }
                    else{
                        Loader.shared.hide()
                        
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please Check your Internet Connection")
        }
    }
}
//MARK: - EXTENSIONS
extension ArtistProjectDetailVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isUserDJ == true{
            //return 2
            return lblControlArray.count
        }else{
            if isCancelled == true{
               // return 2
                return lblControlArray.count
            }else{
                if self.getOfferValue == "1"{
                    //return 3
                    return lblControlArray.count
                }else{
                    //return 3
                    return lblControlArray.count
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectControlButtonsArtist", for: indexPath) as! projectControlButtonsArtist
        cell.lblConnect.isHidden = true
        cell.btnProjControl.tag = indexPath.row
        cell.btnProjControl.addTarget(self, action: #selector(btnProjControl_Action(_:)), for: .touchUpInside)
        if(setProjectNameStr != ""){
        cell.lblButtonName.text = lblControlArray[indexPath.row]
        if indexPath.row == 0 && isUserDJ == false{
            if isCancelled == true{
                cell.lblConnect.isHidden = true
                cell.imgControl.isHidden = false
                cell.imgControl.image = UIImage(named: imgControlArray[indexPath.row])
            }else{
                cell.lblConnect.isHidden = true
                cell.imgControl.isHidden = false
                cell.imgControl.image = UIImage(named: imgControlArray[indexPath.row])
                cell.imgControl.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
                cell.lblConnect.text = self.connectCost
            }
            
        }else{
            cell.lblConnect.isHidden = true
            cell.imgControl.isHidden = false
            cell.imgControl.image = UIImage(named: imgControlArray[indexPath.row])
        }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isUserDJ == false{
            if isCancelled == true{
                self.cnsVwProjControlHeight.constant = 40
                return CGSize(width:(collectionVwProjControls.frame.width)/2, height: 40)
            }else{
                if self.getOfferValue == "1"{
                    self.cnsVwProjControlHeight.constant = 40
                    return CGSize(width:(collectionVwProjControls.frame.width)/3, height: 40)
                }else{
                    self.cnsVwProjControlHeight.constant = 40
                    return CGSize(width:(collectionVwProjControls.frame.width)/3, height: 40)
                }
            }
        }else{
            self.cnsVwProjControlHeight.constant = 40
            return CGSize(width:(collectionVwProjControls.frame.width)/2, height: 40)
        }
    }
    
}

extension ArtistProjectDetailVC:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if artistConnected == true{
            return artistConnectedArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArtistSongStatusCell
        if artistConnected == false{
            cell.SliderSong.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
            cell.lblSongName.text = statusArray[indexPath.row].audio_title!
            cell.lblSongby.text = UserModel.sharedInstance().uniqueUserName!
            cell.lblSongGenre.text = UserModel.sharedInstance().genereList!
            cell.btnPlay.tag = indexPath.row
            cell.btnPlay.addTarget(self, action: #selector(btnPlay_Action(_:)), for: .touchUpInside)
            cell.SliderSong.maximumValue = Float(SliderValue[indexPath.row])!
            cell.lblMinTime.text = String(cell.SliderSong.value)
            cell.lblMaxTime.text = maxtime[indexPath.row]
            cell.lblReason.text = rejectReason
            let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
            cell.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            return cell
        }else{
            cell.SliderSong.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
            cell.lblSongName.text = artistConnectedArray[indexPath.row].audioname!
            cell.lblSongby.text = artistConnectedArray[indexPath.row].artistname!
            cell.btnPlay.tag = indexPath.row
            cell.btnPlay.addTarget(self, action: #selector(btnPlay_Action(_:)), for: .touchUpInside)
            cell.SliderSong.maximumValue = Float(SliderValue[indexPath.row])!
            cell.lblMinTime.text = String(cell.SliderSong.value)
            cell.lblMaxTime.text = maxtime[indexPath.row]
            cell.lblReason.isHidden = true
            let profileImageUrl = URL(string: artistConnectedArray[indexPath.row].profilepicture!)
            cell.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension ArtistProjectDetailVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let indexPath1 = IndexPath(row: indexPathRow, section: 0)
        let cell = tblSongStatus.cellForRow(at: indexPath1) as! ArtistSongStatusCell
        cell.btnPlay.setImage(UIImage(named:"audio-play"),for: .normal)
    }
}

extension ArtistProjectDetailVC {

func showToastt(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
