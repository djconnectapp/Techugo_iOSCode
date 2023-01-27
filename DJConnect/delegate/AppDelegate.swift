//
//  AppDelegate.swift
//  DJConnect
//
//  Created by mac on 09/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import IQKeyboardManager
import GoogleSignIn
import MapKit
import Alamofire
import AlamofireObjectMapper
import UserNotifications
import UserNotificationsUI
import Stripe
import Reachability
import FBSDKLoginKit
import Firebase
import FirebaseDynamicLinks
import LGSideMenuController
import Mixpanel

let CURRENT_LATITUDE = "CURRENT_LATITUDE"
let CURRENT_LONGITUDE = "CURRENT_LONGITUDE"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate,UNUserNotificationCenterDelegate, MessagingDelegate{
    
    var deviceTokenString: String!
    var window: UIWindow?
    var enteredTime: String?
    var exitTime: String?
    var totTime: String?
    var locationManager : CLLocationManager?
    var currentLocation: CLLocation?
    var isLoggedIn: String!
    var isFromInActive = false
    var notificationType = String()
    var notificationDetail = NSDictionary()
    var projectID = String()
    var audioID = String()
    var projectId = ""
    
    var nav = UINavigationController()
    
    enum Actions:String{
        case accept = "Accept_Action"
        case reject = "Reject_Action"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        let app = UIApplication.shared
//        let bundleID = "com.djconnectapp://"
//        if app.canOpenURL(URL(string: bundleID)!) {
//          print("App is install and can be opened")
//          let url = URL(string:bundleID)!
//          if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//          } else {
//            UIApplication.shared.openURL(url)
//          }
//        } else {
//           print("App in not installed. Go to AppStore")
//        }
        
        let mixpanel = Mixpanel.initialize(token: "2d9c41d669de7b5edd3d3d6e30e55e79", trackAutomaticEvents: true)
        print("mixpanel",mixpanel)
        
//        Mixpanel.mainInstance().track(event: "Sign Up", properties: [:
//            
//        ])
        
//        let mixpanel: Mixpanel = Mixpanel.sharedInstance()
//        mixpanel = Mixpanel.initialize(token: "2d9c41d669de7b5edd3d3d6e30e55e79", trackAutomaticEvents: true)
//        mixpanel.track(“App launched”)
        
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            //FIRMessaging.messaging().remoteMessageDelegate = self
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
              application.registerUserNotificationSettings(settings)
        }
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        application.registerForRemoteNotifications()
        remoteNotification(application: application)
        
        if let _ = UserModel.sharedInstance().userId{
            let now = Date()
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "HH:mm:ss"
            enteredTime = formatter.string(from: now)
            globalObjects.shared.AppEnteredTime = enteredTime
            globalObjects.shared.isFromBackGroundState = false
        }
        if UserModel.sharedInstance().AppTotalTime != nil{
            callSetAverageTimeApi(_time: UserModel.sharedInstance().AppTotalTime!)
        }
        
        setupLocationManager()
        if UserModel.sharedInstance().appLanguage == "0"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            let arabic = Locale().initWithLanguageCode(languageCode: "ar", countryCode: "ar", name: "Arabic")
            DGLocalization.sharedInstance.setLanguage(withCode:arabic)
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let English = Locale().initWithLanguageCode(languageCode: "en", countryCode: "en", name: "English")
            DGLocalization.sharedInstance.setLanguage(withCode:English)
        }
        Stripe.setDefaultPublishableKey(Keys.stripeKey) // previous
        
        //for default stripe payment screen opening here
        //STPPaymentConfiguration.shared().publishableKey = Keys.stripeKey
        // Override point for customization after application launch.
        IQKeyboardManager.shared().isEnabled = true
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().delegate = self
        setNotificationSwipeActions()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
//        if let options = launchOptions, let userInfo = options[UIApplication.LaunchOptionsKey.remoteNotification] as? NSDictionary {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                if let aps = userInfo["aps"] as? NSDictionary {
//                    self.notificationDetail = aps
//                    UserModel.sharedInstance().notificationCount! += 1
//                    UserModel.sharedInstance().synchroniseData()
//                    if let type = aps["type"] as? String {
//                        self.notificationType = type
//                        if type == "drop_request" {
//                        }else if type == "review_request" {
//                            self.review_request(aps["sender_id"] as! String)
//                        }else if type == "Buy_Project_Artist_Audio"{
//                            self.projectID = aps["projectid"] as! String
//                            self.audioID = aps["audioId"] as! String
//                            self.Buy_Project_Artist_Audio(aps["projectid"] as! String)
//                        }else if type == "admin"{
//                            self.admin(aps["title"] as! String,dateInfo: aps["create_date"] as! String,msgDesc: aps["message"] as! String,id: aps["id"] as! String)
//                        }else if type == "drop_live"{
//                            self.drop_live(aps["video_id"] as! String,aps["broadcastID"] as! String)
//                        }else if type == "Buy_Project_Artist_Audio_Rejected" || type == "Buy_Project_Artist_Audio_Accepted"{
//                            if aps["is_offer"] as! String == "0"{
//                                self.callBuyConnectVC(id: aps["projectid"] as! String)
//                            }else{
//                                self.callArtistOfferVC(id: aps["projectid"] as! String)
//                            }
//                        }else if type == "newproject_added" || type == "refund_cancle_project"{
//                            self.Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)
//                        }else if type == "drop_song_live"{
//                            self.drop_song_live(aps["video_id"] as! String,aps["broadcastID"] as! String,aps["sender_id"] as! String)
//                        }else if type == "add_favorite"{
//                            self.add_favorite()
//                        }else if type == "project_ending"{
//                            self.Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)
//                        }
//                    }
//                }
//            }
//        }
        
        if(UserModel.sharedInstance().userId != nil){
            
//            let desireViewController = homeStoryBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC
//            desireViewController.projectId = self.projectId
            
//            guard let centerController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "GetPinVC") as? GetPinVC else { return }
//            guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
//
//             nav = UINavigationController.init(rootViewController: centerController)
//             nav.setNavigationBarHidden(true, animated: false)
//                let sideMenuController = LGSideMenuController(rootViewController: nav,
//                                                              leftViewController: sideController,
//                                                              rightViewController: nil)
//            sideMenuController.leftViewPresentationStyle = .scaleFromLittle
//          self.window?.rootViewController = sideMenuController
//          self.window?.makeKeyAndVisible()

            
            
        if UserModel.sharedInstance().userType == "DJ"{
                self.setUpDrawer()
        }else{
            self.setUpDrawerArtist()

        }
        }
        
        return ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        //return true
    }
    
    func application(
                _ app: UIApplication,
                open url: URL,
                options: [UIApplication.OpenURLOptionsKey : Any] = [:]
            ) -> Bool {
        
        print(url.absoluteString)
        print(url.absoluteURL)
        print(url.baseURL)
        print(url.host)
        
//        if url.host ?? "" != ""{
//           // if checkForLogin == "Yes"{
//                let arrr = url.absoluteString.split(separator: "?")
//                if arrr.count > 1{
//
////                    let val = arrr[1].description
////                    if self.currentVc == nil{
////                       self.perform(#selector(callDetails), with: val, afterDelay: 0.3)
////                        return true
////                    }
////                    else{
//                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "DJProfile", bundle: nil)
//                        let innerPage = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuNavigation") as! UINavigationController
//                        let viewController3 = mainStoryboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
//                        viewController3.projectId = "224"
//                        innerPage.setViewControllers([viewController3], animated: false)
//                        self.window?.rootViewController = innerPage
//                        self.window!.makeKeyAndVisible()
//                    return true
//                   // }
//                }
//
//           // }
//            return false
//        }
                ApplicationDelegate.shared.application(
                    app,
                    open: url,
                    sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                )
        
//        let stripeHandled = StripeAPI.handleURLCallback(with: url)
//        if (stripeHandled) {
//            return true
//        } else {
//            // This was not a Stripe url – handle the URL normally as you would
//        }
        return false
        
            }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//        let stripeHandled = StripeAPI.handleURLCallback(with: url)
//        if (stripeHandled) {
//            return true
//        } else {
//            // This was not a Stripe url – handle the URL normally as you would
//        }
//        return false
//    }

    // This method handles opening universal link URLs (for example, "https://example.com/stripe_ios_callback")
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool  {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {

            }
        }
       
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            if let dlink = dynamiclink{
                let getdynamiclink = "\(dlink.url!)"
                print(getdynamiclink.components(separatedBy: "="))
                if Int(getdynamiclink.components(separatedBy: "=").last ?? "") == nil{
                  UserDefaults.standard.set(getdynamiclink.components(separatedBy: "=").last, forKey: "shareRefercode")
               }else{
                
                
                self.projectId = getdynamiclink.components(separatedBy: "=").last ?? ""
                   
//                   let alert = UIAlertController(title: "Alert", message: "Deep Link", preferredStyle: .alert)
//                   alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                   self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                   UserDefaults.standard.set(self.projectId, forKey: "linkProjectid")
                   NotificationCenter.default.post(name: Notification.Name("projectIdLink"), object: nil)
                   
                  // DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                       self.NavigatetoTextPost(projectId: self.projectId)
                  // })
                   
                
//                let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
//                let desiredViewController = homeSB.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC
//                desiredViewController.projectId = getdynamiclink.components(separatedBy: "=").last ?? ""
//                desiredViewController.modalPresentationStyle = .fullScreen
//                desiredViewController.projectId = self.projectId
//                UserDefaults.standard.set(self.projectId, forKey: "linkProjectid")
//                NotificationCenter.default.post(name: Notification.Name("projectIdLink"), object: nil)
//                self.window?.rootViewController?.present(desiredViewController, animated: true)
//                self.window!.makeKeyAndVisible()
                //================================
               }

            }
        }
        return handled
        
    }
    
    func NavigatetoTextPost(projectId:String)
        {
            if UserModel.sharedInstance().userType == "DJ"{
            let storyboard = UIStoryboard(name: "DJProfile", bundle: nil)
            let projectDetailVc = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
            UserDefaults.standard.set(self.projectId, forKey: "linkProjectid")
            projectDetailVc.projectId = projectId
            nav = UINavigationController.init(rootViewController:projectDetailVc)
            nav.navigationBar.isHidden = true
            self.window?.rootViewController = self.nav
            self.window?.makeKeyAndVisible()
            }
            else{
                let storyboard = UIStoryboard(name: "ArtistProfile", bundle: nil)
                let projectDetailVc = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
                UserDefaults.standard.set(self.projectId, forKey: "linkProjectid")
                projectDetailVc.projectId = projectId
                nav = UINavigationController.init(rootViewController:projectDetailVc)
                nav.navigationBar.isHidden = true
                self.window?.rootViewController = self.nav
                self.window?.makeKeyAndVisible()
            }
            
        }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.description.hasPrefix("google"){
            return GoogleSignIn.GIDSignIn.sharedInstance.handle(url)
               // GIDSignIn.sharedInstance.handle(url,
//                                                     sourceApplication: sourceApplication,
//                                                     annotation: annotation)
        }else{
            let lastCompo = url.lastPathComponent
            let urlCompo = url.pathComponents
            globalObjects.shared.isDeeplinkNavigate = true
            if "\(lastCompo)" == "ar-project-detail-page"{
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "ArtistProfile", bundle: nil)
                let innerPage = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuNavigation") as! UINavigationController
                let viewController3 = mainStoryboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
                viewController3.projectId = "\(urlCompo[1])"
                innerPage.setViewControllers([viewController3], animated: false)
                self.window?.rootViewController = innerPage
                self.window!.makeKeyAndVisible()
            }
            return true
        }
    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//        print("didReceiveRemoteNotification",userInfo)
//    }
    
    func remoteNotification(application:UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_,_ in})
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmToken",fcmToken ?? "")
        UserDefaults.standard.set(fcmToken, forKey: "device_token")
        
        UserModel.sharedInstance().deviceToken = fcmToken!
        print("deviceToken",UserModel.sharedInstance().deviceToken)
        UserModel.sharedInstance().synchroniseData()
       
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to auth.
//        let firebaseAuth = Auth.auth()
//        //At development time we use .sandbox
//        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
        
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        
        print("deviceToken1",deviceToken)
        print("deviceTokenString",deviceTokenString)
        
//        UserModel.sharedInstance().deviceToken = deviceTokenString
//        UserModel.sharedInstance().synchroniseData()
       
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        let date = Date()
        let formatter = DateFormatter()
//        formatter.dateFormat =  "MM/dd/yyyy"
        formatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        let saveTime = "\(formatter.string(from: date))"
        print("TodaysDate",saveTime)
        UserDefaults.standard.set(saveTime, forKey: "saveTime")
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ChangeVC"), object: nil)
        if UserModel.sharedInstance().userId != nil{
            globalObjects.shared.isFromBackGroundState = true
        }else{
            globalObjects.shared.isFromBackGroundState = false
        }
        if let _ = UserModel.sharedInstance().userId{
            let now = Date()
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "HH:mm:ss"
            exitTime = formatter.string(from: now)
            totTime = findDateDiff(time1Str: globalObjects.shared.AppEnteredTime ?? "", time2Str: exitTime!)
            UserModel.sharedInstance().AppTotalTime = totTime
            UserModel.sharedInstance().synchroniseData()
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if UserModel.sharedInstance().AppTotalTime != nil{
            callSetAverageTimeApi(_time: totTime!)
        }
        if globalObjects.shared.isFromBackGroundState == true{
            
           let getTimeStr = UserDefaults.standard.string(forKey: "saveTime")
            if(getTimeStr != "" || getTimeStr != nil){
                
                let datee = Date()
                let formatterr = DateFormatter()
                formatterr.dateFormat =  "yyyy-MM-dd HH:mm:ss"
                let curntTime = "\(formatterr.string(from: datee))"
                
                  let firstDate = formatterr.date(from: curntTime)
                let secondDate = formatterr.date(from: getTimeStr!)
                
                let diffSeconds = firstDate!.timeIntervalSinceReferenceDate - secondDate!.timeIntervalSinceReferenceDate
                
                print("diffSeconds",diffSeconds)

                if diffSeconds < 180 {
//                  if firstDate?.compare(secondDate!) == .orderedDescending {
                      print("Time is shorter than 3 mins")
                      
                  }
                else{
                    let homeStoryBoard = UIStoryboard(name: "SignIn", bundle: nil)
                    let desireViewController = homeStoryBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC
                    desireViewController.projectId = self.projectId
                    desireViewController.modalPresentationStyle = .fullScreen
                    self.window?.rootViewController?.present(desireViewController, animated: true, completion: nil)
                    self.window!.makeKeyAndVisible()
                }
                
            }
            else{
                let homeStoryBoard = UIStoryboard(name: "SignIn", bundle: nil)
                let desireViewController = homeStoryBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC
                desireViewController.projectId = self.projectId
                desireViewController.modalPresentationStyle = .fullScreen
                self.window?.rootViewController?.present(desireViewController, animated: true, completion: nil)
                self.window!.makeKeyAndVisible()
            }

        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if self.totTime != nil{
            UserModel.sharedInstance().AppTotalTime = self.totTime
        }
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let tokenParts = deviceToken.map { data -> String in
//            return String(format: "%02.2hhx", data)
//        }
//        let token = tokenParts.joined()
//        deviceTokenString = token
//        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//        print("this will return '32 bytes' in iOS 13+ rather than the token \(tokenString)")
//        print("for App : \(deviceTokenString!)")
//        UserModel.sharedInstance().deviceToken = deviceTokenString!
//        UserModel.sharedInstance().synchroniseData()
//    }
    
     func setUpDrawer() {
        
        guard let centerController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "NewDJHomeVC") as? NewDJHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
    
         nav = UINavigationController.init(rootViewController: centerController)
         nav.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: nav,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle
      self.window?.rootViewController = sideMenuController
      self.window?.makeKeyAndVisible()
    }
    
     func setUpDrawerArtist() {
        
        guard let centerController = UIStoryboard.init(name: "ArtistHome", bundle: nil).instantiateViewController(withIdentifier: "NewArtistHomeVC") as? NewArtistHomeVC else { return }
        guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
    
         nav = UINavigationController.init(rootViewController: centerController)
         nav.setNavigationBarHidden(true, animated: false)
            let sideMenuController = LGSideMenuController(rootViewController: nav,
                                                          leftViewController: sideController,
                                                          rightViewController: nil)
            //sideMenuController.leftViewWidth = 280.0
        sideMenuController.leftViewPresentationStyle = .scaleFromLittle
       // if #available(iOS 13, *) {
//                  guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                      let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
//                         return window
       // } else {
            
      self.window?.rootViewController = sideMenuController
      self.window?.makeKeyAndVisible()
       // }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    internal func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Message \(response.notification.request.content.userInfo)")
//        if let Notification_type = response.notification.request.content.userInfo["gcm.notification.type"] as? String{
        if let Notification_type = response.notification.request.content.userInfo["aps"] as? NSDictionary{
            //if let aps = userInfo["aps"] as? NSDictionary {
                               // self.notificationDetail = Notification_type
                               // UserModel.sharedInstance().notificationCount! += 1
                               // UserModel.sharedInstance().synchroniseData()
                                if let aps = Notification_type["alert"] as? NSDictionary {
                                   // self.notificationType = type
//                                    if let type = ntype["title"] as? String {
                                    if let type = aps["title"] as? String {
                                        self.notificationType = type
                                         if type == "drop_request" {
                                                                }else if type == "review_request" {
                                                                    self.review_request(aps["sender_id"] as! String)
                                                                }else if type == "Buy_Project_Artist_Audio"{
                                                                   // self.projectID = aps["projectid"] as! String
                                                                   // self.audioID = aps["audioId"] as! String
                                                                   // self.Buy_Project_Artist_Audio(aps["projectid"] as! String)
//                                                                    let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
//                                                                            let next1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
//                                                                            next1?.isFromMenu = false
//                                                                            navigationController?.pushViewController(next1!, animated: true)
                                                            
                                                                    let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
                                                                    let projectDetailVc = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
                                                                    projectDetailVc.isFromMenu = false
                                                                    nav = UINavigationController.init(rootViewController:projectDetailVc)
                                                                    nav.navigationBar.isHidden = true
                                                                    self.window?.rootViewController = self.nav
                                                                    self.window?.makeKeyAndVisible()
                                                                    
                                                                }else if type == "admin"{
                                                                   // self.admin(aps["title"] as! String,dateInfo: aps["create_date"] as! String,msgDesc: aps["message"] as! String,id: aps["id"] as! String)
                                                                    self.moveToNavigationScreen()
                                                                }else if type == "drop_live"{
                                                                   // self.drop_live(aps["video_id"] as! String,aps["broadcastID"] as! String)
                                                                    self.moveToNavigationScreen()
                                                                }else if type == "Buy_Project_Artist_Audio_Rejected" || type == "Buy_Project_Artist_Audio_Accepted"{
//                                                                    if aps["is_offer"] as! String == "0"{
//                                                                        self.callBuyConnectVC(id: aps["projectid"] as! String)
//                                                                    }else{
//                                                                        self.callArtistOfferVC(id: aps["projectid"] as! String)
//                                                                    }
                                                                    self.moveToNavigationScreen()
                                                                }else if type == "newproject_added" || type == "refund_cancle_project"{
                                                                   // self.Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)
                                                                    self.moveToNavigationScreen()
                                                                }else if type == "drop_song_live"{
                                                                   // self.drop_song_live(aps["video_id"] as! String,aps["broadcastID"] as! String,aps["sender_id"] as! String)
                                                                    self.moveToNavigationScreen()
                                                                
                                                                }else if type == "add_favorite"{
                                                                   // self.add_favorite()
                                                                }else if type == "project_ending"{
                                                                   // self.Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)
                                                                    
                                                                    self.moveToNavigationScreen()
                                                                }
                                    }
                                    
                                }
          
        }
        completionHandler()
    }
   
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
        UserDefaults.standard.set("123456", forKey: "device_token")
    }
    
    func moveToNavigationScreen(){
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: nil)
        let projectDetailVc = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        projectDetailVc.isFromMenu = false
        nav = UINavigationController.init(rootViewController:projectDetailVc)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = self.nav
        self.window?.makeKeyAndVisible()
    }
    
    func ChangeRoottoHome() {
        let homeStoryBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let desireViewController = homeStoryBoard.instantiateViewController(withIdentifier: "GetPinVC") as! GetPinVC
        desireViewController.notify_type = self.notificationType
        desireViewController.notify_detail = self.notificationDetail
       // self.window?.rootViewController?.navigationController?.pushViewController(desireViewController, animated: true)
        desireViewController.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(desireViewController, animated: true, completion: nil)
        self.window!.makeKeyAndVisible()
    }
    
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self as! UNUserNotificationCenterDelegate
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "HH:mm:ss"
        
        guard let time1 = timeformatter.date(from: time1Str),
              let time2 = timeformatter.date(from: time2Str) else { return "" }
        
        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let sec = interval.truncatingRemainder(dividingBy: 60)
        let intervalInt = Int(interval)
        return "\(Int(hour)):\(Int(minute)):\(Int(sec))"
    }
    
    func callSetAverageTimeApi(_time : String){
        print("APi Entered")
        let parameters = [
            "token":"\(UserModel.sharedInstance().token!)",
            "userid":"\(UserModel.sharedInstance().userId!)",
            "user_type":"\(UserModel.sharedInstance().userType!))",
            "time":"\(_time)"
            
        ]
        
        Alamofire.request("\(webservice.url)\(webservice.addTimeAPI)", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
            
            switch response.result {
            case .success(_):
                Loader.shared.hide()
                let acceptRejectProfile = response.result.value!
            case .failure(let error):
                Loader.shared.hide()
                debugPrint(error)
            }
        }
    }
    
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation == nil {
            currentLocation = locations.last
            locationManager?.stopMonitoringSignificantLocationChanges()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
            UserModel.sharedInstance().currentLatitude = locationValue.latitude
            UserModel.sharedInstance().currentLongitude = locationValue.longitude
            UserModel.sharedInstance().synchroniseData()
            locationManager?.stopUpdatingLocation()
        }
    }
    
    // Below Mehtod will print error if not able to update location.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // Print notification payload data
        print(userInfo)
        if !isFromInActive{
            isFromInActive = false
            if UserModel.sharedInstance().userId != nil {
                if ( application.applicationState == UIApplication.State.active) {
                    if(UserModel.sharedInstance().notificationCount != nil){
                    UserModel.sharedInstance().notificationCount! += 1
                    UserModel.sharedInstance().synchroniseData()
                    }
                    if let aps = userInfo["aps"] as? NSDictionary {
                        self.notificationDetail = aps
                        if let type = aps["type"] as? String {
                            self.notificationType = type
                            if type == "drop_request" {

                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.drop_request(aps["sender_id"] as! String)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            } else if type == "review_request"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.review_request(aps["sender_id"] as! String)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "Buy_Project_Artist_Audio"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.Buy_Project_Artist_Audio(aps["project_id"] as! String)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "admin"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.admin(aps["title"] as! String,dateInfo: aps["create_date"] as! String,msgDesc: aps["message"] as! String,id: aps["id"] as! String)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "drop_live"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.drop_live(aps["video_id"] as! String,aps["broadcastID"] as! String)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "Buy_Project_Artist_Audio_Rejected" || type == "Buy_Project_Artist_Audio_Accepted"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    if aps["is_offer"] as! String == "0"{
                                        self.callBuyConnectVC(id: aps["projectid"] as! String)
                                    }else{
                                        self.callArtistOfferVC(id: aps["projectid"] as! String)
                                    }
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "newproject_added" || type == "refund_cancle_project"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "drop_song_live"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.drop_song_live(aps["video_id"] as! String,aps["broadcastID"] as! String,aps["sender_id"] as! String)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "add_favorite"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.add_favorite()
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }else if type == "project_ending"{
                                let alertController = UIAlertController(title: "\(aps["title"] ?? "DJConnect")", message: "\(aps["alert"] ?? "")", preferredStyle: .alert)

                                let okAction = UIAlertAction(title: "Connect", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    self.Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)                                    }

                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in

                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)

                            }
                        }
                    }

                }
            }
        }
    }
    
    func application(_ application: UIApplication,
                     handleActionWithIdentifier identifier: String?,
                     for notification: UILocalNotification,
                     completionHandler: () -> Void) {
        
        // Handle notification action
        if notification.category == "Song_Request" {
            let action:Actions = Actions.init(rawValue: identifier!)!
            switch action{
            case Actions.accept:
                callAcceptRejectSongWebService(audioStatus: "1", audioId: "\(self.audioID)")
            case Actions.reject:
                callAcceptRejectSongWebService(audioStatus: "2", audioId: "\(self.audioID)")
            }
        }
        completionHandler()
    }
    
    //MARK:- Push notification ashitesh
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        if let aps = userInfo["aps"] as? NSDictionary {
//            self.notificationDetail = aps
//            if let type = aps["type"] as? String {
//                self.notificationType = type
//                if type == "drop_request" {
//                    drop_request(aps["sender_id"] as! String)
//                }else if type == "review_request" {
//                    review_request(aps["sender_id"] as! String)
//                }else if type == "Buy_Project_Artist_Audio"{
//                    self.projectID = aps["project_id"] as! String
//                    self.audioID = aps["audioId"] as! String
//                    Buy_Project_Artist_Audio(aps["project_id"] as! String)
//                }else if type == "admin"{
//                    admin(aps["title"] as! String,dateInfo: aps["create_date"] as! String,msgDesc: aps["message"] as! String,id: aps["id"] as! String)
//                }else if type == "drop_live"{
//                    drop_live(aps["video_id"] as! String,aps["broadcastID"] as! String)
//                }else if type == "Buy_Project_Artist_Audio_Rejected" || type == "Buy_Project_Artist_Audio_Accepted"{
//                    if aps["is_offer"] as! String == "0"{
//                        self.callBuyConnectVC(id: aps["projectid"] as! String)
//                    }else{
//                        self.callArtistOfferVC(id: aps["projectid"] as! String)
//                    }
//                }else if type == "newproject_added" || type == "refund_cancle_project"{
//                    Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)
//                }else if type == "drop_song_live"{
//                    drop_song_live(aps["video_id"] as! String,aps["broadcastID"] as! String,aps["sender_id"] as! String)
//                }else if type == "add_favorite"{
//                    self.add_favorite()
//                }else if type == "project_ending"{
//                    self.Buy_Project_Artist_Audio_Rejected(aps["projectid"] as! String)
//                }
//            }
//        }
//    }
    
    
    //MARK:- Push Notification Function
    func drop_request(_ artistId : String){
        let storyboard = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "DjDropVC") as? DjDropVC
        next1?.artist_id = "\(artistId)"//TODO: Pass artist ID here
        next1?.projectUserId = "\(artistId)"
        next1?.isDropAlert = false
        next1?.isFromNotification = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = next1
    }
    
    func review_request(_ artistId : String){
        let storyboard = UIStoryboard(name: "DJProfile", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "DJSongReviewsVC") as? DJSongReviewsVC
        next1?.artist_id = "\(artistId)"//TODO: Pass artist ID here
        next1?.djId = "\(artistId)"
        next1?.isSongReviewAlert = false
        next1?.isFromNotification = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = next1
    }
    
    func Buy_Project_Artist_Audio(_ projectId : String){
        let storyboard = UIStoryboard(name: "DJProfile", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "DJProjectDetail") as! DJProjectDetail
        vc1.isFromAlert = false
        vc1.isFromNotification = true
        vc1.projectId = "\(projectId)"//TODO: pass id here
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = vc1
    }
    
    func admin(_ msgType: String, dateInfo: String, msgDesc: String, id: String){
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: Bundle.main)
        let next1 = storyboard.instantiateViewController(withIdentifier: "AdminAlertVC") as? AdminAlertVC
        next1?.messageType = "\(msgType)"
        next1?.dateTimeInfo = "\(dateInfo)"
        next1?.messageDesc = "\(msgDesc)"
        next1?.deleteId = "\(id)"
        next1?.isFromNotification = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = next1
    }
    
    func drop_live(_ broadcastId : String, _ videoId: String){
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: Bundle.main)
        let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistLiveVideoRecieveVC") as? ArtistLiveVideoRecieveVC
        next1!.isFromNotification = true
        next1!.id = "\(videoId)"
        next1!.broadCastID = "\(broadcastId)"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = next1
    }
    
    func drop_song_live(_ broadcastId : String, _ videoId: String, _ senderId: String){
        let storyboard = UIStoryboard(name: "AlertFlow", bundle: Bundle.main)
        let next1 = storyboard.instantiateViewController(withIdentifier: "SongReviewVideoRecieveVC") as? SongReviewVideoRecieveVC
        next1!.isFromNotification = true
        next1!.id = "\(videoId)"
        next1!.broadCastID = "\(broadcastId)"
        next1!.getSenderId = "\(senderId)"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = next1
    }
    
    func Buy_Project_Artist_Audio_Rejected(_ projectId : String){
        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
        vc1.isFromNotification = true
        vc1.projectId = "\(projectId)"//TODO: pass id here
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = vc1
    }
    
    func add_favorite(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "FavoriteMenuVC") as! FavoriteMenuVC
        vc1.isFromNotification = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = vc1
    }
    func setNotificationSwipeActions(){
        let notificationCategoryIdentifier = "Song_Request"
        
        let acceptAction = UIMutableUserNotificationAction()
        acceptAction.identifier = Actions.accept.rawValue
        acceptAction.title = "ACCEPT"
        acceptAction.activationMode = UIUserNotificationActivationMode.background
        acceptAction.isAuthenticationRequired = true
        acceptAction.isDestructive = false
        
        let rejectAction = UIMutableUserNotificationAction()
        rejectAction.identifier = Actions.reject.rawValue
        rejectAction.title = "REJECT"
        rejectAction.activationMode = UIUserNotificationActivationMode.background
        rejectAction.isAuthenticationRequired = true
        rejectAction.isDestructive = false
        
        let actionCategory = UIMutableUserNotificationCategory()
        actionCategory.identifier = notificationCategoryIdentifier
        
        actionCategory.setActions(
            [acceptAction, rejectAction],
            for: .default)
        
        let notificationCategories = Set<AnyHashable>([actionCategory])
        let notificationTypes: UIUserNotificationType = [.alert, .sound, .badge]
        
        var settings: UIUserNotificationSettings?
        settings = UIUserNotificationSettings(
            types: notificationTypes,
            categories: notificationCategories as? Set<UIUserNotificationCategory>)
        
        if let settings = settings {
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func callAcceptRejectSongWebService(audioStatus: String, audioId : String){
        if getReachabilityStatus(){
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "projectid":"\(self.projectID)",
                "audioid":"\(self.audioID)",
                "audio_status":"\(audioStatus)",
                "reason":""
            ]
            Alamofire.request(getServiceURL("http://keshavinfotechdemo.com/KESHAV/KG2/JSON/webservices/app/accept-reject-artist-audio.php?"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let acceptRejectProfile = response.result.value!
                    if acceptRejectProfile.success == 1{
                        
                    }else{
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }
    }
    
    func getServiceURL(_ strURL:String) -> URL {
        return URL(string: strURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!)!
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
    
    func callBuyConnectVC(id: String){
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        let startString = detailProject.projectDetails![0].event_start_time!
                        let startdateFormatter = DateFormatter()
                        startdateFormatter.dateFormat = "HH:mm"
                        let startdate = startdateFormatter.date(from: startString)
                        startdateFormatter.dateFormat = "h:mm a"
                        let startDate12 = startdateFormatter.string(from: startdate!)
                        
                        let endString = detailProject.projectDetails![0].event_end_time!
                        let enddateFormatter = DateFormatter()
                        enddateFormatter.dateFormat = "HH:mm"
                        let enddate = enddateFormatter.date(from: endString)
                        enddateFormatter.dateFormat = "h:mm a"
                        let endDate12 = enddateFormatter.string(from: enddate!)
                        
                        let dateString = detailProject.projectDetails![0].event_day_date!
                        let dateFormatter1 = DateFormatter()
                        dateFormatter1.dateFormat = "MM/dd/yyyy"
                        let date = dateFormatter1.date(from: dateString)
                        dateFormatter1.dateFormat = "MMM d, yyyy"
                        let date2 = dateFormatter1.string(from: date!)
                        let weekday = Calendar.current.component(.weekday, from: date!)
                        var day = String()
                        switch weekday {
                        case 1:
                            day = "Sunday - "
                        case 2:
                            day = "Monday - "
                        case 3:
                            day = "Tuesday - "
                        case 4:
                            day = "Wednesday - "
                        case 5:
                            day = "Thursday - "
                        case 6:
                            day = "Friday - "
                        case 7:
                            day = "Saturday - "
                        default:
                            day = "Sunday - "
                        }
                        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
                        let next1 = storyboard.instantiateViewController(withIdentifier: "BuyConnectVC") as? BuyConnectVC
                        next1?.userDetailDict["projectId"] = id
                        next1?.userDetailDict["projectName"] = detailProject.projectDetails![0].title!
                        next1?.userDetailDict["projectBy"] = "By ".localize + detailProject.projectDetails![0].project_by!
                        next1?.userDetailDict["EventDayandDate"] = day + date2
//                        next1?.userDetailDict["eventTime"] = startDate12 + " to ".localize
//                            + endDate12
                        next1?.userDetailDict["eventTime"] = startDate12
                        next1?.userDetailDict["imgUrl"] = "\(detailProject.projectDetails![0].project_image!)"
                        next1?.userDetailDict["projUserId"] = "\(detailProject.projectDetails![0].userid!)"
                        next1?.userDetailDict["is_complete"] = "\(detailProject.projectDetails![0].is_completed!)"
                        next1?.userDetailDict["isBuyOn"] = "\(detailProject.projectDetails![0].is_buy_project!)"
                        next1?.userDetailDict["ProjectCost"] = "\(detailProject.projectDetails![0].price!)"
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window!.rootViewController = next1
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    func callArtistOfferVC(id: String){
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(id)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
                        let next1 = storyboard.instantiateViewController(withIdentifier: "ArtistOfferVC") as? ArtistOfferVC
                        next1?.userDetailDict["projectBy"] = detailProject.projectDetails![0].project_by!
                        next1?.userDetailDict["userProfile"] = "\(detailProject.projectDetails![0].project_image!)"
                        next1?.userDetailDict["projId"] = id
                        next1?.userDetailDict["projUserId"] = "\(detailProject.projectDetails![0].userid!)"
                        next1?.userDetailDict["isOfferOn"] = "\(detailProject.projectDetails![0].is_buy_offer!)"
                        next1?.userDetailDict["projectName"] = "\(detailProject.projectDetails![0].title!)"
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window!.rootViewController = next1
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
}

extension UIApplication {
    var statusBarUIView: UIView? {
        
        if #available(iOS 13.0, *) {
            let tag = 3848245
            
            let keyWindow = UIApplication.shared.connectedScenes
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999
                
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
            
        } else {
            
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}

