//
//  AdminAlertVC.swift
//  DJConnect
//
//  Created by mac on 19/06/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class AdminAlertVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblFromName: UILabel!
    @IBOutlet weak var lblMsgType: UILabel!
    @IBOutlet weak var lblDateTimeInfo: UILabel!
    @IBOutlet weak var lblAdminMessage: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var isFromNotification = false
    var dateTimeInfo = String()
    var messageType = String()
    var messageDesc = String()
    var deleteId = String()
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMsgType.text = messageType
        lblAdminMessage.text = messageDesc
        setDateandTimeFormat()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        callAlertDeleteWebService(_id: deleteId)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        if isFromNotification == true{
            backNotificationView()
        }else{
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            sideMenuController()?.setContentViewController(next1!)
        }
    }
    
    //MARK: - OTHER METHODS
    func setDateandTimeFormat(){
        let dateTime = dateTimeInfo.components(separatedBy: " ")
        let date = dateTime[0]
        let olddateFormatter = DateFormatter()
        olddateFormatter.dateFormat = "yyyy-MM-dd"
        let enddate = olddateFormatter.date(from: date)
        olddateFormatter.dateFormat = "MMMM d, yyyy"
        let newDate12 = olddateFormatter.string(from: enddate!)
        
        let time = dateTime[1]
        let oldtimeFormatter = DateFormatter()
        oldtimeFormatter.dateFormat = "HH:mm:ss"
        let newTime = oldtimeFormatter.date(from: time)
        oldtimeFormatter.dateFormat = "h:mm a"
        let newTime12 = oldtimeFormatter.string(from: newTime!)
        
        lblDateTimeInfo.text = newDate12 + " at " + newTime12
    }
    //MARK: - WEBSERVICES
    func callAlertDeleteWebService(_id : String){
        if getReachabilityStatus(){
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "alertid":"\(_id)"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.deleteAlertAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    let deleteAlertProfile = response.result.value!
                    if deleteAlertProfile.success == 1{
                        Loader.shared.hide()
                        self.view.makeToast(deleteAlertProfile.message)
                        let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
                        let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
                        self.sideMenuController()?.setContentViewController(next1!)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(deleteAlertProfile.message)
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
    //MARK: - EXTENSIONS
}
