//
//  ComplateProfileVC.swift
//  DJConnect
//
//  Created by mac on 02/04/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import Alamofire

class ComplateProfileVC: UIViewController  {
    //MARK: - OUTLETS
    @IBOutlet weak var btnArtist_Yes: UIButton!
    @IBOutlet weak var btnArtist_No: UIButton!
    
    @IBOutlet weak var lblArtProfileComplete: UILabel!
    @IBOutlet weak var lblArtProfileDetail: UILabel!
    @IBOutlet weak var lblArtStep1: UILabel!
    @IBOutlet weak var lblArtStep1Detail: UILabel!
    @IBOutlet weak var lblArtStep2: UILabel!
    @IBOutlet weak var lblArtStep2Detail: UILabel!
    @IBOutlet weak var lblArtStep3: UILabel!
    @IBOutlet weak var lblArtStep3Detail: UILabel!
    @IBOutlet weak var btnArtExit: buttonProperties!
    @IBOutlet weak var lblShownextTime: UILabel!
    @IBOutlet weak var lblArtYes: UILabel!
    @IBOutlet weak var lblArtNo: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var yesNoSelected = false
    var yesNoData = String()
    
    //MARK:- UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeElements()
    }
    
    //MARK:- OTHER METHODS
    func localizeElements(){
        lblArtProfileComplete.text = "PROFILE COMPLETE".localize
        lblArtProfileDetail.text = "artist tutorial ack".localize
        lblArtStep1.text = "1st - SEARCH".localize
        lblArtStep1Detail.text = "search by entering".localize
        lblArtStep2.text = "2nd - CLICK".localize
        lblArtStep2Detail.text = "click the green".localize
        lblArtStep3.text = "3rd - SWIPE".localize
        lblArtStep3Detail.text = "Swipe left".localize
        btnArtExit.setTitle("Exit".localize, for: .normal)
        lblShownextTime.text = "Show this next time?".localize
        lblArtYes.text = "yes".localize
        lblArtNo.text = "no".localize
    } 
    
    //MARK: - ACTIONS
    @IBAction func btnClose_Action(_ sender: UIButton) {
        UserModel.sharedInstance().isSignup = false
        UserModel.sharedInstance().synchroniseData()
        if yesNoSelected == true{
            callSetArtistTutorialWebService()
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }else{
            self.view.makeToast("Please select yes or no.".localize)
        }
    }
    
    @IBAction func btnArtist_YesAction(_ sender: UIButton) {
        yesNoSelected = true
        yesNoData = "yes"
        btnArtist_Yes.setImage(UIImage(named: "check-with-close"), for: .normal)
        btnArtist_No.setImage(UIImage(named: "boxwithclear"), for: .normal)
    }
    
    @IBAction func btnArtist_NoAction(_ sender: UIButton) {
        yesNoSelected = true
        yesNoData = "no"
        btnArtist_Yes.setImage(UIImage(named: "boxwithclear"), for: .normal)
        btnArtist_No.setImage(UIImage(named: "check-with-close"), for: .normal)
    }
    
    //MARK:- WEBSERVICES
    func callSetArtistTutorialWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "setting":"\(yesNoData)"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.setTutorialAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProjectTypeList>) in
                
                switch response.result {
                case .success(_):
                    let SetProfile = response.result.value!
                    if SetProfile.success == 1{
                        Loader.shared.hide()
                    }else{
                        self.view.makeToast(SetProfile.message)
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
}
