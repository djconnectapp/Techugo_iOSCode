//
//  IncProfileVC.swift
//  DJConnect
//
//  Created by mac on 01/04/21.
//  Copyright © 2021 mac. All rights reserved.
//

class IncProfileVC: UIViewController  {
    //MARK: - OUTLETS
    @IBOutlet weak var lblProfileInc_Profile: UILabel!
    @IBOutlet weak var lblProfileInc_Payment: UILabel!
    @IBOutlet weak var lblProfileInc_Main: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    
    //MARK:- UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserModel.sharedInstance().userType == "AR" {
            lblProfileInc_Main.text = "popup artist ack".localize
            lblProfileInc_Profile.text = "artist finish profile".localize
            lblProfileInc_Payment.text = "artist payment text".localize
        }else {
            lblProfileInc_Main.text = "popup dj ack".localize
            lblProfileInc_Profile.text = "dj profile text".localize
            lblProfileInc_Payment.text = "dj payment text".localize
        }
    }
    
    //MARK:- OTHER METHODS
    
    //MARK: - ACTIONS
    @IBAction func btnAddPayment(_ sender: UIButton) {
        UserModel.sharedInstance().paymentPopup = true
        UserModel.sharedInstance().synchroniseData()
    }
}
