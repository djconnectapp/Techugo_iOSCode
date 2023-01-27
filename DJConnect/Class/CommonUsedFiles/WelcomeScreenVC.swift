//
//  djWelcomeScreenVC.swift
//  DJConnect
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 mac. All rights reserved.

import UIKit
import MapKit
import SwipeCellKit
import Alamofire
import DropDown
import AlamofireObjectMapper
import Cluster
import Foundation
class DJMultiplePinView : DJMultipleCluserPin{
    lazy var once: Void = { [unowned self] in
        self.countLabel.frame.size.width -= 6
        self.countLabel.frame.origin.x += 3
        self.countLabel.frame.origin.y -= 10
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = once
    }
}

class ImageCountClusterAnnotationView: ClusterAnnotationView {
    lazy var once: Void = { [unowned self] in
        self.countLabel.frame.size.width -= 6
        self.countLabel.frame.origin.x += 3
        self.countLabel.frame.origin.y += 12.8
        self.countLabel.font = .boldSystemFont(ofSize: 11)
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = once
    }
}

class SingleClusterAnnotationView: SinglePinClusterView {
    lazy var once: Void = { [unowned self] in
        self.priceLabel.frame.size.width -= 6
        self.priceLabel.frame.origin.x += 3
        self.priceLabel.frame.origin.y += 12
        self.priceLabel.font = .boldSystemFont(ofSize: 12)
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = once
    }
}

class FilterSongGenreTableViewCell: UITableViewCell{
    @IBOutlet weak var imgSongeGenre: UIImageView!
    @IBOutlet weak var lblSongGenre: UILabel!
}

class FilterProjectTypesTableViewCell: UITableViewCell{
    @IBOutlet weak var imgProjectType: UIImageView!
    @IBOutlet weak var lblProjectType: UILabel!
}

class search_cell: UITableViewCell {
    @IBOutlet weak var img_location: UIImageView!
    @IBOutlet weak var lbl_location: UILabel!
}

class MyAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    var image: UIImage? = nil
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
}

class connectionDetails: SwipeTableViewCell {
    
    @IBOutlet weak var shareBtnBgVw: UIView!
    @IBOutlet weak var cellBgVw: UIView!
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblProjName: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblExpectedAudi: UILabel!
    @IBOutlet weak var lblStarRate: UILabel!
    @IBOutlet weak var lblRateNo: UILabel!
    @IBOutlet weak var lblTime: UILabel!
}

class WelcomeScreenVC: UIViewController  {
    
    
    //MARK: - OUTLETS
    @IBOutlet weak var mapView: MKMapView!
    var region = (center: CLLocationCoordinate2D(latitude: Double(), longitude: Double()), delta: 0.1)
   // var region = (center: CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025), delta: 0.1)// delhi
    lazy var manager: ClusterManager = { [unowned self] in
        let manager = ClusterManager()
        manager.delegate = self
        manager.maxZoomLevel = 17
        manager.minCountForClustering = 2
        manager.clusterPosition = .nearCenter
        return manager
    }()
    
    @IBOutlet weak var viewSearchView: UIView!
    @IBOutlet weak var btnSlideIn: UIButton!
    @IBOutlet weak var vwCalendar: UIView!
    @IBOutlet weak var viewTableData: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblsearch: UITableView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tblSearchHeight: NSLayoutConstraint!
    @IBOutlet weak var btnfilter: UIButton!
    @IBOutlet weak var lblDjNAme: UILabel!
    @IBOutlet var viewDummyVC: UIView!
    @IBOutlet var viewPaymentPopup: UIView!
    
    @IBOutlet weak var btnProfileImage: UIButton!
    @IBOutlet weak var vwFilterLeadingSpace: NSLayoutConstraint!
    @IBOutlet var viewFilterView: UIView!
    @IBOutlet weak var tblSongGenre: UITableView!
    @IBOutlet weak var songGenreTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tblProjectType: UITableView!
    @IBOutlet weak var projectTypeTableHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerMinimumAttendance: UIPickerView!
    @IBOutlet weak var minimumAttendancePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblMinimumAttendance: UILabel!
    @IBOutlet weak var pickerConnectLimit: UIPickerView!
    @IBOutlet weak var connectLimitPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var lblConnectLimit: UILabel!
    @IBOutlet weak var btnFilterReset: UIButton!
    @IBOutlet weak var btnFilterSave: UIButton!
    @IBOutlet weak var viewhover: UIView!
    
    //localize outlet
    @IBOutlet weak var lblWelcomeToDJ: UILabel!
    @IBOutlet weak var btnrightArrow: UIButton!
    @IBOutlet weak var btnLeftArrow: UIButton!
    
    //localize filter view
    @IBOutlet weak var lblFilterResults: UILabel!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblSongGenre: UILabel!
    @IBOutlet weak var lblClickToEnter: UILabel!
    @IBOutlet weak var lblClicktoEnter2: UILabel!
    @IBOutlet weak var lblProjectType: UILabel!
    @IBOutlet weak var btnSetMiles: buttonProperties!
    @IBOutlet weak var lblMiles: UILabel!
    
    @IBOutlet weak var lblAvailableConnection: UILabel!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    @IBOutlet weak var vwSubCalendar: UIView!
    @IBOutlet weak var calendarInsideBgVw: UIView!
    @IBOutlet weak var lblSubCalendarDay: UILabel!
    @IBOutlet weak var lblSubCalendarDate: UILabel!
    @IBOutlet weak var lblSubCalendarMonth: UILabel!
    @IBOutlet weak var btnViewAllDates: UIButton!
    
    @IBOutlet weak var connectionBgImgVw: UIImageView!
    @IBOutlet weak var conctnTblBgVw: UIView!
    
    @IBOutlet weak var backBtn: UIButton!
    //MARK: - GLOBAL VARIABLES
    fileprivate weak var calendar: FSCalendar!
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    var currentLocation: CLLocation?
    var arrArtistGraphPin = [ArtistPinDataDetail]()
    let dateReuseIdentifier = "dayCell"
    let startingIndex = 400
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 8000
    let intialLocation = CLLocation(latitude: 22.3039, longitude: 70.8022)
    var annotationLocations = [[String:Any]]()
    var clusterAnnotationLocations = [[String: Double]]()
    var currLatitude = [[String: NSNumber]]()
    var currentAnnotation = [[String:Any]]()
    let amountArray = [String]()
    let projNameArray = [String]()
    var projByArray = [String]()
    let dateArray = [String]()
    let dayDateArray = [String]()
    var filteredLocations = [String]()
    var isSearchEnabled = false
    var pinAnnotationView:MKPinAnnotationView!
    
    //swipe cell variable
    var defaultOptions = SwipeOptions()
    var isSwipeRightEnabled = true
    var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
    var usesTallCells = false
    
    var vc1 = DJProjectDetail()
    var vc2 = ArtistProjectDetailVC()
    var postDate = String()
    var date = Date()
    var currentDateValue : String!
    var projectId = String()
    var arrSearchResult = [SearchListDetail]()
    var arrSearchFilter = [SearchListDetail]()
    var curDate : Date?
    var milesDropDown = DropDown()
    var viewerId = ""
    var currLongitude = [String]()
    var minimumAttendance = ["800,000,000","900,000,000","1,000,000,000","no minimum","100","200","300"]
    var connectLimit = ["$80,000","$90,000","$100,000","no limit","$10","$20","$30"]
    let currPin = MKPointAnnotation()
    let newPin = MKPointAnnotation()
    
    var searchedUser = String()
    var arprojectList = [ArtistPinDataDetail]()
    var arrgenrelist = [GenreData]()
    var projectTypeList = [projectTypeDataDetail]()
    var selectedAnnotation: MKPointAnnotation?
    var djSinglePinSelectUserType = String()
    var indexPathRow = Int()
    var buyEventTime = [String]()
    var EventDate = [String]()
    var releaseDate = [NSDate?]()
    var countdownTimer = Timer()
    var filterMiles = String()
    var filterAttendance = String()
    var filterPrice = String()
    var filtergenreIndex = [String]()
    var filterProjType = [String]()
    var genreArrayCleaned = String()
    var projTypeArrayCleaned = String()
    var RemainingTimeArray = [String]()
    var arrayCount = Int()
    
    var weekDay = String()
    var isOfferOn = Int()
    var isBuyOn = Int()
    var isProjComplete = String()
    var newNotify = Int()
    var currList = [CurrencyDataDetail]()
    var currentCurrency = String()
    var trial = [String]()
    var i : Int = 0
    var arSelectedDate = String()
    var verifiedLat = [String]()
    
    //MARK:- UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //conctnTblBgVw.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        conctnTblBgVw.backgroundColor = UIColor(red: 55/255, green: 69/255, blue: 99/255, alpha: 1.0).withAlphaComponent(0.9)
        txt_search.delegate = self
       // mapView?.mapType = .hybrid
        conctnTblBgVw.layer.cornerRadius = 20
        connectionBgImgVw.isHidden = true
        btnFilterSave.isEnabled = true
        UserModel.sharedInstance().isPin = true
        callCurrencyListWebService()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector:#selector(locationCheck), name: UIApplication.willEnterForegroundNotification, object: nil)
        manager.add(MeAnnotation(coordinate: region.center))
        self.calendarview()
        mapView.showsCompass = false
        localizeElements()
        pickerMinimumAttendance.isHidden = true
        pickerMinimumAttendance.tintColor = .white
        pickerConnectLimit.tintColor = .white
        minimumAttendancePickerHeight.constant = 10
        pickerConnectLimit.isHidden = true
        connectLimitPickerHeight.constant = 10
        
        let tapMinimumAttendance = UITapGestureRecognizer(target: self, action: #selector(tapMinimumAttendanceFunction))
        lblMinimumAttendance.isUserInteractionEnabled = true
        lblMinimumAttendance.addGestureRecognizer(tapMinimumAttendance)
        
        let tapConnectLimit = UITapGestureRecognizer(target: self, action: #selector(tapConnectLimitFunction))
        lblConnectLimit.isUserInteractionEnabled = true
        lblConnectLimit.addGestureRecognizer(tapConnectLimit)
        
//        if UserModel.sharedInstance().isSignup == true && UserModel.sharedInstance().isSkip == false && UserModel.sharedInstance().paymentPopup == false
//        {
//            toggleSideMenuView()
//           callPopup()
//        }
        
        if UserModel.sharedInstance().userType == "DJ" {
            self.btnfilter.isEnabled = false
            self.btnfilter.isHidden = true
            if UserModel.sharedInstance().userProfileUrl != nil {
                let profileImageUrl = URL(string: "\(UserModel.sharedInstance().userProfileUrl!)")
                self.btnProfileImage.kf.setImage(with: profileImageUrl, for: .normal, placeholder: UIImage(named: "user-profile"), completionHandler: nil)
            }
            else{
                btnProfileImage.setImage(UIImage(named: "djimage"), for: .normal)
            }
            lblDjNAme.text = "\(UserModel.sharedInstance().uniqueUserName!)"
        }else{
            self.btnfilter.isEnabled = true
            btnProfileImage.setImage(UIImage(named: "user-profile"), for: .normal)
            lblDjNAme.text = "\(UserModel.sharedInstance().uniqueUserName!)"
            if UserModel.sharedInstance().userProfileUrl != nil {
                let profileImageUrl = URL(string: "\(UserModel.sharedInstance().userProfileUrl!)")
                self.btnProfileImage.kf.setImage(with: profileImageUrl, for: .normal, placeholder: UIImage(named: "user-profile"), completionHandler: nil)
            }
            else{
                btnProfileImage.setImage(UIImage(named: "djimage"), for: .normal)
            }
        }
        if globalObjects.shared.isForgotPassword == "1"{
            toggleSideMenuView()
        }
        
        tblsearch .isHidden = true
        
        tblView.isHidden = true
        viewTableData.isHidden = true
        
//        viewSearchView.layer.shadowOffset = CGSize(width: 2.0, height: 1.6)
//        viewSearchView.layer.shadowRadius = 4
//        viewSearchView.layer.shadowColor = UIColor.lightGray.cgColor
//        viewSearchView.layer.shadowOpacity = 10
        
        viewSearchView.layer.cornerRadius = 8
        viewSearchView.clipsToBounds = true
        
        tblView.allowsSelection = true
        tblView.allowsMultipleSelectionDuringEditing = true
        navigationItem.rightBarButtonItem = editButtonItem
        
        milesDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.btnSave.isUserInteractionEnabled = true
            self.btnSave.isEnabled = true
            self.btnSetMiles.setTitle(self.milesDropDown.selectedItem, for: .normal)
            switch index {
            case 0:
                self.filterMiles = "10"
                break
            case 1:
                self.filterMiles = "20"
                break
            case 2:
                self.filterMiles = "30"
                break
            case 3:
                self.filterMiles = "40"
                break
            case 4:
                self.filterMiles = "50"
                break
            case 5:
                self.filterMiles = "all"
                break
            default:
                self.filterMiles = "all"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "sidemenuHomePresent"), object: nil)
        if UserModel.sharedInstance().appLanguage == "0"{
//            btnrightArrow.setImage(UIImage(named: "right-arrow_arabic"), for: .normal)
            btnrightArrow.setImage(UIImage(named: ""), for: .normal)
            btnLeftArrow.setImage(UIImage(named: "left-arrow_arabic"), for: .normal)
        }else{
            btnrightArrow.setImage(UIImage(named: "right-arrow"), for: .normal)
            btnLeftArrow.setImage(UIImage(named: "left-arrow-2"), for: .normal)
        }
        if UserModel.sharedInstance().userProfileUrl != nil{
            let profileImageUrl = URL(string: "\(UserModel.sharedInstance().userProfileUrl!)")
            self.btnProfileImage.kf.setImage(with: profileImageUrl, for: .normal, placeholder: UIImage(named: "user-profile"), completionHandler: nil)
        }
        checkLocationPermission()
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusbarView = UIView(frame: app.statusBarFrame)
            statusbarView.backgroundColor = UIColor.black
            app.statusBarUIView?.addSubview(statusbarView)
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor.black
        }
    }
    
    //MARK:- OTHER METHODS
    func goToDJProfile(userID : String){
        let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
        let desireViewController = homeSB.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
        desireViewController.viewerId = userID
        desireViewController.isFromMenu = false
        navigationController?.pushViewController(desireViewController, animated: true)
    }
    
    @IBAction func backBtntapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    func goToArtistProfile(userID : String){
        let homeSB = UIStoryboard(name: "ArtistProfile", bundle: nil)
        let desireViewController = homeSB.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as! ArtistViewProfileVC
        desireViewController.viewerId = viewerId
        desireViewController.isFromMenu = false
        navigationController?.pushViewController(desireViewController, animated: true)
    }
    
    func calendarview () {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: self.view .frame .width, height: 180))
        calendar.dataSource = self
        calendar.delegate = self
        //vwCalendar.backgroundColor = .black
        vwCalendar.addSubview(calendar)
        self.calendar = calendar
        self.calendar.scope = .week
        self.calendar.appearance.weekdayTextColor = UIColor .themeBlack
        self.calendar.appearance.headerTitleColor = UIColor .themeBlack
        self.calendar.appearance.titleDefaultColor = UIColor .themeBlack
        self.calendar.appearance.titleTodayColor = UIColor .systemRed
        self.calendar.appearance.todayColor = UIColor .themeWhite
        self.calendar.appearance.titleSelectionColor = UIColor.themeBlack
        self.calendar.appearance.selectionColor = UIColor.themeWhite
        
//        self.calendar.appearance.weekdayTextColor = UIColor .white
//        self.calendar.appearance.headerTitleColor = UIColor .white
//        self.calendar.appearance.titleDefaultColor = UIColor .white
//        self.calendar.appearance.titleTodayColor = UIColor .systemRed
//        self.calendar.appearance.todayColor = UIColor .themeWhite
//        self.calendar.appearance.titleSelectionColor = UIColor.white
//        self.calendar.appearance.selectionColor = UIColor.themeWhite
        
        self.calendar.appearance.headerMinimumDissolvedAlpha = -1
        
        let c = Calendar.current.firstWeekday
        switch c {
        case 1:
            self.calendar.firstWeekday = 1
            break
        case 2:
            self.calendar.firstWeekday = 2
            break
        case 3:
            self.calendar.firstWeekday = 3
            break
        case 4:
            self.calendar.firstWeekday = 4
            break
        case 5:
            self.calendar.firstWeekday = 5
            break
        case 6:
            self.calendar.firstWeekday = 6
            break
        case 7:
            self.calendar.firstWeekday = 7
            break
        default:
            self.calendar.firstWeekday = 7
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    func centerMapOnLocation(locations: String) {
    }
    
    func ChangeRootUsingFlip(userID : String) {
        goToDJProfile(userID: userID)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createAnnotations(locations: [[String: Any]]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.addAnnotation(annotation)
            
        }
    }
    
    func ChangeRoot() {
        if globalObjects.shared.searchResultUserType == "DJ"{
            goToDJProfile(userID: viewerId)
            
        }else{
            goToArtistProfile(userID: viewerId)
        }
    }
    
    func ChangeRoottoHome() {
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
    
    func callPopup() {
        let popOverVC = UIStoryboard(name: "ArtistHome", bundle: nil).instantiateViewController(withIdentifier: "IncProfileVC") as! IncProfileVC
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    func addFilterView(const: NSLayoutConstraint){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, animations: {
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
                const.constant = 0
            }
        }, completion: nil)
    }
    
    func generateDates(startDate :Date?, addbyUnit:Calendar.Component, value : Int) -> Date {
        var dates = [Date]()
        var date = startDate!
        let endDate = Calendar.current.date(byAdding: addbyUnit, value: value, to: date)!
        while date < endDate {
            date = Calendar.current.date(byAdding: addbyUnit, value: 1, to: date)!
            dates.append(date)
        }
        return endDate
    }
    func ArtistPopUpShowHide(){
        if UserModel.sharedInstance().userType == "AR"{
            if !Identity.isArtistIntroSeen() {
                let controller:ComplateProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "ComplateProfileVC") as! ComplateProfileVC
                controller.view.frame = (self.view.bounds)
                self.view.addSubview(controller.view)
                self.addChild(controller)
                controller.didMove(toParent: self)
            }else{
                let controller:ComplateProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "ComplateProfileVC") as! ComplateProfileVC
                
                controller.willMove(toParent: nil)
                controller.view.removeFromSuperview()
                controller.removeFromParent()
            }
        }
    }
    
    func ArtistPopUpShowHide(_ value : Bool)  {
        if value {
            let controller:ComplateProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "ComplateProfileVC") as! ComplateProfileVC
            controller.view.frame = (self.view.bounds)
            self.view.addSubview(controller.view)
            self.addChild(controller)
            controller.didMove(toParent: self)
        }else{
            let controller:ComplateProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "ComplateProfileVC") as! ComplateProfileVC
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
    }
    
    func localizeElements(){
        lblWelcomeToDJ.text = "Welcome to DJ Connect".localize
        txt_search.placeholder = "Where would you like to connect?".localize
        btnfilter.setTitle("Filter?".localize, for: .normal)
        lblMiles.text = "Miles".localize
        //filter view
        lblFilterResults.text = "Filter Results".localize
        btnReset.setTitle("RESET".localize, for: .normal)
        btnSave.setTitle("SAVE".localize, for: .normal)
        lblSongGenre.text = "filter Song Genre(s)".localize
        lblClickToEnter.text = "click to enter".localize
        lblClicktoEnter2.text = "click to enter".localize
        lblProjectType.text = "Project Types(s)".localize
        lblMinimumAttendance.text = "Minimum Attendance".localize
        lblConnectLimit.text = "Connect limit".localize
    }
    
    func startTimer() {
        if globalObjects.shared.mapTimer == true {
            for i in 0..<arprojectList.count{
                let releaseDateString = "\(RemainingTimeArray[i])"
                let releaseDateFormatter = DateFormatter()
                releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                releaseDate.append(releaseDateFormatter.date(from: releaseDateString)! as NSDate)
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            }
        }
    }
    
    func checkLocationPermission(){
        
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                let alert = UIAlertController(title: "Allow Location Access", message: "DJConnect needs access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertController.Style.alert)
               
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)")
                        })
                    }
                }))
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                if UserModel.sharedInstance().currentLatitude != nil{
                    region = (center: CLLocationCoordinate2D(latitude: UserModel.sharedInstance().currentLatitude!, longitude: UserModel.sharedInstance().currentLongitude!), delta: 0.1)
                    manager.add(MeAnnotation(coordinate: region.center))
                    mapView.region = .init(center: region.center, span: .init(latitudeDelta: region.delta, longitudeDelta: region.delta))
                
                    if UserModel.sharedInstance().userId == nil || UserModel.sharedInstance().userId == ""{
                        return
                    }
                    
                    if UserModel.sharedInstance().userType != "DJ"{
                        callArtistPinWebService()
                    }
                    
                    GetGenreList()
                    callAlertApi()
                    callTimeZoneApi()
                    callProjectTypeWebService()
                    CallGetCreditsWebService()
                }else{
                    locationManager.delegate = self
                    self.locationManager.requestAlwaysAuthorization()
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                }
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
        
                                        
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//            case .notDetermined, .restricted, .denied:
//                self.showAlertView("Need to allow location for app access.", "Allow Navigation", "Allow", completionHandler: { (ACTION) in
//                    if let url = URL(string: UIApplication.openSettingsURLString) {
//                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//                    }
//                })
//
//            case .authorizedAlways, .authorizedWhenInUse:
//                if UserModel.sharedInstance().currentLatitude != nil{
//                    region = (center: CLLocationCoordinate2D(latitude: UserModel.sharedInstance().currentLatitude!, longitude: UserModel.sharedInstance().currentLongitude!), delta: 0.1)
//                    manager.add(MeAnnotation(coordinate: region.center))
//                    mapView.region = .init(center: region.center, span: .init(latitudeDelta: region.delta, longitudeDelta: region.delta))
//
//                    //ashitesh - for getting or showing data near delhi
////                if UserModel.sharedInstance().currentLatitude != nil{
////                    region = (center: CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025), delta: 5)
////                    manager.add(MeAnnotation(coordinate: region.center))
////                    mapView.region = .init(center: region.center, span: .init(latitudeDelta: region.delta, longitudeDelta: region.delta))
////
//                    if UserModel.sharedInstance().userId == nil || UserModel.sharedInstance().userId == ""{
//                        return
//                    }
//
//                    if UserModel.sharedInstance().userType != "DJ"{
//                        // ashitesh - hide for now - given by client - as it is ot updated for now
//                       // callGetArtistTutorialWebService()
//                        // ashitesh - hide part end for now - given by client - as it is ot updated for now
//
//                        callArtistPinWebService()
//                    }
//
//                    GetGenreList()
//                    callAlertApi()
//                    callTimeZoneApi()
//                    callProjectTypeWebService()
//                    CallGetCreditsWebService()
//                }else{
//                    locationManager.delegate = self
//                    self.locationManager.requestAlwaysAuthorization()
//                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//                    locationManager.startUpdatingLocation()
//                }
//            }
//        } else {
//            self.showAlertView("Need to allow location for app access.", "Allow Navigation", "Allow", completionHandler: { (ACTION) in
//                if let url = URL(string: UIApplication.openSettingsURLString) {
//                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//                }
//            })
//        }
    }
    
    func resize(_ image: UIImage?) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 60, height: 60)
        UIGraphicsBeginImageContext(rect.size)
        image!.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality: CGFloat(0.2))
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData!)
    }
    //MARK: - ACTIONS
    @IBAction func btnSlideInAction(_ sender: UIButton) {
        viewSearchView.isHidden = false
        btnSlideIn.isHidden = true
    }
    
    @IBAction func btnSlideOutAction(_ sender: UIButton) {
        viewSearchView.isHidden = true
        btnSlideIn.isHidden = false
    }
    
    @IBAction func btnMainMenuAction(_ sender: UIButton) {
        globalObjects.shared.mapTimer = false
        self.tblView.isHidden = true
        self.viewTableData.isHidden = true
        txt_search.text = ""
        txt_search.resignFirstResponder()
        toggleSideMenuView()
    }
    
    @IBAction func btnProfile_Act(_ sender: UIButton) {
        txt_search.text = ""
        txt_search.resignFirstResponder()
        //UserModel.sharedInstance().isPin = false
        UserModel.sharedInstance().synchroniseData()
        if UserModel.sharedInstance().userType == "DJ"{
            goToDJProfile(userID: "")
        }else{
            goToArtistProfile(userID: "")
        }
    }
    
    @IBAction func btnSearchAction(_ sender: UIButton) {
        
        
    }
    
    @IBAction func tableCellSwipeAction(_ sender: Any) {
    }
    
    @IBAction func btnCloseSearchResult(_ sender: UIButton) {
        globalObjects.shared.mapTimer = false
        RemainingTimeArray.removeAll()
        self.tblView.isHidden = true
        self.viewTableData.isHidden = true
        
//        manager.add(MeAnnotation(coordinate: region.center))
//        if UserModel.sharedInstance().userType == "AR"{
//            callFilterArtistPinWebService()
//        }
    }
    
    @IBAction func btnFilter_Action(_ sender: UIButton) {
        if UserModel.sharedInstance().appLanguage == "1"{
            self.viewhover.isHidden = false
            self.viewFilterView.frame = CGRect(x: 0 - self.view.frame.height, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(viewFilterView)
            UIView.transition(with: viewFilterView,
                              duration: 0.6,
                              options: .curveLinear,
                              animations: { self.viewFilterView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 50, height: self.view.frame.size.height)},
                              completion:{finished in
                              })
            
        }else{
            self.viewhover.isHidden = false
            self.viewFilterView.frame = CGRect(x: self.view.frame.width + 1, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(viewFilterView)
            UIView.transition(with: viewFilterView,
                              duration: 0.6,
                              options: .curveLinear,
                              animations: { self.viewFilterView.frame = CGRect(x: 50, y: 0, width: self.view.frame.size.width - 50, height: self.view.frame.size.height)},
                              completion:{finished in
                              })
            
        }
    }
    @IBAction func btnFilterClose_Action(_ sender: UIButton) {
        if UserModel.sharedInstance().appLanguage == "1"{
            UIView.transition(with: viewFilterView,
                              duration: 0.6,
                              options: .curveLinear,
                              animations: { self.viewFilterView.frame = CGRect(x: 0 - self.view.frame.height, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)},
                              completion:{finished in
                                self.viewhover.isHidden = true
                              })
        }else{
            UIView.transition(with: viewFilterView,
                              duration: 0.6,
                              options: .curveLinear,
                              animations: { self.viewFilterView.frame = CGRect(x: self.view.frame.width + 1, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)},
                              completion:{finished in
                                self.viewhover.isHidden = true
                              })
        }
    }
    @IBAction func btnFilterSave_Action(_ sender: UIButton) {
       // btnFilterSave.isEnabled = false
        btnFilterReset.isEnabled = false
        if UserModel.sharedInstance().userType == "AR"{
            callFilterArtistPinWebService()
        }
    }
    
    @IBAction func btnFilterBgCloseAction(_ sender: UIButton) {
        if UserModel.sharedInstance().appLanguage == "1"{
            UIView.transition(with: viewFilterView,
                              duration: 0.6,
                              options: .curveLinear,
                              animations: { self.viewFilterView.frame = CGRect(x: 0 - self.view.frame.height, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)},
                              completion:{finished in
                                self.viewhover.isHidden = true
                              })
        }else{
            UIView.transition(with: viewFilterView,
                              duration: 0.6,
                              options: .curveLinear,
                              animations: { self.viewFilterView.frame = CGRect(x: self.view.frame.width + 1, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)},
                              completion:{finished in
                                self.viewhover.isHidden = true
                              })
        }
    }
    
    @IBAction func btnFilterResetAction(_ sender: UIButton) {
        lblClickToEnter.text = "click to enter"
        lblClicktoEnter2.text = "click to enter"
        filterAttendance = ""
        filterPrice = ""
//        self.btnSetMiles.setTitle("10 miles", for: .normal) //ashitesh
        self.btnSetMiles.setTitle("all", for: .normal)
        for i in 0..<arrgenrelist.count{
            let indexPath1 = IndexPath(row: i, section: 0)
            let cell = tblSongGenre.cellForRow(at: indexPath1) as! FilterSongGenreTableViewCell
            cell.imgSongeGenre.image = UIImage(named: "ArtistFilter3")
        }
        for i in 0..<projectTypeList.count{
            let indexPath1 = IndexPath(row: i, section: 0)
            let cell = tblProjectType.cellForRow(at: indexPath1) as! FilterProjectTypesTableViewCell
            cell.imgProjectType.image = UIImage(named: "ArtistFilter3")
        }
    }
    
    @IBAction func btnSetMilesAction(_ sender: buttonProperties) {
        milesDropDown.anchorView = btnSetMiles
        milesDropDown.dataSource = ["10 Miles".localize,"20 Miles".localize,"30 Miles".localize,"40 miles".localize,"50 Miles".localize,"All"]
        milesDropDown.show()
        milesDropDown.width = btnSetMiles.frame.width
        milesDropDown.direction = .bottom
        milesDropDown.bottomOffset = CGPoint(x: 0, y:(milesDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    @IBAction func btnViewAllDatesAction(_ sender: UIButton) {
        lblSubCalendarMonth.isHidden = true
        vwSubCalendar.isHidden = true
        vwCalendar.isHidden = false
        btnViewAllDates.isHidden = true
        arSelectedDate = ""
        callArtistPinWebService()
    }
    
    //MARK:- SELECTOR METHODS
    @objc func locationCheck(){
        checkLocationPermission()
    }
    
    @objc func tapMinimumAttendanceFunction(sender:UITapGestureRecognizer) {
        pickerMinimumAttendance.isHidden = false
        minimumAttendancePickerHeight.constant = 120
        btnFilterSave.isEnabled = true
        btnFilterReset.isEnabled = true
    }
    
    @objc func tapConnectLimitFunction(sender:UITapGestureRecognizer) {
        pickerConnectLimit.isHidden = false
        connectLimitPickerHeight.constant = 120
        btnFilterSave.isEnabled = true
        btnFilterReset.isEnabled = true
    }
    
    @objc func updateTime() {
        if globalObjects.shared.mapTimer == true{
            let currentDate = Date()
            let calendar = Calendar.current
            for i in 0..<arprojectList.count{
                let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate[i]! as Date)
                let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
                tblView?.visibleCells.forEach { cell in
                    let indexPath1 = IndexPath.init(row: i, section: 0)
                    if let cell = tblView.cellForRow(at: indexPath1) as? connectionDetails{
                        if arprojectList[i].project_status == "in_progress"{
                            cell.lblTime.text = "IN PROGRESS"
                            cell.lblTime.textColor = .green
                        }else{
                            if diffDateComponents.second ?? 0 < 0 && diffDateComponents.minute ?? 0 < 0{
                                cell.lblTime.text = "0 DAY 0 HR 0 MIN 0 SEC"
                                cell.lblTime.textColor = .red
                            }else{
                                cell.lblTime.text = countdown
                                cell.lblTime.textColor = .red
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func setLocation(_ notification: Notification){
        if UserModel.sharedInstance().userType != "DJ"{
            callArtistPinWebService()
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
    }
    
    //MARK:- WEBSERVICES
    func callSearchListWebService(text: String){
        if getReachabilityStatus(){
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "usertype":"\(UserModel.sharedInstance().userType!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "search_word":"\(text)"
            ]
            Loader.shared.show()
            print("param:", parameters)
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.searchUserAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SearchListModel>) in
            
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let searchList = response.result.value!
                    if searchList.success == 1{
                        print("searchList.searchData:", searchList.searchData)
                        self.arrSearchResult = searchList.searchData!
                        self.tblsearch.isHidden = false
                        self.tblsearch.reloadData()
                        if self.tblsearch.contentSize.height > 200{
                            self.tblSearchHeight.constant = 200
                        }else{
                            self.tblSearchHeight.constant = self.tblsearch.contentSize.height
                        }
                    }else{
                        Loader.shared.hide()
                        self.tblsearch.isHidden = true
                        self.arrSearchResult.removeAll()
                        if searchList.success == 0{
                            if(searchList.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                if(searchList.message == "something is wrong. Please try again!"){
                                    self.view.makeToast("No Users found by this name.")
                                }
//                                self.view.makeToast(searchList.message) // "something is wrong. Please try again!"
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
    
    func callArtistPinWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            let radiStr = "all"
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getArtistGraphPinAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)&latitude=\(UserModel.sharedInstance().currentLatitude!)&longitude=\(UserModel.sharedInstance().currentLongitude!)&usertype=\(UserModel.sharedInstance().userType!)&c_date=\(arSelectedDate)&radius=\(radiStr)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ArtistGraphPinModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let pinList = response.result.value!
                    if pinList.success == 1{
                        self.arrArtistGraphPin.removeAll()
                        
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let currDate = formatter.string(from: date)
                        if self.arSelectedDate.isEmpty == true{
                            for i in 0..<pinList.graphPinData!.count{
                                if currDate <= pinList.graphPinData![i].remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"){
                                    //self.arrArtistGraphPin.append(pinList.graphPinData![i])
                                }
                                
                                self.arrArtistGraphPin = pinList.graphPinData!
                            }
                            
                        }else{
                            for i in 0..<pinList.graphPinData!.count{
                                if self.arSelectedDate == pinList.graphPinData![i].remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"){
                                    //self.arrArtistGraphPin.append(pinList.graphPinData![i])
                                }
                                self.arrArtistGraphPin = pinList.graphPinData!
                            }
                        }
                        print("befor_arrArtistGraphPin.Count",self.arrArtistGraphPin.count)
                        self.manager.removeAll()
                        self.manager.reload(mapView: self.mapView)
                        for i in 0..<self.arrArtistGraphPin.count{
                            self.trial.append("\(self.arrArtistGraphPin[i].is_dj_verify ?? 0)")
                        }
                        for i in 0..<self.arrArtistGraphPin.count{
//                            if self.arrArtistGraphPin[i].is_dj_verify ?? 0 == 1{
//                                self.verifiedLat.append(self.arrArtistGraphPin[i].latitude!)
//                            }
                            if self.arrArtistGraphPin[i].music_type ?? 0 == 2{
                                self.verifiedLat.append(self.arrArtistGraphPin[i].latitude!)
                            }
                        }
                        let annotations: [Annotation] = (0..<self.arrArtistGraphPin.count).map { i in
                            let x = Double(self.arrArtistGraphPin[i].latitude!)
                            let y = Double(self.arrArtistGraphPin[i].longitude!)
                            let annotation = Annotation()
                            annotation.locationData = ["lat":self.arrArtistGraphPin[i].latitude!, "lon":self.arrArtistGraphPin[i].longitude!]
                            annotation.coordinate = CLLocationCoordinate2D(latitude:x! , longitude: y!)
                            return annotation
                        }
                        self.region = (center: CLLocationCoordinate2D(latitude: UserModel.sharedInstance().currentLatitude!, longitude: UserModel.sharedInstance().currentLongitude!), delta: 40)
                        self.manager.add(MeAnnotation(coordinate: self.region.center))
                        self.mapView.region = .init(center: self.region.center, span: .init(latitudeDelta: self.region.delta, longitudeDelta: self.region.delta))
                        self.manager.add(annotations)
                        self.manager.reload(mapView: self.mapView)
                    }
                    else{
                        Loader.shared.hide()
                       // self.view.makeToast(pinList.message)
                        if pinList.success == 0{
                            if(pinList.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(pinList.message)
                            }
                        }
//                        self.view.makeToast("You are not authorised. Please login again.")
//                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
//                            })
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
    
    func callFilterArtistPinWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            if filterAttendance == "click to enter" || filterAttendance == "no minimum"{
                filterAttendance = ""
            }
            if filterPrice == "click to enter" || filterPrice == "no limit"{
                filterPrice = ""
            }
            projTypeArrayCleaned = filterProjType.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
            genreArrayCleaned = filtergenreIndex.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getArtistGraphPinAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)&latitude=\(UserModel.sharedInstance().currentLatitude ?? 0.0)&longitude=\(UserModel.sharedInstance().currentLongitude ?? 0.0)&usertype=\(UserModel.sharedInstance().userType!)&radius=\(filterMiles)&genre=\(genreArrayCleaned)&attendance=\(filterAttendance)&project_type=\(projTypeArrayCleaned)&price=\(filterPrice)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ArtistGraphPinModel>) in
                
                print(self.filtergenreIndex)
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let pinList = response.result.value!
                    if pinList.success == 1{
                       // self.view.makeToast(pinList.message) // hide msg -- Graph pins found
                        self.arrArtistGraphPin = pinList.graphPinData!
                        print("after_arrArtistGraphPin.Count",self.arrArtistGraphPin.count)
                        self.manager.removeAll()
                        self.manager.reload(mapView: self.mapView)
                        let annotations: [Annotation] = (0..<pinList.graphPinData!.count).map { i in
                            let x = Double(pinList.graphPinData![i].latitude!)
                            let y = Double(pinList.graphPinData![i].longitude!)
                            let annotation = Annotation()
                            annotation.locationData = ["lat":pinList.graphPinData![i].latitude!, "lon":pinList.graphPinData![i].longitude!]
                            annotation.coordinate = CLLocationCoordinate2D(latitude:x! , longitude: y!)
                            return annotation
                        }
                        self.manager.add(annotations)
                        self.manager.reload(mapView: self.mapView)
                        
                    }
                    else{
                        Loader.shared.hide()
                        self.manager.removeAll()
                        self.manager.reload(mapView: self.mapView)
                        
                        self.view.makeToast(pinList.message)
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
    
    func GetGenreList() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.getGenreAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)"
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL(requestUrl), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GenreModel>) in
                
                switch response.result {
                case .success(_):
                    let GenreModel = response.result.value!
                    if GenreModel.success == 1{
                        Loader.shared.hide()
                        self.arrgenrelist = GenreModel.genreList!
                        self.tblSongGenre.reloadData()
                        self.songGenreTableHeight.constant = self.tblSongGenre.contentSize.height - 30
                    }else{
                        Loader.shared.hide()
                       // self.view.makeToast(GenreModel.message)
                        if GenreModel.success == 0{
                            if(GenreModel.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(GenreModel.message)
                            }
                        }
//                        self.view.makeToast("You are not authorised. Please login again.")
//                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
//                            })
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
    
    func callProjectTypeWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectTypeAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProjectTypeList>) in
                
                switch response.result {
                case .success(_):
                    let projectTypeProfile = response.result.value!
                    if projectTypeProfile.success == 1{
                        Loader.shared.hide()
                        self.projectTypeList = projectTypeProfile.projectTypeData!
                        self.tblProjectType.reloadData()
                        self.projectTypeTableHeight.constant = self.tblProjectType.contentSize.height - 60
                    }else{
                        //self.view.makeToast(projectTypeProfile.message)
                        Loader.shared.hide()
                        if(projectTypeProfile.message == "You are not authorised. Please login again."){
                            self.view.makeToast(projectTypeProfile.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                            })
                        }
                        else{
                            self.view.makeToast(projectTypeProfile.message)
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
    
    
    func callGetArtistTutorialWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getTutorialAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                
                if let json = response.result.value as? [String:Any] {
                    if json["success"]! as! NSNumber == 1{
                        if json["setting"] as! String == "0"{
                            self.ArtistPopUpShowHide(false)
                        }else{
                            self.ArtistPopUpShowHide(true)
                        }
                    }else{
                        self.ArtistPopUpShowHide(true)
                    }
                }
                print(response)
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func CallGetCreditsWebService(){
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
                }
            }
            )}else{
                self.view.makeToast("Please check your Internet Connection")
            }
    }
    
    func callCurrencyListWebService(){
        self.currentCurrency = UserModel.sharedInstance().userCurrency!
        print("self.currentCurrency", self.currentCurrency)
    }
    
    func callAlertApi(){
        let notiCount = UserModel.sharedInstance().notificationCount
        if notiCount != nil {
            if notiCount! > 0 {
                self.lblMenuNotifyNumber.isHidden = false
                self.lblMenuNotifyNumber.text = "\(notiCount!)"
            }
        }
    }
    
    func callTimeZoneApi(){
        if getReachabilityStatus(){
            let seconds = TimeZone.current.secondsFromGMT()
            let hours = seconds/3600
            let minutes = abs(seconds/60) % 60
            let utcTZ = String(format: "%+.2d:%.2d", hours, minutes)
            
            var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "user_timezone":"\(localTimeZoneIdentifier)",
                "user_timezone_UTC":"\(utcTZ)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addTimezoneAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let timeZoneModelProfile = response.result.value!
                    if timeZoneModelProfile.success != 1{
                        self.view.makeToast(timeZoneModelProfile.message)
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
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueWelcomeBuy"{
            let vc = segue.destination as! BuyConnectVC
            vc.userDetailDict["projectId"] = "\(arprojectList[(sender as? Int)!].project_id!)"
            
            let indexPath = IndexPath(row: indexPathRow, section: 0)
            let cell = tblView.cellForRow(at: indexPath) as! connectionDetails
            
            vc.userDetailDict["projectName"] = cell.lblProjName.text!
            vc.userDetailDict["projectBy"] = cell.lblDjName.text!
            vc.userDetailDict["ProjectCost"] = "COST : \(cell.lblAmount.text!)"
            vc.userDetailDict["EventDayandDate"] = weekDay + EventDate[indexPathRow]
            vc.userDetailDict["eventTime"] = buyEventTime[indexPathRow].UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
            vc.userDetailDict["imgUrl"] = arprojectList[indexPathRow].project_image!
            vc.userDetailDict["isBuyOn"] = "\(arprojectList[indexPath.row].is_buy_project!)"
            vc.userDetailDict["projUserId"] = "\(arprojectList[indexPath.row].dj_id!)"
            vc.userDetailDict["is_complete"] = "\(arprojectList[indexPath.row].is_completed!)"
            vc.userDetailDict["TrialCurrency"] = self.currentCurrency
        }
        if segue.identifier == "segueWelcomeDateclick" {
            let destinationVC = segue.destination as! DJSelectProjectTypeVC
            destinationVC.dateSelected = postDate
            destinationVC.postDate = date
        }
    }
    
    
    func GetBuyProjectDataWebService(id: String, musicTypeId : String){
        
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getStepsProjectAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(id)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetBuyProjStepsModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStepModel = response.result.value!
                    if buyStepModel.success == 0{
                        if(buyStepModel.message == "You had cancelled verification for this project." || buyStepModel.message ==  ".لقد ألغيت التحقق لهذا المشروع" ){
                            self.view.makeToast(buyStepModel.message)
                        }
                        if(buyStepModel.message == "You are not authorised. Please login again."){
                                                    self.view.makeToast("You are not authorised. Please login again.")
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                            self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                        })
                        }else{
                            self.view.makeToast(buyStepModel.message)
                        }
                        
                    }
                    else if(buyStepModel.success == 1){
//                        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
//                        self.vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
//                        self.vc2.delegate = self
//                        self.vc2.projectId = self.projectId
//                        //if tableView.tag == 0{
//                        self.vc2.isProjOld = self.isProjOldSt
//                        self.vc2.isInProgress = self.isInProgressSt
//                        //}
//                        self.vc2.djImageUrl = self.djImageUrl
//                        let transition = CATransition()
//                        transition.duration = 0.5
//                        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//                        transition.type = CATransitionType.moveIn
//                        transition.subtype = CATransitionSubtype.fromTop
//                        self.navigationController?.view.layer.add(transition, forKey: nil)
//                        self.navigationController?.pushViewController(self.vc2, animated: false)
                        
                                    let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
                                    self.vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
                                    self.vc2.delegate = self
                                    self.vc2.projectId = self.projectId
                                    self.vc2.musicTypeId = musicTypeId
                                    let transition = CATransition()
                                    transition.duration = 0.5
                                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                                    transition.type = CATransitionType.moveIn
                                    transition.subtype = CATransitionSubtype.fromTop
                                    self.navigationController?.view.layer.add(transition, forKey: nil)
                                    self.navigationController?.pushViewController(self.vc2, animated: false)
                                    self.tblView.isHidden = true
                                    self.viewTableData.isHidden = true
                    }
                    else{
                        Loader.shared.hide()

                            if(buyStepModel.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(buyStepModel.message)
                            }
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


//MARK:- EXTENSIONS
extension WelcomeScreenVC :  UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            self.projectId = "\(self.arprojectList[indexPath.row].project_id!)"
//            let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
//            self.vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
//            self.vc2.delegate = self
//            self.vc2.projectId = self.projectId
//            let transition = CATransition()
//            transition.duration = 0.5
//            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//            transition.type = CATransitionType.moveIn
//            transition.subtype = CATransitionSubtype.fromTop
//            self.navigationController?.view.layer.add(transition, forKey: nil)
//            self.navigationController?.pushViewController(self.vc2, animated: false)
//            self.tblView.isHidden = true
//            self.viewTableData.isHidden = true
            
            self.GetBuyProjectDataWebService(id: self.projectId, musicTypeId: "\(self.arprojectList[indexPath.row].music_type ?? 0)")
        }
        if tableView.tag == 2 {
            print("arrSearchResult :", arrSearchResult)
            if(arrSearchResult.count > 0){
                viewerId = "\(arrSearchResult[indexPath.row].userid!)"
                UserModel.sharedInstance().isPin = true
                UserModel.sharedInstance().synchroniseData()
                globalObjects.shared.searchResultUserType = arrSearchResult[indexPath.row].user_type!
                ChangeRoot()
            }
            else{
                
            }
//            viewerId = "\(arrSearchResult[indexPath.row].userid!)"
//            UserModel.sharedInstance().isPin = true
//            UserModel.sharedInstance().synchroniseData()
//            globalObjects.shared.searchResultUserType = arrSearchResult[indexPath.row].user_type!
//            ChangeRoot()
        }else if (tableView.tag == 3){
            let cell = tableView.cellForRow(at: indexPath) as! FilterSongGenreTableViewCell
            cell.selectionStyle = .none
            
            if (cell.imgSongeGenre.image == UIImage(named: "ArtistFilter4")){
                cell.imgSongeGenre.image = UIImage(named: "ArtistFilter3")
                cell.lblSongGenre.textColor = .white
                filtergenreIndex = filtergenreIndex.filter{ $0 != "\(arrgenrelist[indexPath.row].id!)" }
                tableView.deselectRow(at: indexPath, animated: true)
            }else{
                filtergenreIndex.append("\(self.arrgenrelist[indexPath.row].id!)")
                cell.imgSongeGenre.image = UIImage(named: "ArtistFilter4")
                cell.lblSongGenre.textColor = .white
                tableView.deselectRow(at: indexPath, animated: true)
            }
            
            btnFilterSave.isEnabled = true
            btnFilterReset.isEnabled = true
        }else if tableView.tag == 4{
            let cell = tableView.cellForRow(at: indexPath) as! FilterProjectTypesTableViewCell
            cell.selectionStyle = .none
            
            if (cell.imgProjectType.image == UIImage(named: "ArtistFilter4")){
                cell.imgProjectType.image = UIImage(named: "ArtistFilter3")
                cell.lblProjectType.textColor = .white
                filterProjType = filterProjType.filter{ $0 != "\(projectTypeList[indexPath.row].project_type_id!)" }
                
                print("projectTypeList",projectTypeList)
                tableView.deselectRow(at: indexPath, animated: true)
            }else{
                var proj_type = self.projectTypeList[indexPath.row].project_type_id as? String ?? ""
                if proj_type == ""{
                    proj_type = "\(self.projectTypeList[indexPath.row].project_type_id!)"
                }
                
                filterProjType.append(proj_type)
                cell.imgProjectType.image = UIImage(named: "ArtistFilter4")
                cell.lblProjectType.textColor = .white
                tableView.deselectRow(at: indexPath, animated: true)
            }
            
            btnFilterSave.isEnabled = true
            btnFilterReset.isEnabled = true
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 {
            return 165
        }else if (tableView.tag == 3 || tableView.tag == 4){
            return 35
        }else if tableView.tag == 5{
            return 90
        }else{
            return 43
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            return arprojectList.count
        }else if tableView.tag == 3{
            return arrgenrelist.count
        }else if tableView.tag == 4{
            return projectTypeList.count
        }else{
            return arrSearchResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! connectionDetails
            cell.delegate = self
            
            cell.cellBgVw.layer.cornerRadius = 15
            cell.cellBgVw.clipsToBounds = true
            cell.cellBgVw.backgroundColor = UIColor(red: 83/255, green: 109/255, blue: 142/255, alpha: 1.0).withAlphaComponent(0.5)
            cell.shareBtnBgVw.layer.cornerRadius = 5
            cell.shareBtnBgVw.clipsToBounds = true
            let startString = arprojectList[indexPath.row].event_start_time!
            let startDate12 = startString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
            
            let endString = arprojectList[indexPath.row].event_end_time!
            let endDate12 = endString.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
            
            let projectImageUrl = URL(string: "\(arprojectList[indexPath.row].project_image!)")
            cell.imgProfileImage.kf.setImage(with: projectImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            
            cell.lblProjName.text = arprojectList[indexPath.row].project_title!
            
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
//            formatter.string(from: Int(arprojectList[indexPath.row].project_cost!)! as NSNumber)
//            let string2 = formatter.string(from: Int(arprojectList[indexPath.row].project_cost!)! as NSNumber)
//
//            cell.lblAmount.text = self.currentCurrency + " " + string2!
            cell.lblAmount.text = self.currentCurrency + "\(arprojectList[indexPath.row].project_cost!)"
            
            cell.lblDjName.text = "By " + arprojectList[indexPath.row].project_by!

//            cell.lblDate.text = arprojectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "MMM d, yyyy")
            if(arprojectList[indexPath.row].event_date != ""){ // 2022-01-07
            let dateString = arprojectList[indexPath.row].event_date
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter1.date(from: dateString ?? "")
            dateFormatter1.dateFormat = "MMM d, yyyy"
            let date2 = dateFormatter1.string(from: date!)
            
            cell.lblDate.text = date2
            }
            
            cell.lblGenre.text = "Genre(s): \(arprojectList[indexPath.row].project_genre!)"
            
//            var fullName: String = "\(arprojectList[indexPath.row].project_genre!)"
//            let fullNameArr = fullName.componentsSeparatedByString(",")
//
//            var firstName: String = fullNameArr[0]
//            var lastName: String = fullNameArr[1]
            
//            for i in 0 ..< arprojectList.count {
//                let gen = arprojectList[i].project_genre
//                cell.lblGenre.text = "\(gen ?? "")" + " | "
//            }
            
//            formatter.string(from: Int(arprojectList[indexPath.row].expected_audience!)! as NSNumber)
//            let string55 = formatter.string(from: Int(arprojectList[indexPath.row].expected_audience!)! as NSNumber)
//            cell.lblExpectedAudi.text = "Expected Attendance - " + string55!
            
            cell.lblExpectedAudi.text = "Expected Attendance - " + arprojectList[indexPath.row].expected_audience!
            
            //cell.lblStarRate.text = "\(arprojectList[indexPath.row].rate!)"
            cell.lblRateNo.text = "\(arprojectList[indexPath.row].avg_rate!)"
            
            cell.lblTime.text = arprojectList[indexPath.row].remaining_time!.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
            self.buyEventTime.append(startDate12 + " to " + endDate12)
            self.EventDate.append(arprojectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "yyyy-MM-dd"))
            
            return cell
        }else if tableView.tag == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "songGenrecell", for: indexPath) as! FilterSongGenreTableViewCell
            
            cell.lblSongGenre.text = arrgenrelist[indexPath.row].title!
            return cell
        }else if tableView.tag == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectTypecell", for: indexPath) as! FilterProjectTypesTableViewCell
            
            cell.lblProjectType.text = projectTypeList[indexPath.row].project_type!
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath) as! search_cell
            print("arrSearchResult.count",arrSearchResult)
            if(arrSearchResult.count > 0){
            cell.lbl_location.text = arrSearchResult[indexPath.row].name!
           // UserModel.sharedInstance().isPin = false
            }
            else{}
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.maximumButtonWidth = 90
        options.minimumButtonWidth = 90
        options.buttonSpacing = 8
        
        return options
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        indexPathRow = indexPath.row
        
        guard orientation == .right else { return nil }
        
        let profile = SwipeAction(style: .destructive, title: "DJ PAGE") { [self] action, indexPath in
            let x = "\(self.arprojectList[indexPath.row].dj_id!)"
            globalObjects.shared.searchResultUserType = "DJ"
            globalObjects.shared.mapTimer = false
            self.ChangeRootUsingFlip(userID: x)
            self.tblView.isHidden = true
            self.viewTableData.isHidden = true
        }
        
        let profileImageUrl = URL(string: "\(arprojectList[indexPath.row].profile_image!)")
        let profileImg = UIImageView()
        profileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        let selectedBarImage: UIImage = profileImg.image!.squareMyImage().resizeMyImage(newWidth: 60).roundMyImage.withRenderingMode(.alwaysOriginal)
        profile.image = selectedBarImage
        profile.backgroundColor = .lightGray
        profile.font = .boldSystemFont(ofSize: 10)
        
        let project = SwipeAction(style: .destructive, title: "VIEW PROJECT") { [self] action, indexPath in
            globalObjects.shared.mapTimer = false
            
            self.projectId = "\(self.arprojectList[indexPath.row].project_id!)"
            
            let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
            self.vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
            self.vc2.delegate = self
            self.vc2.projectId = self.projectId
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromTop
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(self.vc2, animated: false)
            self.tblView.isHidden = true
            self.viewTableData.isHidden = true
        }
        
        project.backgroundColor = UIColor .lightGray
        project.font = .boldSystemFont(ofSize: 10)
        
        // customize the action appearance
        project.image = UIImage(named: "edit-icopn")
        
        let buy = SwipeAction(style: .destructive, title: "BUY") { [self] action, indexPath in
            globalObjects.shared.mapTimer = false
            let dateString = self.arprojectList[indexPath.row].event_date!.UTCToLocal(incomingFormat: "MM/dd/yyyy", outGoingFormat: "yyyy-MM-dd")
            
            self.isOfferOn = self.arprojectList[indexPath.row].is_buy_offer!
            self.isProjComplete = "\(self.arprojectList[indexPath.row].is_completed!)"
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter1.date(from: dateString)
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
            if self.isOfferOn == 0{
                if self.isProjComplete == "0"{
                    self.performSegue(withIdentifier: "segueWelcomeBuy", sender: indexPath.row)
                }else{
                    self.view.makeToast("The Project is already Completed")
                }
            }else{
                self.view.makeToast("You have already applied for Offer")
            }
            // handle action by updating model with deletion
            self.tblView.isHidden = true
            viewTableData.isHidden = true
        }
        buy.backgroundColor = UIColor .lightGray
        
        // customize the action appearance
        buy.image = UIImage(named: "cart")
        buy.font = .boldSystemFont(ofSize: 10)
        
        return [buy,project,profile]
    }
}

extension WelcomeScreenVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txt_search{
            
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if newString.isEmpty{
                tblsearch.isHidden = true
                self.arrSearchResult.removeAll()
            }
            if textField == txt_search{
                isSearchEnabled = true
                self.arrSearchResult.removeAll()
                self.callSearchListWebService(text: newString)
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        txt_search.text?.removeAll()
        self.tblsearch.isHidden = true
        self.arrSearchResult.removeAll()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == txt_search{
//            if txt_search.text == "Where would you like to connect?".localize{
            if txt_search.text != ""{
                txt_search.text = ""
            }
            
        }
       }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField == txt_search{
            if txt_search.text == ""{
                txt_search.text = "Where would you like to connect?".localize
            }
            
        }
    }
    
}

extension WelcomeScreenVC : DummyViewDelegate {
    func dummyViewBtnCloseClicked() {
        UIView.animate(withDuration: 0.5, animations: {
            self.vc1.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) { (isCompleted) in
            self.vc1.willMove(toParent: nil)
            self.vc1.view.removeFromSuperview()
            self.vc1.removeFromParent()
            self.viewDummyVC .isHidden = true
        }
    }
    
    func dummyViewBtnMenuClicked(){
        toggleSideMenuView()
    }
}

extension WelcomeScreenVC : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return minimumAttendance.count
        }else{
            return connectLimit.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return minimumAttendance[row]
        }else{
            return connectLimit[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            lblMinimumAttendance.text = "Minimum Attendance - I would like at least people attending."
            lblClickToEnter.text = minimumAttendance[row]
            filterAttendance = minimumAttendance[row]
            pickerMinimumAttendance.isHidden = true
            minimumAttendancePickerHeight.constant = 10
        }else{
            lblConnectLimit.text = "Connect limit - The most I would like to pay for a connect is:                                 .                            "
            lblClicktoEnter2.text = connectLimit[row]
            filterPrice = connectLimit[row]
            pickerConnectLimit.isHidden = true
            connectLimitPickerHeight.constant = 10
        }
    }
}
extension WelcomeScreenVC : FSCalendarDataSource, FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let selectdateFormatter = DateFormatter()
        selectdateFormatter.dateFormat = "yyyy-MM-dd"
        self.arSelectedDate = selectdateFormatter.string(from: date)
        
        let dateCurr = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let endDate = generateDates(startDate: dateCurr, addbyUnit: .day, value: 7)
        if date > endDate{
            self.view.makeToast("The maximum you can add a project is 7 days from today. Please select a date within this range.".localize)
        }else{
            let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
            if monthPosition == .next || monthPosition == .previous {
                calendar.setCurrentPage(date, animated: true)
            }
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            postDate = dateFormatter.string(from: calendar.selectedDate!)
            self.date = calendar.selectedDate!
            if UserModel.sharedInstance().userType == "DJ" {
                performSegue(withIdentifier: "segueWelcomeDateclick", sender: nil)
            }else{
                lblSubCalendarDate.text = "\(Calendar.current.dateComponents([.day], from: date).day!)"
                lblSubCalendarMonth.text = getMonthOfYear(monthNo: Calendar.current.component(.month, from: calendar.currentPage)) + ",  \(Calendar.current.component(.year, from: calendar.currentPage))"
                lblSubCalendarMonth.isHidden = false
                lblSubCalendarDay.text = getWeekDay(weekDay: Calendar.current.component(.weekday, from: date))
//                btnViewAllDates.isHidden = false
//                vwSubCalendar.isHidden = false
                btnViewAllDates.isHidden = true
                vwSubCalendar.isHidden = true
                vwCalendar.isHidden = false
                vwCalendar.backgroundColor = .clear
                callArtistPinWebService()
            }
        }
    }
    
    func getWeekDay(weekDay: Int) -> String{
        switch weekDay{
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "Mon"
        }
    }
    
    func getMonthOfYear(monthNo: Int) -> String{
        switch monthNo{
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "January"
        }
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return date
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return true
    }
}


extension WelcomeScreenVC : artistDummyViewDelegate {
    func artistViewBtnCloseClicked() {
        toggleSideMenuView()
    }
    
    func artistViewBtnMenuClicked() {
        UIView.animate(withDuration: 0.5, animations: {
            self.vc2.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) { (isCompleted) in
            self.vc2.willMove(toParent: nil)
            self.vc2.view.removeFromSuperview()
            self.vc2.removeFromParent()
        }
    }
}

extension WelcomeScreenVC {
    enum SelectionCluster: Int {
        case count, imageCount, image
    }
}
extension WelcomeScreenVC: ClusterManagerDelegate {
    func cellSize(for zoomLevel: Double) -> Double? {
        return nil
    }
    
    func shouldClusterAnnotation(_ annotation: MKAnnotation) -> Bool {
        return !(annotation is MeAnnotation)
    }
}

extension WelcomeScreenVC: MKMapViewDelegate,CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.removeAnnotation(newPin)
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        newPin.coordinate = location.coordinate
        DispatchQueue.main.async {
            self.mapView.addAnnotation(self.newPin)
        }
        
        if currentLocation == nil {
            currentLocation = locations.last
            locationManager.stopMonitoringSignificantLocationChanges()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
            // use this when work with device
            UserModel.sharedInstance().currentLatitude = locationValue.latitude
            UserModel.sharedInstance().currentLongitude = locationValue.longitude
            UserModel.sharedInstance().synchroniseData()
            locationManager.stopUpdatingLocation()
            if UserModel.sharedInstance().userType != "DJ"{
                callArtistPinWebService()
            }
            GetGenreList()
            callProjectTypeWebService()
        }
    }
    
    // Below Mehtod will print error if not able to update location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if UserModel.sharedInstance().userType == "AR"{
            if let annotation = annotation as? ClusterAnnotation {
                let index = 1
                let identifier = "Cluster\(index)"
                let selection = SelectionCluster(rawValue: 1)!
                var is_verify = "0"
                for i in 0..<annotation.annotations.count{
                    for j in 0..<self.verifiedLat.count{
                        if "\(annotation.annotations[i].coordinate.latitude)" == self.verifiedLat[j]{
                            is_verify = "1"
                        }
                    }
                }
                globalObjects.shared.pinTrial = self.trial
                
                return mapView.annotationViewCluster(selection: selection, annotation: annotation, reuseIdentifier: identifier, index: is_verify)
            } else if let annotation = annotation as? MeAnnotation {
                let identifier = "Me"
                let annotationView = mapView.annotationView(of: MKAnnotationView.self, annotation: annotation, reuseIdentifier: identifier)
                annotationView.image = .me
                return annotationView
            } else {
                var latitude = ""
                var longitude = ""
                
                if let ann = annotation as? Annotation {
                    latitude = ann.locationData!["lat"]!
                    longitude = ann.locationData!["lon"]!
                }
                
                let selection = SelectionCluster(rawValue: 0)!
                var arrSorted = [ArtistPinDataDetail]()
                var verifyArray = [String]()
                
                for i in 0..<arrArtistGraphPin.count {
                    let lat = arrArtistGraphPin[i].latitude
                    let long = arrArtistGraphPin[i].longitude
                    if lat == latitude && long == longitude{
                        arrSorted.append(arrArtistGraphPin[i])
                        verifyArray.append("\(self.arrArtistGraphPin[i].is_dj_verify ?? 0)")
                    }
                }
                if arrSorted.count > 0{
                    let formatter = NumberFormatter()
                    formatter.groupingSeparator = "," // or possibly "." / ","
                    formatter.numberStyle = .decimal
//                    formatter.string(from: Int(arrSorted[0].project_cost!)! as NSNumber)
//                    let string2 = formatter.string(from: Int(arrSorted[0].project_cost!)! as NSNumber)
            
                    
                    //let identifier = "\(self.currentCurrency)" + string2!
                   let identifier = "\(self.currentCurrency)\(arrSorted[0].project_cost ?? "")"
                    
                    return mapView.annotationViewCluster(selection: selection, annotation: annotation, reuseIdentifier: identifier, index: "\(arrSorted[0].is_dj_verify ?? 0)")
                }else{
                    return nil
                }
            }
        }else{
            if let annotation = annotation as? ClusterAnnotation {
                let index = 1
                let identifier = "Cluster\(index)"
                let selection = SelectionCluster(rawValue: 2)!
                
                return mapView.annotationViewCluster(selection: selection, annotation: annotation, reuseIdentifier: identifier, index: "0")
            } else if let annotation = annotation as? MeAnnotation {
                let identifier = "Me"
                let annotationView = mapView.annotationView(of: MKAnnotationView.self, annotation: annotation, reuseIdentifier: identifier)
                annotationView.image = .me
                return annotationView
            } else {
                let identifier = "Pin"
                let annotationView = mapView.annotationView(of: MKAnnotationView.self, annotation: annotation, reuseIdentifier: identifier)
                annotationView.tag = 27
                annotationView.image = UIImage(named: "DJ_Single_pin")
                return annotationView
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        manager.reload(mapView: mapView) { finished in
            print(finished)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        UserModel.sharedInstance().isPin = true
        UserModel.sharedInstance().synchroniseData()
        if UserModel.sharedInstance().userType == "AR"{
            if view.tag == 21{
                var dic = [[String : String]]()
                var arrSorted = [ArtistPinDataDetail]()
                arrSorted.removeAll()
                arprojectList.removeAll()
                dic.removeAll()
                RemainingTimeArray.removeAll()
                releaseDate.removeAll()
                guard let annotations = view.annotation else { return }
                if let cluster = annotations as? ClusterAnnotation {
                    
                    for annotation in cluster.annotations {
                        let ann = annotation as? Annotation
                        let locationData = ann?.locationData!
                        dic.append(locationData!)
                    }
                    
                    for i in 0..<arrArtistGraphPin.count {
                        for j in 0..<dic.count {
                            
                            let pin = arrArtistGraphPin[i].latitude
                            let pin2 = arrArtistGraphPin[i].longitude
                            
                            if pin == dic[j]["lat"]! && pin2 == dic[j]["lon"]!{
                                if !arrSorted.contains(where: {$0.project_id == arrArtistGraphPin[i].project_id}) {
                                    arrSorted.append(arrArtistGraphPin[i])
                                }
                            }
                        }
                    }
                    arprojectList = arrSorted
                    tblView.reloadData()
                    lblAvailableConnection.text = "\(arprojectList.count) Connections Available"
                    tblView.isHidden = false
                    viewTableData.isHidden = false
                    arrayCount = arrSorted.count
                    for i in 0..<arrSorted.count{
                        //self.RemainingTimeArray.append(self.arprojectList[i].remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")) // ashitesh for daye correction
                        self.RemainingTimeArray.append(self.arprojectList[i].remaining_time!)
                    }
                    
                    print(self.RemainingTimeArray)
                    globalObjects.shared.mapTimer = true
                    startTimer()
                    
                }
            }else if view.tag == 26{
                var arrSorted = [ArtistPinDataDetail]()
                var verifyArray = [String]()
                var latitude = ""
                var longitude = ""
                
                if let ann = view.annotation as? Annotation {
                    latitude = ann.locationData!["lat"]!
                    longitude = ann.locationData!["lon"]!
                }
                
                for i in 0..<arrArtistGraphPin.count {
                    
                    let lat = arrArtistGraphPin[i].latitude
                    let long = arrArtistGraphPin[i].longitude
                    
                    if lat == latitude && long == longitude{
                        arrSorted.append(arrArtistGraphPin[i])
                        verifyArray.append("\(self.arrArtistGraphPin[i].is_dj_verify!)")
                    }
                    
                }
                let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
                self.vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
                self.vc2.delegate = self
                self.vc2.projectId = "\(arrSorted[0].project_id!)"
                self.vc2.musicTypeId = "\(arrSorted[0].music_type ?? 0)"
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromTop
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(self.vc2, animated: false)
            }else {
                print("current location")
            }
        }else{
            print("current location")
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach { $0.alpha = 0 }
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            views.forEach { $0.alpha = 1 }
        }, completion: nil)
    }
    
}
class MeAnnotation: Annotation {}

extension String {
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[2356789][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return self == filtered
    }
}
