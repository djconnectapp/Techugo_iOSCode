//
//  AdditionalInfoVC.swift
//  DJConnect
//
//  Created by Techugo on 30/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class AdditionalInfoVC: UIViewController {
    
    @IBOutlet weak var hdrAdditionInfoLbl: UILabel!
    @IBOutlet weak var enterHereLbl: UILabel!
    @IBOutlet weak var enterHereBgVw: UIView!
    @IBOutlet weak var enterHereTxtVw: UITextView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    
    var getPrjectNameStr = String()
    var getPrjectDEtailStr = String()
    var getProjImage:UIImage?
    var prjectTypeStr = String()
    var projectTypeIndex = String()
    var expectedAudienceStr = String()
    var venueName = String()
    var venueAddrss = String()
    var strtxfEventDateTime = String()
    var newSelecttimee = String ()
    
    var priceStr = String()
    var currencyIndex = ""
    var restrictionStr = String()
    var genreIds = String()
    var addFlag = String()
    var sendDate = String()
    var txtAdditnlInfoStr = String()
    var txtLatStr = String()
    var txtLongStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callTimeZoneApi()
        setUpVw()
        if GlobalId.id == "1"{
            enterHereTxtVw.text = txtAdditnlInfoStr
        }
    }
    
    func setUpVw(){
         
        enterHereBgVw.layer.cornerRadius = 10.0
        enterHereBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        enterHereBgVw.layer.borderWidth = 0.5
        enterHereBgVw.clipsToBounds = true
        
        enterHereTxtVw.delegate = self
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
    
    @IBAction func postBtnTapped(_ sender: Any) {
        
            if GlobalId.id == "1" {
                if(priceStr.isEmpty != true && UserModel.sharedInstance().userCurrency == "₹"){
                    
                        callSaveProjectWebService()
                }
                else if(priceStr.isEmpty != true){
                    
                        callSaveProjectWebService()
                }
            }else
            {
                if(priceStr.isEmpty != true && UserModel.sharedInstance().userCurrency == "₹"){
                   
                    callPostProjectWebService()
                }
                else if(priceStr.isEmpty != true){
                    
                    callPostProjectWebService()
                }

            }
    }
    
    //MARK: - WEBSERVICES
    func callPostProjectWebService(){
        if getReachabilityStatus(){

            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "project_title":"\(getPrjectNameStr)",
                "project_description":"\(getPrjectDEtailStr)",
                "project_type":"\(projectTypeIndex)",
                "project_type_other":"\(prjectTypeStr)",
                "expected_audiance":"\(expectedAudienceStr)",
                "venue_name":"\(venueName)",
                "event_date":"\(strtxfEventDateTime)",
                "event_start_time":"\(newSelecttimee)",
                "venue_address":"\(venueAddrss)",
                "venue_address_status":"\(addFlag)",
                "currency":"\(currencyIndex)",
                "latitude":"\(globalObjects.shared.projLat!)",
                "longitude":"\(globalObjects.shared.projLong!)",
                "price":"\(priceStr)",
                "restrications":"\(restrictionStr)",
                "genre_id":"\(self.genreIds)",
                "special_Information":" \(enterHereTxtVw.text!)",
                "project_date":"\(sendDate)",
                "artist_offer":"no"

            ]

            let headers: HTTPHeaders =
                ["Content-type": "multipart/form-data",
                 "Accept": "application/json"]

            Loader.shared.show()
            let profileImage = getProjImage?.jpegData(compressionQuality: 0.4)
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

                        self.view.makeToast("New project created successfully")
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.backTwo()
                        })
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
    
    func backTwo() {
        
        let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
        navigationController?.pushViewController(desiredViewController, animated: false)
        //self.navigationController?.popToRootViewController(animated: false)

    }
    
    func callSaveProjectWebService(){
        if getReachabilityStatus(){
            
            let parameters = [
                
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "project_title":"\(getPrjectNameStr)",
                "project_description":"\(getPrjectDEtailStr)",
                "project_type":"\(projectTypeIndex)",
                "project_type_other":"\(prjectTypeStr)",
                "expected_audiance":"\(expectedAudienceStr)",
                "venue_name":"\(venueName)",
                "event_date":"\(strtxfEventDateTime)",
                "event_start_time":"\(newSelecttimee)",
                "venue_address":"\(venueAddrss)",
                "venue_address_status":"\(addFlag)",
                "currency":"\(currencyIndex)",
                "latitude":txtLatStr,
                "longitude":txtLongStr,
                "price":"\(priceStr)",
                "restrications":"\(restrictionStr)",
                "genre_id":"\(self.genreIds)",
                "special_Information":" \(enterHereTxtVw.text!)",
                "project_date":"\(sendDate)",
                "artist_offer":"no",
                "project_id" : "\(GlobalId.ProjectDetailsId)"
            ]
            let headers: HTTPHeaders =
                ["Content-type": "multipart/form-data",
                 "Accept": "application/json"]
            Loader.shared.show()
            //let profileImage = getProjImage.image?.jpegData(compressionQuality: 0.8)
            let profileImage = getProjImage?.jpegData(compressionQuality: 1)
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
                        self.view.makeToast("Project data updated successfully")
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.backTwo()
                        })
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

    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}

//MARK: - EXTENSIONS
extension AdditionalInfoVC : UITextViewDelegate{
//    func textViewDidChange(_ textView: UITextView) {
//       // lbltextviewPlaceholder.isHidden = true
//        let len = textView.text.count
//        lblWordCounter.text = "\(len)/200"
//        print(String(format: "%i", 200 - len))
//    }
//
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.count == 0 {
            //lbltextviewPlaceholder.isHidden = false
            if textView.text.count != 0 {
                return true
            }
        } else if textView.text.count > 199 {
            return false
        }
        return true
    }
}
