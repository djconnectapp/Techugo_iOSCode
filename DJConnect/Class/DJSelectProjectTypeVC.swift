//
//  DJSelectProjectTypeVC.swift
//  DJConnect
//
//  Created by My Mac on 20/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class DJSelectProjectTypeVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var lblDate: UILabel!
    //localize outlets
    @IBOutlet weak var lblSelectPost: UILabel!
    @IBOutlet weak var lblOpenConnect: UILabel!
    @IBOutlet weak var lblOpenConnectDetail: UILabel!
    @IBOutlet weak var btnOpenConnect: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    
    //MARK:- UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDate.text = dateSelected
        lblSelectPost.text = "Select Post Type".localize
        lblOpenConnect.text = "Open Connect".localize
        lblOpenConnectDetail.text = "Open Detail".localize
        btnOpenConnect.setTitle("open button".localize, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        if UserModel.sharedInstance().appLanguage == "0"{
            btnBack.setImage(UIImage(named: "back_arrow_arabic"), for: .normal)
        }else{
            btnBack.setImage(UIImage(named: "back_arrow_english"), for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        callAlertApi()
    }
    
    //MARK: - GLOBAL VARIABLES
    var dateSelected = String()
    var postDate = Date()
    
    //MARK: - OTHER METHODS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePostTypeOpenproject" {
            let destinationVC = segue.destination as! DJAddPostVC
            destinationVC.dateSelected = dateSelected
            destinationVC.postDate = postDate
        }
        if segue.identifier == "segueSelectCommercial"{
            let destinationVC = segue.destination as! DjCommercialAdVC
            destinationVC.dateSelected = dateSelected
        }
    }
    
    //MARK: - SELECTORS
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
    }
    
    //MARK: - WEBSERVICES
    func callAlertApi(){
        let notiCount = UserModel.sharedInstance().notificationCount
        if notiCount != nil {
            if notiCount! > 0 {
                self.lblMenuNotifyNumber.isHidden = false
                self.lblMenuNotifyNumber.text = "\(notiCount!)"
            }else{
                self.lblMenuNotifyNumber.isHidden = true
            }
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnCloseAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSideMenuAction(_ sender: UIButton) {
        toggleSideMenuView()
    }
    @IBAction func btnSelectAction(_ sender: UIButton) {
        performSegue(withIdentifier: "seguePostTypeOpenproject", sender: nil)
    }
}
