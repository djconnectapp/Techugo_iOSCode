//
//  StripeCheckoutVwModel.swift
//  DJConnect
//
//  Created by Techugo on 17/08/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class StripeCheckoutVwModel: NSObject {

    //MARK: - Properties
    weak var view: FinancialViewController?
    var successClosure :(() -> Void)?
    var errorClosure:() -> (Void) = {   }
    var logoutClosure:() -> (Void) = {   }
    var errorString:String?
   
    //MARK: - METHOD TO GET CUSTOMERS LIST
    func getCustomerList(completionHandler:@escaping(GetCustomerModel)->()) {
//        let appDelegate = AppDelegate()
//        appDelegate.startLoader(viewName: (self.view?.view)!)
//        let requestDict = [String:Any]()
//        let rqst = Services.requestToGetCustomerList(dict: requestDict as [String : Any])
//        ServiceMaster.sharedInstance.getResponseInModelData(for: GetCustomerModel.self, rqst: rqst, withResponse: { [weak self] (response) in
//            appDelegate.stopLoader()
//            let objMaster = response?.objDecodable as! GetCustomerModel
//            if objMaster.data?.count != 0{
//                appDelegate.stopLoader()
//                completionHandler(objMaster)
//            }
//            else{
//
//                appDelegate.stopLoader()
//                self?.view?.view.makeToast("Something went wrong",position:.top)
//            }
//        }) { (error) in
//            appDelegate.stopLoader()
//        }
    }
    
    func getEphemeralKey(customerID:String,completionHandler:@escaping(GetEphemeralKeyModel)->()) {
//        let appDelegate = AppDelegate()
//        appDelegate.startLoader(viewName: (self.view?.view)!)
//        let rqst = Services.requestToGetEphemeralKey(customerID: customerID, stripeVersion: "2020-08-27")
//        ServiceMaster.sharedInstance.getResponseInModelData(for: GetEphemeralKeyModel.self, rqst: rqst, withResponse: { [weak self] (response) in
//            appDelegate.stopLoader()
//            let objMaster = response?.objDecodable as! GetEphemeralKeyModel
//            if objMaster.id != "" || objMaster.id != nil{
//                appDelegate.stopLoader()
//                completionHandler(objMaster)
//            }
//            else{
//                appDelegate.stopLoader()
//                self?.view?.view.makeToast("Something went wrong",position:.top)
//            }
//        }) { (error) in
//            appDelegate.stopLoader()
//        }
    }
    
    func getPaymentIntent(customerID:String,amount:String,currency:String,completionHandler:@escaping(GetPayMentIntentModel)->()) {
//        let appDelegate = AppDelegate()
//        appDelegate.startLoader(viewName: (self.view?.view)!)
//        let rqst = Services.requestToGetPaymentIntent(customerID: customerID, amount: amount, currency: currency)
//        ServiceMaster.sharedInstance.getResponseInModelData(for: GetPayMentIntentModel.self, rqst: rqst, withResponse: { [weak self] (response) in
//            appDelegate.stopLoader()
//            let objMaster = response?.objDecodable as! GetPayMentIntentModel
//            if objMaster.id != "" || objMaster.id != nil{
//                appDelegate.stopLoader()
//                completionHandler(objMaster)
//            }
//            else{
//
//                appDelegate.stopLoader()
//                self?.view?.view.makeToast("Something went wrong",position:.top)
//            }
//        }) { (error) in
//            appDelegate.stopLoader()
//        }
    }
}

