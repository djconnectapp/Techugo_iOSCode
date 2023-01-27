//
//  EditServiceVC.swift
//  DJConnect
//
//  Created by My Mac on 27/03/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import DropDown

class EditServiceVC: UIViewController {
    //MARK:- GLOBAL VARIABLE
    var profileservice : ProfileDataModel?
    var dj_feedback_varying = Int()
    var dj_drop_varying = Int()
    var dj_remix_varying = Int()
    var dj_feedback_range1 = Int()
    var dj_feedback_range2 = Int()
    var dj_remix_range1 = Int()
    var dj_remix_range2 = Int()
    var dj_drop_range1 = Int()
    var dj_drop_range2 = Int()
    var feedback_currency_name = String()
    var drop_currency_name = String()
    var remix_currency_name = String()
    
    //dropdown
    let feedbackCurrDropDown = DropDown()
    let dropCurrDropDown = DropDown()
    let remixCurrDropDown = DropDown()
    
    //on off status
    var feedbackStatus = String()
    var dropStatus = String()
    var remixStatus = String()
    
    var mediaRemainingTime = String()
    
    //MARK:- OUTLETS
    //-->ArtistSide
    //artistservicepage
    @IBOutlet weak var lblNoService: UILabel!
    @IBOutlet weak var lblNoServiceDetail: UILabel!
    @IBOutlet var viewArtistService: UIView!
    
    //-->DJ Side
    @IBOutlet weak var viewDJService: UIView!
    //service song review page
    @IBOutlet weak var lblServiceFeedback: UILabel!
    @IBOutlet weak var lblServiceAbtFeedback: UILabel!
    @IBOutlet weak var lblServiceFeedbackCurrency: UILabel!
    @IBOutlet weak var lblServiceFeedbackPrice: UILabel!
    @IBOutlet weak var lblFeedbackCurrSymbol: UILabel!
    @IBOutlet weak var btnFeedbackCurrency: UIButton!
    @IBOutlet weak var textViewFeedBackDetail: UITextView!
    @IBOutlet weak var lblFeedbackCount: UILabel!
    @IBOutlet weak var lblFeedbackPlaceholder: UILabel!
    @IBOutlet weak var viewFeedbackDropDown: UIView!
    @IBOutlet weak var textFieldFeedbackPrice: UITextField!
    @IBOutlet weak var txtFieldFeedback: UITextField!
    
    //service song drop page
    @IBOutlet weak var lblServiceDrops: UILabel!
    @IBOutlet weak var lblServiceAbtDrop: UILabel!
    @IBOutlet weak var lblServiceDropCurr: UILabel!
    @IBOutlet weak var lblServiceDropPrice: UILabel!
    @IBOutlet weak var lblDropCurrSymbol: UILabel!
    @IBOutlet weak var btnDropCurrency: UIButton!
    @IBOutlet weak var textViewDropDetail: UITextView!
    @IBOutlet weak var textFieldDropPrice: UITextField!
    @IBOutlet weak var lblDropCount: UILabel!
    @IBOutlet weak var lblDropPlaceholder: UILabel!
    @IBOutlet weak var viewDropDropDown: UIView!
    @IBOutlet weak var txtFieldDrop: UITextField!
    @IBOutlet weak var vwFixedDrop: UIView!
    
    //service remix page
    @IBOutlet weak var lblServiceRemix: UILabel!
    @IBOutlet weak var lblServiceAbtRemix: UILabel!
    @IBOutlet weak var lblRemixCount: UILabel!
    @IBOutlet weak var textViewRemixDetail: UITextView!
    @IBOutlet weak var lblRemixPlaceholder: UILabel!
    @IBOutlet weak var viewRemixDropDown: UIView!
    @IBOutlet weak var vwFixedRemix: UIView!
    @IBOutlet weak var lblServiceRemixCurrency: UILabel!
    @IBOutlet weak var txtFieldRemix: UITextField!
    @IBOutlet weak var btnRemixCurrency: UIButton!
    @IBOutlet weak var textFieldRemixPrice: UITextField!
    @IBOutlet weak var lblServiceRemixPrice: UILabel!
    @IBOutlet weak var lblRemixCurrSymbol: UILabel!
    
    //segment control
    @IBOutlet weak var FeedbackSegmentControl: UISegmentedControl!
    @IBOutlet weak var DropSegmentControl: UISegmentedControl!
    @IBOutlet weak var RemixSegmentControl: UISegmentedControl!
    
    //service - remix range view
    @IBOutlet weak var vwRangeRemix: UIView!
    @IBOutlet weak var lblRemixRangePrice: UILabel!
    @IBOutlet weak var lblRemixRangeSymbol1: UILabel!
    @IBOutlet weak var txfRemixMin: UITextField!
    @IBOutlet weak var lblRemixRangeSymbol2: UILabel!
    @IBOutlet weak var txfRemixMax: UITextField!
    
    //service - song review range view
    @IBOutlet weak var vwRangeSongReview: UIView!
    @IBOutlet weak var lblSongReviewRangePrice: UILabel!
    @IBOutlet weak var lblSongReviewRangeSymbol1: UILabel!
    @IBOutlet weak var txfSongReviewMin: UITextField!
    @IBOutlet weak var lblSongReviewRangeSymbol2: UILabel!
    @IBOutlet weak var txfSongReviewMax: UITextField!
    
    //service - drop range view
    @IBOutlet weak var vwRangeDrop: UIView!
    @IBOutlet weak var lblDropRangePrice: UILabel!
    @IBOutlet weak var lblDropRangeSymbol1: UILabel!
    @IBOutlet weak var txfDropMin: UITextField!
    @IBOutlet weak var lblDropRangeSymbol2: UILabel!
    @IBOutlet weak var txfDropMax: UITextField!
    
    
    
    @IBOutlet weak var descFeedBackBgVw: UIView!
    @IBOutlet weak var vwFixedSongReview: UIView!
    
    @IBOutlet weak var nextBtnService: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var mediaButtonCallback: ((_ addObj: String)->Void)?
    var callBackServiceCancelBtn: ((_ addObj: String)->Void)?
    
    @IBOutlet weak var feedBackBtn: UIButton!
    var addFlag = String()
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeedbackSegmentControl.isHidden = true
        //feedBackBtn.setImage(UIImage(named: "displayOff"), for: .normal)
        viewFeedbackDropDown.isHidden = true
        descFeedBackBgVw.layer.cornerRadius = 10.0
        descFeedBackBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        descFeedBackBgVw.layer.borderWidth = 0.5
        descFeedBackBgVw.clipsToBounds = true
        
        
        vwFixedSongReview.layer.cornerRadius = 10.0
        vwFixedSongReview.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        vwFixedSongReview.layer.borderWidth = 0.5
        vwFixedSongReview.clipsToBounds = true
        
        
        setup()
        self.txtFieldFeedback.isUserInteractionEnabled = false
        FeedbackSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
    }
    
    //MARK:- OTHER ACTION
    func setup(){
        localizeElement()
        if UserModel.sharedInstance().userType == "AR"{
            viewArtistService.isHidden = false
            viewDJService.isHidden = true
        }else{
            callCurrencyList()
            setupDropDown()
            dj_feedback_varying = 0
            dj_drop_varying = 0
            dj_remix_varying = 0
            if profileservice != nil{
                //lblFeedbackPlaceholder.isHidden = true
                lblDropPlaceholder.isHidden = true
                lblRemixPlaceholder.isHidden = true
                setupfeedback()
                
            }
            else{
                self.textViewFeedBackDetail.text = "Describe your song review service here."
            }
            viewArtistService.isHidden = true
            viewDJService.isHidden = false
        }
    }
    
    func localizeElement(){
        lblServiceFeedback.text = "service dj feedback".localize
        //lblServiceAbtFeedback.text = "About Feedback".localize
        lblServiceFeedbackCurrency.text = "Price Type".localize
        //lblServiceFeedbackPrice.text = "Price (USD)".localize
        lblServiceDropCurr.text = "Price Type".localize
        lblServiceDropPrice.text = "Price (USD)".localize
        lblServiceRemixPrice.text = "Price (USD)".localize
        lblServiceDrops.text = "service dj drop".localize
        lblServiceAbtDrop.text = "About drop".localize
        lblServiceRemixCurrency.text = "Price Type".localize
        lblServiceAbtRemix.text = "About Remix".localize
        
        //Artist
        lblNoService.text = "no service".localize
        lblNoServiceDetail.text = "no service detail".localize
    }
    
    func setupfeedback(){
        if let feedbackDetail = profileservice!.dj_feedback_drops{
            if feedbackDetail.count > 0{
                var fdbackDetailSt : String?
                fdbackDetailSt = feedbackDetail[0].dj_feedback
                if let dj_feedback = feedbackDetail[0].dj_feedback{
                    self.textViewFeedBackDetail.text = dj_feedback
                    self.textViewFeedBackDetail.textColor = .white
                    if(dj_feedback == ""){
                        self.textViewFeedBackDetail.text = "Describe your song review service here."
                    }
                    let x : String = self.textViewFeedBackDetail.text!
                    //self.lblFeedbackCount.text = "\(x.count)/200"
                    if dj_feedback.isEmpty == true{
                       // self.lblFeedbackPlaceholder.isHidden = false
                    }
                    
                }
                if(fdbackDetailSt == nil){
                     self.textViewFeedBackDetail.text = UserModel.sharedInstance().feedbackDetail
                }
                
                if let dj_feedback_currency = feedbackDetail[0].dj_feedback_currency{
                    self.txtFieldFeedback.text = dj_feedback_currency
                    if(dj_feedback_currency == ""){
                       // self.lblServiceFeedbackPrice.text = "Price"
                       // print("Price1",self.lblServiceFeedbackPrice.text)
                        self.lblSongReviewRangePrice.text = "Price"
                    }
                    else{
//                    self.lblServiceFeedbackPrice.text = "Price(" + dj_feedback_currency + ")"
                       // self.lblServiceFeedbackPrice.text = "Price"
                   // print("Price1",self.lblServiceFeedbackPrice.text)
//                    self.lblSongReviewRangePrice.text = "Price(" + dj_feedback_currency + ")"
                        self.lblSongReviewRangePrice.text = "Price"
                    }
                    
                }
                
                if let feedback_vary = feedbackDetail[0].is_dj_feedback_varying{
                    if feedback_vary == 0{
                        self.txtFieldFeedback.text = "Fixed"
                        self.vwFixedSongReview.isHidden = false
                        self.vwRangeSongReview.isHidden = true
                        self.dj_feedback_varying = 0
                    }else{
                        self.txtFieldFeedback.text = "Varies"
                        self.vwFixedSongReview.isHidden = true
                        self.vwRangeSongReview.isHidden = false
                        self.dj_feedback_varying = 1
                    }
                }
                
                if let SongReviewRange1 = feedbackDetail[0].dj_feedback_range1{
                    self.txfSongReviewMin.text = "\(SongReviewRange1)"
                }
                                
                if let SongReviewRange2 = feedbackDetail[0].dj_feedback_range2{
                    self.txfSongReviewMax.text = "\(SongReviewRange2)"
                }
                
                if var dj_feedback_price = feedbackDetail[0].dj_feedback_price{
                    if dj_feedback_price.hasPrefix("$") || dj_feedback_price.hasPrefix("₹") {
                        dj_feedback_price = String(dj_feedback_price.dropFirst())
                    }
                    self.lblFeedbackCurrSymbol.text = "\(UserModel.sharedInstance().userCurrency!)"
                    self.textFieldFeedbackPrice.text = dj_feedback_price
                }
                var fdbackPrice : String?
                fdbackPrice = feedbackDetail[0].dj_feedback_price
                if(fdbackPrice == nil){
                    self.lblFeedbackCurrSymbol.text = "\(UserModel.sharedInstance().userCurrency!)"
                     self.textFieldFeedbackPrice.text = UserModel.sharedInstance().feedbackPrice
                }
                
                if let dj_drops = feedbackDetail[0].dj_drops{
                    self.textViewDropDetail.text = dj_drops
                    let x : String = self.textViewDropDetail.text!
                    self.lblDropCount.text = "\(x.count)/200"
                }
                
                if let dj_drops_currency = feedbackDetail[0].dj_drops_currency{
                    self.lblServiceDropPrice.text = "Price(" + dj_drops_currency + ")"
                    self.lblDropRangePrice.text = "Price(" + dj_drops_currency + ")"
                }
                
                if let drop_vary = feedbackDetail[0].is_dj_drop_varying{
                    if drop_vary == 0{
                        self.txtFieldDrop.text = "Fixed"
                        self.vwFixedDrop.isHidden = false
                        self.vwRangeDrop.isHidden = true
                        self.dj_drop_varying = 0
                    }else{
                        self.txtFieldDrop.text = "Varies"
                        self.vwFixedDrop.isHidden = true
                        self.vwRangeDrop.isHidden = false
                        self.dj_drop_varying = 1
                    }
                }
                
                if let DropRange1 = feedbackDetail[0].dj_drop_range1{
                    self.txfDropMin.text = "\(DropRange1)"
                }
                
                if let DropRange2 = feedbackDetail[0].dj_drop_range2{
                    self.txfDropMax.text = "\(DropRange2)"
                }
                
                if var dj_drops_price = feedbackDetail[0].dj_drops_price{
                    let removedPriceSymbol = dj_drops_price.removeFirst()
                    self.lblDropCurrSymbol.text = "\(removedPriceSymbol)"
                    self.textFieldDropPrice.text = dj_drops_price
                }
                
                if let fbckStatus = feedbackDetail[0].dj_feedback_status{
                    if fbckStatus == "on" {
                        feedbackStatus = "on"
                        setFeedbackON()
                    }else{
                        self.feedbackStatus = "off"
                        self.setFeedbackOFF()
                        
                    }
                }
                if let drpStatus = feedbackDetail[0].dj_drops_status{
                    if drpStatus == "on" {
                        self.dropStatus = "on"
                        self.setDropON()
                    }else{
                        self.dropStatus = "off"
                        self.setDropOFF()
                    }
                }
                
                if var dj_remix_price = feedbackDetail[0].dj_remix_price{
                    let removedPriceSymbol = dj_remix_price.removeFirst()
                    self.lblRemixCurrSymbol.text = "\(removedPriceSymbol)"
                    self.textFieldRemixPrice.text = dj_remix_price
                }
                
                if let dj_remix = feedbackDetail[0].dj_remix{
                    self.textViewRemixDetail.text = dj_remix
                    let x : String = self.textViewRemixDetail.text!
                    self.lblRemixCount.text = "\(x.count)/200"
                }
                
                if let remixStatus = feedbackDetail[0].dj_remix_status{
                    if remixStatus == "on" {
                        self.remixStatus = "on"
                        self.setRemixON()
                    }else{
                        self.remixStatus = "off"
                        self.setRemixOFF()
                    }
                }
                
                if let dj_remix_currency = feedbackDetail[0].dj_remix_currency{
                    self.lblServiceRemixPrice.text = "Price(" + dj_remix_currency + ")"
                    self.lblRemixRangePrice.text = "Price(" + dj_remix_currency + ")"
                }
                
                if let remix_vary = feedbackDetail[0].is_dj_remix_varying{
                    if remix_vary == 0{
                        self.txtFieldDrop.text = "Fixed"
                        self.vwFixedDrop.isHidden = false
                        self.vwRangeDrop.isHidden = true
                        self.dj_remix_varying = 0
                    }else{
                        self.txtFieldDrop.text = "Varies"
                        self.vwFixedDrop.isHidden = true
                        self.vwRangeDrop.isHidden = false
                        self.dj_remix_varying = 1
                    }
                }
                
                if let DropRange1 = feedbackDetail[0].dj_remix_range1{
                    self.txfRemixMin.text = "\(DropRange1)"
                }
                
                if let DropRange2 = feedbackDetail[0].dj_remix_range2{
                    self.txfRemixMax.text = "\(DropRange2)"
                }
            }
        }
    }
    func setupDropDown(){
        feedbackCurrDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.txtFieldFeedback.text = "Fixed"//self.feedbackCurrDropDown.selectedItem
            let x = self.feedbackCurrDropDown.indexForSelectedRow
            if x == 0 {
                self.vwFixedSongReview.isHidden = false
                self.vwRangeSongReview.isHidden = true
                self.dj_feedback_varying = 0
            }else{
                self.vwFixedSongReview.isHidden = true
                self.vwRangeSongReview.isHidden = false
                self.dj_feedback_varying = 1
            }
        }
        
        dropCurrDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.txtFieldDrop.text = self.dropCurrDropDown.selectedItem
            let x = self.dropCurrDropDown.indexForSelectedRow
            if x == 0 {
                self.vwFixedDrop.isHidden = false
                self.vwRangeDrop.isHidden = true
                self.dj_drop_varying = 0
            }else{
                self.vwFixedDrop.isHidden = true
                self.vwRangeDrop.isHidden = false
                self.dj_drop_varying = 1
            }
        }
        
        remixCurrDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.txtFieldDrop.text = self.remixCurrDropDown.selectedItem
            let x = self.remixCurrDropDown.indexForSelectedRow
            if x == 0 {
                self.vwFixedRemix.isHidden = false
                self.vwRangeRemix.isHidden = true
                self.dj_drop_varying = 0
            }else{
                self.vwFixedRemix.isHidden = true
                self.vwRangeRemix.isHidden = false
                self.dj_drop_varying = 1
            }
        }
    }
    func saveServiceValidation(){
        textViewFeedBackDetail.resignFirstResponder()
        textFieldFeedbackPrice.resignFirstResponder()
        textViewDropDetail.resignFirstResponder()
        textViewRemixDetail.resignFirstResponder()
        textFieldDropPrice.resignFirstResponder()
        textFieldRemixPrice.resignFirstResponder()
    }
    
    func saveButtonAction(){
        if textFieldFeedbackPrice?.text?.isEmpty == true{
            textFieldFeedbackPrice?.text = "50"
        }
        if textFieldDropPrice?.text?.isEmpty == true{
            textFieldDropPrice?.text = "150"
        }
        if textFieldRemixPrice?.text?.isEmpty == true{
            textFieldRemixPrice?.text = "150"
        }
//        if textViewFeedBackDetail?.text?.isEmpty == true{
//            textViewFeedBackDetail?.text = lblFeedbackPlaceholder?.text!
//        }
        if textViewDropDetail?.text?.isEmpty == true{
            textViewDropDetail?.text = lblDropPlaceholder?.text!
        }
        if textViewRemixDetail?.text?.isEmpty == true{
            textViewRemixDetail?.text = lblRemixPlaceholder?.text!
        }
        
        var x = Bool()
        var y = Bool()
        if dj_feedback_varying == 1{
            x = checkSongReviewRange()
        }else{
            dj_feedback_range1 = 0
            dj_feedback_range2 = 0
            x = true
        }
        if dj_drop_varying == 1{
            y = checkDropRange()
        }else{
            dj_drop_range1 = 0
            dj_drop_range2 = 0
            y = true
        }
        if dj_remix_varying == 1{
            y = checkSongRemixRange()
        }else{
            dj_remix_range1 = 0
            dj_remix_range2 = 0
            y = true
        }
        
        if !x || !y {
            self.view.makeToast("Please enter proper range")
        }
    }
    
    func callCurrencyList(){
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.lblFeedbackCurrSymbol.text = currencySymbol
            self.lblSongReviewRangeSymbol1.text = currencySymbol
            self.lblSongReviewRangeSymbol2.text = currencySymbol
            self.lblDropCurrSymbol.text = currencySymbol
            self.lblDropRangeSymbol1.text = currencySymbol
            self.lblDropRangeSymbol2.text = currencySymbol
            //            self.feedback_currency_name = UserModel.sharedInstance().currency_name!
            //            self.lblServiceFeedbackPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            //            self.lblSongReviewRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
           // self.lblServiceRemixPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")" // ashitesh currency name change to INR
            //            self.drop_currency_name = UserModel.sharedInstance().currency_name!
            //            self.remix_currency_name = UserModel.sharedInstance().currency_name!
            //            self.lblServiceDropPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            //            self.lblDropRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            
            if(UserModel.sharedInstance().currency_name == "IN"){
                UserModel.sharedInstance().currency_name = "INR"
                self.lblServiceRemixPrice.text = "Price(" + "INR" + ")"
                
                self.feedback_currency_name = "INR"
                //self.lblServiceFeedbackPrice.text = "Price(" + "INR" + ")"
                self.lblSongReviewRangePrice.text = "Price(" + "INR" + ")"
                
                self.drop_currency_name = "INR"
                self.remix_currency_name = "INR"
                self.lblServiceDropPrice.text = "Price(" + "INR" + ")"
                self.lblDropRangePrice.text = "Price(" + "INR" + ")"
            }
            else{
            self.lblServiceRemixPrice.text = UserModel.sharedInstance().currency_name!
                self.feedback_currency_name = UserModel.sharedInstance().currency_name!
                //self.lblServiceFeedbackPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
                //print("price2",self.lblServiceFeedbackPrice.text)
                self.lblSongReviewRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
                self.drop_currency_name = UserModel.sharedInstance().currency_name!
                self.remix_currency_name = UserModel.sharedInstance().currency_name!
                self.lblServiceDropPrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
                self.lblDropRangePrice.text = "Price(" + UserModel.sharedInstance().currency_name! + ")"
            }
            self.lblRemixCurrSymbol.text = currencySymbol
        }
    }
    
    func setFeedbackON(){
        
        feedBackBtn.setImage(UIImage(named: "displayOn"), for: .normal)
//        self.FeedbackSegmentControl.selectedSegmentIndex = 0
        self.textViewFeedBackDetail.textColor = .white
        self.textViewFeedBackDetail.isEditable = true
        self.lblServiceFeedback.textColor = .white
        self.txtFieldFeedback.textColor = .white
        self.txtFieldFeedback.isEnabled = true
        self.textFieldFeedbackPrice.textColor = .white
        self.textFieldFeedbackPrice.isEnabled = true
        self.lblFeedbackCurrSymbol.textColor = .white
        //self.lblFeedbackPlaceholder.textColor = .black
//        self.txfSongReviewMin.textColor = .white
//        self.txfSongReviewMax.textColor = .white
//        self.lblSongReviewRangeSymbol1.textColor = .white
//        self.lblSongReviewRangeSymbol2.textColor = .white
    }
    
    func setFeedbackOFF(){
        
        feedBackBtn.setImage(UIImage(named: "displayOff"), for: .normal)
//        self.FeedbackSegmentControl.selectedSegmentIndex = 1
        self.textViewFeedBackDetail.textColor = .white
        self.textViewFeedBackDetail.isEditable = false
        self.lblServiceFeedback.textColor = .white
        self.txtFieldFeedback.textColor = .white
        self.txtFieldFeedback.isEnabled = false
        self.textFieldFeedbackPrice.textColor = .white
        self.textFieldFeedbackPrice.isEnabled = false
        self.lblFeedbackCurrSymbol.textColor = .white
       // self.lblFeedbackPlaceholder.textColor = .lightGray
//        self.txfSongReviewMin.textColor = .lightGray
//        self.txfSongReviewMax.textColor = .lightGray
//        self.lblSongReviewRangeSymbol1.textColor = .lightGray
//        self.lblSongReviewRangeSymbol2.textColor = .lightGray
    }
    
    func setDropON(){
        self.DropSegmentControl.selectedSegmentIndex = 0
        self.textViewDropDetail.textColor = .black
        self.textViewDropDetail.isEditable = true
        self.lblServiceDrops.textColor = .white
        self.txtFieldDrop.textColor = .black
        self.txtFieldDrop.isEnabled = true
        self.textFieldDropPrice.textColor = .black
        self.textFieldDropPrice.isEnabled = true
        self.lblDropCurrSymbol.textColor = .black
        self.lblDropPlaceholder.textColor = .black
        self.txfDropMin.textColor = .black
        self.txfDropMax.textColor = .black
        self.lblDropRangeSymbol1.textColor = .black
        self.lblDropRangeSymbol2.textColor = .black
    }
    
    func setDropOFF(){
        
        self.DropSegmentControl.selectedSegmentIndex = 1
        self.textViewDropDetail.textColor = .lightGray
        self.textViewDropDetail.isEditable = false
        self.lblServiceDrops.textColor = .lightGray
        self.txtFieldDrop.textColor = .lightGray
        self.txtFieldDrop.isEnabled = false
        self.textFieldDropPrice.textColor = .lightGray
        self.textFieldDropPrice.isEnabled = false
        self.lblDropCurrSymbol.textColor = .lightGray
        self.lblDropPlaceholder.textColor = .lightGray
        self.txfDropMin.textColor = .lightGray
        self.txfDropMax.textColor = .lightGray
        self.lblDropRangeSymbol1.textColor = .lightGray
        self.lblDropRangeSymbol2.textColor = .lightGray
    }
    
    func setRemixON(){
        self.RemixSegmentControl.selectedSegmentIndex = 0
        self.textViewRemixDetail.textColor = .black
        self.textViewRemixDetail.isEditable = true
        self.lblServiceRemix.textColor = .white
        self.txtFieldRemix.textColor = .black
        self.txtFieldRemix.isEnabled = true
        self.textFieldRemixPrice.textColor = .black
        self.textFieldRemixPrice.isEnabled = true
        self.lblRemixCurrSymbol.textColor = .black
        self.lblRemixPlaceholder.textColor = .black
        self.txfRemixMin.textColor = .black
        self.txfRemixMax.textColor = .black
        self.lblRemixRangeSymbol1.textColor = .black
        self.lblRemixRangeSymbol2.textColor = .black
    }
    
    func setRemixOFF(){
        self.RemixSegmentControl.selectedSegmentIndex = 1
        self.textViewRemixDetail.textColor = .lightGray
        self.textViewRemixDetail.isEditable = false
        self.lblServiceRemix.textColor = .lightGray
        self.txtFieldRemix.textColor = .lightGray
        self.txtFieldRemix.isEnabled = false
        self.textFieldRemixPrice.textColor = .lightGray
        self.textFieldRemixPrice.isEnabled = false
        self.lblRemixCurrSymbol.textColor = .lightGray
        self.lblRemixPlaceholder.textColor = .lightGray
        self.txfRemixMin.textColor = .lightGray
        self.txfRemixMax.textColor = .lightGray
        self.lblRemixRangeSymbol1.textColor = .lightGray
        self.lblRemixRangeSymbol2.textColor = .lightGray
    }
    
    func checkSongReviewRange() -> Bool{
        if txfSongReviewMin.text?.isEmpty == false && txfSongReviewMax.text?.isEmpty == false{
            let  range1 = Int(txfSongReviewMin.text!) ?? 0
            let  range2 = Int(txfSongReviewMax.text!) ?? 0
            if range2 == 0{
                return false
            }else if range1 > range2{
                return false
            }else{
                dj_feedback_range1 = Int(txfSongReviewMin.text!) ?? 0
                dj_feedback_range2 = Int(txfSongReviewMax.text!) ?? 0
                return true
            }
        }else{
            dj_feedback_range1 = Int(txfSongReviewMin.text!) ?? 0
            dj_feedback_range2 = Int(txfSongReviewMax.text!) ?? 0
            return false
        }
    }
    
    func checkDropRange() -> Bool{
        if txfDropMin.text?.isEmpty == false && txfDropMax.text?.isEmpty == false{
            let  range1 = Int(txfDropMin.text!) ?? 0
            let  range2 = Int(txfDropMax.text!) ?? 0
            if range2 == 0{
                return false
            }else if range1 > range2{
                return false
            }else{
                dj_drop_range1 = Int(txfDropMin.text!) ?? 0
                dj_drop_range2 = Int(txfDropMax.text!) ?? 0
                return true
            }
        }else{
            dj_drop_range1 = Int(txfDropMin.text!) ?? 0
            dj_drop_range2 = Int(txfDropMax.text!) ?? 0
            return false
        }
    }
    
    func checkSongRemixRange() -> Bool{
        if txfRemixMin.text?.isEmpty == false && txfRemixMax.text?.isEmpty == false{
            let  range1 = Int(txfRemixMin.text!) ?? 0
            let  range2 = Int(txfRemixMax.text!) ?? 0
            if range2 == 0{
                return false
            }else if range1 > range2{
                return false
            }else{
                dj_remix_range1 = Int(txfRemixMin.text!) ?? 0
                dj_remix_range2 = Int(txfRemixMax.text!) ?? 0
                return true
            }
        }else{
            dj_remix_range1 = Int(txfRemixMin.text!) ?? 0
            dj_remix_range2 = Int(txfRemixMax.text!) ?? 0
            return false
        }
    }
    @IBAction func serviceNextBtnTapped(_ sender: Any) {
        
        if let call = self.mediaButtonCallback{
            call("media")
            
        }
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        if let call = self.callBackServiceCancelBtn{
            call("cancel")
        }
    }
    
    //MARK:- SEGMENT ACTION
    @IBAction func FeedbackSegmentAction(_ sender: UISegmentedControl) {
       // if  sender.selectedSegmentIndex == 0 {
           // feedbackStatus = "on"
            //setFeedbackON()
       // }else{
           // feedbackStatus = "off"
            //FeedbackSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
            //setFeedbackOFF()
        //}
    }
    
    @IBAction func feedbackBtnTapped(_ sender: Any) {
        if(feedbackStatus == "off"){
            feedbackStatus = "on"
            feedBackBtn.setImage(UIImage(named: "displayOn"), for: .normal)
            setFeedbackON()
            //addFlag = "yes"
        }
        else{
            feedbackStatus = "off"
            feedBackBtn.setImage(UIImage(named: "displayOff"), for: .normal)
            setFeedbackOFF()
            //addFlag = "no"
        }
    }
    
    @IBAction func DropSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            dropStatus = "on"
            setDropON()
        }else{
            dropStatus = "off"
            //DropSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
           
            setDropOFF()
        }
    }
    
    @IBAction func RemixSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            remixStatus = "on"
            setRemixON()
        }else{
            remixStatus = "off"
            setRemixOFF()
        }
    }
    
    @IBAction func btnFeedbackCurrAction(_ sender: UIButton) {
        feedbackCurrDropDown.anchorView = btnFeedbackCurrency
        feedbackCurrDropDown.dataSource = ["Fixed", "Varies"]
        if FeedbackSegmentControl.selectedSegmentIndex == 0{
            feedbackCurrDropDown.show()
        }else{
            feedbackCurrDropDown.hide()
        }
        feedbackCurrDropDown.width = viewFeedbackDropDown.frame.width
        feedbackCurrDropDown.direction = .bottom
        feedbackCurrDropDown.bottomOffset = CGPoint(x: 0, y:(feedbackCurrDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    @IBAction func btnDropCurrAction(_ sender: UIButton) {
        dropCurrDropDown.anchorView = btnDropCurrency
        dropCurrDropDown.dataSource = ["Fixed", "Varies"]
        if FeedbackSegmentControl.selectedSegmentIndex == 0{
            dropCurrDropDown.show()
        }else{
            dropCurrDropDown.hide()
        }
        dropCurrDropDown.width = viewDropDropDown.frame.width
        dropCurrDropDown.direction = .bottom
        dropCurrDropDown.bottomOffset = CGPoint(x: 0, y:(dropCurrDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    @IBAction func btnRemixCurrAction(_ sender: UIButton) {
        remixCurrDropDown.anchorView = btnRemixCurrency
        remixCurrDropDown.dataSource = ["Fixed", "Varies"]
        if RemixSegmentControl.selectedSegmentIndex == 0{
            remixCurrDropDown.show()
        }else{
            remixCurrDropDown.hide()
        }
        remixCurrDropDown.width = viewRemixDropDown.frame.width
        remixCurrDropDown.direction = .any
        remixCurrDropDown.bottomOffset = CGPoint(x: 0, y:(remixCurrDropDown.anchorView?.plainView.bounds.height)!)
    }
}
extension EditServiceVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        textViewFeedBackDetail.textColor = .white
        if textView == textViewFeedBackDetail{
           // lblFeedbackPlaceholder.isHidden = true
            let len = textView.text.count
           // lblFeedbackCount.text = "\(len)/200"
//            if textViewFeedBackDetail.text.count == 0{
//                lblFeedbackPlaceholder.isHidden = false
//            }
            self.textViewFeedBackDetail.textColor = .white
            if textViewFeedBackDetail.text == ""{
                textViewFeedBackDetail.text = "Describe your song review service here."
            }
        }
        if textView == textViewDropDetail{
            lblDropPlaceholder.isHidden = true
            let len = textView.text.count
            lblDropCount.text = "\(len)/200"
            if textViewDropDetail.text.count == 0{
                lblDropPlaceholder.isHidden = false
            }
        }
        if textView == textViewRemixDetail{
            lblRemixPlaceholder.isHidden = true
            let len = textView.text.count
            lblRemixCount.text = "\(len)/200"
            if textViewRemixDetail.text.count == 0{
                lblRemixPlaceholder.isHidden = false
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == textViewFeedBackDetail{
            
                if textViewFeedBackDetail.text == "Describe your song review service here."{
                    textViewFeedBackDetail.text = ""
                }
            if text.count == 0 {
                if textView.text.count != 0 {
                    return true
                }
            } else if textView.text.count > 199 {
                return false
            }
            return true
        }else if textView == textViewDropDetail{
            
            if text.count == 0 {
                if textView.text.count != 0 {
                    return true
                }
            } else if textView.text.count > 199 {
                return false
            }
            return true
        }else if textView == textViewRemixDetail{
            
            if text.count == 0 {
                if textView.text.count != 0 {
                    return true
                }
            } else if textView.text.count > 199 {
                return false
            }
            return true
        }else{
            return false
        }
    }
}
