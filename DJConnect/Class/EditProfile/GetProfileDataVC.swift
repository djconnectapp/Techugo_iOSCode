//
//  EditProfileVC.swift
//  DJConnect
//
//  Created by My Mac on 26/03/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import Alamofire
import LocationPickerViewController

class GetProfileDataVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var cnsContainerHeight: NSLayoutConstraint!
   // @IBOutlet weak var imgProfile: imageProperties!
    @IBOutlet weak var btnProfile: buttonProperties!
    @IBOutlet weak var btnService: buttonProperties!
   // @IBOutlet weak var btnProfileChange: UIButton!
    @IBOutlet weak var btnMedia: buttonProperties!
    @IBOutlet weak var vwContainer: UIView!

    @IBOutlet weak var btnSave: buttonProperties!
    @IBOutlet weak var headrProfileLbl: UILabel!
    
    //MARK:- GLOBAL VARIABLE
    var vwProfilePage : EditProfileVC?
    var vwServicePage : EditServiceVC?
    var vwMediaPage : EditMediaVC?
    var picker: UIImagePickerController = UIImagePickerController()
    var songData : NSData? = nil
    var buttonSelected = String()
    
    //Genere variable
    var genreNames = "Rock"
    var genreIds = "1"
    var getLatVal : Double!
    var getLongVal : Double!
    var getState : String!
    var getCity : String!
    var getCountry : String!
    var isProfileImgSelected = false
    
    var saveServiceCity : String?
    var saveServiceCountry: String?
    var saveServiceLat : String?
    var saveServiceLong : String?
    
    
    var djName = ""
    var djCurrentCity = ""
    var djMusicGenre = ""
    var djYourBio = ""
    var saveImgStr = ""
    var setNewImg:UIImage?
    var screenTypeStr = ""
    
    var isProfile = false
    var gerneDataObj = [GenreData]()
    
    @IBOutlet weak var profilePicBgVw: UIView!
    
    @IBOutlet weak var profileImgVw: UIImageView!
    
    @IBOutlet weak var addProfileImgBtn: UIButton!
    
    
    
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(screenTypeStr == "Artist"){
            btnMedia.isHidden = true
        }

        headrProfileLbl.text = "Profile"
        isProfile = false
        GetGenreList() 
        
        btnProfile.layer.cornerRadius = btnProfile.frame.size.height/2
        btnProfile.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        btnProfile.layer.borderWidth = 0.5
        btnProfile.clipsToBounds = true
        
        btnService.layer.cornerRadius = btnService.frame.size.height/2
        btnService.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        btnService.layer.borderWidth = 0.5
        btnService.clipsToBounds = true
        
        btnMedia.layer.cornerRadius = btnMedia.frame.size.height/2
        btnMedia.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        btnMedia.layer.borderWidth = 0.5
        btnMedia.clipsToBounds = true
        
        btnProfile.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
        btnService.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnMedia.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnProfile.setTitleColor(.white, for: .normal)
        btnService.setTitleColor(.white, for: .normal)
        btnMedia.setTitleColor(.white, for: .normal)
        
        
        isProfileImgSelected = false
        setupViews()
        if buttonSelected == "FirstView"{
            //self.btnClose.isHidden = true
        }else{
            //self.btnClose.isHidden = false
        }
        // profile screen - cancelBtn Tapped
        self.vwProfilePage?.callBackCancelBtn = {getcallBack in
            self.navigationController?.popViewController(animated: true)
        }
        
        // service screen - cancelBtn Tapped
        self.vwServicePage?.callBackServiceCancelBtn = {getcallBack in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.vwMediaPage?.saveButtonCallback = {getcallBack in
            self.isProfile = true
            self.buttonSelected = "all"
            self.saveProfile()

        }

        self.vwProfilePage?.serviceButtonCallback = { selected in
            
            let height = self.view.frame.height
            DispatchQueue.main.async { [self] in
                self.addViewToContainer(viewAdd: (self.vwServicePage?.view)!, height: 300)
            }
            self.vwProfilePage?.view.isHidden = true
            self.vwServicePage?.view.isHidden = false
            self.vwMediaPage?.view.isHidden = true

            self.buttonSelected = "service"
           // btnProfileChange.isHidden = true // now
            self.btnProfile.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnService.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
            self.btnMedia.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnProfile.setTitleColor(.white, for: .normal)
            self.btnService.setTitleColor(.white, for: .normal)
            self.btnMedia.setTitleColor(.white, for: .normal)
        }
        
        self.vwServicePage?.mediaButtonCallback = { selected in
            let height = self.view.frame.height
            DispatchQueue.main.async { [self] in
                self.addViewToContainer(viewAdd: (self.vwMediaPage?.view)!, height: 500)
            }
            self.vwMediaPage?.view.isHidden = false
            self.vwProfilePage?.view.isHidden = true
            self.vwServicePage?.view.isHidden = true
            
            self.buttonSelected = "media"
            //btnProfileChange.isHidden = true // now
            self.btnProfile.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnService.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnMedia.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
            self.btnProfile.setTitleColor(.white, for: .normal)
            self.btnService.setTitleColor(.white, for: .normal)
            self.btnMedia.setTitleColor(.white, for: .normal)
        }
            
    }
    
    @IBAction func addProfileimgBtnTapped(_ sender: Any) {
        //imageViewSelected = .profileImage
        choosePhoto()
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
    }
    
   
    
    //MARK:- OTHER ACTION
    func setup(){
        if buttonSelected == "calendar" || buttonSelected == "all project" || buttonSelected == "FirstView"{
            profileSelected()
        }else if buttonSelected == "service"{
           serviceSelected()
        }else{
            mediaSelected()
        }
    }
    
    func setupViews(){
        NotificationCenter.default.addObserver(self, selector: #selector(openGenereVC(notification:)), name: Notification.Name(rawValue: "openGenereVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(genreList(_:)), name: Notification.Name(rawValue: "genre"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openLocationPicker), name: Notification.Name(rawValue: "openLocationPicker"), object: nil)
        
        //ashitesh notification
        NotificationCenter.default.addObserver(self, selector: #selector(openVideoView(notification:)), name: Notification.Name(rawValue: "openVideoView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openDocumentPicker(notification:)), name: Notification.Name(rawValue: "openDocumentPicker"), object: nil)
       
        let storyboard = UIStoryboard(name: "EditProfile", bundle: nil)
        vwProfilePage = (storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC)!
        vwProfilePage?.callBackCancelBtn = {getcallBack in
            
            self.navigationController?.popViewController(animated: false)
        }
        
       // callBackCancelBtn
        vwServicePage = (storyboard.instantiateViewController(withIdentifier: "EditServiceVC") as? EditServiceVC)!
        vwMediaPage = (storyboard.instantiateViewController(withIdentifier: "EditMediaVC") as? EditMediaVC)!
        
        // api is not running
        callGetProfileWebService()
        picker.delegate = self
    }
    func addViewToContainer(viewAdd : UIView, height : Int){
        vwContainer.addSubview(viewAdd)
        cnsContainerHeight.constant = CGFloat(height)
        
       // viewAdd.frame = CGRect(x: 0, y: 0, width: self.vwContainer.frame.size.width, height: self.vwContainer.frame.size.height)
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
    func openGallary()
    {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.mediaTypes = ["public.image"]
        present(picker, animated: true, completion: {self.picker.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black})
    }
    func changeRoot(){
        if UserModel.sharedInstance().userType == "AR"{
            let homeSB = UIStoryboard(name: "ArtistProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as! ArtistViewProfileVC
            desiredViewController.setImgStr = self.saveImgStr
          //  desiredViewController.getImage = self.imgProfile.image // now
            navigationController?.pushViewController(desiredViewController, animated: false)
        }else{
            let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
            navigationController?.pushViewController(desiredViewController, animated: false)
        }
    }
    
    func profileSelected(){
        headrProfileLbl.text = "Profile"
        self.vwProfilePage?.view.isHidden = false
        self.vwServicePage?.view.isHidden = true
        self.vwMediaPage?.view.isHidden = true
        
        
        DispatchQueue.main.async { [self] in
            //let height = 800
            //self.addViewToContainer(viewAdd: (self.vwProfilePage?.view)!, height: Int(height))
            self.addViewToContainer(viewAdd: (self.vwProfilePage?.view)!, height: 800)
        }
        buttonSelected = "all project"
        
        btnProfile.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
        btnService.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnMedia.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnProfile.setTitleColor(.white, for: .normal)
        btnService.setTitleColor(.white, for: .normal)
        btnMedia.setTitleColor(.white, for: .normal)
        
    }
    func serviceSelected(){
        headrProfileLbl.text = "Service"
        let height = view.frame.height
        DispatchQueue.main.async { [self] in
//            self.addViewToContainer(viewAdd: (self.vwServicePage?.view)!, height: Int(height))
            self.addViewToContainer(viewAdd: (self.vwServicePage?.view)!, height: 450)
        }
        self.vwProfilePage?.view.isHidden = true
        self.vwServicePage?.view.isHidden = false
        self.vwMediaPage?.view.isHidden = true
        buttonSelected = "service"
       // btnProfileChange.isHidden = true // now
        btnProfile.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnService.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
        btnMedia.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnProfile.setTitleColor(.white, for: .normal)
        btnService.setTitleColor(.white, for: .normal)
        btnMedia.setTitleColor(.white, for: .normal)
        self.vwProfilePage?.serviceButtonCallback = { selected in
            self.addViewToContainer(viewAdd: (self.vwServicePage?.view)!, height: 450)
            self.vwProfilePage?.view.isHidden = true
            self.vwServicePage?.view.isHidden = false
            self.vwMediaPage?.view.isHidden = true
            self.buttonSelected = "service"
           // btnProfileChange.isHidden = true // now
            self.btnProfile.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnService.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
            self.btnMedia.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnProfile.setTitleColor(.white, for: .normal)
            self.btnService.setTitleColor(.white, for: .normal)
            self.btnMedia.setTitleColor(.white, for: .normal)
        }

    }
  
    func mediaSelected(){
        headrProfileLbl.text = "Media"
        self.vwMediaPage?.view.isHidden = false
        self.vwProfilePage?.view.isHidden = true
        self.vwServicePage?.view.isHidden = true
        
        //let height = view.frame.height
        let height = vwMediaPage?.view.frame.size.height
        DispatchQueue.main.async { [self] in
            self.addViewToContainer(viewAdd: (self.vwMediaPage?.view)!, height: 648)
        }
        buttonSelected = "media"
        //btnProfileChange.isHidden = true // now
        btnProfile.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnService.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
        btnMedia.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
        btnProfile.setTitleColor(.white, for: .normal)
        btnService.setTitleColor(.white, for: .normal)
        btnMedia.setTitleColor(.white, for: .normal)
        self.vwServicePage?.mediaButtonCallback = { selected in
            self.addViewToContainer(viewAdd: (self.vwMediaPage?.view)!, height: 648)
            self.vwMediaPage?.view.isHidden = false
            self.vwProfilePage?.view.isHidden = true
            self.vwServicePage?.view.isHidden = true

            self.buttonSelected = "media"
            //btnProfileChange.isHidden = true // now
            self.btnProfile.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnService.backgroundColor = UIColor(red: 155/255, green: 70/255, blue: 191/255, alpha: 1.0)
            self.btnMedia.backgroundColor = UIColor(red: 47/255, green: 26/255, blue: 72/255, alpha: 1.0)
            self.btnProfile.setTitleColor(.white, for: .normal)
            self.btnService.setTitleColor(.white, for: .normal)
            self.btnMedia.setTitleColor(.white, for: .normal)
        }
    }
    //MARK:- BUTTON ACTION
    @IBAction func btnClose_Action(_ sender: UIButton) {
       
    }
    @IBAction func btnMedia_Action(_ sender: UIButton) {
        mediaSelected()
    }
    @IBAction func btnService_Action(_ sender: UIButton) {
       serviceSelected()
    }
    @IBAction func btnProfile_Action(_ sender: buttonProperties) {
        
        profileSelected()
    }
    
    @IBAction func btnSavetaped(_ sender: buttonProperties) {
        saveProfile()
    }
    
    @IBAction func btnChangeProfile_Action(_ sender: UIButton) {
        choosePhoto()
    }
    @IBAction func btnSave_Action(_ sender: UIButton) {
        saveProfile()
    }
    
    func saveProfile(){
        
        //        var isProfile = false
                if buttonSelected == "calendar" || buttonSelected == "all project" || buttonSelected == "FirstView"{
                    isProfile = true
                    vwProfilePage?.saveProfileValidation()
                }else if buttonSelected == "service"{
                    vwServicePage?.saveServiceValidation()
                }else{
                    vwMediaPage?.savemediaValidation()
                }
                
               //  now coomented
        //        if(vwProfilePage?.textfieldCurrentcity?.text == ""){
        //            vwProfilePage?.textfieldCurrentcity?.text = djCurrentCity
        //
        //        }
        //        else{
        //            djCurrentCity = vwProfilePage?.textfieldCurrentcity?.text ?? ""
        //        }
                
        //        if(vwProfilePage?.textfieldYourBio?.text == ""){
        //            vwProfilePage?.textfieldYourBio?.text = djYourBio
        //        }
        //        else{
        //            djYourBio = vwProfilePage?.textfieldYourBio?.text ?? ""
        //        }
               // djName = UserModel.sharedInstance().uniqueUserName ?? ""
                djMusicGenre = vwProfilePage?.musicGenreTxtFld?.text ?? ""
        djName = vwProfilePage?.usernameTxtFld.text ?? ""
        djCurrentCity = vwProfilePage?.currentCityTxtFld?.text ?? ""
        djYourBio = vwProfilePage?.yourBioTxtVw.text ?? ""
                
                if isProfile{

                    //  now coomented
        //            if(vwProfilePage?.textfieldCurrentcity?.text == ""){
        //                vwProfilePage?.textfieldCurrentcity?.text = djCurrentCity
        //            }
        //            else{
        //                djCurrentCity = vwProfilePage?.textfieldCurrentcity?.text ?? ""
        //            }
        //            if(vwProfilePage?.textfieldYourBio?.text == ""){
        //                vwProfilePage?.textfieldYourBio?.text = djYourBio
        //            }
        //            else{
        //                djYourBio = vwProfilePage?.textfieldYourBio?.text ?? ""
        //            }
        //
        //            djName = vwProfilePage?.textfieldDjname.text ?? ""
        //            djMusicGenre = vwProfilePage?.textfieldMusicgenre.text ?? ""
                    
                }
                
                var x = Bool()
                var y = Bool()
                if vwServicePage!.dj_feedback_varying == 1{
                    x = vwServicePage!.checkSongReviewRange()
                }else{
                    vwServicePage!.dj_feedback_range1 = 0
                    vwServicePage!.dj_feedback_range2 = 0
                    x = true
                }
                if vwServicePage!.dj_drop_varying == 1{
                    y = vwServicePage!.checkDropRange()
                }else{
                    vwServicePage!.dj_drop_range1 = 0
                    vwServicePage!.dj_drop_range2 = 0
                    y = true
                }
                
                if isProfile && djName.isEmpty == true {
                    self.view.makeToast("Please enter name".localize)
                }else if isProfile && djCurrentCity.isEmpty == true {
                    self.view.makeToast("Please enter current city".localize)
                }else if isProfile && djMusicGenre.isEmpty == true  {
                    self.view.makeToast("Please enter music genre".localize)
                }else if isProfile && djYourBio.isEmpty == true {
                    self.view.makeToast("Please enter your bio".localize)
                }else if isProfile && (!x || !y) {
                    self.view.makeToast("Please enter proper range")
                }
                else if isProfile && djCurrentCity == "" {
                    self.view.makeToast("Please enter current city".localize)
                }
            else if isProfile && djYourBio == "" {
                self.view.makeToast("Please enter your bio".localize)
            }
            else if isProfile == false && djCurrentCity == "" {
                    if(UserModel.sharedInstance().countryServiceName == "" || UserModel.sharedInstance().countryServiceName == nil){
                        self.view.makeToast("Go to your profile and add your location to turn on services.".localize)
                        
                    }
                    else{
                        djCurrentCity = UserModel.sharedInstance().countryServiceName!
                        callEditProfileWebService()
                        callEditService()
                    }
                }
                
            else if isProfile == false && djYourBio == "" {
                self.view.makeToast("Please enter your bio".localize)
            }
            
                else{
                    callEditProfileWebService()
                    callEditService()
                }
    }
    //MARK:- SELECTOR ACTIONS
    @objc func openGenereVC(notification : Notification){
//        let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GerneSelectorVC") as! GerneSelectorVC
//        desiredViewController.oldSelectedIds = self.genreIds
//        desiredViewController.notificationName = "genre"
//        desiredViewController.view.frame = (self.view.bounds)
//        self.view.addSubview(desiredViewController.view)
//        self.addChild(desiredViewController)
//        desiredViewController.didMove(toParent: self)
        
                let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
                let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SelectGenreVC") as! SelectGenreVC
                desiredViewController.arrGenrelist = self.gerneDataObj
                desiredViewController.callbackGenreData = {  gerneData, selectAlGenre in
                    self.gerneDataObj.removeAll()
                    self.gerneDataObj = gerneData
                    dump(self.gerneDataObj)
        
                    var gerneSelectedList = [GenreData]()
                    for data in self.gerneDataObj{
                        if data.isSelected{
                            gerneSelectedList.append(data)
                        }
                    }
                    let txtgern: [String] = gerneSelectedList.map{$0.title} as? [String] ?? []
                    let data = txtgern.joined(separator: ", ")
        
                    let txtgernId: [String] = gerneSelectedList.map{String($0.id!)} as? [String] ?? []
                    //let dataid = txtgernId.joined(separator: ",")
                    let dataid = txtgernId.joined(separator: ",")
                    print("generIdValue",dataid)
                    self.vwProfilePage!.musicGenreTxtFld.text = data
                    //self.musicGenreTxtFld.text
                    self.genreIds = dataid
                }
                self.navigationController?.pushViewController(desiredViewController, animated: false)
    }
    
    //MARK: - OTHER METHODS
    func GetGenreList() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.getGenreAPI)?token=&userid="
            
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GenreModel>) in
                
                switch response.result {
                case .success(_):
                    let GenreModel = response.result.value!
                    if GenreModel.success == 1{
                        Loader.shared.hide()
                        self.gerneDataObj = GenreModel.genreList!
                        
                        print("GenrelistCount",self.gerneDataObj.count)
                        
                        //self.setUpGerne()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(GenreModel.message)
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
    
    @objc func genreList(_ notification : Notification){
        guard let names = notification.userInfo?["names"] as? String else { return }
        guard let ids = notification.userInfo?["ids"] as? String else { return }
        self.genreNames = names
        self.genreIds = ids
        //vwProfilePage!.textfieldMusicgenre.text = self.genreNames //  now coomented
    }
    
    @objc func openLocationPicker(){
        let locationPicker = LocationPicker()
        var add = [String]()
        locationPicker.pickCompletion = { [self] (pickedLocationItem) in
            // Do something with the location the user picked.
            let lat = pickedLocationItem.coordinate?.latitude
            let lon = pickedLocationItem.coordinate?.longitude
            print("lat1", lat)
            print("long1", lon)
            if let city = pickedLocationItem.addressDictionary!["City"]{
                add.append(city as! String + ", ")
                getCity = city as! String

            }
            
            if let state = pickedLocationItem.addressDictionary!["State"]{
                add.append(state as! String)
                getState = state as! String
                print("getState",getState)
            }
            
            
            if let countryy = pickedLocationItem.addressDictionary!["Country"]{
                add.append(countryy as! String)
                getCountry = countryy as! String
                UserModel.sharedInstance().countryServiceName = getCountry
                UserModel.sharedInstance().synchroniseData()
                print("getcountryy",getCountry)
            }
            
            getLatVal = lat!
            getLongVal = lon!
            UserModel.sharedInstance().serviceLatitude = getLatVal
            UserModel.sharedInstance().serviceLongitude = getLongVal
            UserModel.sharedInstance().synchroniseData()
            
            
            if add.count != 0 {
                
                //  now coomented
                self.vwProfilePage!.currentCityTxtFld.text = add[0] + add[1]

                UserModel.sharedInstance().cityServiceName = self.vwProfilePage!.currentCityTxtFld.text
               // vwProfilePage?.saveProfileValidation()
                UserModel.sharedInstance().synchroniseData()
                
            }
           
            globalObjects.shared.addLat = lat
            globalObjects.shared.addLong = lon
            
        }
        locationPicker.addBarButtons()
        // Call this method to add a done and a cancel button to navigation bar.
        let navigationController = UINavigationController(rootViewController: locationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func openVideoView(notification : Notification){
        
        print("notification.userInfo", notification)
       // ashitesh - need to work- means.. song should play
//
//        let broadCastID = notification.userInfo!["broadCastID"] as? String
//        let uri = notification.userInfo!["uri"] as? String
//        let video_verify_Id = notification.userInfo!["video_verify_Id"] as? String
//        let videoType = notification.userInfo!["videoType"] as? String
//
        let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistBambUserPlayerVC") as? ArtistBambUserPlayerVC
        
//        next1?.broadCastID = broadCastID!
//        next1?.uri = uri!
//        next1?.id = video_verify_Id!
//        if videoType == "SongReviewLive"{
//            next1?.videoType = "review"
//        }
//        if videoType == "project"{
//            next1?.videoType = "project"
//        }
        next1?.backType = "edit_profile"
     navigationController?.pushViewController(next1!, animated: false)
    }
    @objc func openDocumentPicker(notification : Notification){
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3", "public.wav", "public.m4a","public.audio"], in: .import)
        print("MP3, AAC, M4A, WAV, AIFF, M4R")
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    //MARK:- WEBSERVICE CALLING
    func callGetProfileWebService(){
        if getReachabilityStatus(){
            //calendar date fetch
            Loader.shared.show()
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print(dateFormatter.string(from: date))

            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProfileAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&current_date=\(dateFormatter.string(from: date))&profileviewid=\(UserModel.sharedInstance().userId!)&profileviewtype=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProfileModel>) in

                switch response.result {
                case .success(_):
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        Loader.shared.hide()

                        UserModel.sharedInstance().finishProfile = true
                        //set profile picture
                        if let x = UserModel.sharedInstance().userProfileUrl{

                            if let userProfileImageUrl = URL(string: x){
                               // self.imgProfile.kf.setImage(with: userProfileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)  //now

                                self.saveImgStr = UserModel.sharedInstance().userProfileUrl ?? ""
                            }
                        }
                        if(self.saveImgStr == ""){
                             
                            self.profileImgVw.image = UIImage(named: "pexels-cesar-de-miranda-2381596play")
                        }
                        else{
                        let profileImageUrl = URL(string: self.saveImgStr)
                        self.profileImgVw.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "pexels-cesar-de-miranda-2381596play"),  completionHandler: nil)
                        }
                        print("profileDtaGenre:",getProfile.Profiledata?[0].genre)
                        self.vwProfilePage?.profileData = getProfile.Profiledata![0]
                        print("profileDtaGenre:",getProfile.Profiledata?[0].genre)
                        self.vwServicePage?.profileservice =  getProfile.Profiledata![0]
                        self.vwMediaPage?.profileMedia = getProfile.Profiledata![0]
                        DispatchQueue.main.async { [self] in
                            self.setup()
                        }
                        self.genreIds = (getProfile.Profiledata?[0].genre_ids!) ?? "1"
                        self.genreNames = (getProfile.Profiledata?[0].genre!) ?? "Rock"
                        self.djCurrentCity = getProfile.Profiledata?[0].servciceCity ?? ""
                        self.getLatVal = Double(getProfile.Profiledata?[0].serviceLat ?? "")
                        self.getLongVal = Double(getProfile.Profiledata?[0].ServiceLong ?? "")
                        self.getCountry = getProfile.Profiledata?[0].serviceCountry
                        self.djYourBio = getProfile.Profiledata?[0].bio ?? ""
                        print("serviceCity",getProfile.Profiledata?[0].servciceCity ?? "")
                        print("getLongVal",Double(getProfile.Profiledata?[0].ServiceLong ?? ""))

                        UserModel.sharedInstance().userProfileUrl = getProfile.Profiledata![0].profile_picture!
                         UserModel.sharedInstance().synchroniseData()
                       

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
    
    func callEditProfileWebService(){

        if(UserModel.sharedInstance().userType == "DJ"){
//        if(vwServicePage!.feedbackStatus == "on" && vwServicePage!.textFieldFeedbackPrice.text == ""){
//            self.view.makeToast("Please entre feedback price")
//        }
//        if(vwServicePage!.textFieldFeedbackPrice.text == ""){
//            self.view.makeToast("Please entre feedback price")
//        }

//        else if(vwServicePage!.textFieldFeedbackPrice.text != ""){
            if(buttonSelected == "service"){
            if(vwServicePage!.textFieldFeedbackPrice.text != ""){
        let priceStr = Int(vwServicePage!.textFieldFeedbackPrice.text!)
        let currncyStr = "\(UserModel.sharedInstance().userCurrency!)"
                    if(currncyStr == "$" && priceStr! >= 0 && priceStr! < 1){
                            self.view.makeToast("Price should be atleast 1")
        
                    }
                    else if (currncyStr == "₹" && priceStr! >= 0 && priceStr! < 50){
                        //if(priceStr! >= 0 && priceStr! < 50){
                            self.view.makeToast("Price should be atleast 50")
        
                        //}
                    }
                    else{
                        self.callsaveapi()
                    }
        }
            }
            else
            {
                self.callsaveapi()
            }
       }
        else{
            self.callsaveapi()
        }
                    
    }
    
    func callsaveapi(){

            if getReachabilityStatus(){
                if(UserModel.sharedInstance().countryServiceName == "" || UserModel.sharedInstance().countryServiceName == nil){
                }
    
                let parameters = [
                    "usertype":"\(UserModel.sharedInstance().userType!)",
                    "userid":"\(UserModel.sharedInstance().userId!)",
                    "token":"\(UserModel.sharedInstance().token!)",
                    "genre_ids":"\(self.genreIds)",
                    "city":"\(djCurrentCity)",
                    "state":"",
                    "state_code":"",
                    "country":getCountry!,
                    "postalcode":"110062",
                    "profileid":"\(UserModel.sharedInstance().userId!)",
                    "username":"\(vwProfilePage?.usernameTxtFld.text ?? "")",
                    "bio":"\(djYourBio)",
                    "latitude":"\(getLatVal ?? 0.0)",
                    "longitude":"\(getLongVal ?? 0.0)",
                    // now commented
                    "facebook_link":"\(vwProfilePage?.tfFacebookLink.text ?? "")",
                    "twitter_link":"\(vwProfilePage?.tfTwitterLink.text ?? "")",
                    "instagram_link":"\(vwProfilePage?.tfInstagramLink.text ?? "")",
                    "youtube_link":"",
                    "media_audio_name":"",
                    "dj_feedback":"\(vwServicePage!.textViewFeedBackDetail.text ?? "")",
                    "dj_feedback_status":"\(vwServicePage!.feedbackStatus)",
                    "dj_feedback_currency":"\(vwServicePage!.feedback_currency_name)",
                    "dj_feedback_price":"\(vwServicePage!.textFieldFeedbackPrice.text ?? "")",
                    "is_dj_feedback_varying":"0",
                    "dj_feedback_range1":"0",
                    "dj_feedback_range2":"0",
                    "dj_drops":"",
                    "dj_drops_status":"off",
                    "dj_drops_currency":"INR",
                    "dj_drops_price":"0",
                    "is_dj_drop_varying":"0",
                    "dj_drop_range1":"0",
                    "dj_drop_range2":"0",
                    "dj_remix":"",
                    "dj_remix_status":"",
                    "dj_remix_currency":"",
                    "dj_remix_price":"0",
                    "is_dj_remix_varying" : "0",
                    "dj_remix_range1":"0",
                    "dj_remix_range2":"0",
                ]
                Loader.shared.show()
                print("EditProfile:",parameters)
                let profileImage = self.profileImgVw.image?.jpegData(compressionQuality: 0.5) //now
                let serviceURL = URL(string: "\(webservice.url)\(webservice.saveProfileAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
                Alamofire.upload(multipartFormData: { (multipartFormData) in

                    if profileImage != nil {
                        multipartFormData.append(profileImage!, withName: "profile_image",fileName: "image.png", mimeType: "image/png")
                    } // now

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
                                if(self.isProfileImgSelected == true){
                                    self.view.makeToast("Profile Pic is updated")
                                }
                    
                    let editProfileModel = response.result.value!
                    if editProfileModel.success == 1{
                        
                        self.view.makeToast(editProfileModel.message)
                        if UserModel.sharedInstance().finishProfile == true{
                            self.changeRoot()
                        }else{
                            self.btnClose_Action(UIButton())
                        }
                        UserModel.sharedInstance().finishProfile = false
                       // UserModel.sharedInstance().genereList = self.vwProfilePage!.textfieldMusicgenre.text! // now coomntd
                        UserModel.sharedInstance().genereList = UserModel.sharedInstance().genrePro
                       // UserModel.sharedInstance().uniqueUserName = self.vwProfilePage!.textfieldDjname.text! // now coomntd
                       // UserModel.sharedInstance().bioServiceName = self.vwProfilePage!.textfieldYourBio.text! // now coomntd
                        UserModel.sharedInstance().uniqueUserName = self.vwProfilePage?.usernameTxtFld.text
                        NotificationCenter.default.post(name: Notification.Name("userNameNotify"), object: nil)
                       
                        UserModel.sharedInstance().countryServiceName = self.djCurrentCity
                        globalObjects.shared.profileCompleted = true
                        UserModel.sharedInstance().synchroniseData()
                        
                        self.callGetProfileWebService()
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                            self.navigationController?.popToRootViewController(animated: false)
                            self.changeRoot()
                                })
                        
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
    
    func callEditService(){
        if(buttonSelected == "service"){
        if(vwServicePage!.feedbackStatus == "on" && vwServicePage!.textFieldFeedbackPrice.text == ""){
            self.view.makeToast("Please enter feedback price")
        }
        
//        if(vwServicePage!.textFieldFeedbackPrice.text != "" ){
       else if(vwServicePage!.feedbackStatus == "on" && vwServicePage!.textFieldFeedbackPrice.text != ""){
            let priceStr = Int(vwServicePage!.textFieldFeedbackPrice.text!)
        let currncyStr = "\(UserModel.sharedInstance().userCurrency!)"
            if(currncyStr == "$" && priceStr! >= 0 && priceStr! < 1){
                    self.view.makeToast("Price should be atleast 1")
                    
            }
            else if (currncyStr == "₹" && priceStr! >= 0 && priceStr! < 50){
                //if(priceStr! >= 0 && priceStr! < 50){
                    self.view.makeToast("Price should be atleast 50")
                    
                //}
            }
            
                else{
                    if getReachabilityStatus() {
                        let requestUrl = "\(webservice.url)\(webservice.editProfileServiceAPI)"
                        let parameters = [
                            "profileid":"\(UserModel.sharedInstance().userId!)",
                            "token":"\(UserModel.sharedInstance().token!)",
                            "dj_feedback":"\(vwServicePage!.textViewFeedBackDetail.text!)",
                            "dj_feedback_status":"\(vwServicePage!.feedbackStatus)",
                            "dj_feedback_currency":"\(vwServicePage!.feedback_currency_name)",
                            "dj_feedback_price":"\(vwServicePage!.textFieldFeedbackPrice.text!)",
                            "dj_drops":"",//\(vwServicePage!.textViewDropDetail.text!)",
                            "dj_drops_status":"\(vwServicePage!.dropStatus)",
                            "dj_drops_currency":"\(vwServicePage!.drop_currency_name)",
                            "dj_drops_price":"\(vwServicePage!.textFieldDropPrice.text!)",
                            "dj_remix":"",//\(vwServicePage!.textViewRemixDetail.text!)",
                            "dj_remix_status":"\(vwServicePage!.remixStatus)",
                            "dj_remix_currency":"\(vwServicePage!.remix_currency_name)",
                            "dj_remix_price":"\(vwServicePage!.textFieldRemixPrice.text!)",
                            "usertype":"\(UserModel.sharedInstance().userType!)",
                            // for feedback varies use is_dj_feedback_varying = dj_feedback_varying
                            "is_dj_feedback_varying":"\(vwServicePage!.dj_feedback_varying)",
                            "dj_feedback_range1":"\(vwServicePage!.dj_feedback_range1)",
                            "dj_feedback_range2":"\(vwServicePage!.dj_feedback_range2)",
                            "dj_remix_range2":"\(vwServicePage!.dj_remix_range2)",
                            "dj_remix_range1":"\(vwServicePage!.dj_remix_range1)",
                            "is_dj_remix_varying":"\(vwServicePage!.dj_remix_varying)",
                            // for drop varies use is_dj_drop_varying = dj_drop_varying
                            "is_dj_drop_varying":"0",
                            "dj_drop_range1":"\(vwServicePage!.dj_drop_range1)",
                            "dj_drop_range2":"\(vwServicePage!.dj_drop_range2)"
                        ] as [String : String]
                        
                        Loader.shared.show()
                        Alamofire.request(getServiceURL(requestUrl), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { [self] (response:DataResponse<RegisterModel>) in
                            
                            switch response.result {
                            case .success(_):
                                Loader.shared.hide()
                                let registerModel = response.result.value!
                                if registerModel.success == 1{
                                    self.view.makeToast(registerModel.message)
                                    //self.btnClose_Action(UIButton())
                                    if(self.djCurrentCity != ""){
                                    UserModel.sharedInstance().countryServiceName = self.djCurrentCity
                                        UserModel.sharedInstance().feedbackDetail = "\(vwServicePage!.textViewFeedBackDetail.text!)"
                                        UserModel.sharedInstance().feedbackPrice = "\(vwServicePage!.textFieldFeedbackPrice.text!)"
                                    UserModel.sharedInstance().synchroniseData()
                                    }
                                    // navigate to screen after 2 seconds
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                        self.navigationController?.popViewController(animated: true)
                                            })
                                    
                                }else{
                                    Loader.shared.hide()
                                    self.view.makeToast(registerModel.message)
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
       else{
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//            self.navigationController?.popViewController(animated: true)
//                })
       }
        //
        }
        
    }
    //MARK:- NAVIAGTION METHODS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
extension GetProfileDataVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
       
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        profileImgVw.image = chosenImage //now
        setNewImg = chosenImage
        profileImgVw.contentMode = .scaleAspectFill //now
        isProfileImgSelected = true
        dismiss(animated: true, completion: nil)
    }
       
}
extension GetProfileDataVC: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        vwMediaPage!.songData = try! Data(contentsOf: url) as NSData
        vwMediaPage!.viewNameAudio.frame = CGRect(x: 0, y: (view.frame.height - vwMediaPage!.viewActionSheet.frame.height), width: view.frame.width, height: 250)
        vwMediaPage!.viewNameAudio.alpha = 0.0
        vwMediaPage!.viewAddAudioBlur.addSubview(vwMediaPage!.viewNameAudio)
        UIView.animate(withDuration: 1) {
            self.vwMediaPage!.viewNameAudio.alpha = 1.0
        }
        vwMediaPage!.lblDjName.text = UserModel.sharedInstance().uniqueUserName!
        vwMediaPage!.lblGenre.text = UserModel.sharedInstance().genereList!
        vwMediaPage!.preparePlayer(url)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        vwMediaPage!.viewAddAudioBlur.isHidden = true
        vwMediaPage!.mediaPageCalled()
    }
}
