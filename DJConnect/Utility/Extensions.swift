//
//  Extensions.swift
//  DJConnect
//
//  Created by Kehav-MacBookPro on 21/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Reachability
import MapKit
import Alamofire

import FBSDKCoreKit
import FBSDKLoginKit
import AlamofireObjectMapper

var imageVw = UIImageView()
extension UIViewController {
    
    func showAlertView(_ message:String!, _ title:String = "", _ okButtonTitle:String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction (title: okButtonTitle, style: UIAlertAction.Style.cancel, handler: { action -> Void in
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertView(_ message: String!, _ title:String = "", _ okButtonTitle:String = "OK", completionHandler: @escaping (_ value: Bool) -> Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOKAction = UIAlertAction(title: okButtonTitle, style: .default) { (action) -> Void in
            completionHandler(true)
        }
        alertController.addAction(btnOKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertView(_ message:String!, _ title:String = "", defaultTitle:String?, cancelTitle:String?, completionHandler: @escaping (_ value: Bool) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOKAction = UIAlertAction(title: defaultTitle, style: .default) { (action) -> Void in
            completionHandler(true)
        }
        let btnCancelAction = UIAlertAction(title: cancelTitle, style: .default) { (action) -> Void in
            completionHandler(false)
        }
        alertController.addAction(btnOKAction)
        alertController.addAction(btnCancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func userLogout(_ userId:String!, _ userToken:String = ""){
            if getReachabilityStatus(){
               
                let parameters = [
                    "token":userToken,
                    "userid":userId,
                ]
                debugPrint(parameters)
                Loader.shared.show()
                
                Alamofire.request(getServiceURL("\(webservice.url)\(webservice.logoutAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                    
                    switch response.result {
                    case .success(_):
                        Loader.shared.hide()
                        let logoutModel = response.result.value!
                        if logoutModel.success == 1{

                            print("logout success")
                            self.view.makeToast(logoutModel.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                self.logoutUser()
                                    })
                        }else{
                            Loader.shared.hide()
                            self.view.makeToast(logoutModel.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                self.logoutUser()
                                    })
                        }
                    case .failure(let error):
                        Loader.shared.hide()
                        debugPrint(error)
                        print("Error")
                    }
                }
            }else{
                self.view.makeToast("Please check your Internet Connection")
            }
    }
    
    func logoutUser(){
        UserModel.sharedInstance().isSignup = true
        UserModel.sharedInstance().isSkip = false
        UserDefaults.standard.set(false, forKey: "isProfileComplete")
        UserDefaults.standard.set(false, forKey: "isPaymentComplete")
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logOut()
        let applanguage = UserModel.sharedInstance().appLanguage
        let latitude = UserModel.sharedInstance().currentLatitude
        let longitude = UserModel.sharedInstance().currentLongitude
        //let deviceToken = UserModel.sharedInstance().deviceToken
       // print("sideMenu_deviceToken",deviceToken)
        let username = UserModel.sharedInstance().userName
        let password = UserModel.sharedInstance().password
        let isRemember = UserModel.sharedInstance().isRemembered
        let rememberType = UserModel.sharedInstance().RememberUserType
        let arname = UserModel.sharedInstance().arname
        let arpassword = UserModel.sharedInstance().arpassword
        UserModel.sharedInstance().removeData()
        UserModel.sharedInstance().synchroniseData()
        UserModel.sharedInstance().appLanguage = applanguage
        UserModel.sharedInstance().currentLatitude = latitude
        UserModel.sharedInstance().currentLongitude = longitude
       // print("sideMenu_deviceToken1",deviceToken)
       // UserModel.sharedInstance().deviceToken = deviceToken
        UserModel.sharedInstance().synchroniseData()
        if isRemember == "1"{
            UserModel.sharedInstance().arname = arname
            UserModel.sharedInstance().arpassword = arpassword
            UserModel.sharedInstance().userName = username
            UserModel.sharedInstance().password = password
            UserModel.sharedInstance().isRemembered = isRemember
            UserModel.sharedInstance().RememberUserType = rememberType
            UserModel.sharedInstance().synchroniseData()
        }else{
            UserModel.sharedInstance().isRemembered = isRemember
        }

        UserModel.sharedInstance().token = ""
        UserModel.sharedInstance().userId = ""
        UserModel.sharedInstance().removeData()
        UserModel.sharedInstance().synchroniseData()
        self.ChangeRootVC()

    }

    func ChangeRootVC() {

        let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
        let navigationController = UINavigationController(rootViewController: nextViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController

    }
    
    func callHelpSubMenuWebService(_ urlPart : String){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(urlPart)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<HelpSubMenuModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let helpSubModel = response.result.value!
                    if helpSubModel.success == 1{
                        let data = helpSubModel.helpData!
                        let txt = data.content
                        let alert = UIAlertController(title: data.title, message: "", preferredStyle: .alert)
                        alert.setValue(txt?.htmlToAttributedString, forKey: "attributedMessage")
                        let okAction = UIAlertAction (title: "ACCEPT", style: UIAlertAction.Style.cancel, handler: { action -> Void in
                        })
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(helpSubModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func getBroadCastVideoLink(brodcastID : String) -> String{
        if getReachabilityStatus(){
            var url = ""
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
                    let resourceUri = videoModelProfile.resourceUri
                    url = resourceUri!
                    
                case .failure(let error):
                    Loader.shared.hide()
                    self.view.makeToast("This broadcast was removed by user")
                    debugPrint(error)
                    url = ""
                }
            }
            
            return url
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
            return ""
        }
    }
    func isValidPhone(phone: String) -> Bool {

       let phoneRegex = "^[0-9]{6,14}$";
       let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
       return valid
    }
    func validateEmail(email: String) -> Bool {
        let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegExp)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        if password.count >= 6 && password.count <= 18 && !password.trimmingCharacters(in: .whitespaces).isEmpty{
            return true
        }else{
            return false
        }
      }
      func validateConfirmPassword(_Pwd: String, _cPwd: String) -> Bool {
          if _Pwd == _cPwd {
              return true
          }else {
              return false
          }
      }
      
      func validateConfirmEmail(_email: String, _cEmail: String) -> Bool {
          if _email == _cEmail {
              return true
          }else {
              return false
          }
      }
    
    func backNotificationView(){
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

    func getReachabilityStatus() -> Bool{
        
        let reachability = try! Reachability.init(hostname: "http://www.google.com")
        if ((reachability.connection == .wifi) && (reachability.connection != .unavailable)) {
            return true
        }else {
            
            if ((reachability.connection == .cellular) && (reachability.connection != .unavailable)) {
                return true
            }else {
                return false
            }
        }
    }
    
    func setLoader(){
        do {
            let gif = try UIImage(gifName: "loadergif.gif")
            imageVw = UIImageView(gifImage: gif, loopCount: -1) // Will loop 3 times
            imageVw.frame = view.bounds
            view.addSubview(imageVw)
            imageVw.startAnimatingGif()
        } catch {
            print(error)
        }
    }
    
    func removeLoader(){
        imageVw.stopAnimatingGif()
        imageVw.removeFromSuperview()
    }
    
    func getServiceURL(_ strURL:String) -> URL {
        return URL(string: strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
    }
    
    func getCurrentDate() -> String? {
        var test: String?
        let date = Date()
        let components = Calendar.current
            .dateComponents([.year, .month, .day], from: date)
        if let day = components.day {
              test = String(day)
        }
       
        return test
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func formattedDateFromString(dateString: String, expectFormat: String,givenDateFormat: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = givenDateFormat

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = expectFormat

            return outputFormatter.string(from: date)
        }

        return nil
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var numberValue: NSNumber? {
        if let value = Int(self) {
            return NSNumber(value: value)
        }
        return nil
    }
 
    
    //MARK:- Convert UTC To Local Date by passing date formats value
      func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat

        return dateFormatter.string(from: dt ?? Date())
      }

      //MARK:- Convert Local To UTC Date by passing date formats value
      func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current

        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat

        return dateFormatter.string(from: dt ?? Date())
      }
}

extension MKMapView {
    func annotationView<T: MKAnnotationView>(of type: T.Type, annotation: MKAnnotation?, reuseIdentifier: String) -> T {
        guard let annotationView = dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? T else {
            return type.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        annotationView.annotation = annotation
        return annotationView
    }
}

class globalObjects{
    
    static let shared = globalObjects()
    
    var latitude: String?
    var longitude: String?
    var searchResultUserType: String?
    var projCount: Int?
    var isSplash: Bool?
    var dropAudioAdded: Bool?
    var profileCompleted: Bool?
    var isForgotPassword: String?
    var forgotEmail: String?
    var AppEnteredTime : String?
    var isFromBackGroundState: Bool?
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var deviceToken: String?
    var menuClose: Bool?
    var buyViewConnect: Bool?
    var dropCompleteConnect: Bool?
    var offerViewConnect: Bool?
    var reviewConnect : Bool?
    var isDjProjStartTimer = true
    var isWeekTimer = true
    var isArProjStartTimer = true
    var isArVideoTimer = true
    var isDjVideoTimer = true
    var isArWeekTimer = true
    var isDjProjDetailTimer = true
    var isArProjDetailTimer = true
    var isBuyStartTimer = true
    var mapTimer = true
    var projLat : Double?
    var projLong : Double?
    var addLat : Double?
    var addLong : Double?
    var remainingTime : String?
    var DropConnectCost : String?
    var djProjId : String?
    var AppTotalTime : String?
    var isFromNotify: Bool?
    var isDeeplinkNavigate: Bool?
    var pinTrial: [String]?
}

extension MKMapView {

    func annotationViewCluster(selection: WelcomeScreenVC.SelectionCluster, annotation: MKAnnotation?, reuseIdentifier: String, index: String) -> MKAnnotationView {
        switch selection {
        case .count:
            let annotationView = self.annotationView(of: SingleClusterAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView.tag = 26
            //annotationView.
            annotationView.priceLabel.textColor = .green
            annotationView.priceLabel.text = "\(reuseIdentifier)"
//            annotationView.image = UIImage(named: "cluster") // "mapProjectIcon-1"
            annotationView.image = UIImage(named: "mapProjectIcon-1")
            if index == "1"{
                annotationView.image = UIImage(named: "gold_cluster1")
            }else{
                annotationView.image = UIImage(named: "mapProjectIcon-1")
            }
            return annotationView
        case .imageCount:
            let annotationView = self.annotationView(of: ImageCountClusterAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView.tag = 21
            annotationView.countLabel.textColor = .green
            annotationView.mapType = "Buy"
            if index == "1"{
                annotationView.image = .pin4
            }else{
                annotationView.image = .pin2
            }
            return annotationView
        case .image:
            let annotationView = self.annotationView(of: DJMultiplePinView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView.tag = 22
            annotationView.countLabel.textColor = .white
            annotationView.image = UIImage(named: "DJ_Mult_pin")
            return annotationView
        }
    }
    
    func annotationViewReviewCluster(selection: ArtistMapReviewVC.SelectionCluster, annotation: MKAnnotation?, reuseIdentifier: String, index: String) -> MKAnnotationView {
        switch selection {
        case .count:
            let annotationView = self.annotationView(of: SingleClusterAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView.tag = 26
            //annotationView.
            annotationView.priceLabel.textColor = .green
            annotationView.priceLabel.text = "\(reuseIdentifier)"
           // annotationView.image = UIImage(named: "HomeSong")
            annotationView.image = UIImage(named: "simple_reviewCluster")
            
//            if index == "1"{
//                annotationView.image = .pin5
//            }else{
//                annotationView.image = .pin2
//            }
            if index == "1"{
                annotationView.image = .pin8
            }else{
                annotationView.image = .pin8
            }
            return annotationView
        case .imageCount:
            let annotationView = self.annotationView(of: ImageCountClusterAnnotationView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView.tag = 21
            annotationView.countLabel.textColor = .green
            annotationView.mapType = "Review"
            if index == "1"{
                annotationView.image = .pin8
            }else{
                annotationView.image = .pin8
            }

            return annotationView
        case .image:
            
            let annotationView = self.annotationView(of: DJMultiplePinView.self, annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView.tag = 22
            annotationView.countLabel.textColor = .white
            annotationView.image = UIImage(named: "DJ_Mult_pin")
            return annotationView
            
        }
    }
}



extension UIImage{
    
    var roundMyImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
        ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    func resizeMyImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func squareMyImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: self.size.width, height: self.size.width))
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.width))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    // image with rounded corners
  
    func filled(with color: UIColor) -> UIImage {
           UIGraphicsBeginImageContextWithOptions(size, false, scale)
           color.setFill()
           guard let context = UIGraphicsGetCurrentContext() else { return self }
           context.translateBy(x: 0, y: size.height)
           context.scaleBy(x: 1.0, y: -1.0);
           context.setBlendMode(CGBlendMode.normal)
           let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
           guard let mask = self.cgImage else { return self }
           context.clip(to: rect, mask: mask)
           context.fill(rect)
           let newImage = UIGraphicsGetImageFromCurrentImageContext()!
           UIGraphicsEndImageContext()
           return newImage
       }
    //annotationView.image = UIImage(named: "mapProjectIcon-1")
       static let pin = UIImage(named: "mapProjectIcon-1")?.filled(with: .green)
       static let pin2 = UIImage(named: "mapProjectIcon-1")
       static let pin3 = UIImage(named: "djCrowd")?.filled(with: .red)
       static let pin4 = UIImage(named: "gold_cluster1")
       static let pin5 = UIImage(named: "gold_reviewCluster")
//       static let pin6 = UIImage(named: "simple_reviewCluster")
    static let pin6 = UIImage(named: "mapProjectIcon-1")
//    static let pin8 = UIImage(named: "simple_reviewCluster")
    static let pin8 = UIImage(named: "mapProjectIcon-1")
    
       static let me = UIImage(named: "me")?.filled(with: .blue)
}
extension UIColor {
    class var green: UIColor { return UIColor(red: 50 / 255, green: 176 / 255, blue: 66 / 255, alpha: 1) }
    class var blue: UIColor { return UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) }
    
    static var themeBlack: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return .black
        }
    }
    
//    static var themePink: UIColor {
//            return UIColor(red: 155, green: 70, blue: 191, alpha: 1)
//        
//    }
    
    static var themeWhite: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return .white
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        
    }
}
extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
extension Date {

    var firstWeekDay: Date? {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .year, .month, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) - ((components?.weekday ?? 0) - 1)
        return calendar.date(from: modifiedComponent!)
    }
    
    var lastWeekDay: Date? {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .year, .month, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) + (7 - (components?.weekday ?? 0))
        modifiedComponent?.hour = 23
        modifiedComponent?.minute = 59
        modifiedComponent?.second = 59
        return calendar.date(from: modifiedComponent!)
    }
    
    func timeAgoSinceDate() -> String {

        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "MM/dd/yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: toDate)

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return myStringafd
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }

        return "a moment ago"
    }
}
extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func isEqualToImage(_ image: UIImage) -> Bool {
            return self.pngData() == image.pngData()
        }
}
extension Array {
    mutating func shiftRight() {
        if let obj = self.popLast(){
            self.insert(obj, at: 0)
        }
    }
}
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, targetText: String) -> Bool {
        guard let attributedString = label.attributedText, let lblText = label.text else { return false }
        let targetRange = (lblText as NSString).range(of: targetText)
        //IMPORTANT label correct font for NSTextStorage needed
        let mutableAttribString = NSMutableAttributedString(attributedString: attributedString)
        mutableAttribString.addAttributes(
            [NSAttributedString.Key.font: label.font ?? UIFont.smallSystemFontSize],
            range: NSRange(location: 0, length: attributedString.length)
        )
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: mutableAttribString)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y:
                                                        locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
