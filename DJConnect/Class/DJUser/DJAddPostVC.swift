//
//  DJAddPostVC.swift
//  Json
//
//  Created by keshav on 19/12/19.
//  Copyright © 2019 keshav. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import AlamofireObjectMapper
import LocationPickerViewController
import MapKit

class adProjectGenrecell : UITableViewCell {
    @IBOutlet weak var lbl_genereName: UILabel!
    @IBOutlet weak var btn_check: UIButton!
}

class DJAddPostVC: UIViewController {
    
    @IBOutlet weak var currentDateLbl: UILabel!
    //MARK: - OUTLET
    
    @IBOutlet weak var txfProjectName: UITextField!
    //@IBOutlet weak var txfProjectEndDateTime: UITextField!
    @IBOutlet weak var txfProjectDetail: UITextView!
    @IBOutlet weak var txfProjectType: UITextField!
    @IBOutlet weak var txfExpactedAudiance: UITextField!
    @IBOutlet weak var txfVenueName: UITextField!
    @IBOutlet weak var txfEventDateTime: UITextField!
    @IBOutlet weak var txfStart: UITextField!
    //@IBOutlet weak var txfEnd: UITextField!
    @IBOutlet weak var txfVenueAddress: UITextField!
    @IBOutlet weak var txfCurrency: UITextField!
    @IBOutlet weak var txfRestriction: UITextField!
    @IBOutlet weak var txfSongGener: UITextField!
    @IBOutlet weak var txfAdditionalInfo: UITextView!
    @IBOutlet weak var btnProjectType: UIButton!
    @IBOutlet weak var btnRestriction: UIButton!
    @IBOutlet weak var btnGenres: UIButton!
    @IBOutlet weak var btnPost_Yes: UIButton!
    @IBOutlet weak var btnPost_No: UIButton!
    @IBOutlet weak var txtfPrice: textFieldProperties!
    @IBOutlet weak var vwRestrictionContainer: UIView!
    @IBOutlet weak var imgDjpostPhoto: UIImageView!
    
    //localize outlet
    @IBOutlet weak var btnPost: buttonProperties!
    @IBOutlet weak var lblprojTitle: UILabel!
    @IBOutlet weak var lblProjDetail: UILabel!
    @IBOutlet weak var lblProjInfo: UILabel!
    @IBOutlet weak var lblProjType: UILabel!
    @IBOutlet weak var lblExpectedAudi: UILabel!
    @IBOutlet weak var lblVenueInfo: UILabel!
    @IBOutlet weak var lblVenueName: UILabel!
    @IBOutlet weak var lblEvtDateTime: UILabel!
    @IBOutlet weak var lblStart: UILabel!
   // @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var lblVenueAdd: UILabel!
    @IBOutlet weak var lblDisplayAdd: UILabel!
    @IBOutlet weak var lblyes: UILabel!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblConnectInfo: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblrestriction: UILabel!
    @IBOutlet weak var lblSongGenre: UILabel!
    @IBOutlet weak var lblAdiInfo: UILabel!
    @IBOutlet weak var lblAdiInfoDetail: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblCurrencySymbol: UILabel!
    @IBOutlet weak var txfStartButton: UITextField!
    //@IBOutlet weak var txfEndButton: UITextField!
    @IBOutlet weak var cnsAddViewTop: NSLayoutConstraint!
    @IBOutlet weak var btnOffer_Yes: UIButton!
    @IBOutlet weak var btnOffer_No: UIButton!
    @IBOutlet weak var lblLo_AcceptOffer: UILabel!
    @IBOutlet weak var lblLo_OfferYes: UILabel!
    @IBOutlet weak var lblLo_OfferNo: UILabel!
    @IBOutlet weak var lblAddFryerImageInfo: UILabel!
    
    @IBOutlet weak var imgBgVw: UIView!
    
    
    //MARK: - GLOBAL VARIABLES
    var projectTypeInstance = DropDown()
    var restriction = DropDown()
    let picker : UIDatePicker = UIDatePicker()
    let picker1 : UIDatePicker = UIDatePicker()
    let picker2 : UIDatePicker = UIDatePicker()
    let picker3 : UIDatePicker = UIDatePicker()
    let picker4 : UIDatePicker = UIDatePicker()
    var dateSelected = String()
    var addFlag = String()
    var offerFlag = String()
    var currList = [CurrencyDataDetail]()
    var projectTypeList = [projectTypeDataDetail]()
    var postPicker: UIImagePickerController = UIImagePickerController()
    var projectTypeIndex = Int()
    var currencyIndex = String()
    var postDate = Date()
    var shortAdd = String()
    var longAdd = String()
    var fullAddress = String()
    var shortAddress = String()
    var projectId = String()
    var latitude = String()
    var longitude = String()
    var editfullAddress = String()
    var editsortAddress = String()
    var projecttypeName = String ()
    var genreNames = "Rock"
    var genreIds = "1"
    var newSelecttimee = String ()
    var newSelecttimeesec = String ()
    var sevenDaysfromNow: Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: 7, to: Date(), options: [])!
    }
    var strtxfEventDateTime = String()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLE.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callTimeZoneApi()
        if GlobalId.id == "1"{
            callEditWebService()
        }
        localizeElements()
        txfProjectType.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(genreList(_:)), name: Notification.Name(rawValue: "genreAddPost"), object: nil)
        
        projectTypeInstance.selectionAction = { [unowned self] (index: Int, item: String) in
            self.projectTypeIndex = index + 1
            if self.projectTypeInstance.selectedItem! == "Other"{
                self.txfProjectType.isUserInteractionEnabled = true
                self.txfProjectType.isEnabled = true
                self.txfProjectType.text = ""
            }else{
                self.txfProjectType.isEnabled = false
                self.txfProjectType.text = self.projectTypeInstance.selectedItem
            }
        }
        restriction.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txfRestriction.text = self.restriction.selectedItem
        }
        txfEventDateTime.delegate = self
        postPicker.delegate = self
        
        //currentDateLbl.text = Date().string(format: "MM/dd/yyyy")
        currentDateLbl.text = Date().string(format: "MMM d, yyyy")
        txfExpactedAudiance.keyboardType = .numberPad
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imgBgVw.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        callCurrencyListWebService()
        callProjectTypeWebService()
        picker1.minimumDate = postDate
        picker1.maximumDate = getMaximumDate(startDate: postDate, addbyUnit: .day, value: 7)
        if UserModel.sharedInstance().appLanguage == "0"{
            btnBack.setImage(UIImage(named: "back_arrow_arabic"), for: .normal)
        }else{
            btnBack.setImage(UIImage(named: "back_arrow_english"), for: .normal)
        }
    }
    
    //MARK: - OTHER METHODS
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            postPicker.allowsEditing = false
            postPicker.sourceType = UIImagePickerController.SourceType.camera
            postPicker.cameraCaptureMode = .photo
            present(postPicker, animated: true, completion: nil)
        }else{
            self.showAlertView("This device has no Camera", "Camera Not Found")
        }
    }
    
    func openGallary()
    {
        postPicker.allowsEditing = false
        postPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(postPicker, animated: true, completion: nil)
    }
    
    func getMinimumDate() -> Date{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return date
    }
    
    func getMaximumDate(startDate :Date?, addbyUnit:Calendar.Component, value : Int) -> Date {
        var dates = [Date]()
        var date = startDate!
        let endDate = Calendar.current.date(byAdding: addbyUnit, value: value, to: date)!
        while date < endDate {
            date = Calendar.current.date(byAdding: addbyUnit, value: 1, to: date)!
            dates.append(date)
        }
        return endDate
    }
    
    func localizeElements(){
        if GlobalId.id == "1" {
            lblAddFryerImageInfo.text = "Update Flyer of Project Photo"
            btnPost.setTitle("SAVE".localize, for: .normal)
        }else
        {
            lblAddFryerImageInfo.text = "Add a Flyer of Project Photo"
            btnPost.setTitle("POST".localize, for: .normal)
        }
        lblprojTitle.text = "project title".localize
        lblProjDetail.text = "project detail".localize
        lblProjInfo.text = "Project Info".localize
        lblProjType.text = "Project Type".localize
        lblExpectedAudi.text = "Expected Audience".localize
        lblVenueInfo.text = "Venue Info".localize
        lblVenueName.text = "Name of Venue".localize
        lblEvtDateTime.text = "Event Date and Time".localize
        lblStart.text = "Start".localize
       // lblEnd.text = "End".localize
        lblVenueAdd.text = "Venue Address".localize
        lblDisplayAdd.text = "Display Address?".localize
        lblyes.text = "YES".localize
        lblNo.text = "NO".localize
        lblConnectInfo.text = "connect Info".localize
        lblCurrency.text = "Currency".localize
        lblrestriction.text = "Restriction".localize
        lblSongGenre.text = "song Genre".localize
        lblAdiInfo.text = "additional info".localize
        lblAdiInfoDetail.text = "Additional Info text".localize
       // lblLo_AcceptOffer.text = "Accept_Offer_Text".localize
        //lblLo_OfferYes.text = "YES".localize
        //lblLo_OfferNo.text = "NO".localize
    }
    
    func showStartDatePicker(){
        if #available(iOS 13.4, *) {
            picker1.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        //Formate Date
        picker1.frame = CGRect(x:0, y: self.view.frame.height-picker1.frame.height, width: picker1.frame.width, height: picker1.frame.height)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolbar.backgroundColor = #colorLiteral(red: 0.768627451, green: 0, blue: 0.4901960784, alpha: 1)
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action:#selector(startDateTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        picker1.datePickerMode = .dateAndTime
        txfStartButton.inputAccessoryView = toolbar
        txfStartButton.inputView = picker1
    }
    
//    func showEndDatePicker(){
//        if #available(iOS 13.4, *) {
//            picker2.preferredDatePickerStyle = UIDatePickerStyle.wheels
//        }
//        //Formate Date
//        picker2.frame = CGRect(x:0, y: self.view.frame.height-picker2.frame.height, width: picker2.frame.width, height: picker2.frame.height)
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        toolbar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        toolbar.backgroundColor = #colorLiteral(red: 0.768627451, green: 0, blue: 0.4901960784, alpha: 1)
//        //done button & cancel button
//        //let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action:#selector(endTimePicker))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
//        //toolbar.setItems([cancelButton,spaceButton,doneButton,], animated: false)
//        picker2.datePickerMode = .time
//        picker2.minimumDate = picker1.date
//       // txfEndButton.inputAccessoryView = toolbar
//        //txfEndButton.inputView = picker2
//    }
    
    func backTwo() {
        UserModel.sharedInstance().isPin = false
        UserModel.sharedInstance().synchroniseData()
        let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = homeSB.instantiateViewController(withIdentifier: "CalendarVC") as? CalendarVC
        sideMenuController()?.setContentViewController(next1!)
    }
    
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "HH:mm"
        
        guard let time1 = timeformatter.date(from: time1Str),
              let time2 = timeformatter.date(from: time2Str) else { return "" }
        
        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        return "\(Int(hour)):\(Int(minute))"
    }
    
    func convertIntoMinute(_time : String) -> Int{
        let apitimeFormatter = DateFormatter()
        apitimeFormatter.timeStyle = .short
        apitimeFormatter.dateFormat = "HH:mm"
        let apiTime = apitimeFormatter.date(from: _time)
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.hour, .minute], from: apiTime!)
        let hour = comp.hour ?? 0
        let minute = comp.minute ?? 0
        let finalMinute:Int = (hour * 60) + minute
        return finalMinute
    }
    
    //MARK: - SELECTOR METHODS
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
//    @objc func projectDateTime(sender: UIDatePicker){
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = .short
//        dateFormatter.dateStyle = .medium
//        txfProjectEndDateTime.text = dateFormatter.string(from: picker.date)
//        print("txfProjectEndDateTime", txfProjectEndDateTime.text)
//        picker.removeFromSuperview()
//    }
    @objc func timeStart(sender: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateFormat = "h:mm a"
        txfStart.text = timeFormatter.string(from: picker1.date)
        print("txfStart", txfStart.text)
        picker1.minimumDate = postDate
        picker1.maximumDate = getMaximumDate(startDate: postDate, addbyUnit: .day, value: 7)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MM/dd/yyyy"
        strtxfEventDateTime = dateFormatter.string(from: picker1.date)
        
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateStyle = .medium
        dateFormatterr.dateFormat = "MMM d, yyyy"
        txfEventDateTime.text = dateFormatterr.string(from: picker1.date)
        print("txfEventDateTime", txfEventDateTime.text)
        picker1.removeFromSuperview()
    }
    
//    @objc func timeEnd(sender: UIDatePicker){
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = .short
//        dateFormatter.dateFormat = "h:mm a"
//        txfEnd.text = dateFormatter.string(from: picker2.date)
//        print("txfEnd", txfEnd.text)
//        picker2.removeFromSuperview()
//    }
    
    @objc func eventDateTime(sender: UIDatePicker){
        if #available(iOS 13.4, *) {
            picker3.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd MMM , yyyy"
        txfEventDateTime.text = dateFormatter.string(from: picker3.date)
        print("txfEventDateTime", txfEventDateTime.text)
        picker3.removeFromSuperview()
    }
    
    @objc func startDateTimePicker(){
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateFormat = "h:mm a"
        txfStart.text = timeFormatter.string(from: picker1.date)
        picker1.minimumDate = postDate
        picker1.maximumDate = getMaximumDate(startDate: postDate, addbyUnit: .day, value: 7)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MM/dd/yyyy"
        strtxfEventDateTime = dateFormatter.string(from: picker1.date)
        
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateStyle = .medium
        dateFormatterr.dateFormat = "MMM d, yyyy"
        txfEventDateTime.text = dateFormatterr.string(from: picker1.date)
        print("txfEventDateTime1", txfEventDateTime.text)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat =  "MM/dd/yyyy"
        let currDate =  "\(formatter.string(from: date))"
        
        let currtime = Date()
        let newtimeFormatter = DateFormatter()
        newtimeFormatter.timeStyle = .short
        newtimeFormatter.dateFormat = "HH:mm"
        let newCurrtime = newtimeFormatter.string(from: currtime)
        
        let selecttimeFormatter = DateFormatter()
        selecttimeFormatter.timeStyle = .short
        selecttimeFormatter.dateFormat = "HH:mm"
        let newSelecttime = selecttimeFormatter.string(from: picker1.date)
        
        let selectStarttimeFormatter = DateFormatter()
        selectStarttimeFormatter.timeStyle = .short
        selectStarttimeFormatter.dateFormat = "HH:mm"
        let newStartSelecttime = selectStarttimeFormatter.string(from: picker2.date)
        
        
        
//        if currDate == txfEventDateTime.text{
        if currDate == strtxfEventDateTime{
            let result = findDateDiff(time1Str: newCurrtime, time2Str: newSelecttime)
            if newCurrtime > newSelecttime{
                let checkApiTime = convertIntoMinute(_time: UserModel.sharedInstance().remainingTime!)
                self.view.makeToast("Your project cannot be posted because your event starts within the limits set by admin (less than \(checkApiTime) minutes from now).")
                txfEventDateTime.text?.removeAll()
                txfStart.text?.removeAll()
            }else{
                let apiTime = convertIntoMinute(_time: UserModel.sharedInstance().remainingTime!)
                let userTimeDiff = convertIntoMinute(_time: result)
                if userTimeDiff < apiTime{
                    self.view.makeToast("Your project cannot be posted because your event starts within the limits set by admin (less than \(apiTime) minutes from now).")
                    txfEventDateTime.text?.removeAll()
                    txfStart.text?.removeAll()
                }
            }
        }
        self.view.endEditing(true)
    }
    
//    @objc func endTimePicker(){
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = .short
//        dateFormatter.dateFormat = "h:mm a"
//        txfEnd.text = dateFormatter.string(from: picker2.date)
//        self.view.endEditing(true)
//    }
    
    @objc func genreList(_ notification : Notification){
        guard let names = notification.userInfo?["names"] as? String else { return }
        guard let ids = notification.userInfo?["ids"] as? String else { return }
        self.genreNames = names
        self.genreIds = ids
        txfSongGener.text = self.genreNames
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - ACTIONS
    @IBAction func btnBack_Action(_ sender: UIButton) {
        txfVenueAddress.text = ""
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPost_Action(_ sender: UIButton) {
        txfProjectName.resignFirstResponder()
        
        txfProjectDetail.resignFirstResponder()
        txfProjectType.resignFirstResponder()
        txfExpactedAudiance.resignFirstResponder()
        txfVenueName.resignFirstResponder()
        txfEventDateTime.resignFirstResponder()
        txfStart.resignFirstResponder()
       // txfEnd.resignFirstResponder()
        txfVenueAddress.resignFirstResponder()
        txfRestriction.resignFirstResponder()
        txfSongGener.resignFirstResponder()
        txfCurrency.resignFirstResponder()
        txtfPrice.resignFirstResponder()
        txfAdditionalInfo.resignFirstResponder()
        
        let selecttimeFormatter = DateFormatter()
        selecttimeFormatter.timeStyle = .short
        selecttimeFormatter.dateFormat = "HH:mm"
        newSelecttimee = selecttimeFormatter.string(from: picker1.date)
        
        let selecttimeForma = DateFormatter()
        selecttimeForma.timeStyle = .short
        selecttimeForma.dateFormat = "HH:mm:ss"
        newSelecttimeesec = selecttimeForma.string(from: picker1.date)
        
        let selectStarttimeFormatter = DateFormatter()
        selectStarttimeFormatter.timeStyle = .short
        selectStarttimeFormatter.dateFormat = "HH:mm"
        let newStartSelecttimee = selectStarttimeFormatter.string(from: picker2.date)
        
        print("newSelecttimee", newSelecttimee)
        print("newSelecttimeesec", newSelecttimeesec)
        print("newStartSelecttimee", newStartSelecttimee)
        
        let isImageUploaded = imgDjpostPhoto.image?.isEqualToImage(#imageLiteral(resourceName: "djCrowd"))
        if (txfProjectName.text?.isEmpty == true){
            self.view.makeToast("Enter Project Title".localize)
        }
//        else if newSelecttimee > newStartSelecttimee{
//            self.view.makeToast("Start time cann't greater than end time")
//        }
        else if(txfProjectDetail.text.isEmpty == true){
            self.view.makeToast("Enter Project Detail".localize)
        }else if(txfProjectType.text?.isEmpty == true){
            self.view.makeToast("Enter Project Type".localize)
        }else if(txfExpactedAudiance.text?.isEmpty == true){
            self.view.makeToast("Enter Expected Audiance".localize)
        }else if(txfVenueName.text?.isEmpty == true){
            self.view.makeToast("Enter Venue Name".localize)
        }else if(txfEventDateTime.text?.isEmpty == true){
            self.view.makeToast("Enter Date and Time".localize)
        }else if(txfStart.text?.isEmpty == true){
            self.view.makeToast("Enter Start Time".localize)
        }
//        else if(txfEnd.text?.isEmpty == true){
//            self.view.makeToast("Enter End Time".localize)
//        }
        else if(txfVenueAddress.text?.isEmpty == true){
            self.view.makeToast("Enter Venue Address".localize)
        }else if(txfRestriction.text?.isEmpty == true){
            self.view.makeToast("Enter Restriction".localize)
        }else if isImageUploaded!{
            self.view.makeToast("Please select Flyer to continue")
        }else if(txfSongGener.text?.isEmpty == true){
            self.view.makeToast("Enter Song Genre".localize)
        }else if(txfCurrency.text?.isEmpty == true){
            self.view.makeToast("Enter Currency".localize)
        }else if(txtfPrice.text?.isEmpty == true){
            self.view.makeToast("Enter Price".localize)
        }
        
        else if addFlag.isEmpty{
            self.view.makeToast("Select display address")
        }
//        else if offerFlag.isEmpty{
//            self.view.makeToast("Select accept offers from artists")
//        }
        
        
        else{
            if GlobalId.id == "1" {
                if(txtfPrice.text?.isEmpty != true && UserModel.sharedInstance().userCurrency == "₹"){
                    let txtPrice = txtfPrice.text
                    let setSprice = Int(txtPrice!)
                    if(setSprice! < 50){
                        self.view.makeToast("Price atleast ₹50".localize)
                    }
                    else{
                        callSaveProjectWebService()
                    }
                }
                else if(txtfPrice.text?.isEmpty != true){
                    let txtPrice = txtfPrice.text
                    let setSprice = Int(txtPrice!)
                    if(setSprice! < 1){
                        self.view.makeToast("Price atleast $1".localize)
                    }
                    else{
                        callSaveProjectWebService()
                    }
                }
            }else
            {
                if(txtfPrice.text?.isEmpty != true && UserModel.sharedInstance().userCurrency == "₹"){
                    let txtPrice = txtfPrice.text
                    let setSprice = Int(txtPrice!)
                    if(setSprice! < 50){
                        self.view.makeToast("Price atleast ₹50".localize)
                    }
                    else{
                    callPostProjectWebService()
                    }
                }
                else if(txtfPrice.text?.isEmpty != true){
                    let txtPrice = txtfPrice.text
                    let setSprice = Int(txtPrice!)
                    if(setSprice! < 1){
                        self.view.makeToast("Price atleast $1".localize)
                    }
                    else{
                    callPostProjectWebService()
                    }
                }
                
            }
        }
    }
    
//    @IBAction func btnProjectEndDateTimeClick(_ sender: UIButton) {
//        picker.datePickerMode = UIDatePicker.Mode.dateAndTime
//        picker.addTarget(self, action: #selector(projectDateTime(sender:)), for: UIControl.Event.valueChanged)
//        picker.frame = CGRect(x:0, y:self.view.frame.height-picker.frame.height, width:self.view.frame.width, height:250)
//        picker.backgroundColor = UIColor.lightGray
//        self.view.addSubview(picker)
//    }
    
    @IBAction func btnStartClick(_ sender: UIButton) {
        picker1.datePickerMode = UIDatePicker.Mode.dateAndTime
        picker1.addTarget(self, action: #selector(timeStart(sender:)), for: UIControl.Event.valueChanged)
        picker1.frame = CGRect(x:0, y:self.view.frame.height-picker1.frame.height, width:self.view.frame.width, height:250)
        picker1.backgroundColor = UIColor.lightGray
        self.view.addSubview(picker1)
    }
    
    
//    @IBAction func btnEndClick(_ sender: UIButton) {
//        picker2.datePickerMode = UIDatePicker.Mode.time
//        picker2.addTarget(self, action: #selector(timeEnd(sender:)), for: UIControl.Event.valueChanged)
//        picker2.frame = CGRect(x:0, y:self.view.frame.height-picker2.frame.height, width:self.view.frame.width, height:250)
//        picker2.backgroundColor = UIColor.lightGray
//        self.view.addSubview(picker2)
//    }
    
    @IBAction func txfEventDateTime(_ sender: UITextField) {
        
    }
    
    @IBAction func btnProjectTypeClick(_ sender: UIButton) {
        projectTypeInstance.anchorView = btnProjectType
        projectTypeInstance.width = 160
        projectTypeInstance.show()
        projectTypeInstance.direction = .any
        projectTypeInstance.bottomOffset = CGPoint(x: -txfProjectType.frame.width + 10, y: 38)
    }
    
    @IBAction func btnRestrictionClick(_ sender: UIButton) {
        restriction.anchorView = btnRestriction
        restriction.dataSource = ["No Restrictions (Explicit songs accepted)","No Restrictions (No time limit for song)","Restriction (No explicit material)","Restriction (Time limit for song)"]
        restriction.width = vwRestrictionContainer.frame.size.width
        restriction.show()
        restriction.direction = .any
        restriction.bottomOffset = CGPoint(x: -txfRestriction.frame.width + 10, y: 38)
    }
    
    @IBAction func btnGenresClick(_ sender: UIButton) {
        let homeSB = UIStoryboard(name: "AddProject", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GerneSelectorVC") as! GerneSelectorVC
        desiredViewController.oldSelectedIds = self.genreIds
        desiredViewController.notificationName = "genreAddPost"
        desiredViewController.view.frame = (self.view.bounds)
        self.view.addSubview(desiredViewController.view)
        self.addChild(desiredViewController)
        desiredViewController.didMove(toParent: self)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        
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
    
    @IBAction func btnAddProjectPhoto(_ sender: UIButton) {
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
    
    @IBAction func btnPostYesAction(_ sender: UIButton) {
        addFlag = "yes"
        btnPost_Yes.setImage(UIImage(named: "post_yes"), for: .normal)
        btnPost_No.setImage(UIImage(named: "post_no"), for: .normal)
    }
    
    @IBAction func btnPostNoAction(_ sender: UIButton) {
        addFlag = "no"
        btnPost_Yes.setImage(UIImage(named: "post_no"), for: .normal)
        btnPost_No.setImage(UIImage(named: "post_yes"), for: .normal)
    }
    
    @IBAction func btnOfferYesAction(_ sender: UIButton) {
        //offerFlag = "yes"
//        btnOffer_Yes.setImage(UIImage(named: "post_yes"), for: .normal)
//        btnOffer_No.setImage(UIImage(named: "post_no"), for: .normal)
    }
    
    @IBAction func btnOfferNoAction(_ sender: UIButton) {
       // offerFlag = "no"
//        btnOffer_Yes.setImage(UIImage(named: "post_no"), for: .normal)
//        btnOffer_No.setImage(UIImage(named: "post_yes"), for: .normal)
    }
    
    
    @IBAction func btnVenue_Action(_ sender: UIButton) {
        self.fullAddress = ""
        self.shortAddress = ""
        let locationPicker = LocationPicker()
        locationPicker.tableView.tableFooterView = UIView()
        //self.tableView.tableFooterView = UIView()
        locationPicker.pickCompletion = { (pickedLocationItem) in
            let lat = pickedLocationItem.coordinate?.latitude
            let lon = pickedLocationItem.coordinate?.longitude
            if let street = pickedLocationItem.addressDictionary!["Street"]{
                self.fullAddress.append(street as! String + ", ")
            }
            if let city = pickedLocationItem.addressDictionary!["City"]{
                self.fullAddress.append(city as! String + ", ")
                self.shortAddress.append(city as! String + ", ")
            }
//            if let zipCode = pickedLocationItem.addressDictionary!["ZIP"]{
//                self.fullAddress.append(zipCode as! String + ", ")
//            }
            if let state = pickedLocationItem.addressDictionary!["State"]{
                self.fullAddress.append(state as! String + ", ")
                self.shortAddress.append(state as! String + ", ")
            }
            if let country = pickedLocationItem.addressDictionary!["Country"]{
                self.fullAddress.append(country as! String)
                self.shortAddress.append(country as! String)
            }
            print(self.fullAddress)
            self.txfVenueAddress.text = self.fullAddress
            if GlobalId.id == "1"{
                self.longitude = "\(lat!)"
                self.latitude = "\(lon!)"
                GlobalId.locationid = "1"
            }else{
                globalObjects.shared.projLat = lat
                globalObjects.shared.projLong = lon
            }
        }
        locationPicker.addBarButtons()
        // Call this method to add a done and a cancel button to navigation bar.
        let navigationController = UINavigationController(rootViewController: locationPicker)
        present(navigationController, animated: true, completion: nil)
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
            print("timezone_parameters:",parameters)
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
    
    //MARK: - WEBSERVICES
    func callPostProjectWebService(){
        if getReachabilityStatus(){
            if addFlag == "yes"{
                txfVenueAddress.text = fullAddress
            }else{
                txfVenueAddress.text = shortAddress
            }
            var sendDate = String()
            if dateSelected != "" {
                let formatter = DateFormatter()
                formatter.dateFormat =  "MMM d, yyyy"
                let date = formatter.date(from: dateSelected)
                formatter.dateFormat = "yyyy-MM-dd"
                sendDate = formatter.string(from: date!).localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                sendDate = formatter.string(from: Date ()).localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
            }
            
            //get current time
            var currTime = String()
            let currTimeformatter = DateFormatter()
            currTimeformatter.dateFormat = "HH:mm:ss"
            currTime = currTimeformatter.string(from: Date()).localToUTC(incomingFormat: "HH:mm:ss", outGoingFormat: "HH:mm:ss")
            
            //start time conversion
            let startdateFormatter = DateFormatter()
            startdateFormatter.dateFormat = "HH:mm"
            let startDate24 = startdateFormatter.string(from: picker1.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm") // right converion ashitesh
            //let startDate24 = startdateFormatter.string(from: picker1.date).UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")
            //self.RemainingTimeArray.append(projectLis[i].closing_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss"))
            
            //end time conversion
            let enddateFormatter = DateFormatter()
            enddateFormatter.dateFormat = "HH:mm"
            let endDate24 = enddateFormatter.string(from: picker2.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")
            print("txfStart.text",txfStart.text)
            print("startDate24",startDate24)
            print("endDate24",endDate24)
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "project_title":"\(txfProjectName.text!)",
                "project_description":"\(txfProjectDetail.text!)",
                "project_type":"\(projectTypeIndex)",
                "project_type_other":"\(txfProjectType.text!)",
                "expected_audiance":"\(txfExpactedAudiance.text!)",
                "venue_name":"\(txfVenueName.text!)",
//                "event_date":"\(txfEventDateTime.text!)",
                "event_date":"\(strtxfEventDateTime)",
                //"event_start_time":"\(startDate24)",
                "event_start_time":"\(newSelecttimee)",
                //"event_end_time":"\(endDate24)",
                //"event_end_time":"\(newSelecttimee)",
                "venue_address":"\(txfVenueAddress.text!)",
                "venue_address_status":"\(addFlag)",
                "currency":"\(currencyIndex)",
                "latitude":"\(globalObjects.shared.projLat!)",
                "longitude":"\(globalObjects.shared.projLong!)",
                "price":"\(txtfPrice.text!)",
                "restrications":"\(txfRestriction.text!)",
                "genre_id":"\(self.genreIds)",
                "special_Information":" \(txfAdditionalInfo.text!)",
//                "project_date":"\(sendDate), \(currTime)",
                "project_date":"\(sendDate)",
                //"project_date":"\(sendDate), \(newSelecttimeesec)",
//                "artist_offer":"\(offerFlag)"
                "artist_offer":"no"
                
            ]
            
            let headers: HTTPHeaders =
                ["Content-type": "multipart/form-data",
                 "Accept": "application/json"]
            
            Loader.shared.show()
            let profileImage = self.imgDjpostPhoto.image?.jpegData(compressionQuality: 0.4)
            let serviceURL = URL(string: "\(webservice.url)\(webservice.addDjProjectAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            print("addpost",parameters)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                if profileImage != nil {
                    multipartFormData.append(profileImage!, withName: "project_image",fileName: "image.png", mimeType: "image/png")
                }
                
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            },usingThreshold: UInt64.init(), to: serviceURL, method: .post, headers: headers) { (result) in
                switch result {
                case .success(let upload,_,_):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    upload.responseString { response in
                        Loader.shared.hide()
                       // print("completed \(response.value!)")
                    
                        self.view.makeToast("New project created successfully")
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.backTwo()
                        })
                        //self.backTwo()
                    }
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
    
    func callCurrencyListWebService(){
//        if(UserModel.sharedInstance().currency_name == ""){
//            if(UserModel.sharedInstance().setCurrencyNameSt == "$"){
//                UserModel.sharedInstance().currency_name = "$"
//            }
//            else{
//                UserModel.sharedInstance().currency_name = "₹"
//            }
//        }
        
        if(UserModel.sharedInstance().currency_name == ""){
            self.txfCurrency.text = "USD"
            self.lblCurrencySymbol.text = "$"
            UserModel.sharedInstance().currency_name = "USD"
            UserModel.sharedInstance().userCurrency = "$"
            UserModel.sharedInstance().currency_id  = "1"
            self.currencyIndex = "1"
            UserModel.sharedInstance().synchroniseData()
        }
        else{
        if(UserModel.sharedInstance().currency_name == "IN"){
            UserModel.sharedInstance().currency_name = "INR"
            self.txfCurrency.text = "INR"
        }
        else{
        self.txfCurrency.text = UserModel.sharedInstance().currency_name
        }
        self.lblPrice.text = "Price(" + self.txfCurrency.text! + ")"
        self.lblCurrencySymbol.text = UserModel.sharedInstance().userCurrency
        
        print("currency",UserModel.sharedInstance().currency_id ?? "")
        self.currencyIndex = UserModel.sharedInstance().currency_id ?? ""
        }
    }
    
    func callEditWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            projectId = GlobalId.ProjectDetailsId
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        self.setProjectDetail(detailProject: detailProject)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(detailProject.message)
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
    
    func setProjectDetail(detailProject: ProjectDetailModel){
        txfProjectName.text = detailProject.projectDetails![0].title
        txfProjectDetail.text = detailProject.projectDetails![0].project_description
        txfProjectType.text = detailProject.projectDetails![0].project_info_type
        projecttypeName = detailProject.projectDetails![0].project_info_type!
        txfExpactedAudiance.text =
            detailProject.projectDetails![0].project_info_audiance
        txfVenueName.text =  detailProject.projectDetails![0].venue_name
        txfEventDateTime.text =  detailProject.projectDetails![0].event_date
        
        let startdateFormatter = DateFormatter()
        startdateFormatter.dateFormat = "HH:mm"
        let startDate24 = startdateFormatter.string(from: picker1.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")
        
        //end time conversion
        let enddateFormatter = DateFormatter()
        enddateFormatter.dateFormat = "HH:mm"
        let endDate24 = enddateFormatter.string(from: picker2.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")
        txfStart.text = detailProject.projectDetails![0].event_start_time!.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
       // txfEnd.text = detailProject.projectDetails![0].event_end_time!.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
        txfVenueAddress.text = detailProject.projectDetails![0].venue_address
        latitude = detailProject.projectDetails![0].latitude!
        longitude = detailProject.projectDetails![0].longitude!
        txfCurrency.text = "INR"
        txtfPrice.text = detailProject.projectDetails![0].price
        txfRestriction.text = detailProject.projectDetails![0].regulation
        self.genreNames = detailProject.projectDetails![0].genre ?? "Rock"
        self.genreIds = detailProject.projectDetails![0].genre_ids ?? "1"
        txfSongGener.text = self.genreNames
        txfAdditionalInfo.text = detailProject.projectDetails![0].special_Information
        self.imgDjpostPhoto.kf.setImage(with: URL(string: (detailProject.projectDetails![0].project_image)!), placeholder: UIImage(named: "djCrowd"),  completionHandler: nil)
        getAddressFromLatLon()
        callProjectTypeWebService()
        if detailProject.projectDetails![0].venue_address_status == "yes" {
            addFlag = "yes"
            btnPost_Yes.setImage(UIImage(named: "post_yes"), for: .normal)
            btnPost_No.setImage(UIImage(named: "post_no"), for: .normal)
        }else{
            addFlag = "no"
            btnPost_Yes.setImage(UIImage(named: "post_no"), for: .normal)
            btnPost_No.setImage(UIImage(named: "post_yes"), for: .normal)
        }
        if detailProject.projectDetails![0].artist_offer == "1" {
            offerFlag = "yes"
//            btnOffer_Yes.setImage(UIImage(named: "post_yes"), for: .normal)
//            btnOffer_No.setImage(UIImage(named: "post_no"), for: .normal)
            
        }else{
            offerFlag = "no"
//            btnOffer_Yes.setImage(UIImage(named: "post_no"), for: .normal)
//            btnOffer_No.setImage(UIImage(named: "post_yes"), for: .normal)
        }
        
    }
    
    func getAddressFromLatLon() {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(latitude)")!
        //21.228124
        let lon: Double = Double("\(longitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country)
                                            print(pm.locality)
                                            print(pm.subLocality)
                                            print(pm.thoroughfare)
                                            print(pm.postalCode)
                                            print(pm.subThoroughfare)
                                            
                                            var addressSort : String = ""
                                            
                                            if pm.thoroughfare != nil {
                                                addressSort = addressSort + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressSort = addressSort + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressSort = addressSort + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressSort = addressSort + pm.postalCode! + " "
                                            }
                                            print(addressSort)
                                            self.editsortAddress = addressSort
                                            var addressString : String = ""
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                addressString = addressString + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressString = addressString + pm.postalCode! + " "
                                            }
                                            self.editfullAddress = addressString
                                            print(addressString)
                                        }
                                    })
        
    }
    
    func callSaveProjectWebService(){
        if getReachabilityStatus(){
            
            if txfVenueAddress.text != nil && GlobalId.locationid == "0"{
                if addFlag == "yes"{
                    txfVenueAddress.text = editfullAddress
                }else{
                    txfVenueAddress.text = editsortAddress
                }
            }else{
                
                if addFlag == "yes"{
                    txfVenueAddress.text = fullAddress
                }else{
                    txfVenueAddress.text = shortAddress
                }
            }
            
            var sendDate = String()
            
            if dateSelected != "" {
                let formatter = DateFormatter()
                formatter.dateFormat =  "MMM d, yyyy"
                let date = formatter.date(from: dateSelected)
                formatter.dateFormat = "yyyy-MM-dd"
                sendDate = formatter.string(from: date!).localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
            }else{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                sendDate = formatter.string(from: Date ()).localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
            }
            
            //get current time
            var currTime = String()
            let currTimeformatter = DateFormatter()
            currTimeformatter.dateFormat = "HH:mm:ss"
            currTime = currTimeformatter.string(from: Date()).localToUTC(incomingFormat: "HH:mm:ss", outGoingFormat: "HH:mm:ss")
            
            //start time conversion
            let startdateFormatter = DateFormatter()
            startdateFormatter.dateFormat = "HH:mm"
            let startDate24 = startdateFormatter.string(from: picker1.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")
            
            //end time conversion
            let enddateFormatter = DateFormatter()
            enddateFormatter.dateFormat = "HH:mm"
            let endDate24 = enddateFormatter.string(from: picker2.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")
            
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "project_title":"\(txfProjectName.text!)",
                "project_description":"\(txfProjectDetail.text!)",
                "project_type":"\(projectTypeIndex)",
                "project_type_other":"\(txfProjectType.text!)",
                "expected_audiance":"\(txfExpactedAudiance.text!)",
                "venue_name":"\(txfVenueName.text!)",
//                "event_date":"\(txfEventDateTime.text!)",
                "event_date":"\(strtxfEventDateTime)",
                //"event_start_time":"\(startDate24)",
                "event_start_time":"\(newSelecttimee)",
               // "event_end_time":"\(endDate24)",
                "venue_address":"\(txfVenueAddress.text!)",
                "venue_address_status":"\(addFlag)",
                "currency":"\(currencyIndex)",//currencyIndex
                "latitude":"\(latitude)",
                "longitude":"\(longitude)",
                "price":"\(txtfPrice.text!)",
                "restrications":"\(txfRestriction.text!)",
                "genre_id":"\(self.genreIds)",
                "special_Information":" \(txfAdditionalInfo.text!)",
                "project_date":"\(sendDate)",
//                "artist_offer":"\(offerFlag)",
                "artist_offer":"no",
                "project_id" : "\(GlobalId.ProjectDetailsId)"
            ]
            print(parameters)
            let headers: HTTPHeaders =
                ["Content-type": "multipart/form-data",
                 "Accept": "application/json"]
            Loader.shared.show()
            let profileImage = self.imgDjpostPhoto.image?.jpegData(compressionQuality: 0.8)
            let serviceURL = URL(string: "\(webservice.url)\(webservice.EditpostDjProjectAPI)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
            print(parameters)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                if profileImage != nil {
                    multipartFormData.append(profileImage!, withName: "project_image",fileName: "image.png", mimeType: "image/png")
                }
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            },usingThreshold: UInt64.init(), to: serviceURL, method: .post, headers: headers) { (result) in
                switch result {
                case .success(let upload,_,_):
                    upload.uploadProgress(closure: { (progress) in
                        GlobalId.id = "0"
                    })
                    upload.responseString { response in
                        Loader.shared.hide()
                        self.backTwo()
                    }
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
    func callProjectTypeWebService(){
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectTypeAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProjectTypeList>) in
                
                switch response.result {
                case .success(_):
                    let projectTypeProfile = response.result.value!
                    if projectTypeProfile.success == 1{
                        self.projectTypeList = projectTypeProfile.projectTypeData!
                        let EditData = [String]()
                        let editDataName = self.projecttypeName
                        for i in 0..<self.projectTypeList.count{
                            
                            if editDataName == "\(self.projectTypeList[i].project_type!)"{
                                self.projectTypeIndex = Int((self.projectTypeList[i].project_type_id!))
                            }else{
                                
                            }
                            
                        }
                        self.projectTypeInstance.dataSource = EditData
                        var data = [String]()
                        for i in 0..<self.projectTypeList.count{
                            data.append(self.projectTypeList[i].project_type!)
                        }
                        self.projectTypeInstance.dataSource = data
                    }else{
                        self.view.makeToast(projectTypeProfile.message)
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
}

//MARK: - EXTENSIONS
extension  DJAddPostVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        
        let imgData = NSData(data: chosenImage.jpegData(compressionQuality: 1)!)
        let imageSize: Int = imgData.count
//        if Double(imageSize) / 1000.0 > 2048{
//            self.view.makeToast("Image file size should be less than or equal to 2MB. Please choose other image")
//        }else{
            imgDjpostPhoto.image = chosenImage
            imgDjpostPhoto.contentMode = .scaleAspectFill
        //}
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension DJAddPostVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == txfStartButton{
            showStartDatePicker()
            return true
        }
//        if textField == txfEndButton{
//            showEndDatePicker()
//            return true
//        }
        return true
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
