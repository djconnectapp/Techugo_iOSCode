//
//  ArtistMapReviewVC.swift
//  DJConnect
//
//  Created by My Mac on 16/02/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import MapKit
import SwipeCellKit
import Alamofire
import DropDown
import AlamofireObjectMapper
import Cluster
import Foundation

class ArtistMapReviewCell : SwipeTableViewCell{
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var imgProfile: imageProperties!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblGenereList: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblStar: UILabel!
    
    @IBOutlet weak var cellbgVw: UIView!
}
class ArtistMapReviewVC: UIViewController {
    
    @IBOutlet weak var viewSearchView: UIView!
    @IBOutlet weak var btnSlideIn: UIButton!
    
    
    //MARK:- GLOBAL VARIABLES
    fileprivate weak var calendar: FSCalendar!
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    var arSelectedDate = String()
    var postDate = String()
    var date = Date()
    var region = (center: CLLocationCoordinate2D(latitude: Double(), longitude: Double()), delta: 0.1)
    var arrArtistGraphPin = [ArtistReviewMapGraphPinData]()
    lazy var manager: ClusterManager = { [unowned self] in
        let manager = ClusterManager()
        manager.delegate = self
        manager.maxZoomLevel = 17
        manager.minCountForClustering = 2
        manager.clusterPosition = .nearCenter
        return manager
    }()
    let currPin = MKPointAnnotation()
    let newPin = MKPointAnnotation()
    var trial = [String]()
    var verifiedLat = [String]()
    var currentLocation: CLLocation?
    var currentCurrency = String()
    let locationManager = CLLocationManager()
    var arprojectList = [ArtistReviewMapGraphPinData]()
    var arrayCount = Int()
    var arrgenrelist = [GenreData]()
    var arrSearchResult = [SearchListDetail]()
    var arrSearchFilter = [SearchListDetail]()
    var isSearchEnabled = false
    var viewerId = ""
    
    
    //MARK:- OUTLETS
    @IBOutlet weak var viewTableData: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnViewAllDates: UIButton!
    @IBOutlet weak var tblReviewMap: UITableView!
    @IBOutlet weak var lblAvailableConnection: UILabel!
    @IBOutlet weak var btnProfile: buttonProperties!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    //Table Search
    @IBOutlet weak var tblsearch: UITableView!
    @IBOutlet weak var tblSearchHeight: NSLayoutConstraint!
    @IBOutlet weak var lblUserNAme: UILabel!
    
    var projectId = String()
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewTableData.backgroundColor = UIColor(red: 55/255, green: 69/255, blue: 99/255, alpha: 1.0).withAlphaComponent(0.9)
        //tblReviewMap.backgroundColor = UIColor(red: 55/255, green: 69/255, blue: 99/255, alpha: 1.0).withAlphaComponent(0.9)
        //tblReviewMap.layer.cornerRadius = 15
        viewTableData.layer.cornerRadius = 20
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationAct(_:)), name: NSNotification.Name(rawValue: "Test12"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        checkLocationPermission()
        CallGetCurrentCreditsWebService()
    }
    
    @objc func NotificationAct(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
           if let userName = userInfo["name"] as? String {
                print("notification",userName)
            CallGetCurrentCreditsWebService()
            }
        }
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func btnSearch_Action(_ sender: UIButton) {
    }
    
    @IBAction func btnProfile_Action(_ sender: UIButton) {
        tfSearch.text = ""
        tfSearch.resignFirstResponder()
        UserModel.sharedInstance().isPin = false
        UserModel.sharedInstance().synchroniseData()
        
        let storyBoard = UIStoryboard(name: "ArtistProfile", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as? ArtistViewProfileVC
        sideMenuController()?.setContentViewController(next1!)
    }
    
    @IBAction func btnCloseSearch_Action(_ sender: UIButton) {
        viewTableData.isHidden = true
    }
    @IBAction func btnMenu_Action(_ sender: UIButton) {
        //toggleSideMenuView()
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func btnFilter_Action(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistReviewFilterVC") as? ArtistReviewFilterVC
        present(next1!, animated: false, completion: nil)
    }
    
    @IBAction func btnSlideInAction(_ sender: UIButton) {
        viewSearchView.isHidden = false
        btnSlideIn.isHidden = true
    }
    
    @IBAction func btnSlideOutAction(_ sender: UIButton) {
        viewSearchView.isHidden = true
        btnSlideIn.isHidden = false
    }
    
    
    //MARK:- OTHER ACTIONS
    func goToDJProfile(userID : String){
        let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
        let desireViewController = homeSB.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
        desireViewController.viewerId = userID
        desireViewController.isFromMenu = false
        navigationController?.pushViewController(desireViewController, animated: true)
    }
    
    func changeRoot(){
        if globalObjects.shared.searchResultUserType == "DJ"{
            goToDJProfile(userID: viewerId)
        }else{
            let homeSB = UIStoryboard(name: "ArtistProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationArtistProfile") as! UINavigationController
            let desireViewController = homeSB.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as! ArtistViewProfileVC
            desireViewController.viewerId = viewerId
            desiredViewController.setViewControllers([desireViewController], animated: false)
            let appdel = UIApplication.shared.delegate as! AppDelegate
            let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
            desiredViewController.view.addSubview(snapshot)
            appdel.window?.rootViewController = desiredViewController;
            UIView.animate(withDuration: 0.3, animations: {() in
                snapshot.layer.opacity = 0
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            }, completion: {
                (value: Bool) in
                snapshot.removeFromSuperview()
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueCalendarDjSongReview"{
            let destinationVC = segue.destination as! DJSongReviewsVC
            //let arrGraphPin = arrArtistGraphPin[sender as! Int]
            let arrGraphPin = arprojectList[sender as! Int]
            destinationVC.djId = "\(arrGraphPin.djId!)"
            destinationVC.projBy = arrGraphPin.djName
            destinationVC.connectCost = arrGraphPin.songreviewCost
            if let projectImageUrl = URL(string: "\(arrGraphPin.profileImage!)"){
                if let data = try? Data(contentsOf: projectImageUrl)
                {
                    let image: UIImage = UIImage(data: data)!
                    destinationVC.userProfile = image
                }
            }
            destinationVC.currentCurrency = currentCurrency
        }
    }
    
    func ChangeRootUsingFlip(userID : String) {
        goToDJProfile(userID: userID)
        
    }
    
    func setupViews(){
        NotificationCenter.default.addObserver(self, selector: #selector(saveFilter(notification:)), name: Notification.Name(rawValue: "saveReviewMapFilter"), object: nil)
        viewSearchView.layer.shadowOffset = CGSize(width: 2.0, height: 1.6)
        viewSearchView.layer.shadowRadius = 4
        viewSearchView.layer.shadowColor = UIColor.lightGray.cgColor
        viewSearchView.layer.shadowOpacity = 10
        viewSearchView.layer.cornerRadius = 8
        viewSearchView.clipsToBounds = true
        
        tblsearch.isHidden = true
        viewTableData.isHidden = true
        manager.add(MeAnnotation(coordinate: region.center))
        mapView.showsCompass = false
        viewTableData.isHidden = true
        tblReviewMap.allowsSelection = true
        tblReviewMap.allowsMultipleSelectionDuringEditing = true
        navigationItem.rightBarButtonItem = editButtonItem
        self.currentCurrency = UserModel.sharedInstance().userCurrency!
        lblUserNAme.text = UserModel.sharedInstance().userName
        if UserModel.sharedInstance().userProfileUrl != nil{
            let profileImageUrl = URL(string: UserModel.sharedInstance().userProfileUrl!)
            if profileImageUrl != nil {
                btnProfile.kf.setImage(with: profileImageUrl, for: .normal)
            }
        }else{
            btnProfile.setImage(UIImage(named: "user-profile"), for: .normal)
        }
        let notiCount = UserModel.sharedInstance().notificationCount
        if notiCount != nil {
            if notiCount! > 0 {
                self.lblMenuNotifyNumber.isHidden = false
                self.lblMenuNotifyNumber.text = "\(notiCount!)"
            }
        }
    }
    
    func checkLocationPermission(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                self.showAlertView("Need to allow location for app access.", "Allow Navigation", "Allow", completionHandler: { (ACTION) in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                })
            case .authorizedAlways, .authorizedWhenInUse:
                
                //ashitesh - review song - delhi location
                if UserModel.sharedInstance().currentLatitude != nil{
                    region = (center: CLLocationCoordinate2D(latitude: UserModel.sharedInstance().currentLatitude!, longitude: UserModel.sharedInstance().currentLongitude!), delta: 0.1)
                    manager.add(MeAnnotation(coordinate: region.center))
                    mapView.region = .init(center: region.center, span: .init(latitudeDelta: region.delta, longitudeDelta: region.delta))
                
//                if UserModel.sharedInstance().currentLatitude != nil{
//                    region = (center: CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025), delta: 5)
//                    manager.add(MeAnnotation(coordinate: region.center))
//                    mapView.region = .init(center: region.center, span: .init(latitudeDelta: region.delta, longitudeDelta: region.delta))
                    callArtistPinWebService(url: "userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&usertype=\(UserModel.sharedInstance().userType!)&latitude=\(UserModel.sharedInstance().currentLatitude!)&longitude=\(UserModel.sharedInstance().currentLongitude!)")
                }else{
                    locationManager.delegate = self
                    self.locationManager.requestAlwaysAuthorization()
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                }
            }
        } else {
            self.showAlertView("Need to allow location for app access.", "Allow Navigation", "Allow", completionHandler: { (ACTION) in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            })
        }
    }
    //MARK:- SELECTOR ACTION
    @objc func saveFilter(notification : Notification){
        let url = (notification.userInfo!["url"] as? String)!
        callArtistPinWebService(url: url)
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
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.searchUserAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SearchListModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let searchList = response.result.value!
                    if searchList.success == 1{
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
                        if(searchList.message == "something is wrong. Please try again!"){
                            self.view.makeToast("No Users found by this name.")
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
    
    func callArtistPinWebService(url : String){
        if getReachabilityStatus(){
            Loader.shared.show()
            print("mapurl",url)
            
            //commented by ashitesh
//            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getSongReviewGraphPinAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)&usertype=\(UserModel.sharedInstance().userType!)&latitude=\(UserModel.sharedInstance().currentLatitude!)&longitude=\(UserModel.sharedInstance().currentLongitude!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ArtistReviewMapResponse>) in
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getSongReviewGraphPinAPI)?"+url), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ArtistReviewMapResponse>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let pinList = response.result.value!
                    if pinList.success == 1{
                        self.arrArtistGraphPin.removeAll()
                        
                        for i in 0..<pinList.graphPinData!.count{
                            self.arrArtistGraphPin.append(pinList.graphPinData![i])
                        }
                        self.manager.removeAll()
                        self.manager.reload(mapView: self.mapView)
                        for i in 0..<self.arrArtistGraphPin.count{
                            self.trial.append("\(self.arrArtistGraphPin[i].djIsVerified!)")
                        }
                        for i in 0..<self.arrArtistGraphPin.count{
                            if self.arrArtistGraphPin[i].djIsVerified! == 1{
                                self.verifiedLat.append(self.arrArtistGraphPin[i].latitude!)
                            }
                        }
                        let annotations: [Annotation] = (0..<self.arrArtistGraphPin.count).map { i in
                            let x = Double(self.arrArtistGraphPin[i].latitude!)
                            let y = Double(self.arrArtistGraphPin[i].longitude!)
                            let annotation = Annotation()
                            annotation.locationData = ["lat":self.arrArtistGraphPin[i].latitude!, "lon":self.arrArtistGraphPin[i].longitude!]
                            annotation.coordinate = CLLocationCoordinate2D(latitude:x ?? 0.0 , longitude: y ?? 0.0)
                            return annotation
                        }
                        self.region = (center: CLLocationCoordinate2D(latitude: UserModel.sharedInstance().currentLatitude ?? 0.0, longitude: UserModel.sharedInstance().currentLongitude ?? 0.0), delta: 40)
                        self.manager.add(MeAnnotation(coordinate: self.region.center))
                        self.mapView.region = .init(center: self.region.center, span: .init(latitudeDelta: self.region.delta, longitudeDelta: self.region.delta))
                        self.manager.add(annotations)
                        self.manager.reload(mapView: self.mapView)
                    }
                    else{
                        Loader.shared.hide()
                        if(pinList.message == "You are not authorised. Please login again."){
                            self.view.makeToast(pinList.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                            })
                        }
                        else{
                            self.view.makeToast(pinList.message)
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
    
    func generateAlert(msg: String){
        self.showAlertView(msg, "Alert")
    }
}
extension ArtistMapReviewVC: ClusterManagerDelegate {
    func cellSize(for zoomLevel: Double) -> Double? {
        return nil
    }
    func shouldClusterAnnotation(_ annotation: MKAnnotation) -> Bool {
        return !(annotation is MeAnnotation)
    }
}
extension ArtistMapReviewVC: MKMapViewDelegate,CLLocationManagerDelegate{
    
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
            
            //UserModel.sharedInstance().currentLatitude = 28.7041
           // UserModel.sharedInstance().currentLongitude = 77.1025
            
            UserModel.sharedInstance().synchroniseData()
            locationManager.stopUpdatingLocation()
            if UserModel.sharedInstance().userType != "DJ"{
                callArtistPinWebService(url: "userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&usertype=\(UserModel.sharedInstance().userType!)&latitude=\(UserModel.sharedInstance().currentLatitude!)&longitude=\(UserModel.sharedInstance().currentLongitude!)")
            }
        }
    }
    
    // Below Mehtod will print error if not able to update location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
            
            return mapView.annotationViewReviewCluster(selection: selection, annotation: annotation, reuseIdentifier: identifier, index: is_verify)
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
            var arrSorted = [ArtistReviewMapGraphPinData]()
            var verifyArray = [String]()
            
            for i in 0..<arrArtistGraphPin.count {
                
                let lat = arrArtistGraphPin[i].latitude
                let long = arrArtistGraphPin[i].longitude
                if lat == latitude && long == longitude{
                    arrSorted.append(arrArtistGraphPin[i])
                    verifyArray.append("\(arrArtistGraphPin[i].djIsVerified!)")
                }
            }
            var idntfrrevwCostStr = ""
            var idntfrrIsvrfdStr = ""
            if(arrSorted.count > 0){
                idntfrrevwCostStr = arrSorted[0].songreviewCost!
                idntfrrIsvrfdStr = "\(arrSorted[0].djIsVerified!)"
            }
            let identifier = "\(self.currentCurrency)\(idntfrrevwCostStr)"
            return mapView.annotationViewReviewCluster(selection: selection, annotation: annotation, reuseIdentifier: identifier, index: idntfrrIsvrfdStr)
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
                var arrSorted = [ArtistReviewMapGraphPinData]()
                arrSorted.removeAll()
                arprojectList.removeAll()
                dic.removeAll()
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
                                if !arrSorted.contains(where: {$0.songReiewId == arrArtistGraphPin[i].songReiewId}) {
                                    arrSorted.append(arrArtistGraphPin[i])
                                }
                            }
                        }
                    }
                    arprojectList = arrSorted
                    tblReviewMap.reloadData()
                    lblAvailableConnection.text = "\(arprojectList.count) connections available"
                    tblReviewMap.isHidden = false
                    viewTableData.isHidden = false
                    arrayCount = arrSorted.count
                }
            }else if view.tag == 26{
                var arrSorted = [ArtistReviewMapGraphPinData]()
                var verifyArray = [String]()
                var latitude = ""
                var longitude = ""
                
                arrSorted.removeAll()
                arprojectList.removeAll()
               // dic.removeAll()
                
                if let ann = view.annotation as? Annotation {
                    latitude = ann.locationData!["lat"]!
                    longitude = ann.locationData!["lon"]!
                }
                
                for i in 0..<arrArtistGraphPin.count {
                    let lat = arrArtistGraphPin[i].latitude
                    let long = arrArtistGraphPin[i].longitude
                    if lat == latitude && long == longitude{
                        arrSorted.append(arrArtistGraphPin[i])
                        verifyArray.append("\(arrArtistGraphPin[i].djIsVerified!)")
                    }
                }
                
                arprojectList = arrSorted
                tblReviewMap.reloadData()
                lblAvailableConnection.text = "\(arprojectList.count) connections available"
                tblReviewMap.isHidden = false
                viewTableData.isHidden = false
                arrayCount = arrSorted.count
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
extension ArtistMapReviewVC {
    enum SelectionCluster: Int {
        case count, imageCount, image
    }
}
extension ArtistMapReviewVC :  UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            return arprojectList.count
        }else {
            return arrSearchResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistMapReviewCell") as? ArtistMapReviewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            
            cell.cellbgVw.layer.cornerRadius = 15
            cell.cellbgVw.clipsToBounds = true
            cell.cellbgVw.backgroundColor = UIColor(red: 83/255, green: 109/255, blue: 142/255, alpha: 1.0).withAlphaComponent(0.5)
            
            let arrReviewProj = arprojectList[indexPath.row]
            cell.lblDjName.text = arrReviewProj.djName
            cell.lblGenereList.text = arrReviewProj.djGenre
                 
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
//            formatter.string(from: Int(arrReviewProj.songreviewCost!)! as NSNumber)
//            print("number::",formatter.string(from: Int(arrReviewProj.songreviewCost!)! as NSNumber))
//            let string = formatter.string(from: Int(arrReviewProj.songreviewCost!)! as NSNumber)
//
//            cell.lblCost.text = "\(currentCurrency)" + " " + string!
            cell.lblCost.text = "\(currentCurrency) \(arrReviewProj.songreviewCost!)"
            cell.lblCount.text = arrReviewProj.totalUser
            cell.lblStar.text = arrReviewProj.totalStars
            let projectImageUrl = URL(string: "\(arrReviewProj.profileImage!)")
            cell.imgProfile.kf.setImage(with: projectImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "search_cell", for: indexPath) as! search_cell
            cell.lbl_location.text = arrSearchResult[indexPath.row].name!
            UserModel.sharedInstance().isPin = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let profile = SwipeAction(style: .destructive, title: "DJ PAGE") { action, indexPath in
            let id = "\(self.arprojectList[indexPath.row].djId!)"
            globalObjects.shared.searchResultUserType = "DJ"
            globalObjects.shared.mapTimer = false
            self.ChangeRootUsingFlip(userID: id)
            self.viewTableData.isHidden = true
        }
        
        let profileImageUrl = URL(string: "\(arprojectList[indexPath.row].profileImage!)")
        let profileImg = UIImageView()
        profileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        let selectedBarImage: UIImage = profileImg.image!.squareMyImage().resizeMyImage(newWidth: 60).roundMyImage.withRenderingMode(.alwaysOriginal)
        profile.image = selectedBarImage
        profile.backgroundColor = .themeBlack
        profile.font = .boldSystemFont(ofSize: 10)
        
        let project = SwipeAction(style: .destructive, title: "BUY REVIEW") { action, indexPath in
            self.performSegue(withIdentifier: "segueCalendarDjSongReview", sender: indexPath.row)
            self.viewTableData.isHidden = true
        }
        
        project.backgroundColor = UIColor .themeBlack
        project.font = .boldSystemFont(ofSize: 10)
        
        // customize the action appearance
        project.image = UIImage(named: "edit-icopn")
        
        return [project,profile]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        options.maximumButtonWidth = 90
        options.minimumButtonWidth = 90
        options.buttonSpacing = 8
        
        return options
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.tag == 2 {
            return 45
        }
        else{
        return 165
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 2 {
            viewerId = "\(arrSearchResult[indexPath.row].userid!)"
            UserModel.sharedInstance().isPin = true
            UserModel.sharedInstance().synchroniseData()
            globalObjects.shared.searchResultUserType = arrSearchResult[indexPath.row].user_type!
            changeRoot()
        }
        
        if tableView.tag == 1{
            let arrReviewProj1 = arprojectList[indexPath.row]
            if UserModel.sharedInstance().userCurrentBalance! <= (Float(arrReviewProj1.songreviewCost)!){
                generateAlert(msg: "You don't have enough Connect Cash to buy this project.")
                }
            else{
            let profileImageUrl = URL(string: "\(arprojectList[indexPath.row].profileImage!)")
            let profileImg = UIImageView()
            profileImg.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            
            //let project = SwipeAction(style: .destructive, title: "BUY REVIEW") { action, indexPath in
                self.performSegue(withIdentifier: "segueCalendarDjSongReview", sender: indexPath.row)
                self.viewTableData.isHidden = true
          //  }
            }
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
                                print("Total money",UserModel.sharedInstance().userCurrentBalance)
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
    
//    if UserModel.sharedInstance().userCurrentBalance! >= (Int(self.projPrice)! + 75){
//        return true
//    }else{
//        return false
//    }
    
}
extension ArtistMapReviewVC : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfSearch {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if newString.isEmpty{
                tblsearch.isHidden = true
                self.arrSearchResult.removeAll()
            }
            if textField == tfSearch{
                isSearchEnabled = true
                self.arrSearchResult.removeAll()
                self.callSearchListWebService(text: newString)
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tfSearch.text?.removeAll()
        self.tblsearch.isHidden = true
        self.arrSearchResult.removeAll()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == tfSearch{
//            if txt_search.text == "Where would you like to connect?".localize{
            if tfSearch.text != ""{
                tfSearch.text = ""
            }
            
        }
       }
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField == tfSearch{
            if tfSearch.text == ""{
                tfSearch.text = "Where would you like to connect?".localize
            }
            
        }
    }
}

//struct Number {
//    static let withSeparator: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.groupingSeparator = "," // or possibly "." / ","
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
//}
//extension Integer {
//    var stringWithSepator: String {
//        return Number.withSeparator.string(from: NSNumber(value: hashValue)) ?? ""
//    }
//}
