
import UIKit

class UserModel: NSObject, NSCoding {
    
    var userId: String?
    var token: String?
    var name: String?
    var uniqueUserName: String?
    var birthdate: String?
    var email: String?
    var artist_type: String?
    var phone_number: String?
    var userType : String?
    var finishProfile: Bool?
    var isRemembered: String?
    var userName: String?
    var password: String?
    var pushNotificationStatus: String?
    var emailNotificationStatus: String?
    var isSignup : Bool?
    var isPin : Bool?
    var isSkip : Bool?
    var isExit : Bool?
    var isHomePress :Bool?
    var finishPopup : Bool?
    var paymentPopup : Bool?
    var appLanguage = "1"
    var genereList : String?
    var userProfileUrl: String?
    var deviceToken: String?
    var currentLatitude: Double?
    var currentLongitude: Double?
    var AppTotalTime : String?
    var RememberUserType: String?
    var currency_code: String?
    var currency_name : String?
    var currency_id : String?
    var userCurrency : String?
    var userCurrentBalance : Float?
    var splasshow = "no"
    var mapType : String?
    var userPin : String?
    var notificationCount : Int?
    var remainingTime : String?
    var arname:String?
    var arpassword: String?
    var countryName: String?
    var countryServiceName: String?
    var cityServiceName: String?
    var bioServiceName: String?
    
    var serviceLatitude: Double?
    var serviceLongitude: Double?
    
    var facebookLink: String?
    var twitterLink: String?
    var youtubeLink: String?
    var instagramLink: String?
    
    var genrePro: String?
    var feedbackPrice : String?
    var feedbackDetail : String?
    var setCurrencyNameSt : String?
    
    var artist_typeSt : String?
    //var projectIdSt : String?
    
    static var userModel: UserModel?
    static func sharedInstance() -> UserModel {
        if UserModel.userModel == nil {
            if let data = UserDefaults.standard.value(forKey: "UserModel") as? Data {
                let retrievedObject = NSKeyedUnarchiver.unarchiveObject(with: data)
                if let objUserModel = retrievedObject as? UserModel {
                    UserModel.userModel = objUserModel
                    return objUserModel
                }
            }
//                do {
//                    let retrievedObject = try NSKeyedUnarchiver.unarchivedObject(ofClass: self, from: data)
//                    if let objUserModel = retrievedObject {
//                        UserModel.userModel = objUserModel
//                        return objUserModel
//                    }
//                } catch {
//                    print("didn't work")
//                }
//            }
            
            
            
            if UserModel.userModel == nil {
                UserModel.userModel = UserModel.init()
            }
            return UserModel.userModel!
        }
        return UserModel.userModel!
    }
    
    override init() {
        
    }
        
    func synchroniseData(){
        let data : Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(data, forKey: "UserModel")
        UserDefaults.standard.synchronize()
    }
    
    func removeData() {
        UserModel.userModel = nil
        UserDefaults.standard.removeObject(forKey: "UserModel")
        UserDefaults.standard.synchronize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.userId = aDecoder.decodeObject(forKey: "userId") as? String
        self.token = aDecoder.decodeObject(forKey: "token") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.uniqueUserName = aDecoder.decodeObject(forKey: "uniqueUserName") as? String
        self.birthdate = aDecoder.decodeObject(forKey: "birthdate") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.artist_type = aDecoder.decodeObject(forKey: "artist_type") as? String
        self.phone_number = aDecoder.decodeObject(forKey: "phone_number") as? String
        self.userType = aDecoder.decodeObject(forKey: "userType") as? String
        self.finishProfile = aDecoder.decodeObject(forKey: "finishProfile") as? Bool
        self.isRemembered = aDecoder.decodeObject(forKey: "isRemembered") as? String
        self.userName = aDecoder.decodeObject(forKey: "userName") as? String
        self.password = aDecoder.decodeObject(forKey: "password") as? String
        self.genereList = aDecoder.decodeObject(forKey: "genereList") as? String
        self.userProfileUrl = aDecoder.decodeObject(forKey: "userProfileUrl") as? String
        self.deviceToken = aDecoder.decodeObject(forKey: "deviceToken") as? String
        self.AppTotalTime = aDecoder.decodeObject(forKey: "AppTotalTime") as? String
        self.RememberUserType = aDecoder.decodeObject(forKey: "RememberUserType") as? String
        self.isSignup = aDecoder.decodeObject(forKey: "isSignup") as? Bool
        self.isPin = aDecoder.decodeObject(forKey: "isPin") as? Bool
        self.isSkip = aDecoder.decodeObject(forKey: "isSkip") as? Bool
        self.isExit = aDecoder.decodeObject(forKey: "isExit") as? Bool
        self.isHomePress = aDecoder.decodeObject(forKey: "isHomePress") as? Bool
        self.finishPopup = aDecoder.decodeObject(forKey: "finishPopup") as? Bool
        self.paymentPopup = aDecoder.decodeObject(forKey: "paymentPopup") as? Bool
        self.pushNotificationStatus = aDecoder.decodeObject(forKey: "pushNotificationStatus") as? String
        self.emailNotificationStatus = aDecoder.decodeObject(forKey: "emailNotificationStatus") as? String
        self.splasshow = (aDecoder.decodeObject(forKey: "splasshow") as? String)!
        self.appLanguage = (aDecoder.decodeObject(forKey: "appLanguage") as? String)!
        //ashitesh
        self.currentLatitude = (aDecoder.decodeObject(forKey: "currentLatitude") as? Double) ?? 0.0
        self.currentLongitude = (aDecoder.decodeObject(forKey: "currentLongitude") as? Double) ?? 0.0
        self.currency_code = aDecoder.decodeObject(forKey: "currency_code") as? String
        self.userCurrency = aDecoder.decodeObject(forKey: "userCurrency") as? String
        self.currency_name = aDecoder.decodeObject(forKey: "currency_name") as? String
        self.currency_id = aDecoder.decodeObject(forKey: "currency_id") as? String
        self.userCurrentBalance = aDecoder.decodeObject(forKey: "userCurrentBalance") as? Float
        self.mapType = aDecoder.decodeObject(forKey: "mapType") as? String
        self.userPin = aDecoder.decodeObject(forKey: "userPin") as? String
        self.notificationCount = aDecoder.decodeObject(forKey: "notificationCount") as? Int
        self.remainingTime = aDecoder.decodeObject(forKey: "remainingTime") as? String
        self.arname = aDecoder.decodeObject(forKey: "arname") as? String
        self.arpassword = aDecoder.decodeObject(forKey: "arpassword") as? String
        self.countryName = aDecoder.decodeObject(forKey: "countryName") as? String
        self.countryServiceName = aDecoder.decodeObject(forKey: "countryServiceName") as? String
        self.cityServiceName = aDecoder.decodeObject(forKey: "cityServiceName") as? String
        self.bioServiceName = aDecoder.decodeObject(forKey: "bioServiceName") as? String
        
        self.serviceLatitude = aDecoder.decodeObject(forKey: "serviceLatitude") as? Double
        self.serviceLongitude = aDecoder.decodeObject(forKey: "serviceLongitude") as? Double
        
        self.facebookLink = aDecoder.decodeObject(forKey: "facebookLink") as? String
        self.twitterLink = aDecoder.decodeObject(forKey: "twitterLink") as? String
        self.youtubeLink = aDecoder.decodeObject(forKey: "youtubeLink") as? String
        self.instagramLink = aDecoder.decodeObject(forKey: "instagramLink") as? String
        
        self.genrePro = aDecoder.decodeObject(forKey: "genrePro") as? String
        self.feedbackPrice = aDecoder.decodeObject(forKey: "feedbackPrice") as? String
        self.feedbackDetail = aDecoder.decodeObject(forKey: "feedbackDetail") as? String
        self.setCurrencyNameSt = aDecoder.decodeObject(forKey: "setCurrencyNameSt") as? String
        self.artist_typeSt = aDecoder.decodeObject(forKey: "artist_typeSt") as? String
       // self.projectIdSt = aDecoder.decodeObject(forKey: "projectIdSt") as? String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.userId, forKey: "userId")
        aCoder.encode(self.token, forKey: "token")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.uniqueUserName, forKey: "uniqueUserName")
        aCoder.encode(self.birthdate, forKey: "birthdate")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.phone_number, forKey: "phone_number")
        aCoder.encode(self.userType, forKey: "userType")
        aCoder.encode(self.finishProfile, forKey: "finishProfile")
        aCoder.encode(self.isRemembered, forKey: "isRemembered")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.password, forKey: "password")
        aCoder.encode(self.password, forKey: "deviceToken")
        aCoder.encode(self.currentLatitude, forKey: "currentLatitude")
        aCoder.encode(self.currentLongitude, forKey: "currentLongitude")
        aCoder.encode(self.AppTotalTime, forKey: "AppTotalTime")
        aCoder.encode(self.isSignup, forKey: "isSignup")
        aCoder.encode(self.isPin, forKey: "isPin")
        aCoder.encode(self.isSkip, forKey: "isSkip")
        aCoder.encode(self.isExit, forKey: "isExit")
        aCoder.encode(self.isHomePress, forKey: "isHomePress")
        aCoder.encode(self.finishPopup, forKey: "finishPopup")
        aCoder.encode(self.paymentPopup, forKey: "paymentPopup")
        aCoder.encode(self.pushNotificationStatus, forKey: "pushNotificationStatus")
        aCoder.encode(self.emailNotificationStatus, forKey: "emailNotificationStatus")
        aCoder.encode(self.splasshow, forKey: "splasshow")
        aCoder.encode(self.appLanguage, forKey: "appLanguage")
        aCoder.encode(self.genereList, forKey: "genereList")
        aCoder.encode(self.userProfileUrl, forKey: "userProfileUrl")
        aCoder.encode(self.RememberUserType, forKey: "RememberUserType")
        aCoder.encode(self.currency_code, forKey: "currency_code")
        aCoder.encode(self.userCurrency, forKey: "userCurrency")
        aCoder.encode(self.currency_name, forKey: "currency_name")
        aCoder.encode(self.currency_id, forKey: "currency_id")
        aCoder.encode(self.userCurrentBalance, forKey: "userCurrentBalance")
        aCoder.encode(self.mapType,forKey: "mapType")
        aCoder.encode(self.userPin,forKey: "userPin")
        aCoder.encode(self.notificationCount,forKey: "notificationCount")
        aCoder.encode(self.remainingTime,forKey: "remainingTime")
        aCoder.encode(self.arname,forKey: "arname")
        aCoder.encode(self.arpassword,forKey: "arpassword")
        aCoder.encode(self.countryName,forKey: "countryName")
        aCoder.encode(self.countryServiceName,forKey: "countryServiceName")
        
        aCoder.encode(self.cityServiceName,forKey: "cityServiceName")
        aCoder.encode(self.bioServiceName,forKey: "bioServiceName")
        
        aCoder.encode(self.serviceLatitude,forKey: "serviceLatitude")
        aCoder.encode(self.serviceLongitude,forKey: "serviceLongitude")
        
        aCoder.encode(self.facebookLink,forKey: "facebookLink")
        aCoder.encode(self.twitterLink,forKey: "twitterLink")
        aCoder.encode(self.youtubeLink,forKey: "youtubeLink")
        aCoder.encode(self.instagramLink,forKey: "instagramLink")
        aCoder.encode(self.genrePro,forKey: "genrePro")
        aCoder.encode(self.feedbackPrice,forKey: "feedbackPrice")
        aCoder.encode(self.feedbackDetail,forKey: "feedbackDetail")
        aCoder.encode(self.setCurrencyNameSt,forKey: "setCurrencyNameSt")
        aCoder.encode(self.artist_typeSt,forKey: "artist_typeSt")
        
    }
}
