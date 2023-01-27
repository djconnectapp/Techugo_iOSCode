//
//  VenuInfoViewController.swift
//  DJConnect
//
//  Created by Techugo on 29/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import LocationPickerViewController
import MapKit

class VenuInfoViewController: UIViewController {
    
    @IBOutlet weak var venueInfoHdrLbl: UILabel!
    @IBOutlet weak var nameInfoVw: UIView!
    @IBOutlet weak var venueAddressVw: UIView!
    @IBOutlet weak var eventDateVw: UIView!
    @IBOutlet weak var startTimeVw: UIView!
    @IBOutlet weak var displayAddressLbl: UILabel!
    @IBOutlet weak var displayAdrsBtn: UIButton!
    
    @IBOutlet weak var venueNameTxtFld: UITextField!
    @IBOutlet weak var venueAdrsTxtFld: UITextField!
    @IBOutlet weak var startTimeTxtFld: UITextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var getPrjectNameStr = String()
    var getPrjectDEtailStr = String()
    var getProjImage:UIImage?
    var prjectTypeStr = String()
    var expectedAudienceStr = String()
    var projectTypeIndex = String()
    
    
    fileprivate weak var calendar: FSCalendar!
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    var postDate = String()
    var postMaxDate = Date()
    var date = Date()
    var isCurrentWeek = false
    var thisWeek : Int?
    var myWeek : Int?
    var weekDate = String()
    var startIndexWeekProj = 0
    
    var fullAddress = String()
    var shortAddress = String()
    var latitude = String()
    var longitude = String()
    var editfullAddress = String()
    var editsortAddress = String()
    var addFlag = String()
    let picker1 : UIDatePicker = UIDatePicker()
    
    var strtxfEventDateTime = String()
    var newSelecttimee = String ()
    var eventDateSelected = String ()
    var selectcurrentDate = String ()
    var newCurrtimeSt = String ()
    var newSelecttimeeSt = String ()
    var maxDateSelected = String ()
    
    var projectId = String()
    var txtVenueNameStr = String()
    var txtEventDateStr = String()
    var txtStartTimeStr = String()
    var txtVenueAdrsStr = String()
    var txtLatStr = String()
    var txtLongStr = String()
    var txtpriceStr = String()
    var txtRestricStr = String()
    var txtAdditnlInfoStr = String()
    var txtaddFlag = String()
    var txtofferFlag = String()
    var txteditfullAddress = String()
    var txteditsortAddress = String()
    var genreNames = String()
    var genreIds = String()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDateSelected = ""
        maxDateSelected = ""
        addFlag = "no"
        displayAdrsBtn.isHidden = true
        displayAdrsBtn.isUserInteractionEnabled = false
        //displayAdrsBtn.setImage(UIImage(named: "displayOff"), for: .normal)
        self.calendarview()
        setUpVw()
        getWeekDate()
        startIndexWeekProj = 0
        startTimeTxtFld.delegate = self
        venueNameTxtFld.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
//        scrView.isScrollEnabled = true
//        scrView.contentSize = CGSize(width: self.view.frame.width, height: 1100)
//        if viewAllProject.isHidden == false{
//            isCurrentWeek = true
//            intialContainerHeight()
//        }
//        if viewCalendar.isHidden == false{
            isCurrentWeek = false
            //intialContainerHeight()
//        }
//
//        if viewService.isHidden == false{
//            scrView.contentSize = CGSize(width: self.view.frame.width, height: 1180)
//        }
        
        if GlobalId.id == "1"{
            // txtEventDateStr --  "09/29/2022"
            print("txteditfullAddress",txteditfullAddress)
            print("txtStartTimeStr",txtStartTimeStr)
            print("txteditsortAddress",txteditsortAddress)
            fullAddress = txteditfullAddress
            shortAddress = txteditsortAddress
            venueNameTxtFld.text = txtVenueNameStr
            venueAdrsTxtFld.text = txteditsortAddress
            startTimeTxtFld.text = txtStartTimeStr
            strtxfEventDateTime = txtEventDateStr
            eventDateSelected = "selected"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        //picker1.maximumDate = getMaximumDate(startDate: postMaxDate, addbyUnit: .day, value: 7)
        
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
    
    func setUpVw(){
         
        nameInfoVw.layer.cornerRadius = 10.0
        nameInfoVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        nameInfoVw.layer.borderWidth = 0.5
        nameInfoVw.clipsToBounds = true
        
        venueAddressVw.layer.cornerRadius = 10.0
        venueAddressVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        venueAddressVw.layer.borderWidth = 0.5
        venueAddressVw.clipsToBounds = true
        
        eventDateVw.layer.cornerRadius = 10.0
        eventDateVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        eventDateVw.layer.borderWidth = 0.5
        eventDateVw.clipsToBounds = true
        
        startTimeVw.layer.cornerRadius = 10.0
        startTimeVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        startTimeVw.layer.borderWidth = 0.5
        startTimeVw.clipsToBounds = true
        
        
        venueNameTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Name of Venue",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        venueAdrsTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Venue Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        startTimeTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Start Time",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
    }
    
//    let transition = CATransition()
//    transition.duration = 0.5
//    transition.type = CATransitionType(rawValue: "flip")
//    transition.subtype = CATransitionSubtype.fromLeft
//    self.navigationController?.view.layer.add(transition, forKey: kCATransition)
//    self.navigationController?.pushViewController(desiredViewController, animated: true)
    
    @objc func nextbuttonTapped() {
        calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
    }


    @objc  func backbuttonTapped(_ sender:UIButton) {
        calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
    }

    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }

    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    func calendarview () {
       let calendar = FSCalendar(frame: CGRect(x: 0, y: 45, width: self.view .frame .width - 50, height: eventDateVw.frame.size.height-45))
        calendar.clipsToBounds = true
        calendar.dataSource = self
        calendar.delegate = self
        eventDateVw.addSubview(calendar)
        self.calendar = calendar
        
        
        let nextBtn = UIButton(frame: CGRect(x: self.view .frame .width - 160, y: 55, width: 80, height: 30))
        //nextBtn.setTitle("Next", for: .normal)
        nextBtn.setImage(UIImage(named:"back_arrow_arabic"), for: .normal)
        nextBtn.backgroundColor = .clear
        nextBtn.setTitleColor(UIColor.black, for: .normal)
        nextBtn.addTarget(self, action: #selector(self.nextbuttonTapped), for: .touchUpInside)
        nextBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 29)

        eventDateVw.addSubview(nextBtn)
        
        
        let prvBtn = UIButton(frame: CGRect(x: 20, y: 55, width: 80, height: 30))
        //prvBtn.setTitle("back", for: .normal)
        prvBtn.setImage(UIImage(named:"back_arrow_english"), for: .normal)
        prvBtn.backgroundColor = .clear
        prvBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 29, bottom: 0, right: 29)
        prvBtn.setTitleColor(UIColor.black, for: .normal)
        prvBtn.addTarget(self, action: #selector(self.backbuttonTapped), for: .touchUpInside)
        eventDateVw.addSubview(prvBtn)
        

        
        self.calendar.scope = .month
        self.calendar.appearance.weekdayTextColor = UIColor .white
        self.calendar.appearance.headerTitleColor = UIColor .white
        self.calendar.appearance.titleDefaultColor = UIColor .white
        self.calendar.appearance.headerMinimumDissolvedAlpha = -1
        self.calendar.appearance.titleTodayColor = UIColor .white
//        if(txtEventDateStr != ""){
//
//        }else{
        self.calendar.appearance.todayColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
           // }
        self.calendar.appearance.titleSelectionColor = UIColor.black
        self.calendar.appearance.selectionColor = UIColor.white
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
    
    func formattedDaysInThisWeek() -> [String] {
        // create calendar
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!
        
        // today's date
        let today = NSDate()
        let todayComponent = calendar.components([.day, .month, .year], from: today as Date)
        
        // range of dates in this week
        let thisWeekDateRange = calendar.range(of: .day, in:.weekOfMonth, for:today as Date)
        
        // date interval from today to beginning of week
        let dayInterval = thisWeekDateRange.location - todayComponent.day!
        
        // date for beginning day of this week, ie. this week's Sunday's date
        let beginningOfWeek = calendar.date(byAdding: .day, value: dayInterval, to: today as Date, options: .matchNextTime)
        
        var formattedDays: [String] = []
        
        for i in 0 ..< thisWeekDateRange.length {
            let date = calendar.date(byAdding: .day, value: i, to: beginningOfWeek!, options: .matchNextTime)!
            formattedDays.append(formatDate(date: date as NSDate))
        }
        
        return formattedDays
    }
    
    func formatDate(date: NSDate) -> String {
        let format = "EEE MMMdd"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
    
    func getWeekDate(){
        let week = calendar.currentPage
        let monthOfWeek = Calendar.current.component(.weekOfMonth, from: week)
        myWeek = monthOfWeek
        let currentPageDate = calendar.currentPage
        let yearString = Calendar.current.component(.year, from: currentPageDate)
        let weekOfYearString = Calendar.current.component(.weekOfYear, from: currentPageDate)
        
        let year = Int(yearString)
        let components = DateComponents(weekOfYear: weekOfYearString, yearForWeekOfYear: year)
        guard let date = Calendar.current.date(from: components) else {return}
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        weekDate = df.string(from: date)
        print(weekDate)
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
//        picker1.datePickerMode = .dateAndTime
        picker1.datePickerMode = .time
        startTimeTxtFld.inputAccessoryView = toolbar
        startTimeTxtFld.inputView = picker1
        
//        let now = Date()
//        picker1.datePickerMode = .time
//        picker1.minimumDate = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: now)
//        picker1.maximumDate = Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: now)
//        picker1.minuteInterval = 30
    }
    
    @objc func startDateTimePicker(){
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateFormat = "h:mm a"
        startTimeTxtFld.text = timeFormatter.string(from: picker1.date)
       // picker1.minimumDate = postMaxDate
        picker1.maximumDate = getMaximumDate(startDate: postMaxDate, addbyUnit: .day, value: 7)
        
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
        
//        let selectStarttimeFormatter = DateFormatter()
//        selectStarttimeFormatter.timeStyle = .short
//        selectStarttimeFormatter.dateFormat = "HH:mm"
//        let newStartSelecttime = selectStarttimeFormatter.string(from: picker2.date)
        //if (eventDateSelected != ""){
        selectcurrentDate = currDate
        newCurrtimeSt = newCurrtime
        newSelecttimeeSt = newSelecttime
            if currDate == strtxfEventDateTime{
                let result = findDateDiff(time1Str: newCurrtime, time2Str: newSelecttime)
                if newCurrtime > newSelecttime{
                    let checkApiTime = convertIntoMinute(_time: UserModel.sharedInstance().remainingTime!)
                    self.view.makeToast("Your project cannot be posted because your event starts within the limits set by admin (less than \(checkApiTime) minutes from now).")
                    
                }else{
                    let apiTime = convertIntoMinute(_time: UserModel.sharedInstance().remainingTime!)
                    let userTimeDiff = convertIntoMinute(_time: result)
                    if userTimeDiff < apiTime{
                        self.view.makeToast("Your project cannot be posted because your event starts within the limits set by admin (less than \(apiTime) minutes from now).")
                        
                    }
                }
            }
        //}
        //else{
            //self.view.makeToast("Please select Event Date")
        //}
        
        self.view.endEditing(true)
    }
    
    //MARK: - SELECTOR METHODS
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
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
    
    @IBAction func nextBtntapped(_ sender: Any) {
        
        let selecttimeFormatter = DateFormatter()
        selecttimeFormatter.timeStyle = .short
        selecttimeFormatter.dateFormat = "HH:mm"
        newSelecttimee = selecttimeFormatter.string(from: picker1.date)
       
                if(venueNameTxtFld.text?.isEmpty == true){
                    self.view.makeToast("Enter Venue Name".localize)
                }else if(venueAdrsTxtFld.text?.isEmpty == true){
                    self.view.makeToast("Enter Venue Address".localize)
                }
                else if(eventDateSelected == ""){
                    self.view.makeToast("Please select Event Date")
                    }
                else if(maxDateSelected == "maximum Date" && maxDateSelected != ""){
                    self.view.makeToast("The maximum you can add a project is 7 days from today. Please select a date within this range.".localize)
                }
                else if(startTimeTxtFld.text?.isEmpty == true){
                    self.view.makeToast("Enter Start Time".localize)
                }
           else if selectcurrentDate == strtxfEventDateTime{
               
                let result = findDateDiff(time1Str: newCurrtimeSt, time2Str: newSelecttimeeSt)
                if newCurrtimeSt > newSelecttimeeSt{
                    let checkApiTime = convertIntoMinute(_time: UserModel.sharedInstance().remainingTime!)
                    self.view.makeToast("Your project cannot be posted because your event starts within the limits set by admin (less than \(checkApiTime) minutes from now).")
                    
                }else{
                    let apiTime = convertIntoMinute(_time: UserModel.sharedInstance().remainingTime!)
                    let userTimeDiff = convertIntoMinute(_time: result)
                    if userTimeDiff < apiTime{
                        self.view.makeToast("Your project cannot be posted because your event starts within the limits set by admin (less than \(apiTime) minutes from now).")
                        
                    }
                    else{
                        if addFlag == "yes"{
                            //if(txteditsortAddress == ""){
                            venueAdrsTxtFld.text = fullAddress
//                            }
//                            else{
//                                venueAdrsTxtFld.text = txteditfullAddress
//                            }
                        }else{
                           // if(txteditsortAddress == ""){
                            venueAdrsTxtFld.text = shortAddress
//                            }
//                            else{
//                                venueAdrsTxtFld.text = txteditsortAddress
//                            }
                        }
                        
                                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
                        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "ConnectInfoVC") as! ConnectInfoVC
                                desiredViewController.getPrjectNameStr = getPrjectNameStr
                                desiredViewController.getPrjectDEtailStr = getPrjectDEtailStr
                                desiredViewController.getProjImage = getProjImage
                                desiredViewController.prjectTypeStr = prjectTypeStr
                                desiredViewController.projectTypeIndex = projectTypeIndex
                                desiredViewController.expectedAudienceStr = expectedAudienceStr
                                desiredViewController.venueName = venueNameTxtFld.text!
                                desiredViewController.venueAddrss = venueAdrsTxtFld.text!
                                desiredViewController.strtxfEventDateTime = strtxfEventDateTime
                                desiredViewController.newSelecttimee = newSelecttimee
                                desiredViewController.addFlag = addFlag
                        
                        desiredViewController.txtpriceStr = txtpriceStr
                        desiredViewController.txtRestricStr = txtRestricStr
                        desiredViewController.txtAdditnlInfoStr = txtAdditnlInfoStr
                        desiredViewController.genreNames = genreNames
                        desiredViewController.genreIds = genreIds
                        desiredViewController.txtLatStr = txtLatStr
                        desiredViewController.txtLongStr = txtLongStr
                       // desiredViewController.txtaddFlag = txtaddFlag
                        //desiredViewController.txtofferFlag = txtofferFlag
                       // desiredViewController.txteditfullAddress = txteditfullAddress
                        //desiredViewController.txteditsortAddress = txteditsortAddress
                        
                        
                                navigationController?.pushViewController(desiredViewController, animated: false)
                    }
                }
            }
                else{
        
        if addFlag == "yes"{
            //if(txteditsortAddress == ""){
            venueAdrsTxtFld.text = fullAddress
//            }
//            else{
//                venueAdrsTxtFld.text = txteditfullAddress
//            }
        }else{
            //if(txteditsortAddress == ""){
            venueAdrsTxtFld.text = shortAddress
//            }
//            else{
//                venueAdrsTxtFld.text = txteditsortAddress
//            }
        }
        
                let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "ConnectInfoVC") as! ConnectInfoVC
                desiredViewController.getPrjectNameStr = getPrjectNameStr
                desiredViewController.getPrjectDEtailStr = getPrjectDEtailStr
                desiredViewController.getProjImage = getProjImage
                desiredViewController.prjectTypeStr = prjectTypeStr
                desiredViewController.projectTypeIndex = projectTypeIndex
                desiredViewController.expectedAudienceStr = expectedAudienceStr
                desiredViewController.venueName = venueNameTxtFld.text!
                desiredViewController.venueAddrss = venueAdrsTxtFld.text!
                desiredViewController.strtxfEventDateTime = strtxfEventDateTime
                desiredViewController.newSelecttimee = newSelecttimee
                desiredViewController.addFlag = addFlag
                    
                    desiredViewController.txtpriceStr = txtpriceStr
                    desiredViewController.txtRestricStr = txtRestricStr
                    desiredViewController.txtAdditnlInfoStr = txtAdditnlInfoStr
                    desiredViewController.genreNames = genreNames
                    desiredViewController.genreIds = genreIds
                    desiredViewController.txtLatStr = txtLatStr
                    desiredViewController.txtLongStr = txtLongStr
                navigationController?.pushViewController(desiredViewController, animated: false)
                }
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    @IBAction func displayBtnTapped(_ sender: Any) {
//        if(addFlag == "no"){
//            displayAdrsBtn.setImage(UIImage(named: "displayOn"), for: .normal)
//            addFlag = "yes"
//        }
//        else{
//        displayAdrsBtn.setImage(UIImage(named: "displayOff"), for: .normal)
//            addFlag = "no"
//        }
    }
    @IBAction func addresBtnTapped(_ sender: Any) {
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
            self.venueAdrsTxtFld.text = self.fullAddress
           // self.txteditsortAddress = ""
           // self.txteditfullAddress = ""
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
//                                            print(pm.country)
//                                            print(pm.locality)
//                                            print(pm.subLocality)
//                                            print(pm.thoroughfare)
//                                            print(pm.postalCode)
//                                            print(pm.subThoroughfare)
                                            
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
    
}

extension VenuInfoViewController : FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
        let dateCurr = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let endDate = generateDates(startDate: dateCurr, addbyUnit: .day, value: 7)
        if date > endDate{
            maxDateSelected = "maximum Date"
            self.view.makeToast("The maximum you can add a project is 7 days from today. Please select a date within this range.".localize)
        }else{
            maxDateSelected = ""
            print("did select date \(self.dateFormatter.string(from: date))")
            let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
            print("selected dates is \(selectedDates)")
            if monthPosition == .next || monthPosition == .previous {
                calendar.setCurrentPage(date, animated: true)
            }
            //dateFormatter.dateFormat = "MM/dd/yyyy"
            //strtxfEventDateTime = dateFormatter.string(from: picker1.date)
            //dateFormatter.dateFormat = "MMM dd, yyyy"
            //postDate = dateFormatter.string(from: calendar.selectedDate!)
            dateFormatter.dateFormat = "MM/dd/yyyy"
            strtxfEventDateTime = dateFormatter.string(from: calendar.selectedDate!)
            eventDateSelected = "selected"
            //self.date = calendar.selectedDate!
            
            
//            if viewerId == UserModel.sharedInstance().userId!{
//                performSegue(withIdentifier: "segueCalendarDateclick", sender: nil)
//            }
        }
        
        calendar.appearance.eventSelectionColor = .clear
        
    }
    
    public func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
    { // date -- 2022-08-27 18:30:00 +0000
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let getDefaultdate = dateFormatter.string(from: date)
        print("getDefaultdate",getDefaultdate)
        
        let datee = Date()
        let formatterr = DateFormatter()
        formatterr.dateFormat =  "MM/dd/yyyy"
        var curntTime = "\(formatterr.string(from: datee))"
        
        //strtxfEventDateTime = dateFormatter.string(from: picker1.date)
        if txtEventDateStr ==  getDefaultdate  // "09/29/2022"
        {
            curntTime = ""
            return UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        }
        else
        {
            if(curntTime == getDefaultdate && txtEventDateStr == ""){
                return UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
            }
            else{
            return .clear
            }
        }
    }
    
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return date
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        globalObjects.shared.isDjProjStartTimer = false
        globalObjects.shared.isWeekTimer = false
//        WeeklyRemainingTimeArray.removeAll()
//        RemainingTimeArray.removeAll()
//        getWeekDate()
//        releaseDate.removeAll()
//        weekProjectList.removeAll()
//        startIndexWeekProj = 0
//        callGetWeeeklyProjListWebService()
    }
}

extension VenuInfoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        if textField == startTimeTxtFld{
            showStartDatePicker()
            return true
        }

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == venueNameTxtFld{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            }
            else if textField.text!.count > 50 {
                return false
            }
        }
        return true
    }
    
}

