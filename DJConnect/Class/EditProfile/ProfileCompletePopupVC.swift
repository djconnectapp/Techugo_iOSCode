//
//  ProfileCompletePopupVC.swift
//  DJConnect
//
//  Created by My Mac on 02/04/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit

class ProfileCompletePopupVC: UIViewController {
    
    
    //MARK:- OUTLETS
    @IBOutlet weak var lblProfileInc_Main: UILabel!
    @IBOutlet weak var lblProfileInc_Profile: UILabel!
    @IBOutlet weak var lblProfileInc_Payment: UILabel!
    @IBOutlet weak var lblProfileInc: UILabel!
    @IBOutlet weak var lblProfIncText: UILabel!
    @IBOutlet weak var lblPaymentIncText: UILabel!
    @IBOutlet weak var btnSkip: UIButton!

    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- BUTTON ACTION
    @IBAction func btnFinishProfileAction(_ sender: UIButton) {
        UserModel.sharedInstance().finishPopup = true
        UserModel.sharedInstance().finishProfile = true
        UserModel.sharedInstance().synchroniseData()
        dismiss(animated: true, completion: nil)
    }
}
