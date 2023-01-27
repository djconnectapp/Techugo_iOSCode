//
//  DjDropReceiptVC.swift
//  DJConnect
//
//  Created by mac on 13/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class DjDropReceiptStep2Cell: UICollectionViewCell{
    @IBOutlet weak var vwComplete: UIView!
    @IBOutlet weak var btnViewDrop: UIButton!
    @IBOutlet weak var lblDropTitle: UILabel!
    @IBOutlet weak var lblDropDescript: UILabel!
    @IBOutlet weak var vwDropStatus: UIView!
    @IBOutlet weak var lblDropStatusTitle: UILabel!
    @IBOutlet weak var lblDropStatusDescrip: UILabel!
    @IBOutlet weak var lblDropAck: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var lblDropStatusNotify: UILabel!
    
}

class DjDropReceiptStep1Cell : UICollectionViewCell{
    @IBOutlet weak var lblProjPrice: UILabel!
    @IBOutlet weak var lblTransFee: UILabel!
    @IBOutlet weak var lblTotPrice: UILabel!
}

class DjDropReceiptVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var CollectionVw: UICollectionView!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var imgDjProfile: imageProperties!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var projName = String()
    var djname = String()
    var eventDate = String()
    var projCost = String()
    var djId = String()
    var step1ProjPrice =  String()
    var step1TransFee = String()
    var step1TotalPrice = String()
    var currency = String()
    var step2DropTitle = String()
    var step2DropDescrip = String()
    var step3DropTitle = String()
    var step3DropDescrip = String()
    var RemainingTime = String()
    var isComplete = Bool()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callStep1DataWebService()
        GetDjDropDataWebService()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnLeftAction(_ sender: UIButton) {
        let collectionBounds = self.CollectionVw.bounds
        let contentOffset = CGFloat(floor(self.CollectionVw.contentOffset.x - collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    @IBAction func btnRightAction(_ sender: UIButton) {
        let collectionBounds = self.CollectionVw.bounds
        let contentOffset = CGFloat(floor(self.CollectionVw.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        if UserModel.sharedInstance().userType == "AR"{
            let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
            sideMenuController()?.setContentViewController(next1!)
        }else{
            let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "DJHomeVC") as? DJHomeVC
            sideMenuController()?.setContentViewController(next1!)
        }
    }
    
    //MARK: - OTHER METHODS
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.CollectionVw.contentOffset.y ,width : self.CollectionVw.frame.width,height : self.CollectionVw.frame.height)
        self.CollectionVw.scrollRectToVisible(frame, animated: true)
    }
    
    func startTimer() {
        let releaseDateString = "\(RemainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    //MARK: - SELECTOR METHODS
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        
        let indexPath1 = IndexPath.init(row: 0, section: 0)
        let cell = CollectionVw.cellForItem(at: indexPath1) as! DjDropReceiptStep2Cell
        
        cell.lblRemainingTime.text = countdown
    }
    
    //MARK: - WEB SERVICES
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id= &dj_id=\(djId)&token=\(UserModel.sharedInstance().token!)&type=djdrop"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let step1Model = response.result.value!
                    if step1Model.success == 1{
                        if let price = step1Model.result!.project_price{
                            self.step1ProjPrice = self.currency + price
                        }
                        if let transPrice = step1Model.result!.transaction_fees{
                            self.step1TransFee = self.currency + transPrice
                        }
                        if let totAmount = step1Model.result!.total_price{
                            self.step1TotalPrice = self.currency + totAmount
                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(step1Model.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func GetDjDropDataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getDjDropStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(djId)&artist_id=\(UserModel.sharedInstance().userId!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjDropStepModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let dropStepModel = response.result.value!
                    if dropStepModel.success == 1{
                        if dropStepModel.step2!.status! == "1"{
                            self.isComplete = false
                            self.step2DropTitle = dropStepModel.step2!.dj_drop_title!
                            self.step2DropDescrip = dropStepModel.step2!.dj_drop_des!
                            if dropStepModel.step2!.remaining_time!.contains("00:00:00") {
                                self.RemainingTime = "TIME EXPIRED".localize
                            }else{
                                self.RemainingTime = dropStepModel.step2!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }
                        }
                        if dropStepModel.step3!.status! == "1"{
                            self.isComplete = true
                            self.step3DropTitle = dropStepModel.step2!.dj_drop_title!
                            self.step3DropDescrip = dropStepModel.step2!.dj_drop_des!
                        }
                        self.CollectionVw.reloadData()
                    }else{
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please Check your Internet Connection")
        }
    }
}
//MARK: - EXTENSIONS
extension DjDropReceiptVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DjDropReceiptStep1Cell", for: indexPath) as! DjDropReceiptStep1Cell
            cell.lblProjPrice.text = "Project Price = \(self.step1ProjPrice)"
            cell.lblTransFee.text = "Transaction Fee = \(self.step1TransFee)"
            cell.lblTotPrice.text = "Total Project Price = \(self.step1TotalPrice)"
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DjDropReceiptStep2Cell", for: indexPath) as! DjDropReceiptStep2Cell
            if isComplete == true{
                cell.vwComplete.isHidden = false
                cell.vwDropStatus.isHidden = true
                cell.lblDropTitle.text = self.step2DropTitle
                cell.lblDropDescript.text = self.step2DropDescrip
            }else{
                cell.vwComplete.isHidden = true
                cell.vwDropStatus.isHidden = false
                cell.lblDropStatusTitle.text = self.step2DropTitle
                cell.lblDropStatusDescrip.text = self.step2DropDescrip
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 1{
            btnRight.isHidden = true
        }else{
            btnRight.isHidden = false
        }
        if indexPath.row == 0 {
            btnLeft.isHidden = true
        }else{
            btnLeft.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: self.view.frame.width - 80, height: 300)
        }else{
            return CGSize(width: self.view.frame.width - 80, height: 400)
        }
    }
}
