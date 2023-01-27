//
//  SideMenuHomeVC.swift
//  DJConnect
//
//  Created by My Mac on 07/01/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Alamofire
import AlamofireObjectMapper
//import Stripe
import DropDown
import JMMaskTextField_Swift
import CryptoSwift
import Mixpanel

class IconInfoCell : UITableViewCell{
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var lblIconDetail: UILabel!
    
}

class TransactionDateCell : UITableViewCell{
    @IBOutlet weak var lblTransDate: UILabel!
    @IBOutlet weak var btnViewStatus: UIButton!
}

class TransConnectCell: UITableViewCell{
    @IBOutlet weak var lblConnectNoPrice: UILabel!
    @IBOutlet weak var btnExpandConnectDetail: UIButton!
    @IBOutlet weak var lblConnectBy: UILabel!
    
}
class TransDetailCell: UITableViewCell{
    @IBOutlet weak var imgUserProfile: imageProperties!
    @IBOutlet weak var lblProjName: UILabel!
    @IBOutlet weak var vwApply: UIView!
    @IBOutlet weak var lblDeliverydate: UILabel!
    @IBOutlet weak var lblOrderTotal: UILabel!
    @IBOutlet weak var lblArTotal: UILabel!
    @IBOutlet weak var lblArTotalAmount: UILabel!
    @IBOutlet weak var lblIs_feedback: UILabel!
    @IBOutlet weak var lblIs_verified: UILabel!
    @IBOutlet weak var lblIs_Delivered: UILabel!
    @IBOutlet weak var lblIs_AcceptedNo: UILabel!
    @IBOutlet weak var lblAvailablebalance: UILabel!
    @IBOutlet weak var lblStartingBalance: UILabel!
    @IBOutlet weak var vwCreditCash: UIView!
    @IBOutlet weak var lblCashOutNote: UILabel!
    @IBOutlet weak var imgCreCash1: UIImageView!
    @IBOutlet weak var imgCreCash2: UIImageView!
    @IBOutlet weak var imgCreCash3: UIImageView!
    @IBOutlet weak var btnIsVerify: UIButton!
    @IBOutlet weak var btnIsAcceptNo: UIButton!
    @IBOutlet weak var btnIsFeedback: UIButton!
    @IBOutlet weak var btnIsDelivered: UIButton!
    @IBOutlet weak var lblCharge: UILabel!
    
    @IBOutlet weak var lblCHargeBgVw: UIView!
    @IBOutlet weak var lblSongStatus: UILabel!
    @IBOutlet weak var lblRejectReason: UILabel!
    @IBOutlet weak var imgIs_Feedback: UIImageView!
    @IBOutlet weak var imgIs_AcceptNo: UIImageView!
    @IBOutlet weak var imgIs_verify: UIImageView!
    @IBOutlet weak var imgIs_Delivered: UIImageView!
    @IBOutlet weak var lblPotentialEarning: UILabel!
    
}
class DjConnectDetailCell: UITableViewCell{
    @IBOutlet weak var lblDjConnectNoPrice: UILabel!
    @IBOutlet weak var lblDjConnectBy: UILabel!
    
}
class BlockedProfileCell : UICollectionViewCell{
    @IBOutlet weak var btnUnblock: UIButton!
    @IBOutlet weak var imgBlockImage: imageProperties!
    @IBOutlet weak var lblBlockName: UILabel!
    
}

class SocialLinkCell : UITableViewCell{
    
    @IBOutlet weak var btnSocialMedia: UIButton!
    @IBOutlet weak var lblSocialMediaName: UILabel!
    @IBOutlet weak var imgSocialMediaImage: UIImageView!
    @IBOutlet weak var socialLinkBgVw: UIView!
    
}

class SideMenuHomeVC: UIViewController, UIGestureRecognizerDelegate{
    
    //MARK:- OUTLETS
    @IBOutlet weak var vwSecurity: UIView!
    @IBOutlet weak var vwSettings: UIView!
    @IBOutlet weak var vwAcccount: UIView!
    @IBOutlet weak var vwTanscation: UIView!
    @IBOutlet weak var vwFinacials: UIView!
    @IBOutlet weak var vwArtistFinancial: UIView!
    @IBOutlet weak var vwBlocked: UIView!
    @IBOutlet weak var vwHelp: UIView!
    @IBOutlet weak var vwFeedBack: UIView!
    @IBOutlet weak var vwSubHelp: UIView!
    @IBOutlet weak var lblHelpDetails: UILabel!
    
    @IBOutlet weak var helpDetailTextView: UITextView!
    @IBOutlet weak var lblHelpSubTitle: UILabel!
    @IBOutlet weak var tblTransaction: UITableView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tblSocialMediaLink: UITableView!
    @IBOutlet weak var lblHomeActive: UILabel!
    @IBOutlet weak var lblNotifyActive: UILabel!
    @IBOutlet weak var lblProfileActive: UILabel!
    @IBOutlet weak var lblFavActive: UILabel!
    @IBOutlet weak var vwBankAccount: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwSocial: UIView!
    @IBOutlet weak var logoutview: UIView!
    @IBOutlet weak var lblLogout: UILabel!
    @IBOutlet weak var LbllanguageName: UILabel!
    @IBOutlet weak var cvBlockView: UICollectionView!
    
    //constraints outlets
    @IBOutlet weak var vwIconInfoLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwsidemenuLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwBlockedLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwFeedbackLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwTransactionLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwHelpLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwSubHelpLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwArtistFinancialLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwSocialLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwSettingLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwAccountLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwFinancialLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwSecurityLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwLaunguageLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var vwArtistSettingLeadingSpace: NSLayoutConstraint!
    
    @IBOutlet weak var vwMyaccountALeadingSapace: NSLayoutConstraint!
    //image outlets
    @IBOutlet weak var imgMainMenu: imageProperties!
    @IBOutlet weak var imgHelp: imageProperties!
    @IBOutlet weak var imgTransaction: imageProperties!
    @IBOutlet weak var imgFeedback: imageProperties!
    @IBOutlet weak var imgBlocked: imageProperties!
    @IBOutlet weak var imgFinancial: imageProperties!
    @IBOutlet weak var imgAccount: imageProperties!
    @IBOutlet weak var img_Settings: imageProperties!
    @IBOutlet weak var imgSettings: imageProperties!
    @IBOutlet weak var imgSecurity: imageProperties!
    @IBOutlet weak var imgSocial: imageProperties!
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var imgArtistFinancial: imageProperties!
    @IBOutlet weak var imgSubHelpMenu: imageProperties!
    
    //localize outlets
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblfinancial: UILabel!
    @IBOutlet weak var lblTransHistory: UILabel!
    @IBOutlet weak var lblsecurity: UILabel!
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var lblblocked: UILabel!
    @IBOutlet weak var lblSSocial: UILabel!
    @IBOutlet weak var lblHelp: UILabel!
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var lblLaunguage: UILabel!
    @IBOutlet weak var lblAccount2: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var lblPaymentDueDate: UILabel!
    @IBOutlet weak var lblNOTEaccount: UILabel!
    @IBOutlet weak var lblsetting: UILabel!
    
    @IBOutlet weak var btnonSetting: UIButton!
    @IBOutlet weak var btnoffSetting: UIButton!
    @IBOutlet weak var btnBack: UIImageView!
    
    @IBOutlet weak var userActiveBtn: UIButton!
    //localize Financials
    @IBOutlet weak var lblDJConnectCashAck: UILabel!
    @IBOutlet weak var lblfinancials: UILabel!
    @IBOutlet weak var lblDjCurrentBalance: UILabel!
    @IBOutlet weak var lblDjCashAddGet: UILabel!
    @IBOutlet weak var txfDjConnectCash: textFieldProperties!
    @IBOutlet weak var lblDjpage1: UILabel!
    @IBOutlet weak var lblDjpage2: UILabel!
    @IBOutlet weak var vwDjpaymentDetail: UIView!
    @IBOutlet weak var vwDjNumberPad: UIView!
    @IBOutlet weak var lblDjCashOutActiveline: UILabel!
    @IBOutlet weak var lblDjConnectcashActiveline: UILabel!
    @IBOutlet weak var lblDjPendingBalance: UILabel!
    
  //  @IBOutlet weak var checkoutButton: UIButton! // ashitesh
      
    
    //cashout flow - dj
    @IBOutlet weak var vwDjMainCashOut: UIView!
    @IBOutlet weak var txfDjSelectAcNo: textFieldProperties!
    @IBOutlet weak var btnDjSelectAcNo: UIButton!
    @IBOutlet weak var SliderDjPayment: MySlide!
    @IBOutlet weak var btnDjCashoutAddAcc: UIButton!
    
    
    //localize Security
    @IBOutlet weak var lblSecurityCap: UILabel!
    @IBOutlet weak var btneditemail: UIButton!
    @IBOutlet weak var btnEditpassword: UIButton!
    @IBOutlet weak var lblCurrentEmail1: UILabel!
    
    //localize Blocked
    @IBOutlet weak var lblBlockedcap: UILabel!
    @IBOutlet weak var lblBlockusercannot: UILabel!
    
    //localize Social
    @IBOutlet weak var lblsocialcap: UILabel!
    @IBOutlet weak var lblsocialpage: UILabel!
    
    //localize Help
    @IBOutlet weak var lblhelpcap: UILabel!
    @IBOutlet weak var btnfaq: UIButton!
    @IBOutlet weak var btntermofservice: UIButton!
    @IBOutlet weak var btnPolicy: UIButton!
    @IBOutlet weak var supportBtn: UIButton!
    
    //localize feedback
    @IBOutlet weak var lblfeedbackcap: UILabel!
    @IBOutlet weak var lblfeedbackquestion: UILabel!
    
    //localize transaction
    @IBOutlet weak var lbltransactioncap: UILabel!
    @IBOutlet weak var sliderLogout: UISlider!
    
    //localize Artist Financials
    @IBOutlet weak var txfConnectCash: textFieldProperties!
    @IBOutlet weak var vwNumberPad: UIView!
    @IBOutlet weak var vwPaymentDetail: UIView!
    @IBOutlet weak var lblPage1: UILabel!
    @IBOutlet weak var lblPage2: UILabel!
    @IBOutlet weak var lblArConnectcashActiveline: UILabel!
    @IBOutlet weak var lblArcashoutActiveline: UILabel!
    @IBOutlet weak var lblArCashAddGet: UILabel!
    @IBOutlet weak var lblArCurrentBalance: UILabel!
    @IBOutlet weak var lblArPendingBalance: UILabel!
    
    //cashout flow - artist
    @IBOutlet weak var vwArMainCashout: UIView!
    @IBOutlet weak var txfArSelectAcNo: textFieldProperties!
    @IBOutlet weak var SliderArPayment: MySlide!
    @IBOutlet weak var btnArCashoutAddAcc: UIButton!
    @IBOutlet weak var btnArSelectAcNo: UIButton!
    
    
    //localize account
    @IBOutlet weak var lblFree: UILabel!
    @IBOutlet weak var lblYourFreeAcc: UILabel!
    @IBOutlet weak var btnEmailSendFeedback: UIButton!
    @IBOutlet weak var lblSelectLanguage: UILabel!
    
    //setting outlet
    
    @IBOutlet weak var imgSun: UIImageView!
    @IBOutlet weak var imgMon: UIImageView!
    @IBOutlet weak var imgTue: UIImageView!
    @IBOutlet weak var imgWed: UIImageView!
    @IBOutlet weak var imgThu: UIImageView!
    @IBOutlet weak var imgFri: UIImageView!
    @IBOutlet weak var imgSat: UIImageView!
    @IBOutlet weak var lblSun: UILabel!
    @IBOutlet weak var lblMon: UILabel!
    @IBOutlet weak var lblTue: UILabel!
    @IBOutlet weak var lblWed: UILabel!
    @IBOutlet weak var lblThu: UILabel!
    @IBOutlet weak var lblFri: UILabel!
    @IBOutlet weak var lblSat: UILabel!
    @IBOutlet weak var txfSetTime: UITextField!
    @IBOutlet weak var btnSave: buttonProperties!
    
    @IBOutlet weak var setRTimeTxtfld: UITextField!
    //setting artist outlet
    @IBOutlet weak var setTimeVw: UIView!
    @IBOutlet weak var vwArtistSetting: UIView!
    @IBOutlet weak var btnArtistOnSetting: UIButton!
    @IBOutlet weak var btnArtistOffSetting: UIButton!
    @IBOutlet weak var lblNotifyNumber: labelProperties!
    
    // payment - artist - outlets
    @IBOutlet weak var txfArNameOnCredit: textFieldProperties!
    @IBOutlet weak var txfArCardNo: textFieldProperties!
    @IBOutlet weak var txfArExpiryDate: textFieldProperties!
    @IBOutlet weak var txfArCvv: textFieldProperties!
    @IBOutlet weak var lblArCurrencySymbol: UILabel!
    
    //payment - dj - outlets
    @IBOutlet weak var txfDjNameOnCredit: textFieldProperties!
    @IBOutlet weak var txfDjCardNo: textFieldProperties!
    @IBOutlet weak var txfDjExpiryDate: textFieldProperties!
    @IBOutlet weak var txfDjCvv: textFieldProperties!
    @IBOutlet weak var lblDjCurrencySymbol: UILabel!
    
    //accont detail screen
    @IBOutlet weak var vwBankDetails: UIView!
    @IBOutlet weak var cnsBankDetailsLeadingSpace: NSLayoutConstraint!
    
    //localize dj finance
    @IBOutlet weak var btnDjConnectCash: UIButton!
    @IBOutlet weak var btnDjCashOut: UIButton!
    @IBOutlet weak var lblDjExpiry: UILabel!
    @IBOutlet weak var lblDjCode: UILabel!
    @IBOutlet weak var lblDjOrUse: UILabel!
    @IBOutlet weak var btnDjProcessPay: UIButton!
    @IBOutlet weak var lblDjSelectAcc: UILabel!
    @IBOutlet weak var lblDjNoteCashout: UILabel!
    
    //localize ar finance
    @IBOutlet weak var lblArConnectCashAck: UILabel!
    @IBOutlet weak var btnArCashOut: UIButton!
    @IBOutlet weak var btnArConnectCash: UIButton!
    @IBOutlet weak var lblArExpiry: UILabel!
    @IBOutlet weak var lblArCode: UILabel!
    @IBOutlet weak var lblArOrUse: UILabel!
    @IBOutlet weak var btnArProcessPay: UIButton!
    @IBOutlet weak var lblArSelectAcc: UILabel!
    @IBOutlet weak var lblArNoteCashout: UILabel!
    
    //account outlets
    @IBOutlet weak var vwAddPromo: UIView!
    @IBOutlet weak var vwAddedPromo: UIView!
    @IBOutlet weak var lblFirstNoDj: UILabel!
    @IBOutlet weak var lblPromotion: UILabel!
    @IBOutlet weak var lblPromoAck: UILabel!
    @IBOutlet weak var lblPromoExpire: UILabel!
    @IBOutlet weak var lblPromoDescrip1: UILabel!
    @IBOutlet weak var lblPromoDescrip2: UILabel!
    @IBOutlet weak var lblPromoDescrip3: UILabel!
    @IBOutlet weak var txtPromoCode: textFieldProperties!
    @IBOutlet weak var btnPromoAdd: buttonProperties!
    
    //icon info outlet
    @IBOutlet weak var vwIconInfo: UIView!
    @IBOutlet weak var txfPaypal: textFieldProperties!
    @IBOutlet weak var txfApplePay: textFieldProperties!
    
    //change email and password
    @IBOutlet weak var vwChangeEmail: UIView!
    @IBOutlet weak var vwChangeEmailLeadingSpace: NSLayoutConstraint!
    @IBOutlet weak var lblMainChangeEmailPwd: UILabel!
    @IBOutlet weak var vwChangeCurrentMail: UIView!
    @IBOutlet weak var vwChangeCurrentPwd: UIView!
    @IBOutlet weak var vwEmailVerify: UIView!
    @IBOutlet weak var lblCurrentEmail2: UILabel!
    
    
    @IBOutlet weak var updatePswrdBtn: UIButton!
    @IBOutlet weak var updateEmailBtn: UIButton!
    @IBOutlet weak var verifyEmailBtn: UIButton!
    
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtReenterNewMail: textFieldProperties!
    @IBOutlet weak var txfCurrPwd: textFieldProperties!
    
    @IBOutlet weak var lblCurrentEmail3: UILabel!
    @IBOutlet weak var txfVerifyMail: textFieldProperties!
    
    
    @IBOutlet weak var txtFieldCurrentPassword: UITextField!
    @IBOutlet weak var txtFieldNewPassword: UITextField!
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    @IBOutlet weak var cnsQuickPinTop: NSLayoutConstraint!
    @IBOutlet weak var lblSecurity_email: UILabel!
    @IBOutlet weak var lblSecurity_pwd: UILabel!
    @IBOutlet weak var lblSecurity_pwdValue: UILabel!
    @IBOutlet weak var finalVerifyEmalVw: UIView!
    
    @IBOutlet weak var transactionTableVwTop: NSLayoutConstraint!
    
    @IBOutlet weak var subscriptionVw: UIView!
    var notificationCountLbl:UILabel?
    @IBOutlet weak var goldPriceBTn: UIButton!
    @IBOutlet weak var subscriptionPriceLbl: UILabel!
    @IBOutlet weak var cardDescrFirstLbl: UILabel!
    @IBOutlet weak var cardDescSecondLbl: UILabel!
    @IBOutlet weak var inAppCardNoLbl: UILabel!
    @IBOutlet weak var perMonthLbl: UILabel!
    @IBOutlet weak var cancelMangeBtn: UIButton!
        
    @IBOutlet weak var basicBgVw: UIView!
    
    
    @IBOutlet weak var MyAccountMainView: UIView!
    
    @IBOutlet weak var myAccountBackBtn: UIButton!
    @IBOutlet weak var myAccountLbl: UILabel!
    @IBOutlet weak var accountTransactionHistoryBtn: UIButton!
    
    @IBOutlet weak var accountSecurityBtn: UIButton!
    @IBOutlet weak var inActiveAccountBtn: UIButton!
    @IBOutlet weak var acntDeleteBtn: UIButton!
    
    @IBAction func cancelMangeBtnTapped(_ sender: Any) {
    }
    @IBAction func goldBtnTapped(_ sender: Any) {
    }
    @IBAction func subscrptnBtnTapped(_ sender: Any) {
    }
    
    @IBAction func acntTrnsctHstryBtntapped(_ sender: Any) {
        openTransactionScreen()
    }
    
    @IBAction func accntSecurityBtntapped(_ sender: Any) {
        openSecurityScreen()
    }
    @IBAction func inactiveBtntapped(_ sender: Any) {
    }
    @IBAction func acntDeleteBtntapped(_ sender: Any) {
        self.deleteUserAlert()
    }
    
    @IBAction func walkthroughBtntapped(_ sender: Any) {
    }
    @IBAction func myAccountBackBtnTapped(_ sender: Any) {
        
        sideMenuController?.showLeftView()
    }
    
    @IBOutlet weak var walkthroughBtn: UIButton!
    
    //MARK: - ENUMS
    enum editType{
        case email
        case password
        case pin
    }
    
    enum ConnectType{
        case connect_case
        case cash_out
    }
    
    enum paymentType{
        case paypal
        case applepay
    }
    //MARK: - GLOBAL VARIABLES
    let step: Float = 5
    var arrLaunguage = ["Arabic".localize,"English".localize]
    var selectedIndex = 1
    var edit_typeSelected = editType.email
    var flag = String()
    var arFlag = String()
    var monFlag = String()
    var tueFlag = String()
    var wedFlag = String()
    var thurFlag = String()
    var friFlag = String()
    var satFlag = String()
    var sunFlag = String()
    
    var blockDetail = [blockProfileData]()
    var unblockId = String()
    var helpType = String()
    var subTitleHelp = String()
    var socialData = [socialDataLinkDetail]()
    var linkId = String()
    var feedbackEmail = String()
    let picker1 : UIDatePicker = UIDatePicker()
    var x = [String]()
    var stringArrayCleaned = String()
    var localArray = [String]()
    var days = String()
    var newNotify = Int()
    var numberArray = [String]()
    var numberArrayCleaned = String()
    var selectedConnectType = ConnectType.connect_case
    var arTransDetail = [ArTransDetail]()
    var djTransDetail = [DjTransDetail]()
    var currList = [CurrencyDataDetail]()
    let arSelectAcc = DropDown()
    let djSelectAcc = DropDown()
    var accountList = [GetAccountListModelDetail]()
    var arAccountId = String()
    var djAccountId = String()
    var transList = [BuyTransProjDetail]()
    var djTransList = [BuyDjTransProjDetail]()
    var arSubTransList = [DjTransHistArDetail]()
    var currentCurrency = String()
    var isExpand = [Bool](repeating: true, count: 4)
    var isExpanded = Bool()
    var startIndexTransHis = 0
    var noOfcellforTrans = 3
    var expandDataArray = [Int]()
    var expandTransaction = [Bool]()
    var iconDetailArray = [String]()
    var iconImagesArray = [String]()
    var paymentMethodType = paymentType.paypal
    var newMail = String()
    var userImage = UIImageView()
    var RegisterType = String()
    var connectCashAmountStr = String()
    enum ExpiryValidation {//For card expiry date validation
        case valid, invalidInput, expired
    }
    
    var userVerifyStr = String()
    var sreenType = String()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLE.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monFlag = "0"
        tueFlag = "0"
        wedFlag = "0"
        thurFlag = "0"
        friFlag = "0"
        satFlag = "0"
        sunFlag = "0"
        setRTimeTxtfld.delegate = self
        
        subscriptionVw.isHidden = true
        subscriptionVw.layer.cornerRadius = 20.0
        subscriptionVw.clipsToBounds = true
        subscriptionVw.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        basicBgVw.layer.cornerRadius = basicBgVw.frame.size.height/2
        basicBgVw.clipsToBounds = true
        
        goldPriceBTn.layer.cornerRadius = goldPriceBTn.frame.size.height/2
        goldPriceBTn.clipsToBounds = true
        inAppCardNoLbl.isHidden = true
        cancelMangeBtn.isHidden = true
        if UserModel.sharedInstance().userType == "DJ"{
            //subscriptionVw.isHidden = true
            transactionTableVwTop.constant = 40
        }else {
            //subscriptionVw.isHidden = false
            transactionTableVwTop.constant = 210
            callsubscriptionDetailsAPI()
        }
        //transactionTableVwTop.constant = 220
  
        callGetNotifyWebService()
        
        finalVerifyEmalVw.isHidden = true
//        var notiCount = 0
//
//        notiCount = UserModel.sharedInstance().notificationCount ?? 0
//        print("notiCount1",notiCount)
//        if notiCount != nil {
//            DispatchQueue.main.async {
//                if notiCount > 0 {
//                    self.lblNotifyNumber.isHidden = false
//                    self.lblNotifyNumber.text = "\(notiCount)"
//                    notiCount = 0
//                }else{
//                    self.lblNotifyNumber.isHidden = true
//                }
//            }
//        }
       // self.lblNotifyNumber.removeFromSuperview()
        NotificationCenter.default.addObserver(self, selector: #selector(changeButtonState(_:)), name: Notification.Name(rawValue: "sidemenuHomePresent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeButtonState2(_:)), name: Notification.Name(rawValue: "sidemenuProfilePresent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sideMenuWillOpen(_:)), name: Notification.Name(rawValue: "sideMenuWillOpen"), object: nil)
        localizeElements()
        
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        LbllanguageName.text = arrLaunguage[selectedIndex]
        tableview.tableFooterView = UIView()
        
        setLeftSpace(txf: txfDjCardNo)
        setLeftSpace(txf: txfDjNameOnCredit)
        setLeftSpace(txf: txfDjExpiryDate)
        setLeftSpace(txf: txfDjCvv)
        setLeftSpace(txf: txfArCardNo)
        setLeftSpace(txf: txfArNameOnCredit)
        setLeftSpace(txf: txfArExpiryDate)
        setLeftSpace(txf: txfArCvv)
        
        // contraints constant
        vwAccountLeadingSpace.constant = self.view.frame.size.width
        vwBlockedLeadingSpace.constant = self.view.frame.size.width
        vwFeedbackLeadingSpace.constant = self.view.frame.size.width
        vwTransactionLeadingSpace.constant = self.view.frame.size.width
        vwHelpLeadingSpace.constant = self.view.frame.size.width
        vwSubHelpLeadingSpace.constant = self.view.frame.size.width
        vwArtistFinancialLeadingSpace.constant = self.view.frame.size.width
        vwSocialLeadingSpace.constant = self.view.frame.size.width
        vwSettingLeadingSpace.constant = self.view.frame.size.width
        vwMyaccountALeadingSapace.constant = self.view.frame.size.width
        vwFinancialLeadingSpace.constant = self.view.frame.size.width
        vwSecurityLeadingSpace.constant = self.view.frame.size.width
        vwLaunguageLeadingSpace.constant = self.view.frame.size.width
        vwArtistSettingLeadingSpace.constant = self.view.frame.size.width
        cnsBankDetailsLeadingSpace.constant = self.view.frame.size.width
        vwIconInfoLeadingSpace.constant = self.view.frame.size.width
        vwChangeEmailLeadingSpace.constant = self.view.frame.size.width
        tblTransaction.tableFooterView = UIView(frame: CGRect.zero)
        
//        if UserModel.sharedInstance().isSignup == true && UserModel.sharedInstance().paymentPopup == false{
//            vwFinacials.isHidden = false
//            if UserModel.sharedInstance().userType == "DJ"{
//                popupAnimation_Action(vwFinancialLeadingSpace)
//            }else {
//                popupAnimation_Action(vwArtistFinancialLeadingSpace)
//            }
//        }
        if globalObjects.shared.isForgotPassword == "1"{
            vwSecurity.isHidden = false
            popupAnimation_Action(vwSecurityLeadingSpace)
        }
        
        let left = UISwipeGestureRecognizer(target : self, action : #selector(self.leftSwipe))
        left.direction = .left
        self.vwPaymentDetail.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target : self, action : #selector(self.rightSwipe))
        left.direction = .right
        self.vwNumberPad.addGestureRecognizer(right)
        
        arSelectAcc.selectionAction = {
            [unowned self] (index: Int, item: String) in
            let temp = ["no account added"]
            if temp == self.arSelectAcc.dataSource{
                
            }else{
                self.txfArSelectAcNo.text = self.arSelectAcc.selectedItem
                self.arAccountId = self.accountList[index].id!
                self.btnArCashoutAddAcc.setTitle("back", for: .normal)
            }
        }
        
        djSelectAcc.selectionAction = {
            [unowned self] (index: Int, item: String) in
            let temp = ["no account added"]
            if temp == self.djSelectAcc.dataSource{
                
            }else{
                self.txfDjSelectAcNo.text = self.djSelectAcc.selectedItem
                self.djAccountId = self.accountList[index].id!
                self.btnDjCashoutAddAcc.setTitle("back", for: .normal)
            }
        }
        
        iconDetailArray = ["- User Waiting","- User Submitted Info","- User Info Accepted","- User Info Not Accepted","- Payment Waiting","- Paid","- Payment Refunded","- Product Waiting","- Product Delivered","- Leave Feedback","- Feedback Left","- Time Expired","- Project Cancelled","- Project Completed"]
        iconImagesArray = ["iconinfo1","iconinfo2","iconinfo3","iconinfo4","iconinfo5","iconinfo6","iconinfo7","iconinfo8","iconinfo9","iconinfo10","icoinfo11","iconinfo12","iconinfo13","iconinfo14"]
        
        txfDjConnectCash.delegate = self
        
        txfConnectCash.delegate = self
        
        if(sreenType == "Transac"){
            myAccountLbl.text = ""
            openTransactionScreen()
        }
        else if(sreenType == "Account"){
            myAccountLbl.text = ""
            openAccountScreen()
        }
        else if(sreenType == "myAccount"){
            
            let getUserActiveStr = UserDefaults.standard.string(forKey: "userVerify")
            if(getUserActiveStr == "0"){
                userActiveBtn.setImage(UIImage(named: "displayOff"), for: .normal)
                userActiveBtn.isUserInteractionEnabled = false
            }
            else{
                userActiveBtn.isUserInteractionEnabled = true
                userActiveBtn.setImage(UIImage(named: "displayOn"), for: .normal)
            }
            openMyAccountScreen()
        }
        else if(sreenType == "Financial"){
            myAccountLbl.text = ""
            let getUserActiveStr = UserDefaults.standard.string(forKey: "userVerify")
            if(getUserActiveStr == "0"){
                self.showToast(message: "Please make verify through Admin first.")
            }
            else{
                openFinancialScreen()
            }
            
        }
        else if(sreenType == "Settings"){
            myAccountLbl.text = ""
            openSettingScreen()
        }
        else if(sreenType == "Security"){
            myAccountLbl.text = ""
            openSecurityScreen()
        }
        else if(sreenType == "Support"){
            myAccountLbl.text = ""
            openHelpScreen()
        }
        else if(sreenType == "Feedback"){
            myAccountLbl.text = ""
            openFeedbackScreen()
        }
        else if(sreenType == "Social"){
            myAccountLbl.text = ""
            openSocialScreen()
        }
        
        updatePswrdBtn.layer.cornerRadius = updatePswrdBtn.frame.size.height/2
        updatePswrdBtn.clipsToBounds = true
        
        updateEmailBtn.layer.cornerRadius = updateEmailBtn.frame.size.height/2
        updateEmailBtn.clipsToBounds = true
        
        verifyEmailBtn.layer.cornerRadius = verifyEmailBtn.frame.size.height/2
        verifyEmailBtn.clipsToBounds = true
        
        setTimeVw.layer.cornerRadius = 10.0
        setTimeVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        setTimeVw.layer.borderWidth = 0.5
        setTimeVw.clipsToBounds = true
        
        setRTimeTxtfld.attributedPlaceholder = NSAttributedString(
            string: "Time to remind:",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        //self.updateNotiCount()
    }
    
    func createGradient(view: UIView, bounds: CGSize) {
            let gradientLayer = CAGradientLayer()
            var updatedFrame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: bounds)
            updatedFrame.size.height += 100
            gradientLayer.frame = updatedFrame
        gradientLayer.colors = [UIColor(red: 209 / 255, green: 126 / 255, blue: 51 / 255, alpha: 1).cgColor, UIColor(red: 213 / 255, green: 222 / 255, blue: 69 / 255, alpha: 1).cgColor] // start color and end color
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // horizontal gradient start
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) // horizontal gradient end
            UIGraphicsBeginImageContext(gradientLayer.bounds.size)
            // gradientLayer.render(in: UIGraphicsGetCurrentContext() ?? UIGraphicsGetCurrentContext())
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            view.backgroundColor = UIColor.init(patternImage: (image ?? UIImage()).resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch))
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
                
//        if UserModel.sharedInstance().appLanguage == "0"{
//            sliderLogout.setThumbImage(UIImage(named: "logout_new_en"), for: .normal)
//            sliderLogout.setThumbImage(UIImage(named: "logout_new_en"), for: .highlighted)
//            btnBack.setImage(UIImage(named: "white_right_arror_new_ar")!)
//        }else{
//            sliderLogout.setThumbImage(UIImage(named: "logout_new_en"), for: .normal)
//            sliderLogout.setThumbImage(UIImage(named: "logout_new_en"), for: .highlighted)
//            btnBack.setImage(UIImage(named: "white_right_arror_new_en")!)
//        }
        
        callGetProfileWebService()
        callCurrencyListWebService()
        sliderLogout.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        btnSave.layer.cornerRadius = btnSave.frame.size.height/2
        btnSave.clipsToBounds = true
        if(sreenType == "Transac"){
            myAccountLbl.text = ""
            openTransactionScreen()
        }
        else if(sreenType == "Account"){
            myAccountLbl.text = ""
            openAccountScreen()
        }
        else if(sreenType == "myAccount"){
            let getUserActiveStr = UserDefaults.standard.string(forKey: "userVerify")
            if(getUserActiveStr == "0"){
                userActiveBtn.setImage(UIImage(named: "displayOff"), for: .normal)
                userActiveBtn.isUserInteractionEnabled = false
            }
            
            else{
                userActiveBtn.isUserInteractionEnabled = true
                userActiveBtn.setImage(UIImage(named: "displayOn"), for: .normal)
            }
            openMyAccountScreen()
        }
        else if(sreenType == "Financial"){
            myAccountLbl.text = ""
            let getUserActiveStr = UserDefaults.standard.string(forKey: "userVerify")
            if(getUserActiveStr == "0"){
                self.showToast(message: "Please make verify through Admin first.")
            }
            else{
                openFinancialScreen()
            }
            
        }
        else if(sreenType == "Settings"){
            myAccountLbl.text = ""
            openSettingScreen()
        }
        else if(sreenType == "Security"){
            myAccountLbl.text = ""
            openSecurityScreen()
        }
        else if(sreenType == "Support"){
            myAccountLbl.text = ""
            openHelpScreen()
        }
        else if(sreenType == "Feedback"){
            myAccountLbl.text = ""
            openFeedbackScreen()
        }
        else if(sreenType == "Social"){
            myAccountLbl.text = ""
            openSocialScreen()
        }
    }
    
    //MARK:- WEBSERVICE CALLING
    func callcheckUserVerifyAPI(){
        
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid": "\(UserModel.sharedInstance().userId!)"
            ]
            print("parameters34",parameters)
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.checkUserVerifyAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<CheckUserVerifyModel>) in
       
                switch response.result {
                case .success(_):
                    self.removeLoader()
                    Loader.shared.hide()
                    let getProfile = response.result.value!
                    if getProfile.success == 1{
                        
                        
                        self.userVerifyStr = getProfile.userdata?.admin_verify ?? ""
                        print("userVerifyStr",self.userVerifyStr)
                       
                        print("sucessUserCheck")
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
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
        
    //MARK:- OTHER METHODS
    func removeView_Action( _ con : NSLayoutConstraint){
        con.constant = self.view.frame.size.width
        self.view.layoutIfNeeded()
    }
    
    func removeOtherView(){
        if self.view.subviews.contains(vwSettings) {
            removeView_Action(vwSettingLeadingSpace)
        }
        if self.view.subviews.contains(vwBlocked) {
            removeView_Action(vwBlockedLeadingSpace)
        }
        if self.view.subviews.contains(vwHelp) {
            removeView_Action(vwHelpLeadingSpace)
        }
        if self.view.subviews.contains(MyAccountMainView){
            removeView_Action(vwMyaccountALeadingSapace)
        }
        if self.view.subviews.contains(vwSubHelp) {
            removeView_Action(vwSubHelpLeadingSpace)
        }
        if self.view.subviews.contains(vwFeedBack) {
            removeView_Action(vwFeedbackLeadingSpace)
        }
        if self.view.subviews.contains(vwSocial) {
            removeView_Action(vwSocialLeadingSpace)
        }
        if self.view.subviews.contains(vwArtistSetting) {
            removeView_Action(vwArtistSettingLeadingSpace)
        }
        if self.view.subviews.contains(vwFinacials) {
            removeView_Action(vwFinancialLeadingSpace)
        }
        if self.view.subviews.contains(vwArtistFinancial) {
            removeView_Action(vwArtistFinancialLeadingSpace)
        }
        if self.view.subviews.contains(vwTanscation) {
            removeView_Action(vwTransactionLeadingSpace)
        }
        if self.view.subviews.contains(vwBankDetails) {
            removeView_Action(cnsBankDetailsLeadingSpace)
        }
        if self.view.subviews.contains(vwAcccount) {
            removeView_Action(vwAccountLeadingSpace)
        }
        if self.view.subviews.contains(vwIconInfo) {
            removeView_Action(vwIconInfoLeadingSpace)
        }
        if self.view.subviews.contains(vwChangeEmail){
            removeView_Action(vwChangeEmailLeadingSpace)
        }
    }
    
    func HOME(){
        let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SideMenuNavigationArtistHome") as! UINavigationController
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
        desiredViewController.view.addSubview(snapshot);
        appdel.window?.rootViewController = desiredViewController;
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview();
        });
    }
    
    func ChangeRoot() {
//        let homeSB = UIStoryboard(name: "SignIn", bundle: nil)
//        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "SignUp") as! UINavigationController
//        let appdel = UIApplication.shared.delegate as! AppDelegate
//        let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
//        desiredViewController.view.addSubview(snapshot);
//        appdel.window?.rootViewController = desiredViewController;
//        UIView.animate(withDuration: 0.3, animations: {() in
//            snapshot.layer.opacity = 0;
//            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
//        }, completion: {
//            (value: Bool) in
//            snapshot.removeFromSuperview();
//        });
        let storyBoard : UIStoryboard = UIStoryboard(name: "SignIn", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
        let navigationController = UINavigationController(rootViewController: nextViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController
    }
    
    func popupAnimation_Action(_ con : NSLayoutConstraint){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, animations: {
            con.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in
            
        }
    }
    
    func closeBtnAnimation_Action( _ con : NSLayoutConstraint){
        UIView.animate(withDuration: 1.0, animations: {
            con.constant = self.view.frame.size.width
            self.txfArNameOnCredit.text = ""
            self.txfArCardNo.text = ""
            self.txfArExpiryDate.text = ""
            self.txfArCvv.text = ""
            self.txfDjNameOnCredit.text = ""
            self.txfDjCardNo.text = ""
            self.txfDjExpiryDate.text = ""
            self.txfDjCvv.text = ""
            self.view.layoutIfNeeded()
        }) { (completion) in
        }
    }
    
    func userSelection() {
        if UserModel.sharedInstance().userType == "DJ" {
            lblTitle.text = "DJ MENU".localize
            changeImage(imgFinancial)
            changeImage(imgHelp)
            changeImage(imgTransaction)
            changeImage(imgFeedback)
            changeImage(imgBlocked)
            changeImage(imgArtistFinancial)
            changeImage(imgAccount)
            changeImage(img_Settings)
            //changeImage(imgSettings)
            changeImage(imgSecurity)
            changeImage(imgSocial)
            changeImage(imgSubHelpMenu)
        }else {
            lblTitle.text = "ARTIST MENU".localize
            changeImage(imgFinancial)
            changeImage(imgHelp)
            changeImage(imgTransaction)
            changeImage(imgFeedback)
            changeImage(imgBlocked)
            changeImage(imgArtistFinancial)
            changeImage(imgAccount)
            changeImage(img_Settings)
            //changeImage(imgSettings)
            changeImage(imgSecurity)
            changeImage(imgSocial)
            changeImage(imgSubHelpMenu)
        }
    }
    
    func changeImage(_ image: UIImageView) {
        image.image = userImage.image
    }
    
    func arabic(){
        UserModel.sharedInstance().appLanguage = "0"
        UserModel.sharedInstance().synchroniseData()
        
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        let arabic = Locale().initWithLanguageCode(languageCode: "ar", countryCode: "ar", name: "Arabic")
        DGLocalization.sharedInstance.setLanguage(withCode:arabic)
        self.reloadViewFromNib()
    }
    
    func english(){
        UserModel.sharedInstance().appLanguage = "1"
        UserModel.sharedInstance().synchroniseData()
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        let English = Locale().initWithLanguageCode(languageCode: "en", countryCode: "en", name: "English")
        DGLocalization.sharedInstance.setLanguage(withCode:English)
        self.reloadViewFromNib()
    }
    
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
        self.selectedIndex = Int(UserModel.sharedInstance().appLanguage)!
        LbllanguageName.text = arrLaunguage[selectedIndex]
        tableview .reloadData()
        self.HOME()
    }
    
    func localizeElements(){
        lblSelectLanguage.text = "Select Language".localize
        lblAccount.text = "Account".localize
        lblLogout.text = "LOGOUT".localize
        lblfinancial.text = "Financials".localize
        lblTransHistory.text = "Transaction History".localize
        //lblsecurity.text = "Security".localize
        lblSetting.text = "Settings".localize
        lblblocked.text = "Blocked".localize
//        lblSSocial.text = "Social".localize
        lblSSocial.text = "Social"
        //lblHelp.text = "Help".localize
        //lblFeedback.text = "Feedback".localize
        lblLaunguage.text = "Language".localize
        lblFeedback.text = "Support"
        
        //Sidemenu Account
        lblAccount2.text = "Account".localize
        lblAccountType.text = "Account Type :".localize
        lblPaymentDueDate.text = "Payment due date :".localize
        lblNOTEaccount.text = "NOTE:".localize
        lblPromotion.text = "Promotion".localize
        lblPromoExpire.text = "Expires".localize
        btnPromoAdd.setTitle("ADD", for: .normal)
        
//        btnonSetting.setTitle("ON".localize, for: .normal)
//        btnoffSetting.setTitle("OFF".localize, for: .normal)
       // btnonSetting.setImage(UIImage (named: "displayOn"), for: .normal)
        //btnoffSetting.setImage(UIImage (named: "displayOff"), for: .normal)
        
        //financial localize
       // lblsetting.text = "SETTINGS".localize
        lblsetting.text = "Turn On Notification"
        lblfinancials.text = "FINANCIALS".localize
        
        //sidemenu security
        //lblSecurityCap.text = "SECURITY".localize
        
        //sidemenu blocked
        lblBlockedcap.text = "BLOCKED".localize
        lblBlockusercannot.text = "Blocked users cannot view your profile and they cannot participate in your projects.".localize
        
        //sidemenu social
        //lblsocialcap.text = "SOCIAL".localize
        lblsocialpage.text = "Connect with DJ Connect on our social  pages.".localize
        
        //sidemenu Help
        //lblhelpcap.text = "HELP".localize
        btnfaq.setTitle("FAQ".localize, for: .normal)
        btntermofservice.setTitle("Terms of Service".localize, for: .normal)
        btnPolicy.setTitle("Privacy Policy", for: .normal)
        supportBtn.setTitle("Support", for: .normal)
        
        //sidemenu Feedback
        lblfeedbackcap.text = "Support"
        lblfeedbackquestion.text = "If you have any questions, concerns,need further assistance or would like to leave feedback to help us make this app even better, contacts us on our social networks or reach out to us at the email below.".localize
        
        //lbltransactioncap.text = "TRANSACTION HISTORY".localize
        
        lblDJConnectCashAck.text = "ConnectCashAck".localize
        btnDjConnectCash.setTitle("Connect Cash".localize, for: .normal)
        btnDjCashOut.setTitle("Cash Out".localize, for: .normal)
        lblDjExpiry.text = "expiration".localize
        lblDjCode.text = "code".localize
        lblDjOrUse.text = "- or use -".localize
        btnDjProcessPay.setTitle("process payment".localize, for: .normal)
        lblDjNoteCashout.text = "dj_note_cashout".localize
        lblArConnectCashAck.text = "ConnectCashAck".localize
        btnArConnectCash.setTitle("Connect Cash".localize, for: .normal)
        btnArCashOut.setTitle("Cash Out".localize, for: .normal)
        lblArExpiry.text = "expiration".localize
        lblArCode.text = "code".localize
        lblArOrUse.text = "- or use -".localize
        btnArProcessPay.setTitle("process payment".localize, for: .normal)
        lblArNoteCashout.text = "dj_note_cashout".localize
    }
    
    func showStartDatePicker(){
        //Formate Date
        if #available(iOS 13.4, *) {
            picker1.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        picker1.frame = CGRect(x:0, y: self.view.frame.height-picker1.frame.height, width: picker1.frame.width, height: picker1.frame.height)
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        toolbar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolbar.backgroundColor = #colorLiteral(red: 0.768627451, green: 0, blue: 0.4901960784, alpha: 1)
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action:#selector(startDateTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton,], animated: false)
        picker1.datePickerMode = .time
        txfSetTime.inputAccessoryView = toolbar
        txfSetTime.inputView = picker1
        
        setRTimeTxtfld.inputAccessoryView = toolbar
        setRTimeTxtfld.inputView = picker1
    }
    
    func handleError(error: NSError) {
        print(error)
    }
    
    func setArAccountListDropDown(){
        arSelectAcc.anchorView = btnArSelectAcNo
        arSelectAcc.width = btnArSelectAcNo.frame.width
        arSelectAcc.show()
        arSelectAcc.direction = .any
        arSelectAcc.bottomOffset = CGPoint(x: 0, y: 38)
    }
    func setDjAccountListDropDown(){
        djSelectAcc.anchorView = btnDjSelectAcNo
        djSelectAcc.width = btnArSelectAcNo.frame.width
        djSelectAcc.show()
        djSelectAcc.direction = .any
        djSelectAcc.bottomOffset = CGPoint(x: 0, y: 38)
    }
    
    func callBuyReceipt(index: Int){
        if UserModel.sharedInstance().userType == "AR"{
            if transList[index].type == "apply"{
                
                
                let homeSB = UIStoryboard(name: "Receipt", bundle: nil)
                let desireViewController = homeSB.instantiateViewController(withIdentifier: "BuyReceiptVC") as! BuyReceiptVC
                
                desireViewController.projName = transList[index].project_name!
                desireViewController.projCost = transList[index].project_price!
                desireViewController.djname = transList[index].dj_name!
                desireViewController.eventDate = transList[index].purchased_date!
                desireViewController.djId = "\(transList[index].dj_id!)"
                desireViewController.projId = "\(transList[index].project_id!)"
                desireViewController.currency = self.currentCurrency
                
                self.navigationController?.pushViewController(desireViewController, animated: false)
                
//
//                let homeSB = UIStoryboard(name: "Receipt", bundle: nil)
//                let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationProfile") as! UINavigationController
//                let desireViewController = homeSB.instantiateViewController(withIdentifier: "BuyReceiptVC") as! BuyReceiptVC
//                desireViewController.projName = transList[index].project_name!
//                desireViewController.projCost = transList[index].project_price!
//                desireViewController.djname = transList[index].dj_name!
//                desireViewController.eventDate = transList[index].purchased_date!
//                desireViewController.djId = "\(transList[index].dj_id!)"
//                desireViewController.projId = "\(transList[index].project_id!)"
//                desireViewController.currency = self.currentCurrency
//                desiredViewController.setViewControllers([desireViewController], animated: false)
//                let appdel = UIApplication.shared.delegate as! AppDelegate
//                let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
//                desiredViewController.view.addSubview(snapshot);
//                appdel.window?.rootViewController = desiredViewController;
//                UIView.animate(withDuration: 0.3, animations: {() in
//                    snapshot.layer.opacity = 0;
//                    snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
//                }, completion: {
//                    (value: Bool) in
//                    snapshot.removeFromSuperview();
//                });
            }
        }
    }
    
    func setLeftSpace(txf: UITextField){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: txf.frame.size.height))
        view.backgroundColor = UIColor.clear
        txf.leftView = view
        txf.leftViewMode = .always
    }
    
    func logout(){
        UserModel.sharedInstance().isSignup = true
        UserModel.sharedInstance().isSkip = false
        UserDefaults.standard.set(false, forKey: "isProfileComplete")
        UserDefaults.standard.set(false, forKey: "isPaymentComplete")
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logOut()
        let applanguage = UserModel.sharedInstance().appLanguage
        let latitude = UserModel.sharedInstance().currentLatitude
        let longitude = UserModel.sharedInstance().currentLongitude
        //let deviceToken = UserModel.sharedInstance().deviceToken
       // print("sideMenu_deviceToken",deviceToken)
        let username = UserModel.sharedInstance().userName
        let password = UserModel.sharedInstance().password
        let isRemember = UserModel.sharedInstance().isRemembered
        let rememberType = UserModel.sharedInstance().RememberUserType
        let arname = UserModel.sharedInstance().arname
        let arpassword = UserModel.sharedInstance().arpassword
        UserModel.sharedInstance().removeData()
        UserModel.sharedInstance().synchroniseData()
        UserModel.sharedInstance().appLanguage = applanguage
        UserModel.sharedInstance().currentLatitude = latitude
        UserModel.sharedInstance().currentLongitude = longitude
       // print("sideMenu_deviceToken1",deviceToken)
       // UserModel.sharedInstance().deviceToken = deviceToken
        UserModel.sharedInstance().synchroniseData()
        if isRemember == "1"{
            UserModel.sharedInstance().arname = arname
            UserModel.sharedInstance().arpassword = arpassword
            UserModel.sharedInstance().userName = username
            UserModel.sharedInstance().password = password
            UserModel.sharedInstance().isRemembered = isRemember
            UserModel.sharedInstance().RememberUserType = rememberType
            UserModel.sharedInstance().synchroniseData()
        }else{
            UserModel.sharedInstance().isRemembered = isRemember
        }
        
//        UserModel.sharedInstance().token = ""
//        UserModel.sharedInstance().userId = ""
//        UserModel.sharedInstance().removeData()
//        UserModel.sharedInstance().synchroniseData()
        self.ChangeRoot()
        
    }
    //MARK: - SELECTOR METHODS
    @objc func sideMenuWillOpen(_ notification: Notification) {
        
        callcheckUserVerifyAPI()
        updateNotiCount()
        callGetProfileWebService()
        removeOtherView()
    }
    
    @objc func startDateTimePicker(){
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateFormat = "h:mm a"
        txfSetTime.text = timeFormatter.string(from: picker1.date)
        setRTimeTxtfld.text = timeFormatter.string(from: picker1.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    @objc func btnUnblock_Action(_ sender: UIButton){
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            unblockId = "\(blockDetail[sender.tag].block_user_id!)"
            callUnBlockUserWebService(sender.tag)
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @objc func btnSocialMedia_Action(_ sender: UIButton){
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            linkId = socialData[sender.tag].social_media_link!
            UIApplication.shared.open(URL(string: "https://\(linkId)")! as URL, options: [:], completionHandler: nil)
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @objc func changeButtonState(_ notification: Notification) {
        lblHomeActive.isHidden = false
        lblNotifyActive.isHidden = true
        lblProfileActive.isHidden = true
        lblFavActive.isHidden = true
    }
    @objc func changeButtonState2(_ notification: Notification) {
        lblHomeActive.isHidden = true
        lblNotifyActive.isHidden = true
        lblProfileActive.isHidden = false
        lblFavActive.isHidden = true
    }
    
    @objc func closeAccount(_ notification: Notification) {
        closeBtnAnimation_Action(vwAccountLeadingSpace)
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began: break
            // handle drag began
            case .moved: break
            // handle drag moved
            case .ended:
                let roundedValue = round(slider.value / step) * step
                slider.value = roundedValue
                print("=====================slider================")
                print(slider.value)
                if slider.value == 5 {
                    //logout code
                    callLogoutWebservice()
                }
                break
            // handle drag ended
            default:
                break
            }
        }
    }
    
    @objc func leftSwipe(){
        self.vwPaymentDetail.isHidden = true
        self.vwNumberPad.isHidden = false
        if UserModel.sharedInstance().userType == "DJ"{
            lblDjpage1.backgroundColor = .themeBlack
            lblDjpage2.backgroundColor = .lightGray
        }else{
            lblDjpage1.backgroundColor = .themeBlack
            lblDjpage2.backgroundColor = .lightGray
        }
    }
    
    @objc func rightSwipe(){
        self.vwPaymentDetail.isHidden = false
        self.vwNumberPad.isHidden = true
    }
    
    @objc func openIconView(_ sender: UIButton){
        popupAnimation_Action(vwIconInfoLeadingSpace)
    }
    
    @objc func viewReceiptAction(_ sender: UIButton){
        if transList[sender.tag].type == "apply_project"{
            //let ReceiptStoryboard = UIStoryboard(name: "Receipt", bundle: nil)
//            let homeSB = UIStoryboard(name: "DJProfile", bundle: nil)
//            let desiredViewController = homeSB.instantiateViewController(withIdentifier: "sideMenuNavigationProfile") as! UINavigationController
//            let desireViewController = ReceiptStoryboard.instantiateViewController(withIdentifier: "BuyReceiptVC") as! BuyReceiptVC
//            desireViewController.projName = transList[sender.tag].project_name!
//            desireViewController.projCost = transList[sender.tag].project_price!
//            desireViewController.djname = transList[sender.tag].dj_name!
//            desireViewController.eventDate = transList[sender.tag].purchased_date!
//            desireViewController.djId = "\(transList[sender.tag].dj_id!)"
//            desireViewController.projId = "\(transList[sender.tag].project_id!)"
//            desireViewController.currency = self.currentCurrency
//            desiredViewController.setViewControllers([desireViewController], animated: false)
//            let appdel = UIApplication.shared.delegate as! AppDelegate
//            let snapshot:UIView = (appdel.window?.snapshotView(afterScreenUpdates: true))!
//            desiredViewController.view.addSubview(snapshot);
//            appdel.window?.rootViewController = desiredViewController;
//            UIView.animate(withDuration: 0.3, animations: {() in
//                snapshot.layer.opacity = 0;
//                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
//            }, completion: {
//                (value: Bool) in
//                snapshot.removeFromSuperview();
//            });
//        }
        
        let homeSB = UIStoryboard(name: "Receipt", bundle: nil)
        let desireViewController = homeSB.instantiateViewController(withIdentifier: "BuyReceiptVC") as! BuyReceiptVC
        desireViewController.projName = transList[sender.tag].project_name!
        desireViewController.projCost = transList[sender.tag].project_price!
        desireViewController.djname = transList[sender.tag].dj_name!
        desireViewController.eventDate = transList[sender.tag].purchased_date!
        desireViewController.djId = "\(transList[sender.tag].dj_id!)"
        desireViewController.projId = "\(transList[sender.tag].project_id!)"
        desireViewController.currency = self.currentCurrency
        
        self.navigationController?.pushViewController(desireViewController, animated: false)
        }
    }
    
    func CallGetCreditsWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getCurrentCreditsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    if let jsonData = response.result.value as? [String: AnyObject]{
                        print(jsonData)
                        if jsonData["success"]! as! NSNumber == 1{
                            
                            let formatter = NumberFormatter()
                            formatter.groupingSeparator = "," // or possibly "." / ","
                            formatter.numberStyle = .decimal
                            
                            if let x = (jsonData["total_current_credit"] as? String){
                                if UserModel.sharedInstance().userType == "DJ"{
                                    
                                    self.lblDjCurrentBalance.text = self.lblDjCurrencySymbol.text! + "\(x)"
                                }else{
                                    
//                                    formatter.string(from: Int(x)! as NSNumber)
//                                    let stri11 = formatter.string(from: Int(x)! as NSNumber)
//                                    self.lblArCurrentBalance.text = self.lblArCurrencySymbol.text! + stri11!
                                    self.lblArCurrentBalance.text = self.lblArCurrencySymbol.text! + "\(x)"
                                }
                            }
                            NotificationCenter.default.post(name: NSNotification.Name("Test12"), object: self, userInfo: ["name": "Webkul"])
                            if let y = (jsonData["total_pedding_credit"] as? String){
                                var value : String?
                                value = y
                                if value!.contains("-") {
                                    value = y.replacingOccurrences(of: "-", with: "")
                                    print("value",value!)
                                }
                                if value!.contains("+") {
                                    value = y.replacingOccurrences(of: "+", with: "")
                                    print("value",value!)
                                }
                                if UserModel.sharedInstance().userType == "DJ"{
                                
                                    if value == "0"{
                                        self.lblDjPendingBalance.text = ""
                                    }else{
                                        
                                        self.lblDjPendingBalance.text = " (" + UserModel.sharedInstance().userCurrency! + " \(value!))"
//                                        self.lblDjPendingBalance.text = " (+\(y))"
//                                        self.lblDjPendingBalance.text = " (" + self.lblDjCurrencySymbol.text! + " \(value!))" // ashitesh new
                                    }
                                }else{
                                    ///
                                    if value == "0"{
                                        self.lblArPendingBalance.text = ""
                                    }else{
//                                        self.lblArPendingBalance.text = " (-\(y))"
//                                        self.lblArPendingBalance.text =  " (" + self.lblDjCurrencySymbol.text! + " \(value!))"
                                        self.lblArPendingBalance.text =  " (" + UserModel.sharedInstance().userCurrency! + " \(value!))"
                                    }
                                }
                            }
                        }else{
                            Loader.shared.hide()
                            self.view.makeToast("There is some issue loading current credit.")
                        }
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
            )}else{
                self.view.makeToast("Please check your Internet Connection")
            }
    }
    
    //MARK:- ACTIONS
    @IBAction func btnEnglish_Action(_ sender: UIButton) {
        self.view.setNeedsLayout()
        self.english()
    }
    
    @IBAction func btnArabic_Action(_ sender: UIButton) {
        self.view.setNeedsLayout()
        self.arabic()
    }
    
    @IBAction func btnClose_Action(_ sender: UIButton) {
        NotificationCenter.default.addObserver(self, selector: #selector(closeAccount(_:)), name: Notification.Name(rawValue: "sideMenuAccount"), object: nil)
        toggleSideMenuView()
    }
    
    @IBAction func btnProfile_Action(_ sender: UIButton) {
        if(self.userVerifyStr == "0"){ // ashi profile
            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
        }
        else if(self.userVerifyStr == "1"){
            lblHomeActive.isHidden = true
            lblNotifyActive.isHidden = true
            lblProfileActive.isHidden = false
            lblFavActive.isHidden = true
            UserModel.sharedInstance().isPin = false
            UserModel.sharedInstance().synchroniseData()
            if UserModel.sharedInstance().userType == "DJ"{
                let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
                let next1 = storyBoard.instantiateViewController(withIdentifier: "CalendarVC") as? CalendarVC
                next1?.isFromMenu = true
                sideMenuController()?.setContentViewController(next1!)
            }else{
                let storyBoard = UIStoryboard(name: "ArtistProfile", bundle: nil)
                let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as? ArtistViewProfileVC
                next1?.isFromMenu = true
                sideMenuController()?.setContentViewController(next1!)
            }
        }
        else{
            callLogoutWebservice()
        }
        
    }
    
    @IBAction func btnHomeMenu_Action(_ sender: UIButton) {
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            lblHomeActive.isHidden = false
            lblNotifyActive.isHidden = true
            lblProfileActive.isHidden = true
            lblFavActive.isHidden = true
            self.showToast(message: "Data Save.")
    //        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
    //        })
                        
            if UserModel.sharedInstance().userType == "AR"{
                let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
                let next1 = homeSB.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
                sideMenuController()?.setContentViewController(next1!)
            }else{
                let homeSB = UIStoryboard(name: "DJHome", bundle: nil)
                let next1 = homeSB.instantiateViewController(withIdentifier: "DJHomeVC") as? DJHomeVC
                sideMenuController()?.setContentViewController(next1!)
            }
//        }
//        else{
//            callLogoutWebservice()
//        }
//
    }
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func btnFavMenuu_Action(_ sender: UIButton) {
        openFavMenuScreen()
    }
    
    func openFavMenuScreen(){
//        if(self.userVerifyStr == "0"){ // ashi favourite
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            lblHomeActive.isHidden = true
            lblNotifyActive.isHidden = true
            lblProfileActive.isHidden = true
            lblFavActive.isHidden = false
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "FavoriteMenuVC") as? FavoriteMenuVC
            sideMenuController()?.setContentViewController(next1!)
//        }
//        else{
//            callLogoutWebservice()
//        }
        
    }
    
    @IBAction func btnNotifyAction(_ sender: UIButton) { // ashi notification button
        if(self.userVerifyStr == "0"){
            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
        }
        else if(self.userVerifyStr == "1"){
            lblHomeActive.isHidden = true
            lblNotifyActive.isHidden = false
            lblProfileActive.isHidden = true
            lblFavActive.isHidden = true
            let storyBoard = UIStoryboard(name: "AlertFlow", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "AlertVC") as? AlertVC
            next1?.isFromMenu = true
            sideMenuController()?.setContentViewController(next1!)
        }
        else{
            callLogoutWebservice()
        }
        
    }
    
    @IBAction func btnAccount_Action(_ sender: UIButton) {
        openAccountScreen()
    }
    
    func openAccountScreen(){
//        if(self.userVerifyStr == "0"){ // ashi acount
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            NotificationCenter.default.post(name: Notification.Name(rawValue: "sideMenuAccount"), object: nil)
    //        if UserModel.sharedInstance().userType == "AR"{
    //            lblNOTEaccount.isHidden = true
    //            lblYourFreeAcc.isHidden = true
    //            callGetPromoCodeWebservice()
    //        }else{
    //            lblNOTEaccount.isHidden = false
    //            lblYourFreeAcc.isHidden = false
    //            callGetPromoCodeWebservice()
    //        }
    //        popupAnimation_Action(vwAccountLeadingSpace)
            
            let alert = UIAlertController(title: "Account", message: "Coming Soon", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnLaunguage_Action(_ sender: UIButton) {
        popupAnimation_Action(vwLaunguageLeadingSpace)
    }
    
    //artist financials
    @IBAction func btnFinacials_Action(_ sender: UIButton) {
        openFinancialScreen()
    }
    
    func openFinancialScreen(){
//        if(self.userVerifyStr == "0"){ // ashi financial
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            CallGetCreditsWebService()
            if UserModel.sharedInstance().userType == "DJ" {
                txfDjConnectCash.text = "0"
                popupAnimation_Action(vwFinancialLeadingSpace)
            }else {
                txfConnectCash.text = "0"
                popupAnimation_Action(vwArtistFinancialLeadingSpace)
            }
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnTrnsationHistroy_Action(_ sender: UIButton) {
        openTransactionScreen()
    }
    
    func openTransactionScreen(){
        popupAnimation_Action(vwTransactionLeadingSpace)
//        if(self.userVerifyStr == "0"){ // ashi transaction
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            if UserModel.sharedInstance().userType == "DJ"{
                callGetDjTransHistoryWebservice(start: 0)
                
            }else{
                if(self.transList.count > 0){
                            self.transList.removeAll()
                            }
                callGetArTransHistoryWebservice(start: 0)
            }
           // popupAnimation_Action(vwTransactionLeadingSpace)
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnSecurity_Action(_ sender: UIButton) {
        openSecurityScreen()
    }
    func openSecurityScreen(){
//        if(self.userVerifyStr == "0"){ // ashi security
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            lblCurrentEmail1.text = UserModel.sharedInstance().email!
            lblCurrentEmail2.text = UserModel.sharedInstance().email!
            lblCurrentEmail3.text = UserModel.sharedInstance().email!
            if self.RegisterType == "Facebook" ||  self.RegisterType == "Google"{
                //cnsQuickPinTop.constant = 25
                lblCurrentEmail1.isHidden = true
                lblSecurity_email.isHidden = true
                lblSecurity_pwd.isHidden = true
                lblSecurity_pwdValue.isHidden = true
                btneditemail.isHidden = true
                btneditemail.isEnabled = false
                btnEditpassword.isHidden = true
                btnEditpassword.isEnabled = false
            }else{
                //cnsQuickPinTop.constant = 128
                lblCurrentEmail1.isHidden = false
                lblSecurity_email.isHidden = false
                lblSecurity_pwd.isHidden = false
                lblSecurity_pwdValue.isHidden = false
                btneditemail.isHidden = false
                btneditemail.isEnabled = true
                btnEditpassword.isHidden = false
                btnEditpassword.isEnabled = true
            }
            popupAnimation_Action(vwSecurityLeadingSpace)
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnSettings_Action(_ sender: UIButton) {
       // openSettingScreen()
        
        if UserModel.sharedInstance().userType == "DJ"{
            callGetRemainderSettingWebService()
        }else{
            callGetRemainderSettingWebService()
        }
    }

    func openSettingScreen(){

            if UserModel.sharedInstance().userType == "DJ"{
                popupAnimation_Action(vwSettingLeadingSpace)
                callGetRemainderSettingWebService()
            }else{
                popupAnimation_Action(vwSettingLeadingSpace)
                callGetRemainderSettingWebService()
            }
        
    }
    
    func openMyAccountScreen(){

            if UserModel.sharedInstance().userType == "DJ"{
                popupAnimation_Action(vwMyaccountALeadingSapace)
            }else{
                popupAnimation_Action(vwMyaccountALeadingSapace)
            }
        
    }
    
    @IBAction func btnHelp_Action(_ sender: UIButton) {
       // openHelpScreen()
    }
    
    func openHelpScreen(){
//        if(self.userVerifyStr == "0"){ // ashi help
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            popupAnimation_Action(vwHelpLeadingSpace)
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnFeedBack_Action(_ sender: UIButton) {
        openFeedbackScreen()
    }
    
    func openFeedbackScreen(){
//        if(self.userVerifyStr == "0"){ // ashi feedback
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            popupAnimation_Action(vwFeedbackLeadingSpace)
            callFeedbackMailWebService()
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnBlocked_Action(_ sender: UIButton) {
        
        //ashitesh
//        popupAnimation_Action(vwBlockedLeadingSpace)
//        callBlockListWebService()
        openBlockScreen()
    }
    
    func openBlockScreen(){
        
//        if(self.userVerifyStr == "0"){ // ashi blocked
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            let alert = UIAlertController(title: "Blocked", message: "Coming Soon", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnAccountClose_Action(_ sender: UIButton) {
       // closeBtnAnimation_Action(vwAccountLeadingSpace)
        sideMenuController?.showLeftView()
    }
    
    @IBAction func btnLaunguageClose_Action(_ sender: UIButton) {
        //closeBtnAnimation_Action(vwLaunguageLeadingSpace)
        sideMenuController?.showLeftView()
    }
    
    @IBAction func btnFinacials_Actions(_ sender: UIButton) {

//            txfDjConnectCash.text?.removeAll()
//            connectCashAmountStr.removeAll()
//            self.numberArrayCleaned.removeAll()
//            self.numberArray.removeAll()
//            vwDjpaymentDetail.isHidden = true
//            vwDjMainCashOut.isHidden = true
//            vwDjNumberPad.isHidden = false
//            CallGetCurrentCreditsWebService()
//            closeBtnAnimation_Action(vwFinancialLeadingSpace)
        
        sideMenuController?.showLeftView()


    }
    
    @IBAction func btnTransaction_Action(_ sender: UIButton) {
////        if(self.userVerifyStr == "0"){
////            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
////                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
////                    self.present(alert, animated: true)
////        }
////        else if(self.userVerifyStr == "1"){
//            closeBtnAnimation_Action(vwTransactionLeadingSpace)
////        }
////        else{
////            callLogoutWebservice()
////        }
        
        closeBtnAnimation_Action(vwTransactionLeadingSpace)
        //sideMenuController?.showLeftView()
        
    }
    
    @IBAction func btnSecurityClose_Action(_ sender: UIButton) {
////        if globalObjects.shared.isForgotPassword == "0" || globalObjects.shared.isForgotPassword == nil{
//            closeBtnAnimation_Action(vwSecurityLeadingSpace)
////        }
        
        closeBtnAnimation_Action(vwSecurityLeadingSpace)
        //sideMenuController?.showLeftView()
    }
    
    
    @IBAction func btnSettingsClose_Action(_ sender: UIButton) {
//        lblSun.textColor = .themeBlack
//        imgSun.image = UIImage(named: "uncheck")
//        lblMon.textColor = .themeBlack
//        imgMon.image = UIImage(named: "uncheck")
//        lblTue.textColor = .themeBlack
//        imgTue.image = UIImage(named: "uncheck")
//        lblWed.textColor = .themeBlack
//        imgWed.image = UIImage(named: "uncheck")
//        lblThu.textColor = .themeBlack
//        imgThu.image = UIImage(named: "uncheck")
//        lblFri.textColor = .themeBlack
//        imgFri.image = UIImage(named: "uncheck")
//        lblSat.textColor = .themeBlack
//        imgSat.image = UIImage(named: "uncheck")
//        txfSetTime.text = "10:00 am"
//        picker1.removeFromSuperview()
//        txfSetTime.resignFirstResponder()
//        if btnSave.isHidden == false{
//            btnSave.isHidden = true
//        }
//        closeBtnAnimation_Action(vwSettingLeadingSpace)
        
        sideMenuController?.showLeftView()
    }
    @IBAction func btnBlockedClose_Action(_ sender: UIButton) {
        //closeBtnAnimation_Action(vwBlockedLeadingSpace)
        
        sideMenuController?.showLeftView()
    }
    @IBAction func btnHelpClose_Action(_ sender: UIButton) {
        //closeBtnAnimation_Action(vwHelpLeadingSpace)
        
        sideMenuController?.showLeftView()
    }
    
    @IBAction func btnFeedbackClose_Action(_ sender: UIButton) {
        closeBtnAnimation_Action(vwFeedbackLeadingSpace)
        
        //sideMenuController?.showLeftView()
    }
    @IBAction func btnArtistTransactionCloseAction(_ sender: UIButton) {
//        txfConnectCash.text?.removeAll()
//        connectCashAmountStr.removeAll()
//        self.numberArrayCleaned.removeAll()
//        self.numberArray.removeAll()
//        vwPaymentDetail.isHidden = true
//        vwArMainCashout.isHidden = true
//        vwNumberPad.isHidden = false
//        closeBtnAnimation_Action(vwArtistFinancialLeadingSpace)
        sideMenuController?.showLeftView()
    }
    @IBAction func btnSocial_Action(_ sender: UIButton) {
        openSocialScreen()
    }
    
    func openSocialScreen(){
       // if(self.userVerifyStr == "0"){ // ashi social
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
        //else if(self.userVerifyStr == "1"){
            popupAnimation_Action(vwSocialLeadingSpace)
            callSocialLinksWebService()
//        }
//        else{
//            callLogoutWebservice()
//        }
    }
    
    @IBAction func btnSoicalClose_Action(_ sender: UIButton) {
       // closeBtnAnimation_Action(vwSocialLeadingSpace)
        sideMenuController?.showLeftView()
    }
    
    @IBAction func btnIconInfoClose_Action(_ sender: UIButton) {
        //closeBtnAnimation_Action(vwIconInfoLeadingSpace)
        sideMenuController?.showLeftView()
    }
    
    @IBAction func btnEditPwdAction(_ sender: UIButton) {
        edit_typeSelected = .password
        lblMainChangeEmailPwd.text = "Change Password"
        vwChangeCurrentMail.isHidden = true
        vwChangeCurrentPwd.isHidden = false
        vwEmailVerify.isHidden = true
        popupAnimation_Action(vwChangeEmailLeadingSpace)
    }
    
    @IBAction func btnEditMailAction(_ sender: UIButton) {
        edit_typeSelected = .email
        lblMainChangeEmailPwd.text = "Change Email"
        vwChangeCurrentMail.isHidden = false
        vwChangeCurrentPwd.isHidden = true
        vwEmailVerify.isHidden = true
        popupAnimation_Action(vwChangeEmailLeadingSpace)
    }
    
    @IBAction func btnEditPinAction(_ sender: UIButton) {
        edit_typeSelected = .pin
        let homeSB = UIStoryboard(name: "Main", bundle: nil)
        let desiredViewController = homeSB.instantiateViewController(withIdentifier: "ChangePinVC") as! ChangePinVC
        self.present(desiredViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnOnNotifyAction(_ sender: UIButton) {
        
    }
    @IBAction func btnOffNotifyAction(_ sender: UIButton) {
        
    }
    @IBAction func supportBtnTapped(_ sender: Any) {
        openFeedbackScreen()
    }
    
    @IBAction func btnFaqAction(_ sender: UIButton) {
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            helpType = "faq"
            subTitleHelp = "FAQ"
            lblHelpSubTitle.text = "FAQ".localize
            popupAnimation_Action(vwSubHelpLeadingSpace)
            callHelpSubMenuWebService()
//        }
//        else{
//            callLogoutWebservice()
//        }
       
    }
    
    @IBAction func btnTermsServiceAction(_ sender: UIButton) {
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            helpType = "terms"
            subTitleHelp = "TERMS OF SERVICE"
            lblHelpSubTitle.text = "Terms of Service".localize
            popupAnimation_Action(vwSubHelpLeadingSpace)
            callHelpSubMenuWebService()
//        }
//        else{
//            callLogoutWebservice()
//        }
        
    }
    
    @IBAction func btnPolicyAction(_ sender: UIButton) {
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            helpType = "privacy"
            subTitleHelp = "Privacy Policy"
            lblHelpSubTitle.text = "Privacy Policy"
            popupAnimation_Action(vwSubHelpLeadingSpace)
            callHelpSubMenuWebService()
//        }
//        else{
//            callLogoutWebservice()
//        }
       
    }
    
    
    @IBAction func btnSubHelpCloseAction(_ sender: UIButton) {
        closeBtnAnimation_Action(vwSubHelpLeadingSpace)
    }
    
    @IBAction func btnEmailFeedbackAction(_ sender: UIButton) {
//        if(self.userVerifyStr == "0"){
//            let alert = UIAlertController(title: "Alert", message: "Thanks for signing up. You will be notified when your account is fully active.", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: true)
//        }
//        else if(self.userVerifyStr == "1"){
            UIApplication.shared.open(URL(string: "mailto:\(feedbackEmail)")! as URL, options: [:], completionHandler: nil)
//        }
//        else{
//            callLogoutWebservice()
//        }
        
    }
    
    @IBAction func btnInstaAction(_ sender: UIButton) {
    }
    
    @IBAction func btnTwitterAction(_ sender: UIButton) {
    }
    
    @IBAction func btnFacebookAction(_ sender: UIButton) {
    }
    
    
    @IBAction func btnDaysSelectionAction(_ sender: UIButton) {
        switch sender.tag{
        case 0:
//            if imgSun.image == #imageLiteral(resourceName: "boxwithmark"){
//                lblSun.textColor = .themeBlack
//                imgSun.image = UIImage(named: "p-hover")
//                for i in 0...x.count{
//                    if x[i] == "0"{
//                        x.remove(at: i)
//                        break
//                    }
//                }}else{
//                    lblSun.textColor = .lightGray
//                    imgSun.image = UIImage(named: "p")
//                    x.append("0")
//                }
            
            if sunFlag == "0"{
                sunFlag = "1"
                lblSun.textColor = .lightGray
                imgSun.image = UIImage(named: "p")
                x.append("0")

                
            }
            else{
                sunFlag = "0"
                lblSun.textColor = .white
                imgSun.image = UIImage(named: "p-hover")
                for i in 0...x.count{
                    if x[i] == "0"{
                        x.remove(at: i)
                        break
                    }
                }
                }
        case 1:
//            if imgMon.image == #imageLiteral(resourceName: "boxwithmark"){
            if monFlag == "0"{
                monFlag = "1"
//                lblMon.textColor = .themeBlack
                lblMon.textColor = .lightGray
                imgMon.image = UIImage(named: "p")
                x.append("1")
//                for i in 0...x.count{
//                    if x[i] == "1"{
//                        x.remove(at: i)
//                        break
//                    }
//                }
                
            }
            else{
                    monFlag = "0"
                    lblMon.textColor = .white
                    imgMon.image = UIImage(named: "p-hover")
                    //x.append("1")
                for i in 0...x.count{
                    if x[i] == "1"{
                        x.remove(at: i)
                        break
                    }
                }
                }
        case 2:
//            if imgTue.image == #imageLiteral(resourceName: "boxwithmark"){
//                lblTue.textColor = .themeBlack
//                imgTue.image = UIImage(named: "p-hover")
//                for i in 0...x.count{
//                    if x[i] == "2"{
//                        x.remove(at: i)
//                        break
//                    }
//                }
//            }else{
//                lblTue.textColor = .lightGray
//                imgTue.image = UIImage(named: "p")
//                x.append("2")
//            }
            
            if tueFlag == "0"{
                tueFlag = "1"
                lblTue.textColor = .lightGray
                imgTue.image = UIImage(named: "p")
                x.append("2")

                
            }
            else{
                tueFlag = "0"
                lblTue.textColor = .white
                imgTue.image = UIImage(named: "p-hover")
                for i in 0...x.count{
                    if x[i] == "2"{
                        x.remove(at: i)
                        break
                    }
                }
                }
        case 3:
//            if imgWed.image == #imageLiteral(resourceName: "boxwithmark"){
//                lblWed.textColor = .themeBlack
//                imgWed.image = UIImage(named: "p-hover")
//                for i in 0...x.count{
//                    if x[i] == "3"{
//                        x.remove(at: i)
//                        break
//                    }
//                }
//            }else{
//                lblWed.textColor = .lightGray
//                imgWed.image = UIImage(named: "p")
//                x.append("3")
//            }
            if wedFlag == "0"{
                wedFlag = "1"
                lblWed.textColor = .lightGray
                imgWed.image = UIImage(named: "p")
                x.append("3")

                
            }
            else{
                    monFlag = "0"
                lblWed.textColor = .white
                imgWed.image = UIImage(named: "p-hover")
                for i in 0...x.count{
                    if x[i] == "3"{
                        x.remove(at: i)
                        break
                    }
                }
                }
        case 4:
//            if imgThu.image == #imageLiteral(resourceName: "boxwithmark"){
//                lblThu.textColor = .themeBlack
//                imgThu.image = UIImage(named: "p-hover")
//                for i in 0...x.count{
//                    if x[i] == "4"{
//                        x.remove(at: i)
//                        break
//                    }
//                }
//            }else{
//                lblThu.textColor = .lightGray
//                imgThu.image = UIImage(named: "p")
//                x.append("4")
//            }
            if thurFlag == "0"{
                thurFlag = "1"
                lblThu.textColor = .lightGray
                imgThu.image = UIImage(named: "p")
                x.append("4")

                
            }
            else{
                thurFlag = "0"
                lblThu.textColor = .white
                imgThu.image = UIImage(named: "p-hover")
                for i in 0...x.count{
                    if x[i] == "4"{
                        x.remove(at: i)
                        break
                    }
                }
                }
        case 5:
//            if imgFri.image == #imageLiteral(resourceName: "boxwithmark"){
//                lblFri.textColor = .themeBlack
//                imgFri.image = UIImage(named: "p-hover")
//                for i in 0...x.count{
//                    if x[i] == "5"{
//                        x.remove(at: i)
//                        break
//                    }
//                }
//            }else{
//                lblFri.textColor = .lightGray
//                imgFri.image = UIImage(named: "p")
//                x.append("5")
//            }
            if friFlag == "0"{
                friFlag = "1"
                lblFri.textColor = .lightGray
                imgFri.image = UIImage(named: "p")
                x.append("5")

                
            }
            else{
                friFlag = "0"
                lblFri.textColor = .white
                imgFri.image = UIImage(named: "p-hover")
                for i in 0...x.count{
                    if x[i] == "5"{
                        x.remove(at: i)
                        break
                    }
                }
                }
        case 6:
//            if imgSat.image == #imageLiteral(resourceName: "boxwithmark"){
//                lblSat.textColor = .themeBlack
//                imgSat.image = UIImage(named: "p-hover")
//                for i in 0...x.count{
//                    if x[i] == "6"{
//                        x.remove(at: i)
//                        break
//                    }
//                }
//            }else{
//                lblSat.textColor = .lightGray
//                imgSat.image = UIImage(named: "p")
//                x.append("6")
//            }
            if satFlag == "0"{
                satFlag = "1"
                lblSat.textColor = .lightGray
                imgSat.image = UIImage(named: "p")
                x.append("6")

                
            }
            else{
                satFlag = "0"
                lblSat.textColor = .white
                imgSat.image = UIImage(named: "p-hover")
                for i in 0...x.count{
                    if x[i] == "6"{
                        x.remove(at: i)
                        break
                    }
                }
                }
        default:
            lblSun.textColor = .themeBlack
            imgSun.image = UIImage(named: "p")
        }
        if x.count == 0{
            btnSave.isHidden = true
        }else{
            btnSave.isHidden = false
        }
    }
    
    @IBAction func btnSetTimeAction(_ sender: buttonProperties) {
        
    }
    
    
    @IBAction func btnOnAction(_ sender: UIButton) {
//        flag = "1"
//        self.btnonSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        self.btnonSetting.setTitleColor(.themeBlack, for: .normal)
//        self.btnoffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
//        self.btnoffSetting.setTitleColor(.lightGray, for: .normal)
    }
    @IBAction func userInactiveBtnTapped(_ sender: Any) {
        
        callaccountDeactive()
    }
    
    @IBAction func btnOffAction(_ sender: UIButton) {
        if(arFlag == "0"){
            arFlag = "1"
            btnoffSetting.setImage(UIImage (named: "displayOn"), for: .normal)
            callOnNotifyWebService()
        }
        else{
            arFlag = "0"
            btnoffSetting.setImage(UIImage (named: "displayOff"), for: .normal)
            callOffNotifyWebService()
        }
        
//        flag = "0"
//        self.btnoffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        self.btnoffSetting.setTitleColor(.themeBlack, for: .normal)
//        self.btnonSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
//        self.btnonSetting.setTitleColor(.lightGray, for: .normal)
        
    }
    
    @IBAction func btnArtistOnAction(_ sender: UIButton) {
        arFlag = "1"
        self.btnArtistOnSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.btnArtistOnSetting.setTitleColor(.themeBlack, for: .normal)
        self.btnArtistOffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.btnArtistOffSetting.setTitleColor(.lightGray, for: .normal)
        callOnNotifyWebService()
    }
    
    @IBAction func btnArtistOffAction(_ sender: UIButton) {
        arFlag = "0"
        self.btnArtistOffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.btnArtistOffSetting.setTitleColor(.themeBlack, for: .normal)
        self.btnArtistOnSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.btnArtistOnSetting.setTitleColor(.lightGray, for: .normal)
        callOffNotifyWebService()
    }
    
    @IBAction func btnArtistCloseAction(_ sender: UIButton) {
        closeBtnAnimation_Action(vwArtistSettingLeadingSpace)
    }
    
    @IBAction func btnSaveAction(_ sender: buttonProperties) {
        if x.count != 0{
            callSettingRemainderWebService()
            btnSave.isHidden = true
        }else{
            self.view.makeToast("Please select Day(s) of the week")
        }
    }
    
    @IBAction func btnNumberPadAction(_ sender: buttonProperties) {
        switch sender.tag {
        case 1:
            numberArray.append("1")
        case 2:
            numberArray.append("2")
        case 3:
            numberArray.append("3")
        case 4:
            numberArray.append("4")
        case 5:
            numberArray.append("5")
        case 6:
            numberArray.append("6")
        case 7:
            numberArray.append("7")
        case 8:
            numberArray.append("8")
        case 9:
            numberArray.append("9")
        case 0:
            numberArray.append("0")
        case 11:
            numberArray.removeAll()
        default:
            numberArray.append("0")
        }
        numberArrayCleaned = numberArray.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: " ").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
        if UserModel.sharedInstance().userType == "DJ"{
                        
            
            txfDjConnectCash.text = "\(numberArrayCleaned)"
            
            connectCashAmountStr = "\(numberArrayCleaned)"
            
            print("connectDjCashAmountStr1",connectCashAmountStr)
            
            // add comma before 3 digit like 1,000
            var djcash = txfDjConnectCash.text
            print("djcash",djcash)
            if(djcash != ""){
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
            formatter.string(from: Int(djcash!)! as NSNumber)
            let string = formatter.string(from: Int(djcash!)! as NSNumber)
            txfDjConnectCash.text = string!
        }
            
//            txfDjConnectCash.text = "\(numberArrayCleaned)"
            //txfDjConnectCash.text = "\(nu
        }else{
            txfConnectCash.text = "\(numberArrayCleaned)"
            connectCashAmountStr = "\(numberArrayCleaned)"
            print("connectartistCashAmountStr1",connectCashAmountStr)
            // add comma before 3 digit like 1,000
            var arcash = txfConnectCash.text
            print("djcash",arcash)
            if(arcash != ""){
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
            formatter.string(from: Int(arcash!)! as NSNumber)
            let string = formatter.string(from: Int(arcash!)! as NSNumber)
            txfConnectCash.text = string!
            }
        }
    }
    
    @IBAction func btnAddCreditNextAction(_ sender: UIButton) {
       // if Int(txfConnectCash.text!)! > 50 { // ashitesh - remove by tester
            if txfConnectCash.text?.isEmpty == false{
                if selectedConnectType == .cash_out{
//                    if Int( UserModel.sharedInstance().userCurrentBalance!) >= Int(txfConnectCash.text!)!{
                    print("connectCashAmountStr:",connectCashAmountStr)
                    if Float( UserModel.sharedInstance().userCurrentBalance!) >= Float(connectCashAmountStr)!{
                        vwPaymentDetail.isHidden = true
                        vwNumberPad.isHidden = true
                        vwArMainCashout.isHidden = false
                    }else{
                        self.view.makeToast("You cannot withdraw more than your current available balance.")
                    }
                }else{
                    vwPaymentDetail.isHidden = false
                    vwNumberPad.isHidden = true
                    vwArMainCashout.isHidden = true
                    lblPage1.backgroundColor = .lightGray
                    lblPage2.backgroundColor = .themeBlack
                }
            }
//        }else{
//            self.view.makeToast("Not Enough Credit, Please enter minimum 50 credit")
//        }
    }
    
    @IBAction func btnArCashOutFlow_Action(_ sender: UIButton) {
        selectedConnectType = .cash_out
        btnArCashOut.setTitleColor(.themeBlack, for: .normal)
        btnArConnectCash.setTitleColor(.lightGray, for: .normal)
        txfConnectCash.text?.removeAll()
        txfConnectCash.text = "0"
        connectCashAmountStr.removeAll()
        numberArrayCleaned.removeAll()
        numberArray.removeAll()
        vwPaymentDetail.isHidden = true
        vwArMainCashout.isHidden = true
        vwNumberPad.isHidden = false
        lblArcashoutActiveline.isHidden = false
        lblArConnectcashActiveline.isHidden = true
        lblArCashAddGet.text = "Cash Out Amount".localize
        lblPage1.backgroundColor = .themeBlack
        lblPage2.backgroundColor = .lightGray
    }
    
    @IBAction func btnArConnectCash_Action(_ sender: UIButton) {
        selectedConnectType = .connect_case
        btnArCashOut.setTitleColor(.lightGray, for: .normal)
        btnArConnectCash.setTitleColor(.themeBlack, for: .normal)
        txfConnectCash.text?.removeAll()
        txfConnectCash.text = "0"
        connectCashAmountStr.removeAll()
        numberArrayCleaned.removeAll()
        numberArray.removeAll()
        vwPaymentDetail.isHidden = true
        vwArMainCashout.isHidden = true
        vwNumberPad.isHidden = false
        lblArcashoutActiveline.isHidden = true
        lblArConnectcashActiveline.isHidden = false
        lblArCashAddGet.text = "Add Connect Cash".localize
    }
    
    @IBAction func btnDjAddCreditNextAction(_ sender: UIButton) {
       // if Int(txfDjConnectCash.text!)! > 50 { // ashitesh - remove by tester
            if txfDjConnectCash.text?.isEmpty == false{
                if selectedConnectType == .cash_out{
//                    if Int(UserModel.sharedInstance().userCurrentBalance!) >= Int(txfDjConnectCash.text!)!{
                    if Float(UserModel.sharedInstance().userCurrentBalance!) >= Float(connectCashAmountStr)!{
                        vwDjpaymentDetail.isHidden = true
                        vwDjNumberPad.isHidden = true
                        vwDjMainCashOut.isHidden = false
                    }else{
                        self.view.makeToast("You cannot withdraw more than your current available balance.")
                    }
                }else{
                    vwDjpaymentDetail.isHidden = false
                    vwDjNumberPad.isHidden = true
                    vwDjMainCashOut.isHidden = true
                    lblDjpage1.backgroundColor = .lightGray
                    lblDjpage2.backgroundColor = .themeBlack
                }
            }
//        }else{
//            self.view.makeToast("Not Enough Credit, Please enter minimum 50 credit")
//        }
    }
    
    @IBAction func btnDjConnectCash_Action(_ sender: UIButton) {
        selectedConnectType = .connect_case
        btnDjConnectCash.setTitleColor(.themeBlack, for: .normal)
        btnDjCashOut.setTitleColor(.lightGray, for: .normal)
        txfDjConnectCash.text?.removeAll()
        txfDjConnectCash.text = "0"
        connectCashAmountStr.removeAll()
        
        numberArray.removeAll()
        numberArrayCleaned.removeAll()
        vwDjpaymentDetail.isHidden = true
        vwDjMainCashOut.isHidden = true
        vwDjNumberPad.isHidden = false
        lblDjCashOutActiveline.isHidden = true
        lblDjConnectcashActiveline.isHidden = false
        lblDjCashAddGet.text = "Add Connect Cash".localize
    }
    
    @IBAction func btnDjCashOut_Action(_ sender: UIButton) {
        selectedConnectType = .cash_out
        btnDjCashOut.setTitleColor(.themeBlack, for: .normal)
        btnDjConnectCash.setTitleColor(.lightGray, for: .normal)
        txfDjConnectCash.text?.removeAll()
        txfDjConnectCash.text = "0"
        connectCashAmountStr.removeAll()
        numberArray.removeAll()
        numberArrayCleaned.removeAll()
        vwDjpaymentDetail.isHidden = true
        vwDjMainCashOut.isHidden = true
        vwDjNumberPad.isHidden = false
        lblDjCashOutActiveline.isHidden = false
        lblDjConnectcashActiveline.isHidden = true
        lblDjCashAddGet.text = "Cash Out Amount".localize
        lblDjpage1.backgroundColor = .themeBlack
        lblDjpage2.backgroundColor = .lightGray
    }
    
    @IBAction func btnDjProcessPaymentAction(_ sender: UIButton) {
        txfDjNameOnCredit.resignFirstResponder()
        txfDjCardNo.resignFirstResponder()
        txfDjExpiryDate.resignFirstResponder()
        txfDjCvv.resignFirstResponder()
        //getDjStripeToken()
    }
    
    @IBAction func btnArProcessPaymentAction(_ sender: UIButton) {
        txfArNameOnCredit.resignFirstResponder()
        txfArCardNo.resignFirstResponder()
        txfArExpiryDate.resignFirstResponder()
        txfArCvv.resignFirstResponder()
        //getArStripeToken()
    }
    
    @IBAction func btnArCashoutAddAcc_Action(_ sender: UIButton) {
        vwBankDetails.isHidden = false
        popupAnimation_Action(cnsBankDetailsLeadingSpace)
    }
    
    @IBAction func btnDjCashoutAddAcc_Action(_ sender: UIButton) {
        vwBankDetails.isHidden = false
        popupAnimation_Action(cnsBankDetailsLeadingSpace)
    }
    
    @IBAction func btnDjSelectAcc_Action(_ sender: UIButton) {
        callGetAccountListWebservice()
    }
    
    @IBAction func btnArSelectAcc_Action(_ sender: UIButton) {
        callGetAccountListWebservice()
    }
    
    @IBAction func btnCloseBankDetail_Action(_ sender: UIButton) {
        txfPaypal.text?.removeAll()
        txfApplePay.text?.removeAll()
        txfPaypal.isHidden = true
        txfApplePay.isHidden = true
        txfPaypal.resignFirstResponder()
        txfApplePay.resignFirstResponder()
        closeBtnAnimation_Action(cnsBankDetailsLeadingSpace)
    }
    
    @IBAction func SliderDjPayment_Action(_ sender: UISlider) {
        if SliderDjPayment.value == 1{
            let x =  UserModel.sharedInstance().userCurrentBalance!
//            let y = Int(txfDjConnectCash.text ?? "0")
            let y = Float(connectCashAmountStr)
            if x > y!  {
                //   callDjWithdrawReqWebservice(acc_id: djAccountId)
            }else{
                self.view.makeToast("You cannot withdraw amount more than current balance.")
            }
        }
    }
    
    @IBAction func SliderArPayment_Action(_ sender: UISlider) {
        if SliderArPayment.value == 1{
            let x =  UserModel.sharedInstance().userCurrentBalance!
//            let y = Int(txfConnectCash.text ?? "0")
            let y = Float(connectCashAmountStr )
            if x > y!  {
                //   callDjWithdrawReqWebservice(acc_id: arAccountId)
            }else{
                self.view.makeToast("You cannot withdraw amount more than current balance.")
            }
        }
    }
    
    @IBAction func btnAddPromoCode_Action(_ sender: UIButton) {
        if txtPromoCode.text?.isEmpty == false{
            callSetPromoCodeWebservice()
        }else{
            self.view.makeToast("Please Enter Promo Code")
        }
    }
    
    @IBAction func btnPaypalAction(_ sender: UIButton) {
        paymentMethodType = .paypal
        txfPaypal.isHidden = false
        txfApplePay.isHidden = true
    }
    
    @IBAction func btnApplePayAction(_ sender: UIButton) {
        paymentMethodType = .applepay
        txfPaypal.isHidden = true
        txfApplePay.isHidden = false
    }
    
    @IBAction func btnSendWithdrawReqAction(_ sender: UIButton) {
        if paymentMethodType == .paypal{
            if txfPaypal.text?.isEmpty == true{
                self.view.makeToast("Please Enter Email Address")
            }else{
                callDjWithdrawReqWebservice()
            }
        }else{
            if txfApplePay.text?.isEmpty == true{
                self.view.makeToast("Please Enter Mobile Number")
            }else{
                callDjWithdrawReqWebservice()
            }
        }
    }
    
    @IBAction func btnUpdateMailAction(_ sender: UIButton) {
        if txtemail.text?.isEmpty == true{
            self.view.makeToast("Please enter New mail")
        }else if txtReenterNewMail.text?.isEmpty == true{
            self.view.makeToast("Please re-enter New mail")
        }else if txfCurrPwd.text?.isEmpty == true{
            self.view.makeToast("Please enter current password")
        }else{
            let enteredEmail = txtemail.text
            let validateEmailBool = validateEmail(email: enteredEmail!)
            let compareEmailBool = validateConfirmEmail(_email: txtemail.text!, _cEmail: txtReenterNewMail.text!)
            if enteredEmail?.isEmpty == true {
                self.view.makeToast("Please enter your email.".localize)
            }else if validateEmailBool == false {
                self.view.makeToast("Invalid Email Format".localize)
            }else if compareEmailBool == false {
                self.view.makeToast("Email and Re-enter email doesnot match".localize)
            }else{
                self.newMail = txtemail.text!
                callUpdateUsernamePwdWebService() // ashitesh
                
//                self.vwEmailVerify.isHidden = false
//                self.vwEmailVerify.backgroundColor = .red
            }
        }
    }
    
    @IBAction func btnVerifyEmailAction(_ sender: UIButton) {
        if txfVerifyMail.text?.isEmpty == true{
            self.view.makeToast("Please Enter verification code".localize)
        }else{
           // callVerifyMailWebService(code: txfVerifyMail.text!, email: self.newMail) // ashitesh
            
            callEmailUpdateService()
            
        }
    }
    
    @IBAction func btnUpdatePasswordAction(_ sender: UIButton) {
        if txtFieldCurrentPassword.text?.isEmpty == true{
            self.view.makeToast("Please Enter current password".localize)
        }else if txtFieldNewPassword.text?.isEmpty == true{
            self.view.makeToast("Please Enter new password".localize)
        }else if txtFieldConfirmPassword.text?.isEmpty == true{
            self.view.makeToast("Please Enter confirm password".localize)
        }else{
            let enteredPwd = txtFieldNewPassword.text
            let validPwdBool = validatePassword(password: enteredPwd!)
            
            let enteredConfirmPwd = txtFieldConfirmPassword.text
            let validConfirmPwdBool = validateConfirmPassword(_Pwd: enteredPwd!, _cPwd: enteredConfirmPwd!)
            if enteredPwd?.isEmpty == true || validPwdBool == false {
                self.view.makeToast("Enter password of length 6-18 characters.".localize)
            }else if enteredConfirmPwd?.isEmpty == true || validConfirmPwdBool == false{
                self.view.makeToast("Password and Confirm password doesnot match".localize)
            }else if txtFieldCurrentPassword.text?.isEmpty == true{
                self.view.makeToast("Please enter current password".localize)
            }else {
                callUpdateUsernamePwdWebService()
            }
        }
    }
    
    func validateCardExpiry(_ input: String) -> ExpiryValidation {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YY"
        guard let enteredDate = dateFormatter.date(from: input) else {
            return .invalidInput
        }
        let calendar = Calendar.current
        let components = Set([Calendar.Component.month, Calendar.Component.year])
        let currentDateComponents = calendar.dateComponents(components, from: Date())
        let enteredDateComponents = calendar.dateComponents(components, from: enteredDate)
        guard let eMonth = enteredDateComponents.month, let eYear = enteredDateComponents.year, let cMonth = currentDateComponents.month, let cYear = currentDateComponents.year, eMonth >= cMonth, eYear >= cYear else {
            return .expired
        }
        return .valid
    }
    
    @IBAction func btnChangeEmailCloseAction(_ sender: UIButton) {
        txtFieldNewPassword.text = ""
        txtFieldConfirmPassword.text = ""
        txtFieldCurrentPassword.text = ""
        txtemail.text = ""
        txtReenterNewMail.text = ""
        txfCurrPwd.text = ""
        txtFieldNewPassword.resignFirstResponder()
        txtFieldConfirmPassword.resignFirstResponder()
        txtFieldCurrentPassword.resignFirstResponder()
        txtemail.resignFirstResponder()
        closeBtnAnimation_Action(vwChangeEmailLeadingSpace)
    }
    
    func deleteUserAlert(){
        let refreshAlert = UIAlertController(title: "Logout", message: "Are you sure want to delete your account?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.callGetProjectDetailWebService()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - WEBSERVICES
    func callGetProjectDetailWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
           
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.userAccountDeleteAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<UserDeleteModel>) in
                
                switch response.result {
                case .success(_):
                    //Loader.shared.hide()
                    let userDeleteD = response.result.value!
                    if userDeleteD.success == 1{
                        self.view.makeToast(userDeleteD.message)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.logout()
                        })
                    }else{
                        Loader.shared.hide()
                        if(userDeleteD.message == "You are not authorised. Please login again."){
                            self.view.makeToast(userDeleteD.message)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                            })
                        }
                        else{
                            self.view.makeToast(userDeleteD.message)
                        }
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    
    //MARK: - WEBSERVICES
    func callOnNotifyWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "status":"\(arFlag)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.setNotificationAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let notifyModel = response.result.value!
                    if notifyModel.success == 1{
                        self.view.makeToast(notifyModel.message!)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(notifyModel.message)
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
    
    func callOffNotifyWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "status":"\(arFlag)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.setNotificationAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let notifyModel = response.result.value!
                    if notifyModel.success == 1{
                        self.view.makeToast(notifyModel.message!)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(notifyModel.message)
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
    
    func callaccountDeactive(){
        if getReachabilityStatus(){
//            let parameters = [
//                "userid":"\(UserModel.sharedInstance().userId!)",
//                "token":"\(UserModel.sharedInstance().token!)",
//            ]
            Loader.shared.show()
//            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.accountDeactiveAPI)"), method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                Alamofire.request(getServiceURL("\(webservice.url)\(webservice.accountDeactiveAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let notifyModel = response.result.value!
                    if notifyModel.success == 1{
                        self.view.makeToast(notifyModel.message!)
                        self.userActiveBtn.setImage(UIImage(named: "displayOff"), for: .normal)
                        self.userActiveBtn.isUserInteractionEnabled = false
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(notifyModel.message)
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
    
    func callUpdateUsernamePwdWebService()
    {
        var pwd = String()
        var c_pwd = String()
        
        if edit_typeSelected == .email{
            pwd = txfCurrPwd.text!
            c_pwd = txfCurrPwd.text!
            
        }else if edit_typeSelected == .password{
            pwd = txtFieldNewPassword.text!
            c_pwd = txtFieldCurrentPassword.text!
            
        }else{
            pwd = ""
            c_pwd = ""
            
        }
        
        var email = txtemail.text!
        if email == ""{
            email = UserModel.sharedInstance().email!
        }
        
        if getReachabilityStatus(){
            let parameters = [
                "email":"\(email)",
                "password":"\(pwd)",
                "current_password":"\(c_pwd)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "current_pin":"",
                "new_pin":"",
                "edit_type":"\(edit_typeSelected)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.updateUserPassAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let updateModel = response.result.value!
                    if updateModel.success == 1{
                        globalObjects.shared.isForgotPassword = "0"
                        if self.edit_typeSelected == .email{
                            self.txtemail.text?.removeAll()
                            self.txfCurrPwd.text?.removeAll()
                            self.txtReenterNewMail.text?.removeAll()
                            self.txtemail.resignFirstResponder()
                            self.txfCurrPwd.resignFirstResponder()
                            self.txtReenterNewMail.resignFirstResponder()
                            self.vwChangeCurrentMail.isHidden = true
                            self.vwEmailVerify.isHidden = false
                            //self.vwEmailVerify.backgroundColor = .red
                            self.vwChangeCurrentPwd.isHidden = true
                           // self.closeBtnAnimation_Action(self.vwChangeEmailLeadingSpace)
                            UserModel.sharedInstance().email = email
                            //self.btnSecurity_Action(UIButton())
                            UserModel.sharedInstance().synchroniseData()
                        }
                        if self.edit_typeSelected == .password{
                            self.txtFieldCurrentPassword.text?.removeAll()
                            self.txtFieldNewPassword.text?.removeAll()
                            self.txtFieldConfirmPassword.text?.removeAll()
                            self.txtFieldCurrentPassword.resignFirstResponder()
                            self.txtFieldNewPassword.resignFirstResponder()
                            self.txtFieldConfirmPassword.resignFirstResponder()
                        }
                       // self.view.makeToast(updateModel.message)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(updateModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
//    verifyEmail api for add new email
//    request keys : userid , token , old_email , new_email , code , language
    
    func callEmailUpdateService(){
        
        var email = txtemail.text!
        if email == ""{
            email = UserModel.sharedInstance().email!
        }
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                
                "old_email":"\(lblCurrentEmail3.text!)",
                "new_email":"\(email)",
                "code":"\(txfVerifyMail.text!)",
                "language":"",
                
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.verifyEmailAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let verifyEmailModel = response.result.value!
                    if verifyEmailModel.success == 1{
                        self.view.makeToast(verifyEmailModel.message)
                        self.txfVerifyMail.resignFirstResponder()
                        self.txfVerifyMail.text?.removeAll()
                        self.closeBtnAnimation_Action(self.vwChangeEmailLeadingSpace)
//                        if UserModel.sharedInstance().userType == "DJ"{
////
//                            self.closeBtnAnimation_Action(self.vwChangeEmailLeadingSpace)
//
//                        }else{
////                            let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
////                            let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
////                            self.sideMenuController()?.setContentViewController(next1!)
//                            self.closeBtnAnimation_Action(self.vwChangeEmailLeadingSpace)
//
//                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(verifyEmailModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callGetProfileWebService(){
        if let profileUrl = UserModel.sharedInstance().userProfileUrl{
            let profileImageUrl = URL(string: "\(profileUrl)")
            self.userImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"), completionHandler: nil)
            self.btnViewProfile.kf.setImage(with: profileImageUrl, for: .normal, placeholder: UIImage(named: "user-profile"), completionHandler: nil)
        }
        
        if UserModel.sharedInstance().userType != nil{
            self.RegisterType = UserModel.sharedInstance().userType!
            self.userSelection()
        }
        
    }
    func callFeedBackWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "email":"",
                "message":"",
                "token":"\(UserModel.sharedInstance().token!)",
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.sendFeedbackAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let feedBackModel = response.result.value!
                    if feedBackModel.success == 1{
                        self.view.makeToast(feedBackModel.message)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(feedBackModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callGetNotifyWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getNotificationAPI)"), method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetNotifyModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let notifyModel = response.result.value!
                    if notifyModel.success == 1{
                        //  self.view.makeToast(notifyModel.message)
                       // self.flag = notifyModel.flag!
                        self.arFlag = notifyModel.flag!
//                        if notifyModel.flag == "1"{
                        if self.arFlag == "1"{
//                            self.btnArtistOnSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                            self.btnArtistOnSetting.setTitleColor(UIColor.themeBlack, for: .normal)
//                            self.btnArtistOffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
//                            self.btnArtistOffSetting.setTitleColor(UIColor.lightGray, for: .normal)
                            self.btnoffSetting.setImage(UIImage (named: "displayOn"), for: .normal)
                        }else{
//                            self.btnArtistOffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                            self.btnArtistOffSetting.setTitleColor(UIColor.themeBlack, for: .normal)
//                            self.btnArtistOnSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
//                            self.btnArtistOnSetting.setTitleColor(UIColor.lightGray, for: .normal)
                            self.btnoffSetting.setImage(UIImage (named: "displayOff"), for: .normal)
                        }
                       // self.updateNotiCount()
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
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func updateNotiCount(){
//        if(notificationCountLbl == nil){
//        notificationCountLbl = UILabel(frame: CGRect(x: 85, y: 159, width: 100, height: 20))
//        notificationCountLbl?.backgroundColor = .white
//        notificationCountLbl!.text = "\(UserModel.sharedInstance().notificationCount)"
//        notificationCountLbl?.textColor = .black
//        self.view.addSubview(notificationCountLbl!)
//        }
        let notiCount = UserModel.sharedInstance().notificationCount
        print("notiCount3",notiCount)
        if notiCount != nil {
            DispatchQueue.main.async {
                if notiCount! > 0 {
                    self.lblNotifyNumber.isHidden = false
                    self.lblNotifyNumber.text = "\(notiCount!)"
                }else{
                    self.lblNotifyNumber.isHidden = true
                }
            }
        }
    }
    
    
    func callBlockListWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)"
            ]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getblockedUserAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)"), method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BlockListModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let blockListModel = response.result.value!
                    if blockListModel.success == 1{
                        self.view.makeToast(blockListModel.message)
                        self.blockDetail = blockListModel.responseData!
                        self.cvBlockView.reloadData()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(blockListModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callUnBlockUserWebService(_ index: Int){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "block_by":"\(UserModel.sharedInstance().userId!)",
                "block_to":"\(unblockId)",
                "token":"\(UserModel.sharedInstance().token!)"
            ]
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.unblockUserAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let unBlockUserModel = response.result.value!
                    if unBlockUserModel.success == 1{
                        self.view.makeToast(unBlockUserModel.message)
                        self.blockDetail.remove(at: index)
                        self.cvBlockView.reloadData()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(unBlockUserModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callHelpSubMenuWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getHelpAPI)?userid=\(UserModel.sharedInstance().userId!)&helptype=\(helpType)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<HelpSubMenuModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let helpSubModel = response.result.value!
                    if helpSubModel.success == 1{
                        let data = helpSubModel.helpData!
//                        var dataToDisplay = [String]()
//                        for c in data{
//                            dataToDisplay.append(c.content!)
//                        }
                        let txt = data.content//.joined(separator: "<br/>")
                        //self.lblHelpDetails.attributedText = txt?.htmlToAttributedString
                        self.helpDetailTextView.attributedText = txt?.htmlToAttributedString
                        self.helpDetailTextView.textColor = .white
//                        self.view.makeToast(helpSubModel.message)
//                        self.lblHelpDetails.attributedText = helpSubModel.helpData?.content?.htmlToAttributedString
                        self.lblHelpSubTitle.text = self.subTitleHelp
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(helpSubModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callSocialLinksWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getSocialMediaAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SocialLinksModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let SocialLinkModel = response.result.value!
                    if SocialLinkModel.success == 1{
                        self.view.makeToast(SocialLinkModel.message)
                        self.socialData = SocialLinkModel.socialData!
                        self.tblSocialMediaLink.reloadData()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(SocialLinkModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callFeedbackMailWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getFeedbackEmailAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    if let jsonData = response.result.value as? [String: AnyObject]{
                        print(jsonData)
                       // self.feedbackEmail = (jsonData["result"]!["feedbackemail"] as? String)!
                        //self.btnEmailSendFeedback.setTitle(self.feedbackEmail, for: .normal)
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
            )}else{
                self.view.makeToast("Please check your Internet Connection")
            }
    }
    
    func callSettingRemainderWebService(){
        if getReachabilityStatus(){
            
            stringArrayCleaned = x.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
            
            let parameters = [
                "days":"\(stringArrayCleaned)",
                "onoff":"\(flag)",
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "type":"project_remainder",
                //"times":"\(txfSetTime.text!.localToUTC(incomingFormat: "hh:mm a", outGoingFormat: "hh:mm a"))"
                "times":"\(setRTimeTxtfld.text!.localToUTC(incomingFormat: "hh:mm a", outGoingFormat: "hh:mm a"))"
            ]
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.changeSettingAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let remainderModel = response.result.value!
                    if remainderModel.success == 1{
                        self.view.makeToast(remainderModel.message)
                        self.x.removeAll()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(remainderModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callGetRemainderSettingWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getSettingAPI)?usertype=\(UserModel.sharedInstance().userType!)&token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)&type=project_remainder"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetChangeRemainderModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let getRemainderModel = response.result.value!
                    if getRemainderModel.success == 1{
                        self.txfSetTime.text = (getRemainderModel.responseData?[0].c_time!)!.UTCToLocal(incomingFormat: "hh:mm a", outGoingFormat: "hh:mm a")
                        self.setRTimeTxtfld.text = (getRemainderModel.responseData?[0].c_time!)!.UTCToLocal(incomingFormat: "hh:mm a", outGoingFormat: "hh:mm a")
                        self.days = (getRemainderModel.responseData?[0].days!)!
                        print(self.days)
                        self.flag = (getRemainderModel.responseData?[0].onoff!)!
                        self.arFlag = (getRemainderModel.responseData?[0].onoff!)!
//                        if self.flag == "1"{
                        if self.arFlag == "1"{
//                            self.btnonSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                            self.btnonSetting.setTitleColor(UIColor.themeBlack, for: .normal)
//                            self.btnoffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
//                            self.btnoffSetting.setTitleColor(UIColor.lightGray, for: .normal)
                            self.btnoffSetting.setImage(UIImage (named: "displayOn"), for: .normal)
                        }else{
//                            self.btnoffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                            self.btnoffSetting.setTitleColor(UIColor.themeBlack, for: .normal)
//                            self.btnonSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
//                            self.btnonSetting.setTitleColor(UIColor.lightGray, for: .normal)
                            self.btnoffSetting.setImage(UIImage (named: "displayOff"), for: .normal)
                        }
                        if self.days.contains("0"){
                            self.x.append("0")
                            self.lblSun.textColor = .themeBlack
                            self.imgSun.image = UIImage(named: "ArtistFilter4")
                        }
                        if self.days.contains("1"){
                            self.x.append("1")
                            self.lblMon.textColor = .themeBlack
                            self.imgMon.image = UIImage(named: "ArtistFilter4")
                        }
                        if self.days.contains("2"){
                            self.x.append("2")
                            self.lblTue.textColor = .themeBlack
                            self.imgTue.image = UIImage(named: "ArtistFilter4")
                        }
                        if self.days.contains("3"){
                            self.x.append("3")
                            self.lblWed.textColor = .themeBlack
                            self.imgWed.image = UIImage(named: "ArtistFilter4")
                        }
                        if self.days.contains("4"){
                            self.x.append("4")
                            self.lblThu.textColor = .themeBlack
                            self.imgThu.image = UIImage(named: "ArtistFilter4")
                        }
                        if self.days.contains("5"){
                            self.x.append("5")
                            self.lblFri.textColor = .themeBlack
                            self.imgFri.image = UIImage(named: "ArtistFilter4")
                        }
                        if self.days.contains("6"){
                            self.x.append("6")
                            self.lblSat.textColor = .themeBlack
                            self.imgSat.image = UIImage(named: "ArtistFilter4")
                        }
                    }else{
                        Loader.shared.hide()
                        self.btnoffSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                        self.btnoffSetting.setTitleColor(UIColor.themeBlack, for: .normal)
                        self.btnonSetting.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
                        self.btnonSetting.setTitleColor(UIColor.lightGray, for: .normal)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callpurchaseCreditWebService(trans_id: String){
        if getReachabilityStatus(){
            var acc = String()
            if UserModel.sharedInstance().userType == "AR"{
                acc = txfArCardNo.text!
            }else{
                acc = txfDjCardNo.text!
            }
            var acc_no = String()
            acc_no = acc.description.replacingOccurrences(of: " ", with: "")
            print(acc_no)
            acc_no = CommonFunctions.encryptValue(value: "\(acc_no)")
            print("ENCRYPTED ACC_NO - \(acc_no)")
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "transction_id":"\(trans_id)",
                "amount":"\(numberArrayCleaned)",
                "account_no":"\(acc_no)"
            ]
            
            print(parameters)
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.purchaseCreditslAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let purchaseCreditModel = response.result.value!
                    if purchaseCreditModel.success == 1{
                        self.view.makeToast(purchaseCreditModel.message)
                        if UserModel.sharedInstance().userType! == "DJ"{
                            self.vwDjpaymentDetail.isHidden = true
                            self.vwDjNumberPad.isHidden = false
                            self.lblDjpage1.backgroundColor = .themeBlack
                            self.lblDjpage2.backgroundColor = .lightGray
                            self.btnDjCashOut.setTitleColor(.lightGray, for: .normal)
                            self.btnDjConnectCash.setTitleColor(.themeBlack, for: .normal)
                            self.txfDjConnectCash.text?.removeAll()
                            self.txfDjConnectCash.text = "0"
                            self.connectCashAmountStr.removeAll()
                        }else{
                            self.vwPaymentDetail.isHidden = true
                            self.vwNumberPad.isHidden = false
                            self.lblPage1.backgroundColor = .themeBlack
                            self.lblPage2.backgroundColor = .lightGray
                            self.btnArCashOut.setTitleColor(.lightGray, for: .normal)
                            self.btnArConnectCash.setTitleColor(.themeBlack, for: .normal)
                            self.txfConnectCash.text?.removeAll()
                            self.txfConnectCash.text = "0"
                            self.connectCashAmountStr.removeAll()
                            self.connectCashAmountStr = "0"
                        }
                        self.numberArrayCleaned.removeAll()
                        self.numberArray.removeAll()
                        self.CallGetCreditsWebService()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(purchaseCreditModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callDjWithdrawReqWebservice(){
        if getReachabilityStatus(){
            
            var payData = String()
            if paymentMethodType == .applepay{
                payData = txfApplePay.text!
            }else{
                payData = txfPaypal.text!
            }
            var amount = String()
            if UserModel.sharedInstance().userType == "DJ"{
//                amount = txfDjConnectCash.text!
                amount = connectCashAmountStr
            }else{
//                amount = txfConnectCash.text!
                amount = connectCashAmountStr
            }
            
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "payment_method":"\(paymentMethodType)",
                "paymentData":"\(payData)",
                "amount":"\(amount)"
            ]
            
            print(parameters)
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.djWithdrawReqlAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in

                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let djWithdrawModel = response.result.value!
                    if djWithdrawModel.success == 1{
                        self.view.makeToast(djWithdrawModel.message)
                        self.numberArray.removeAll()
                        self.numberArrayCleaned.removeAll()
                        self.closeBtnAnimation_Action(self.cnsBankDetailsLeadingSpace)
                        if UserModel.sharedInstance().userType == "DJ"{
                            self.txfDjConnectCash.text?.removeAll()
                            self.txfDjConnectCash.text = "0"
                            self.connectCashAmountStr.removeAll()
                            self.connectCashAmountStr.removeAll()
                            self.connectCashAmountStr = "0"
                            self.txfDjSelectAcNo.text?.removeAll()
                            self.vwDjMainCashOut.isHidden = true
                            self.vwDjNumberPad.isHidden = false
                            self.btnDjCashOut.setTitleColor(.lightGray, for: .normal)
                            self.btnDjConnectCash.setTitleColor(.themeBlack, for: .normal)
                        }else{
                            self.txfConnectCash.text?.removeAll()
                            self.txfConnectCash.text = "0"
                            self.SliderArPayment.isHidden = true
                            self.vwArMainCashout.isHidden = true
                            self.vwNumberPad.isHidden = false
                            self.btnArCashOut.setTitleColor(.lightGray, for: .normal)
                            self.btnArConnectCash.setTitleColor(.themeBlack, for: .normal)
                            self.btnArCashoutAddAcc.setTitle("+add/delete account", for: .normal)

                        }
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(djWithdrawModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
            else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    
    
    
    
    func callArpurchaseCreditAPI(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getArtistCreditsListAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ArTransactionListModel>) in
                
                switch response.result {
                case .success(_):
                    let arPurchaseModelProfile = response.result.value!
                    if arPurchaseModelProfile.success == 1{
                        Loader.shared.hide()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(arPurchaseModelProfile.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callDjRequestCreditAPI(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getDjRequestListAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<DjTransactionListModel>) in
                
                switch response.result {
                case .success(_):
                    let djRequestModelProfile = response.result.value!
                    if djRequestModelProfile.success == 1{
                        Loader.shared.hide()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(djRequestModelProfile.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callStripePaymentWebService(token: String, amt: String){
        // also delete dj card details
        txfArNameOnCredit.text?.removeAll()
        txfDjNameOnCredit.text?.removeAll()
        // txfArCardNo.text?.removeAll()
        txfArExpiryDate.text?.removeAll()
        txfDjExpiryDate.text?.removeAll()
        txfArCvv.text?.removeAll()
        txfDjCvv.text?.removeAll()
        print("\(UserModel.sharedInstance().currency_code!)")
        if getReachabilityStatus(){
            let parameters = [
                "user_id":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "stripeyoken":"\(token)",
                "email":"\(UserModel.sharedInstance().email ?? "")",
                "amount":"\(amt)",
                //"userid":"\(UserModel.sharedInstance().userId!)",
                "currency":"\(UserModel.sharedInstance().currency_code!)"
            ]
            print(parameters)
            Loader.shared.show()

            
            Alamofire.request(getServiceURL(webservice.stripePaymentAPI), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<StripeModel>) in

                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let stripeModel = response.result.value!
                    if stripeModel.success == 1{
                        self.view.makeToast(stripeModel.message)
                        self.callpurchaseCreditWebService(trans_id: stripeModel.transaction_id!)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(stripeModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
            else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callCurrencyListWebService(){
        
        if let currencySymbol = UserModel.sharedInstance().userCurrency{
            self.currentCurrency = currencySymbol
            if UserModel.sharedInstance().userType! == "DJ"{
                self.currentCurrency = currencySymbol
                self.lblDjCurrencySymbol.text = currencySymbol
            }else{
                self.currentCurrency = currencySymbol
                self.lblArCurrencySymbol.text = currencySymbol
            }
            
        }
    }
    
    func CallGetCurrentCreditsWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getCurrentCreditsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    if let jsonData = response.result.value as? [String: AnyObject]{
                        print(jsonData)
                        if jsonData["success"]! as! NSNumber == 1{
                            
                            if let x = (jsonData["total_current_credit"] as? String){
                                UserModel.sharedInstance().userCurrentBalance = Float(x)
                                UserModel.sharedInstance().synchroniseData()
                            }
                            
                        }else{
                            Loader.shared.hide()
                        }
                    }
                    
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
            )}else{
                self.view.makeToast("Please check your Internet Connection")
            }
    }
    
    func callGetAccountListWebservice(){
        if getReachabilityStatus(){
            
            self.accountList.removeAll()
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getAccountAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetAccountListModel>) in
                
                switch response.result {
                case .success(_):
                    let accountListModelProfile = response.result.value!
                    if accountListModelProfile.success == 1{
                        Loader.shared.hide()
                        self.accountList = accountListModelProfile.result!
                        var data = [String]()
                        for i in 0..<self.accountList.count{
                            data.append(self.accountList[i].account_no!)
                        }
                        if UserModel.sharedInstance().userType == "DJ"{
                            self.djSelectAcc.dataSource = data
                            self.setDjAccountListDropDown()
                        }else{
                            self.arSelectAcc.dataSource = data
                            self.setArAccountListDropDown()
                        }
                    }else{
                        if UserModel.sharedInstance().userType == "DJ"{
                            self.djSelectAcc.dataSource = ["no account added"]
                            self.setDjAccountListDropDown()
                        }else{
                            self.arSelectAcc.dataSource = ["no account added"]
                            self.setArAccountListDropDown()
                        }
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callAddAccountWebService(routing_no: String, account_no: String){
        
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "routing_number":"\(routing_no)",
                "account_no":"\(account_no)"
            ]
            
            Loader.shared.show()
            
            print(parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addAccountAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let addAcountModel = response.result.value!
                    if addAcountModel.success == 1{
                        self.view.makeToast(addAcountModel.message)
                        self.closeBtnAnimation_Action(self.cnsBankDetailsLeadingSpace)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(addAcountModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    func callGetArTransHistoryWebservice(start: Int){
        if getReachabilityStatus(){
            
            self.accountList.removeAll()
//            if(self.transList.count > 0){
//            self.transList.removeAll()
//            }
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.payment_historyARAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&start=\(start)&limit=10"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferTransHistModel>) in
                
                switch response.result {
                case .success(_):
                    let transDetailListModelProfile = response.result.value!
                    if transDetailListModelProfile.success == 1{
                        Loader.shared.hide()
                        self.transList.removeAll()
                        if let projList = transDetailListModelProfile.projects{
                            if projList.count > 0{
                                self.transList.append(contentsOf: projList)
                                self.tblTransaction.reloadData()
                            }
                        }
                    }else{
                        Loader.shared.hide()
                        if transDetailListModelProfile.success == 0{
                            if(transDetailListModelProfile.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                            self.view.makeToast("No Transaction History found yet")
                            }
                        }

                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callGetDjTransHistoryWebservice(start: Int){
        if getReachabilityStatus(){
            
            self.accountList.removeAll()
//            if(self.djTransList.count > 0){
//                self.djTransList.removeAll()
//            }
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.payment_historyDJAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&start=\(start)&limit=10"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyDjTransHistModel>) in
                
                switch response.result {
                case .success(_):
                    let djtransDetailProfile = response.result.value!
                    if djtransDetailProfile.success == 1{
                        Loader.shared.hide()
                        self.djTransList.removeAll()
                        if let projList = djtransDetailProfile.projects{
                            
                            if projList.count > 0{
                                self.djTransList.append(contentsOf: projList)
                                self.expandTransaction = [Bool](repeating: false, count: self.djTransList.count)
                                print("self.djTransList.count",self.djTransList.count)
                                self.expandDataArray = [Int](repeating: 3, count: self.djTransList.count)
                            }
                            self.tblTransaction.reloadData()
                        }
                        
                        print("self.expandDataArray",self.expandDataArray)
//                        print("self.expandDataArray",self.expandDataArray)
//                        print("self.expandDataArray",self.expandDataArray)
//                        print("self.expandDataArray",self.expandDataArray)
                        
                    }else{
                        Loader.shared.hide()
                        if djtransDetailProfile.success == 0{
                            if(djtransDetailProfile.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                            self.view.makeToast("No Transaction History found yet")
                            }
                    }
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callSetPromoCodeWebservice(){
        if getReachabilityStatus(){
            
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "promocode":"\(txtPromoCode.text!)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.apply_promocodeAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SetPromocodeModel>) in
                
                switch response.result {
                case .success(_):
                    let setPromoDetailProfile = response.result.value!
                    if setPromoDetailProfile.success == 1{
                        Loader.shared.hide()
                        self.view.makeToast(setPromoDetailProfile.message)
                        self.vwAddPromo.isHidden = true
                        self.vwAddedPromo.isHidden = false
                        
                        let startDate = Date()
                        let endDateString = "\(setPromoDetailProfile.result!.exp_date!)"
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd"
                        var days = Int()
                        
                        if let endDate = formatter.date(from: endDateString) {
                            let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
                            print("Number of days: \(components.day!)")
                            days = components.day!
                        } else {
                            print("\(endDateString) can't be converted to a Date")
                        }
                        
                        if setPromoDetailProfile.result!.is_connect_case == 1{
                            self.lblPromoDescrip1.text = "$100 Connect cash.............\(days) days"
                        }else{
                            self.lblPromoDescrip1.isHidden = true
                        }
                        if setPromoDetailProfile.result!.is_commition == 1{
                            self.lblPromoDescrip2.text = "Commission Fee Waved.............\(days) days"
                        }else{
                            self.lblPromoDescrip2.isHidden = true
                        }
                        if setPromoDetailProfile.result!.is_transaction == 1{
                            self.lblPromoDescrip3.text = "Transaction Fee Waved.............\(days) days"
                        }else{
                            self.lblPromoDescrip3.isHidden = true
                        }
                        if setPromoDetailProfile.result!.is_expired == 1{
                            self.vwAddPromo.isHidden = false
                            self.vwAddedPromo.isHidden = true
                        }else{
                            self.vwAddPromo.isHidden = true
                            self.vwAddedPromo.isHidden = false
                        }
                        self.lblFirstNoDj.text = "For \(setPromoDetailProfile.result!.coupon_qty!) DJs"
                        
                        self.lblPromoAck.attributedText = setPromoDetailProfile.result?.description?.htmlToAttributedString
                    }else{
                        self.view.makeToast(setPromoDetailProfile.message)
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    //MARK: - WEBSERVICES
    func callsubscriptionDetailsAPI(){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.subscriptionDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<InAppPurchaseDetailModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let inAppPurchaseModel = response.result.value!
                    if inAppPurchaseModel.success == 1{
                        Loader.shared.hide()
                        let serviceTypeInAppPurchase = inAppPurchaseModel.userSubscription?.artist_type ?? ""
                        print("artistType-inApp-purchase",serviceTypeInAppPurchase)
                        
                        let expirayDate = inAppPurchaseModel.userSubscription?.subscription_expiry_date ?? ""
                        var amountValue = inAppPurchaseModel.userSubscription?.amount ?? ""
                        
                       
                        print("amountValue",amountValue)
                        if(serviceTypeInAppPurchase == "free"){

                            self.subscriptionVw.isHidden = true
                            self.transactionTableVwTop.constant = 40

                        }
                        else{
                            
                            if amountValue.contains(".00") {
                                amountValue = amountValue.replacingOccurrences(of: ".00", with: "")
                            }
                            
                            self.subscriptionVw.isHidden = false
                            self.transactionTableVwTop.constant = 210
                        //if(serviceTypeInAppPurchase == "basic"){
                            self.goldPriceBTn.setTitle("", for: .normal)
                            self.goldPriceBTn.backgroundColor = .clear
                            // self.subscriptionPriceLbl.text = "$9.99"
//                            if(UserModel.sharedInstance().currency_name == "IN" || UserModel.sharedInstance().currency_name == "INR" ){
//                            self.subscriptionPriceLbl.text = "₹"
//                            + amountValue
//                            }
                           // else{
                                if(UserModel.sharedInstance().userCurrency != "" || UserModel.sharedInstance().userCurrency != nil){
                                self.subscriptionPriceLbl.text = UserModel.sharedInstance().userCurrency!
                                + amountValue
                            }
                                else{
                                    self.subscriptionPriceLbl.text = "$"
                                    + amountValue
                                }
                          //  }
                            self.cardDescrFirstLbl.text = "Artist can submit music to basic DJs"
                            if(expirayDate != ""){
                            let substring = expirayDate[expirayDate.startIndex..<expirayDate.index(expirayDate.startIndex, offsetBy: 10)]
                            let newString = String(substring)
                            self.cardDescSecondLbl.text = "Expiry Date : " + newString
                            }
                            
                            self.subscriptionVw.isHidden = false
                        }
//                        else{
//                            self.goldPriceBTn.setTitle("Gold", for: .normal)
//                            self.createGradient(view: self.goldPriceBTn, bounds: .init(width: self.goldPriceBTn.frame.width, height: self.goldPriceBTn.frame.height))
//                            self.subscriptionPriceLbl.text = "$30"
//                            self.cardDescrFirstLbl.text = "Artist can submit music to exclusive"
//                            let substring = expirayDate[expirayDate.startIndex..<expirayDate.index(expirayDate.startIndex, offsetBy: 10)]
//                            let newString = String(substring)
//                            self.cardDescSecondLbl.text = "Expiry Date : " + newString
//                            //self.inAppCardNoLbl.text = ""
//                            self.subscriptionVw.isHidden = false
//                        }
                            
                        //}
                    }
                    else{
                        
                        if inAppPurchaseModel.success == 0{
                            if(inAppPurchaseModel.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(inAppPurchaseModel.message)
                            }
                        }
//                        self.view.makeToast("You are not authorised. Please login again.")
//                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
//                            })
                    }

                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callGetPromoCodeWebservice(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.get_promocodeAPI)?token=\(UserModel.sharedInstance().token!)&user_type=\(UserModel.sharedInstance().userType!)&userid=\(UserModel.sharedInstance().userId!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SetPromocodeModel>) in
                
                switch response.result {
                case .success(_):
                    let getPromoDetailProfile = response.result.value!
                    if getPromoDetailProfile.success == 1{
                        Loader.shared.hide()
                        if getPromoDetailProfile.result!.coupon_code!.isEmpty == false{
                            self.vwAddPromo.isHidden = true
                            self.vwAddedPromo.isHidden = false
                            
                            let startDate = Date()
                            let endDateString = "\(getPromoDetailProfile.result!.exp_date!)"
                            
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            var days = Int()
                            if let endDate = formatter.date(from: endDateString) {
                                let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
                                print("Number of days: \(components.day!)")
                                days = components.day!
                            } else {
                                print("\(endDateString) can't be converted to a Date")
                            }
                            if getPromoDetailProfile.result!.is_connect_case == 1{
                                self.lblPromoDescrip1.text = "$100 Connect cash.............\(days) days"
                            }else{
                                self.lblPromoDescrip1.isHidden = true
                            }
                            if getPromoDetailProfile.result!.is_commition == 1{
                                self.lblPromoDescrip2.text = "Commission Fee Waved.............\(days) days"
                            }else{
                                self.lblPromoDescrip2.isHidden = true
                            }
                            if getPromoDetailProfile.result!.is_transaction == 1{
                                self.lblPromoDescrip3.text = "Transaction Fee Waved.............\(days) days"
                            }else{
                                self.lblPromoDescrip3.isHidden = true
                            }
                            if getPromoDetailProfile.result!.is_expired == 1{
                                self.vwAddPromo.isHidden = false
                                self.vwAddedPromo.isHidden = true
                            }else{
                                self.vwAddPromo.isHidden = true
                                self.vwAddedPromo.isHidden = false
                            }
                            self.lblFirstNoDj.text = "For \(getPromoDetailProfile.result!.coupon_qty!) DJs"
                            self.lblPromoAck.attributedText = getPromoDetailProfile.result?.description?.htmlToAttributedString
                        }else{
                            self.vwAddPromo.isHidden = false
                            self.vwAddedPromo.isHidden = true
                        }
                    }else{
                        Loader.shared.hide()
                        self.vwAddPromo.isHidden = false
                        self.vwAddedPromo.isHidden = true
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callLogoutWebservice(){
        if getReachabilityStatus(){
            
           
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
            ]
            debugPrint(parameters)
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.logoutAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let logoutModel = response.result.value!
                    if logoutModel.success == 1{

                        print("logout success")
                        self.logout()
                        
//                        UserModel.sharedInstance().token = ""
//                        UserModel.sharedInstance().userId = ""
//                        UserModel.sharedInstance().removeData()
//                        UserModel.sharedInstance().synchroniseData()
//                        self.ChangeRoot()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(logoutModel.message)
                        if logoutModel.message == "You are not authorised. Please login again."{
                            self.logout()
                        }
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    
    func callVerifyMailWebService(code: String, email: String){
        
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "code":"\(code)",
                "email":"\(email)"
            ]
            
            Loader.shared.show()
            
            print(parameters)
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.verifyEmailCode)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let verifyEmailModel = response.result.value!
                    if verifyEmailModel.success == 1{
                        self.view.makeToast(verifyEmailModel.message)
                        self.txfVerifyMail.resignFirstResponder()
                        self.txfVerifyMail.text?.removeAll()
                        self.closeBtnAnimation_Action(self.vwChangeEmailLeadingSpace)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(verifyEmailModel.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection")
        }
    }
    
    @IBAction func timetoremindBtnTapped(_ sender: Any) {
    }
    
}

//MARK: - EXTENSIONS
extension SideMenuHomeVC : UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 3{
            if UserModel.sharedInstance().userType == "AR"{
                return transList.count
            }else{
                return djTransList.count
            }
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 7 {
            return arrLaunguage.count
        }else if tableView.tag == 2{
            return socialData.count
        }else if tableView.tag == 8{
            return iconDetailArray.count
        }else if tableView.tag == 3{
            if UserModel.sharedInstance().userType == "AR"{
                return noOfcellforTrans
            }else{
                if expandTransaction[section]{
                    return expandDataArray[section]
                }else{
                    return 3
                }
            }
        }else{
            if UserModel.sharedInstance().userType == "AR"{
                return 0
            }else{
                return 3
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: "celllaunguage", for: indexPath)
            cell.textLabel?.text = arrLaunguage[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor .lightGray
            if indexPath.row == selectedIndex{
                cell.textLabel?.textColor = UIColor .themeBlack
            }
            return cell
        }else if tableView.tag == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocialLinkCell", for: indexPath) as! SocialLinkCell
            
            cell.socialLinkBgVw.backgroundColor = .white
            cell.socialLinkBgVw.layer.cornerRadius = cell.socialLinkBgVw.frame.size.height/2
            cell.socialLinkBgVw.clipsToBounds = true
            let socialStr = socialData[indexPath.row].social_media_name
            let socialImgStr = URL(string: "\(socialData[indexPath.row].social_media_logo!)")
            cell.lblSocialMediaName.text = socialData[indexPath.row].social_media_name
            let profileImage = URL(string: "\(socialData[indexPath.row].social_media_logo!)")
            cell.imgSocialMediaImage.kf.setImage(with: profileImage, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.btnSocialMedia.tag = indexPath.row
            cell.btnSocialMedia.addTarget(self, action: #selector(btnSocialMedia_Action(_:)), for: .touchUpInside)
            return cell
        }else if tableView.tag == 3{
            var myCellNo = Int()
            if UserModel.sharedInstance().userType == "DJ"{
                if expandTransaction[indexPath.section]{
                    myCellNo = expandDataArray[indexPath.section]
                }else{
                    myCellNo = 3
                }
            }else{
                myCellNo = noOfcellforTrans
            }
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionDateCell", for: indexPath) as! TransactionDateCell
                if UserModel.sharedInstance().userType == "AR"{
                   // if(transList.count > 0){
                    if transList[indexPath.section].purchased_date!.isEmpty == false{
                        let startString = transList[indexPath.row].purchased_date!
                        cell.lblTransDate.text = "Date " + ":\(startString.UTCToLocal(incomingFormat: "yyyy-MM-dd, HH:mm:ss", outGoingFormat: "MMMM dd, yyyy"))"
                    }
                    if transList[indexPath.section].type == "withdraw_request" || transList[indexPath.section].type == "getcredit" || transList[indexPath.section].type == "djDrop" || transList[indexPath.section].type == "song_review" || transList[indexPath.section].type == "refund"{
                        cell.btnViewStatus.setTitle("view status", for: .normal)
                    }else{
                        cell.btnViewStatus.tag = indexPath.section
                        cell.btnViewStatus.setTitle("view receipt", for: .normal)
                        cell.btnViewStatus.addTarget(self, action: #selector(viewReceiptAction(_:)), for: .touchUpInside)
                    }
                    //}
                }else{
                    if djTransList[indexPath.section].posted_date!.isEmpty == false{
                        let startString = djTransList[indexPath.section].posted_date!
                        cell.lblTransDate.text = "Date " + ":\(startString.UTCToLocal(incomingFormat: "yyyy-MM-dd, HH:mm:ss", outGoingFormat: "MMMM dd, yyyy"))"
                    }
                    if djTransList[indexPath.section].type == "withdraw_request" || djTransList[indexPath.section].type == "getcredit"{
                        cell.btnViewStatus.setTitle("view status", for: .normal)
                    }
                    if djTransList[indexPath.section].type == "djDrop" || djTransList[indexPath.section].type == "song_review" ||  djTransList[indexPath.section].type == "apply_project"{
                        cell.btnViewStatus.setTitle("view project", for: .normal)
                    }
                }
                return cell
            }else if indexPath.row == (myCellNo - 1){
                let cell = tableView.dequeueReusableCell(withIdentifier: "TransDetailCell", for: indexPath) as! TransDetailCell
                
//                let formatter = NumberFormatter()
//                formatter.groupingSeparator = "," // or possibly "." / ","
//                formatter.numberStyle = .decimal
                if UserModel.sharedInstance().userType == "AR"{
                   // if(transList.count > 0){
                    
                    
                    cell.lblPotentialEarning.text = "Starting Balance"
                    
//                    formatter.string(from: transList[indexPath.section].before_apply! as NSNumber)
//                    let string2 = formatter.string(from: transList[indexPath.section].before_apply! as NSNumber)
//                    cell.lblStartingBalance.text = "\(self.currentCurrency)" + string2!
                    
                    
                    
//                    let doubleBfrAply = Double(transList[indexPath.section].before_apply!)
//                    let strdoubleBfrAply = formatter.string(from: doubleBfrAply as! NSNumber)

                    
                    cell.lblStartingBalance.text = "\(self.currentCurrency)\(transList[indexPath.section].before_apply ?? "")"
                    
                   // cell.lblStartingBalance.text = "\(self.currentCurrency)\(String(format: "%.2f", transList[indexPath.section].before_apply!))"
   
//                    cell.lblAvailablebalance.text = "\(self.currentCurrency)\(String(format: "%.2f", transList[indexPath.section].after_apply ?? 0.0))"
//                    let doubleafrAply = Double(transList[indexPath.section].after_apply!)
//                    let strdoubleafrAply = formatter.string(from: doubleafrAply as! NSNumber)
                    
                    cell.lblAvailablebalance.text = "\(self.currentCurrency)\(transList[indexPath.section].after_apply ?? "")"
                    
                    // ashitesh
//                    if transList[indexPath.section].type == "apply" || transList[indexPath.section].type == "refund"{
                    
                    if transList[indexPath.section].type == "apply_project" || transList[indexPath.section].type == "refund"{
                        cell.vwCreditCash.isHidden = true
                        cell.vwApply.isHidden = false
                        cell.lblCashOutNote.isHidden = true
                        if transList[indexPath.section].add_video_date!.isEmpty == false{
                            let endString = transList[indexPath.section].add_video_date!
                            let enddateFormatter = DateFormatter()
                            enddateFormatter.dateFormat = "yyyy-MM-dd"
                            let enddate = enddateFormatter.date(from: endString)
                            enddateFormatter.dateFormat = "MMMM dd, yyyy"
                            let endDate12 = enddateFormatter.string(from: enddate!)
                            cell.lblDeliverydate.text = "delivered \(endDate12)"
                        }
                        cell.lblProjName.text = transList[indexPath.section].project_name!
                        cell.lblIs_verified.isHidden = true
                        cell.imgIs_verify.isHidden = true
                        cell.lblIs_feedback.isHidden = true
                        cell.imgIs_Feedback.isHidden = true
                        cell.lblIs_AcceptedNo.isHidden = true
                        cell.imgIs_AcceptNo.isHidden = true
                        cell.lblIs_Delivered.isHidden = true
                        cell.imgIs_Delivered.isHidden = true
                        cell.btnIsVerify.tag = indexPath.row
                        cell.btnIsVerify.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsAcceptNo.tag = indexPath.row
                        cell.btnIsAcceptNo.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsFeedback.tag = indexPath.row
                        cell.btnIsFeedback.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsDelivered.tag = indexPath.row
                        cell.btnIsDelivered.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.lblCharge.isHidden = false
                        cell.lblCharge.textColor = .red
                        cell.lblCHargeBgVw.backgroundColor = .clear
                        cell.lblCHargeBgVw.layer.cornerRadius = 6
                        cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                        cell.lblCHargeBgVw.layer.borderWidth = 1
                        cell.lblCHargeBgVw.clipsToBounds = true
                        
//                        let doubleTrnFee = Double(transList[indexPath.section].totalcost_transactionfees!)
//                        let strdoubleTrnFee = formatter.string(from: doubleTrnFee as! NSNumber)
 
                       // print("centreLinePrice",transList[indexPath.section].totalcost_transactionfees!)

//                        let costPr_Pr = Double(transList[indexPath.section].totalcost_transactionfees ?? 0.0)
//                        let costPr_Price = String(format: "%.2f", costPr_Pr ?? 0.0)
                        
                        cell.lblCharge.text = "\(self.currentCurrency)\(transList[indexPath.section].totalcost_transactionfees ?? "")"

                        
                        cell.lblArTotal.isHidden = true
                        cell.lblArTotalAmount.isHidden = true
                        let profileImageUrl = URL(string: "\(transList[indexPath.section].dj_image!)")
                        cell.imgUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        if transList[indexPath.section].type == "refund" {
                            if transList[indexPath.section].song_status == 0{
                                cell.lblSongStatus.isHidden = false

//                                let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                                let offer_cost_Price = String(format: "%.2f", offer_cost_Pr!)
                                
//                                let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                                let offer_cost_Price = formatter.string(from: offer_cost_Pr as! NSNumber)
                                
                                cell.lblSongStatus.text = "waiting : \(transList[indexPath.section].offer_cost!)"
                                cell.lblArTotal.isHidden = true
                                cell.lblCharge.textColor = .red
                                cell.lblCHargeBgVw.backgroundColor = .clear
                                cell.lblCHargeBgVw.layer.cornerRadius = 6
                                cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                                cell.lblCHargeBgVw.layer.borderWidth = 1
                                cell.lblCHargeBgVw.clipsToBounds = true
                                cell.lblArTotalAmount.isHidden = true
                                cell.lblRejectReason.isHidden = true
                            }

                            if transList[indexPath.section].song_status == 1{
                                cell.lblSongStatus.isHidden = false

//                                let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                                let offer_cost_Price = String(format: "%.2f", offer_cost_Pr!)
                                
//                                let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                                let offer_cost_Price = formatter.string(from: offer_cost_Pr as! NSNumber)
//
//                                let string4 = formatter.string(from: Int(transList[indexPath.section].offer_cost!)! as NSNumber)
                                cell.lblSongStatus.text = "accepted : " + "\(transList[indexPath.section].offer_cost!)"
                                cell.lblArTotal.isHidden = false
                                cell.lblArTotalAmount.isHidden = false
                                cell.lblRejectReason.isHidden = true
                                cell.lblCharge.textColor = .red
//                                cell.lblArTotalAmount.text = "\(self.currentCurrency)" + " " + string4! + " total"
                                cell.lblArTotalAmount.text = "\(self.currentCurrency)" + " " + "\(transList[indexPath.section].offer_cost!)" + " total"

                            }
                            if transList[indexPath.section].song_status == 2{
                                cell.lblSongStatus.isHidden = false

//                                let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                                let offer_cost_Price = String(format: "%.2f", offer_cost_Pr!)
//                                let string5 = formatter.string(from: Int(transList[indexPath.section].offer_cost!)! as NSNumber)
//                                let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                                let offer_cost_Price = formatter.string(from: offer_cost_Pr as! NSNumber)
                                cell.lblSongStatus.text = "rejected : " + transList[indexPath.section].offer_cost!
                                
                                //cell.lblSongStatus.text = "rejected : \(self.currentCurrency)\(transList[indexPath.section].offer_cost!)"
                                cell.lblArTotal.isHidden = true
                                cell.lblCharge.textColor = .green
                                cell.lblArTotalAmount.isHidden = true
                                cell.lblRejectReason.isHidden = false
                                cell.lblRejectReason.text = "Reason \(transList[indexPath.section].song_status_reason!)"
                            }
                        }
                        if transList[indexPath.section].is_offer == 1{
                            cell.lblSongStatus.isHidden = false
                            
//                            let project_price_Pr = Double(transList[indexPath.section].project_price!)
//                            let project_price_Price = String(format: "%.2f", project_price_Pr!)
//                            let project_price_Pr = Double(transList[indexPath.section].project_price!)
//                            let project_price_Price = formatter.string(from: project_price_Pr as! NSNumber)
                            
//                            let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                            let offer_cost_Price = String(format: "%.2f", offer_cost_Pr!)
//                            let offer_cost_Pr = Double(transList[indexPath.section].offer_cost!)
//                            let offer_cost_Price = formatter.string(from: offer_cost_Pr as! NSNumber)
                            
//                            let string6 = formatter.string(from: Int(transList[indexPath.section].project_price!)! as NSNumber)
//                            let string7 = formatter.string(from: Int(transList[indexPath.section].offer_cost!)! as NSNumber)
                            
//                            let offer_cost_Pr1 = Double(transList[indexPath.section].offer_cost!)
//                            let string7 = formatter.string(from: offer_cost_Pr1 as! NSNumber)
                            
                            
                            cell.lblOrderTotal.text = "cost : " + transList[indexPath.section].project_price! + "offered :" + transList[indexPath.section].offer_cost!
                            
                            cell.lblArTotalAmount.text = transList[indexPath.section].offer_cost!
//                            cell.lblArTotalAmount.text = transList[indexPath.section].offer_cost!
                        }else{

//                            let proj_Pr = Double(transList[indexPath.section].project_price!)
//                            let formattedPrice = String(format: "%.2f", proj_Pr!)
//                            print("proj_pr1",formattedPrice)
                            
//                            let proj_Pr = Double(transList[indexPath.section].project_price!)
//                            let formattedPrice = formatter.string(from: proj_Pr as! NSNumber)
                            
                            cell.lblOrderTotal.text = "cost: \(self.currentCurrency)\(transList[indexPath.section].offer_cost!)"
                            cell.lblArTotalAmount.isHidden = true
                            cell.lblArTotal.isHidden = true
                        }
                    }else if transList[indexPath.section].type == "djDrop"{
                        cell.vwCreditCash.isHidden = true
                        cell.vwApply.isHidden = false
                        cell.lblProjName.text = "DJ Drop"
                        cell.lblDeliverydate.text = "delivered - "
                        
//                        let project_price_Pr = Double(transList[indexPath.section].project_price!)
//                        let project_price_Price = String(format: "%.2f", project_price_Pr!)
                        
//                        let proj_Pr = Double(transList[indexPath.section].project_price!)
//                        let project_price_Price = formatter.string(from: proj_Pr as! NSNumber)
                        
                        cell.lblOrderTotal.text = "price: \(self.currentCurrency)\(transList[indexPath.section].project_price!)"

                        
//                        let proj_Pr1 = Double(transList[indexPath.section].totalcost_transactionfees!)
//                        let project_price1 = formatter.string(from: proj_Pr1 as! NSNumber)
                        
                        cell.lblSongStatus.text = "total paid: \(self.currentCurrency)\(transList[indexPath.section].totalcost_transactionfees!)"
                        cell.lblCharge.isHidden = false
                        cell.lblCharge.textColor = .red
                        cell.lblCHargeBgVw.backgroundColor = .clear
                        cell.lblCHargeBgVw.layer.cornerRadius = 6
                        cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                        cell.lblCHargeBgVw.layer.borderWidth = 1
                        cell.lblCHargeBgVw.clipsToBounds = true
                        
//                        let proj_Pr2 = Double(transList[indexPath.section].totalcost_transactionfees!)
//                        let strings8 = formatter.string(from: proj_Pr2 as! NSNumber)
                        
                        cell.lblCharge.text = "\(self.currentCurrency)" + "\(transList[indexPath.section].totalcost_transactionfees!)"
                       // cell.lblCharge.text = "\(self.currentCurrency)\(String(format: "%.2f", transList[indexPath.section].totalcost_transactionfees ?? 0.0))"
                        
                        cell.lblArTotal.isHidden = true
                        cell.lblArTotalAmount.isHidden = true
                        cell.lblIs_verified.isHidden = true
                        cell.imgIs_verify.isHidden = false
                        cell.lblIs_feedback.isHidden = true
                        cell.imgIs_Feedback.isHidden = false
                        cell.lblIs_AcceptedNo.isHidden = true
                        cell.imgIs_AcceptNo.isHidden = false
                        cell.lblIs_Delivered.isHidden = true
                        cell.imgIs_Delivered.isHidden = false
                        cell.btnIsVerify.tag = indexPath.row
                        cell.btnIsVerify.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsAcceptNo.tag = indexPath.row
                        cell.btnIsAcceptNo.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsFeedback.tag = indexPath.row
                        cell.btnIsFeedback.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsDelivered.tag = indexPath.row
                        cell.btnIsDelivered.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                    }else if transList[indexPath.section].type == "song_review"{
                        cell.vwCreditCash.isHidden = true
                        cell.vwApply.isHidden = false
                        cell.lblProjName.text = "Song Review"
                        cell.lblDeliverydate.text = "delivered - "
                        
//                        let proj_Pr1 = Double(transList[indexPath.section].project_price!)
//                        let project_price_Price = formatter.string(from: proj_Pr1 as! NSNumber)
                        
//                        let project_price_Pr = Double(transList[indexPath.section].project_price!)
//                        let project_price_Price = String(format: "%.2f", project_price_Pr!)
                        cell.lblOrderTotal.text = "price: \(self.currentCurrency)\(transList[indexPath.section].project_price!)"
                        

//                        let proj_Pr2 = Double(transList[indexPath.section].totalcost_transactionfees!)
//                        let strings8 = formatter.string(from: proj_Pr2 as! NSNumber)
                        
                        cell.lblSongStatus.text = "total paid: \(self.currentCurrency)\(transList[indexPath.section].totalcost_transactionfees!)"
                        cell.lblCharge.isHidden = false
                        cell.lblCharge.textColor = .red
                        cell.lblCHargeBgVw.backgroundColor = .clear
                        cell.lblCHargeBgVw.layer.cornerRadius = 6
                        cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                        cell.lblCHargeBgVw.layer.borderWidth = 1
                        cell.lblCHargeBgVw.clipsToBounds = true
//                        cell.lblCharge.text = "\(self.currentCurrency)" + " " + stringg11!
                        
//                        let proj_Pr3 = Double(transList[indexPath.section].totalcost_transactionfees!)
//                        let strings9 = formatter.string(from: proj_Pr3 as! NSNumber)
                        
                        cell.lblCharge.text = "\(self.currentCurrency)" + " " + "\(transList[indexPath.section].totalcost_transactionfees!)"
                        cell.lblArTotal.isHidden = true
                        cell.lblArTotalAmount.isHidden = true
                        cell.lblIs_verified.isHidden = true
                        cell.imgIs_verify.isHidden = false
                        cell.lblIs_feedback.isHidden = true
                        cell.imgIs_Feedback.isHidden = false
                        cell.lblIs_AcceptedNo.isHidden = true
                        cell.imgIs_AcceptNo.isHidden = false
                        cell.lblIs_Delivered.isHidden = true
                        cell.imgIs_Delivered.isHidden = false
                        cell.btnIsVerify.tag = indexPath.row
                        cell.btnIsVerify.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsAcceptNo.tag = indexPath.row
                        cell.btnIsAcceptNo.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsFeedback.tag = indexPath.row
                        cell.btnIsFeedback.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsDelivered.tag = indexPath.row
                        cell.btnIsDelivered.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                    }else if transList[indexPath.section].type == "getcredit"{
                        cell.imgCreCash2.image = UIImage(named: "creditcasharrow")
                        cell.imgCreCash1.image = UIImage(named: "creditcashnote")
                        cell.imgCreCash3.image = UIImage(named: "creditcashbag")
                        cell.vwCreditCash.isHidden = false
                        cell.vwApply.isHidden = true
                        cell.lblCashOutNote.isHidden = true
                        let acc = CommonFunctions.decryptValue(value: "\(transList[indexPath.section].account_no!)")
                        let acc_Array = Array(acc)
                        var acc2 = Array<Any>()
                        for i in 0..<acc_Array.count{
                            if i < acc_Array.count - 4{
                                acc2.append("*")
                            }else{
                                acc2.append(acc_Array[i])
                            }
                        }
                        let acc3 = acc2.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                        print("ACCOUNT - \(acc3)")
                        cell.lblProjName.text = """
                            FROM
                            Bank Account \(acc3)
                            """
                        cell.lblCharge.isHidden = false
                        cell.lblCharge.textColor = .green
                        cell.lblCHargeBgVw.backgroundColor = .clear
                        cell.lblCHargeBgVw.layer.cornerRadius = 6
                        cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                        cell.lblCHargeBgVw.layer.borderWidth = 1
                        cell.lblCHargeBgVw.clipsToBounds = true

//                        let amount_Pr = Double(transList[indexPath.section].amount!)
//                        let amount_Price = formatter.string(from: amount_Pr as! NSNumber)
                        
//                        let amount_Pr = Double(transList[indexPath.section].amount!)
//                        let amount_Price = String(format: "%.2f", amount_Pr)
//                        if(transList[indexPath.section].amount == nil){
//                            let a = Double(transList[indexPath.section].after_apply ?? "")
//                            let b = Double(transList[indexPath.section].before_apply ?? "")
//                            var c = Double(a! - Double(transList[indexPath.section].before_apply ?? "")!)
//                            let amount_Price = String(format: "%.2f", c)
//                            cell.lblCharge.text =  "\(self.currentCurrency)\(amount_Price)"
//                        }
//                                           else{
                        cell.lblCharge.text =  "\(self.currentCurrency)\(transList[indexPath.section].amount!)"
                            //}
                        
                        cell.lblRejectReason.isHidden = true
                        
                    }else{
                        cell.imgCreCash2.image = UIImage(named: "creditcasharrow")
                        cell.imgCreCash1.image = UIImage(named: "creditcashbag")
                        cell.imgCreCash3.image = UIImage(named: "creditcashnote")
                        cell.vwCreditCash.isHidden = false
                        cell.vwApply.isHidden = true
                        cell.lblCashOutNote.isHidden = false
                        let acc = CommonFunctions.decryptValue(value: "\(transList[indexPath.section].account_no!)")
                        let acc_Array = Array(acc)
                        var acc2 = Array<Any>()
                        for i in 0..<acc_Array.count{
                            if i < acc_Array.count - 4{
                                acc2.append("*")
                            }else{
                                acc2.append(acc_Array[i])
                            }
                        }
                        let acc3 = acc2.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                        print("ACCOUNT - \(acc3)")
                        cell.lblProjName.text = """
                            TO
                            Bank Account \(acc3)
                            """
                        cell.lblCharge.isHidden = false
                        cell.lblCharge.textColor = .red
                        cell.lblCHargeBgVw.backgroundColor = .clear
                        cell.lblCHargeBgVw.layer.cornerRadius = 6
                        cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                        cell.lblCHargeBgVw.layer.borderWidth = 1
                        cell.lblCHargeBgVw.clipsToBounds = true

//                        let amount_Pr = Double(transList[indexPath.section].amount!)
//                        let amount_Price = formatter.string(from: amount_Pr as! NSNumber)
                        
//                        let amount_Pr = Double(transList[indexPath.section].amount!)
//                        let amount_Price = String(format: "%.2f", amount_Pr)
                        
                        cell.lblCharge.text = "\(self.currentCurrency)\(transList[indexPath.section].amount!)"
                        cell.lblRejectReason.isHidden = true
                    }
                    //}
                }else{
                
                    var startBal = djTransList[indexPath.section].ending_balance ?? ""

                    cell.lblPotentialEarning.text = "Potential Earnings"
//                    let formatter = NumberFormatter()
//                    formatter.groupingSeparator = "," // or possibly "." / ","
//                    formatter.numberStyle = .decimal
//                    formatter.string(from: startBal as! NSNumber)
//                    let stringg12 = formatter.string(from: startBal as! NSNumber)
//                    cell.lblStartingBalance.text = "\(self.currentCurrency)" + " " + "\(startBal)"
                    var firstBal = Float(djTransList[indexPath.section].current_balance ?? "") ?? 0.0
                    var secondBal = Float(djTransList[indexPath.section].amount!) ?? 0.0
                    var finalBal = firstBal - secondBal
                    
//                    let amount_Pr = Double(finalBal)
//                    let amount_Price = String(format: "%.2f", amount_Pr)
                    let amount_Pr = Double(djTransList[indexPath.section].ending_balance ?? "")
                    let amount_Price = String(format: "%.2f", amount_Pr ?? 0.0)
                    
//                    let formatter = NumberFormatter()
//                    formatter.groupingSeparator = "," // or possibly "." / ","
//                    formatter.numberStyle = .decimal
//                    formatter.string(from: amount_Price as! NSNumber)
//                    let stringg12 = formatter.string(from: amount_Price as! NSNumber)
                    
                    cell.lblStartingBalance.text = "\(self.currentCurrency)" + " " + "\(djTransList[indexPath.section].ending_balance!)"
                //print("lblStartingBalance",stringg12)
//                    cell.lblStartingBalance.text = "\(self.currentCurrency)\(djTransList[indexPath.section].starting_balance!)"
//                    cell.lblAvailablebalance.text = "\(self.currentCurrency)\(djTransList[indexPath.section].ending_balance!)" // ashsitesh
                    
                    var no1: Float?
                                        var totalearn: Int?
                    no1 = Float(djTransList[indexPath.section].current_balance ?? "")
                                        totalearn = Int(djTransList[indexPath.section].total_earned ?? "")
                    no1 = Float(no1 ?? 0) + Float(Int(totalearn ?? 0))
                                        print("Potential Earnings",djTransList[indexPath.section].total_earned ?? "") // 1, 14
                    
                    
//                    formatter.string(from: no1 as! NSNumber)
//                    let stringg127 = formatter.string(from: no1 as! NSNumber)
                    
                    let amount_Prr = Double(djTransList[indexPath.section].current_balance ?? "")
                    let amount_Pricer = String(format: "%.2f", amount_Prr ?? 0.0)
                    
                    cell.lblAvailablebalance.text = "\(self.currentCurrency)" + "\(djTransList[indexPath.section].current_balance ?? "")"
                    
                    let profileImageUrl = URL(string: "\(djTransList[indexPath.section].dj_image!)")
                    cell.imgUserProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"), completionHandler: nil)
                    
                    if djTransList[indexPath.section].type == "apply_project"{
                        cell.vwCreditCash.isHidden = true
                        cell.vwApply.isHidden = false
                        cell.lblCashOutNote.isHidden = true
                        
                        if djTransList[indexPath.section].video_verify_date!.isEmpty == false{
                            let endString = djTransList[indexPath.section].video_verify_date!
                            let enddateFormatter = DateFormatter()
                            enddateFormatter.dateFormat = "yyyy-MM-dd"
                            let enddate = enddateFormatter.date(from: endString)
                            enddateFormatter.dateFormat = "MMMM dd, yyyy"
                            let endDate12 = enddateFormatter.string(from: enddate!)
                            cell.lblDeliverydate.text = "delivered \(endDate12)"
                        }
                        
                        cell.lblProjName.text = djTransList[indexPath.section].project_name!

                       // let stringg123 = formatter.string(from: Int(djTransList[indexPath.section].original_cost ?? "")! as NSNumber)
                        
                        let original_cost_Prr = Double(djTransList[indexPath.section].original_cost ?? "")
                        let original_cost_Pricer = String(format: "%.2f", original_cost_Prr ?? 0.0)
                        
                        cell.lblOrderTotal.text = "price : \(self.currentCurrency)" + " " + "\(djTransList[indexPath.section].original_cost)"
//                        cell.lblOrderTotal.text = "price : \(self.currentCurrency)\(djTransList[indexPath.section].original_cost!)"
                        
                        cell.lblIs_verified.text = "\(djTransList[indexPath.section].verify_count!)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_feedback.text = "\(djTransList[indexPath.section].rating_count!)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_AcceptedNo.text = "\(djTransList[indexPath.section].applyed_artist!.count)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_Delivered.text = "\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.btnIsVerify.tag = indexPath.row
                        cell.btnIsVerify.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsAcceptNo.tag = indexPath.row
                        cell.btnIsAcceptNo.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsFeedback.tag = indexPath.row
                        cell.btnIsFeedback.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.lblCharge.isHidden = false
                        if(djTransList[indexPath.section].total_earned != ""){
                            
                            let total_earned_Prr = Double(djTransList[indexPath.section].total_earned ?? "")
                            let total_earned_Pricer = String(format: "%.2f", total_earned_Prr ?? 0.0)
                        cell.lblCharge.text = "\(self.currentCurrency)" + "\(djTransList[indexPath.section].total_earned!)"
                            cell.lblCHargeBgVw.backgroundColor = .clear
                            cell.lblCHargeBgVw.layer.cornerRadius = 6
                            cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                            cell.lblCHargeBgVw.layer.borderWidth = 1
                            cell.lblCHargeBgVw.clipsToBounds = true
                        }
                        
                        cell.lblArTotalAmount.isHidden = true
                        cell.lblArTotal.isHidden = true
                        cell.lblSongStatus.isHidden = true
                        cell.lblRejectReason.isHidden = true
                    }else if djTransList[indexPath.section].type == "djDrop"{
                        cell.vwCreditCash.isHidden = true
                        cell.vwApply.isHidden = false
                        cell.lblProjName.text = "DJ Drop"
                        cell.lblDeliverydate.text = "delivered - "
                        
                       // let stringg1234 = formatter.string(from: Int(djTransList[indexPath.section].original_cost!)! as NSNumber)
                        
                        let original_cost_Prr = Double(djTransList[indexPath.section].original_cost!)
                        let original_cost_Pricer = String(format: "%.2f", original_cost_Prr ?? 0.0)
                        
                        cell.lblOrderTotal.text = "price: \(self.currentCurrency)" + " " + "\(djTransList[indexPath.section].original_cost!)"
//                        cell.lblOrderTotal.text = "price: \(self.currentCurrency)\(djTransList[indexPath.section].original_cost!)"
                        cell.lblSongStatus.isHidden = true
                        cell.lblCharge.isHidden = true
                        cell.lblArTotal.isHidden = true
                        cell.lblArTotalAmount.isHidden = true
                        cell.lblIs_verified.isHidden = false
                        cell.imgIs_verify.isHidden = false
                        cell.lblIs_verified.text = "\(djTransList[indexPath.section].verify_count!)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_feedback.isHidden = false
                        cell.imgIs_Feedback.isHidden = false
                        cell.lblIs_feedback.text = "\(djTransList[indexPath.section].rating_count!)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_AcceptedNo.isHidden = false
                        cell.imgIs_AcceptNo.isHidden = false
                        cell.lblIs_AcceptedNo.text = "\(djTransList[indexPath.section].applyed_artist!.count)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_Delivered.isHidden = false
                        cell.imgIs_Delivered.isHidden = false
                        cell.lblIs_Delivered.text = "\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.btnIsVerify.tag = indexPath.row
                        cell.btnIsVerify.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsAcceptNo.tag = indexPath.row
                        cell.btnIsAcceptNo.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsFeedback.tag = indexPath.row
                        cell.btnIsFeedback.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsDelivered.tag = indexPath.row
                        cell.btnIsDelivered.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                    }else if djTransList[indexPath.section].type == "song_review"{
                        cell.vwCreditCash.isHidden = true
                        cell.vwApply.isHidden = false
                        cell.lblProjName.text = "Song Review"
                        cell.lblDeliverydate.text = "delivered - "
                        
                       // let stringg12345 = formatter.string(from: Int(djTransList[indexPath.section].original_cost!)! as NSNumber)
                        
                        let original_cost_Prr = Double(djTransList[indexPath.section].original_cost!)
                        let original_cost_Pricer = String(format: "%.2f", original_cost_Prr ?? 0.0)
                        
                        cell.lblOrderTotal.text = "price: \(self.currentCurrency)" + " " + "\(djTransList[indexPath.section].original_cost!)"
                        //cell.lblOrderTotal.text = "price: \(self.currentCurrency)\(djTransList[indexPath.section].original_cost!)"
                        cell.lblSongStatus.isHidden = true
                        cell.lblCharge.isHidden = true
                        cell.lblArTotal.isHidden = true
                        cell.lblArTotalAmount.isHidden = true
                        cell.lblIs_verified.isHidden = false
                        cell.imgIs_verify.isHidden = false
                        cell.lblIs_verified.text = "\(djTransList[indexPath.section].verify_count!)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_feedback.isHidden = false
                        cell.imgIs_Feedback.isHidden = false
                        cell.lblIs_feedback.text = "\(djTransList[indexPath.section].rating_count!)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_AcceptedNo.isHidden = false
                        cell.imgIs_AcceptNo.isHidden = false
                        cell.lblIs_AcceptedNo.text = "\(djTransList[indexPath.section].applyed_artist!.count)/\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.lblIs_Delivered.isHidden = false
                        cell.imgIs_Delivered.isHidden = false
                        cell.lblIs_Delivered.text = "\(djTransList[indexPath.section].applyed_artist!.count)"
                        cell.btnIsVerify.tag = indexPath.row
                        cell.btnIsVerify.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsAcceptNo.tag = indexPath.row
                        cell.btnIsAcceptNo.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsFeedback.tag = indexPath.row
                        cell.btnIsFeedback.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                        cell.btnIsDelivered.tag = indexPath.row
                        cell.btnIsDelivered.addTarget(self, action: #selector(openIconView(_:)), for: .touchUpInside)
                    }else if djTransList[indexPath.section].type == "getcredit"{
                        cell.imgCreCash2.image = UIImage(named: "creditcasharrow")
                        cell.imgCreCash1.image = UIImage(named: "creditcashnote")
                        cell.imgCreCash3.image = UIImage(named: "creditcashbag")
                        cell.vwCreditCash.isHidden = false
                        cell.vwApply.isHidden = true
                        cell.lblCashOutNote.isHidden = true
                        //set account no
                        print("djTransList",djTransList)
//                        let acc = CommonFunctions.decryptValue(value: "\(djTransList[indexPath.row].account_no!)")
                        let acc = CommonFunctions.decryptValue(value: "\(djTransList[indexPath.section].account_no!)")
                        let acc_Array = Array(acc)
                        var acc2 = Array<Any>()
                        for i in 0..<acc_Array.count{
                            if i < acc_Array.count - 4{
                                acc2.append("*")
                            }else{
                                acc2.append(acc_Array[i])
                            }
                        }
                        let acc3 = acc2.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                        print("ACCOUNT - \(acc3)")
                        cell.lblProjName.text = """
                            FROM
                            Bank Account \(acc3)
                            """
                        cell.lblCharge.isHidden = false
                        cell.lblCharge.textColor = .green
                        cell.lblCHargeBgVw.backgroundColor = .clear
                        cell.lblCHargeBgVw.layer.cornerRadius = 6
                        cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                        cell.lblCHargeBgVw.layer.borderWidth = 1
                        cell.lblCHargeBgVw.clipsToBounds = true
                       // formatter.string(from: djTransList[indexPath.section].amount! as NSNumber)
                       // let stringg123456 = formatter.string(from: djTransList[indexPath.section].amount! as NSNumber)
                        
                        
                       // let original_cost_Prr = Double(djTransList[indexPath.section].amount!)
                       // let original_cost_Pricer = String(format: "%.2f", original_cost_Prr )
                        
                        cell.lblCharge.text =  "\(self.currentCurrency)" + " " + "\(djTransList[indexPath.section].amount!)"
//                        cell.lblCharge.text =  "\(self.currentCurrency)\(djTransList[indexPath.section].amount!)"
                    }else{
                        
                        cell.imgCreCash2.image = UIImage(named: "creditcasharrow")
                        cell.imgCreCash1.image = UIImage(named: "creditcashbag")
                        cell.imgCreCash3.image = UIImage(named: "creditcashnote")
                        cell.vwCreditCash.isHidden = false
                        cell.vwApply.isHidden = true
                        cell.lblCashOutNote.isHidden = false
//                        let acc = CommonFunctions.decryptValue(value: "\(djTransList[indexPath.row].account_no!)")
                        for j in 0..<djTransList.count - 1{
                            let acc = CommonFunctions.decryptValue(value: "\(djTransList[j].account_no!)")
                        let acc_Array = Array(acc)
                        var acc2 = Array<Any>()
                        for i in 0..<acc_Array.count{
                            if i < acc_Array.count - 4{
                                acc2.append("*")
                            }else{
                                acc2.append(acc_Array[i])
                            }
                        }
                        let acc3 = acc2.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ",", with: "")
                        cell.lblProjName.text = """
                            TO
                            Bank Account \(acc3)
                            """
                        cell.lblCharge.isHidden = false
                        cell.lblCharge.textColor = .red
                        cell.lblCHargeBgVw.backgroundColor = .clear
                        cell.lblCHargeBgVw.layer.cornerRadius = 6
                        cell.lblCHargeBgVw.layer.borderColor = UIColor.white.cgColor
                        cell.lblCHargeBgVw.layer.borderWidth = 1
                        cell.lblCHargeBgVw.clipsToBounds = true
                       // let stringg19 = formatter.string(from: djTransList[indexPath.section].amount! as NSNumber)
                            
//                            let original_cost_Prr = Double(djTransList[indexPath.section].amount!)
//                            let original_cost_Pricer = String(format: "%.2f", original_cost_Prr )
                        cell.lblCharge.text = "\(self.currentCurrency)" + " " + "\(djTransList[indexPath.section].amount!)"
//                        cell.lblCharge.text = "\(self.currentCurrency)\(djTransList[indexPath.section].amount!)"
                    }
                    }
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "TransConnectCell", for: indexPath) as! TransConnectCell
//                let formatter = NumberFormatter()
//                formatter.groupingSeparator = "," // or possibly "." / ","
//                formatter.numberStyle = .decimal
                
                if UserModel.sharedInstance().userType == "AR"{
                    cell.btnExpandConnectDetail.isEnabled = false
                  //  if(transList.count > 0){
                    if transList[indexPath.section].type == "apply" || transList[indexPath.section].type == "refund"{
                       // formatter.string(from: Int(transList[indexPath.section].project_price!)! as NSNumber)
                       // let stri = formatter.string(from: Int(transList[indexPath.section].project_price!)! as NSNumber)
                        
                        let project_price_Prr = Double(transList[indexPath.section].project_price!)
                        let project_price_Pricer = String(format: "%.2f", project_price_Prr! )
                        
                        cell.lblConnectNoPrice.text = "1 Connects @ " + transList[indexPath.section].project_price! + " by "
//                        cell.lblConnectNoPrice.text = "1 Connects @ \(transList[indexPath.section].project_price!) by "
                        cell.lblConnectBy.text = transList[indexPath.section].dj_name!
                    }else if transList[indexPath.section].type == "djDrop"{
                        cell.lblConnectNoPrice.text = "1 DJ Drop by "
                        cell.lblConnectBy.text = transList[indexPath.section].dj_name!
                    }else if transList[indexPath.section].type == "song_review"{
                        cell.lblConnectNoPrice.text = "1 DJ Song Review by "
                        cell.lblConnectBy.text = transList[indexPath.section].dj_name!
                    }else if transList[indexPath.section].type == "getcredit"{
                       // let strin = formatter.string(from: transList[indexPath.section].amount! as NSNumber)
                        
                        cell.lblConnectNoPrice.text = "Connect Cash @" + (transList[indexPath.section].amount ?? "") + " by "
                        cell.lblConnectBy.text = transList[indexPath.section].ar_name!
                    }else{
                       // let stri1 = formatter.string(from: transList[indexPath.section].amount! as NSNumber)
                        cell.lblConnectNoPrice.text = "Cash Out @ " + (transList[indexPath.section].amount ?? "") + " by "
//                        cell.lblConnectNoPrice.text = "Cash Out @ \(transList[indexPath.section].amount!) by "
                        cell.lblConnectBy.text = transList[indexPath.section].ar_name!
                    }
                   // }
                }else{
                    if djTransList[indexPath.section].type == "apply_project"{
                        
                        if indexPath.row == 1{
                            //formatter.string(from: Int(djTransList[indexPath.section].original_cost!)! as NSNumber)
//                            let stri1 = formatter.string(from: Int(djTransList[indexPath.section].original_cost!)! as NSNumber)
//
                            cell.lblConnectNoPrice.text = "+\(djTransList[indexPath.section].applyed_artist!.count) Connects @" + (djTransList[indexPath.section].current_balance ?? "") ?? "" + " by"
//                            cell.lblConnectNoPrice.text = "+\(djTransList[indexPath.section].applyed_artist!.count) Connects @ \(djTransList[indexPath.section].original_cost!) by"
                            
                            cell.lblConnectBy.text = djTransList[indexPath.section].dj_name!
                        }else{
                            let appAr = djTransList[indexPath.section].applyed_artist
                            
                            if appAr![indexPath.row-2].is_offer! == 0{
                                
                                //let stri11 = formatter.string(from: appAr![indexPath.row-2].totalcost_transactionfees! as NSNumber)
                                cell.lblConnectNoPrice.text = "Connect @ " + "\(appAr![indexPath.row-2].totalcost_transactionfees!)" + " by"
//                                cell.lblConnectNoPrice.text = "Connect @ \(appAr![indexPath.row-2].totalcost_transactionfees!) by"
                                cell.lblConnectBy.text = appAr![indexPath.row-2].artist_name!
                            }else{
                               // let stri1 = formatter.string(from: Int(arSubTransList[indexPath.row-2].original_cost!)! as NSNumber)
                                cell.lblConnectNoPrice.text = "Offer @ " + arSubTransList[indexPath.row-2].original_cost! + " by "
//                                cell.lblConnectNoPrice.text = "Offer @ \(arSubTransList[indexPath.row-2].original_cost!) by "
                                cell.lblConnectBy.text = arSubTransList[indexPath.row-2].artist_name!
                                
                            }
                        }
                    }
                    else if djTransList[indexPath.section].type == "djDrop"{
                        if indexPath.row == 1{
                            cell.lblConnectNoPrice.text = "+\(djTransList[indexPath.section].applyed_artist!.count) DJ Drop by"
                            cell.lblConnectBy.text = djTransList[indexPath.section].dj_name!
                        }else{
                            let appAr = djTransList[indexPath.section].applyed_artist
                            if appAr![indexPath.row-2].is_offer! == 0{
                                //let stri1 = formatter.string(from: appAr![indexPath.row-2].totalcost_transactionfees! as NSNumber)
                                cell.lblConnectNoPrice.text = "Dj Drop @ " + "\(appAr![indexPath.row-2].totalcost_transactionfees!)" + "  by"
//                                cell.lblConnectNoPrice.text = "Dj Drop @ \(appAr![indexPath.row-2].totalcost_transactionfees!) by"
                                cell.lblConnectBy.text = appAr![indexPath.row-2].artist_name!
                            }else{
                               // let stri12 = formatter.string(from: Int(arSubTransList[indexPath.row-2].original_cost!)! as NSNumber)
                                cell.lblConnectNoPrice.text = "Offerred Drop @ " + arSubTransList[indexPath.row-2].original_cost! + " by "
//                                cell.lblConnectNoPrice.text = "Offerred Drop @ \(arSubTransList[indexPath.row-2].original_cost!) by "
                                cell.lblConnectBy.text = arSubTransList[indexPath.row-2].artist_name!
                            }
                        }
                    }
                    else if djTransList[indexPath.section].type == "song_review"{
                        if indexPath.row == 1{
                            
                            cell.lblConnectNoPrice.text = "+\(djTransList[indexPath.section].applyed_artist!.count) songReview by"
                            cell.lblConnectBy.text = djTransList[indexPath.section].dj_name!
                        }else{
                            let appAr = djTransList[indexPath.section].applyed_artist
                            if appAr![indexPath.row-2].is_offer! == 0{
                                //let stri1 = formatter.string(from: appAr![indexPath.row-2].totalcost_transactionfees! as NSNumber)
                                cell.lblConnectNoPrice.text = "Song Review @ " + "\(appAr![indexPath.row-2].totalcost_transactionfees!)" + " by"
//                                cell.lblConnectNoPrice.text = "Song Review @ \(appAr![indexPath.row-2].totalcost_transactionfees!) by"
                                
                                cell.lblConnectBy.text = appAr![indexPath.row-2].artist_name!
                            }else{
                                //let stri1 = formatter.string(from: Int(arSubTransList[indexPath.row-2].original_cost!)! as NSNumber)
                                cell.lblConnectNoPrice.text = "Offerred Song Review @ " + arSubTransList[indexPath.row-2].original_cost! + " by "
//                                cell.lblConnectNoPrice.text = "Offerred Song Review @ \(arSubTransList[indexPath.row-2].original_cost!) by "
                                
                                cell.lblConnectBy.text = arSubTransList[indexPath.row-2].artist_name!
                            }
                        }
                    }
                    else if djTransList[indexPath.section].type == "getcredit"{
                        cell.btnExpandConnectDetail.isEnabled = false
                       // let stri1 = formatter.string(from: djTransList[indexPath.section].amount! as NSNumber)
                        cell.lblConnectNoPrice.text = "Connect Cash @ \(self.currentCurrency)" + djTransList[indexPath.section].amount! + "  by "
//                        cell.lblConnectNoPrice.text = "Connect Cash @ \(self.currentCurrency)\(djTransList[indexPath.section].amount!) by "
                        
                        cell.lblConnectBy.text = djTransList[indexPath.section].dj_name!
                    }else{
                        cell.btnExpandConnectDetail.isEnabled = false
                        //let stri1 = formatter.string(from: djTransList[indexPath.section].amount! as NSNumber)
                        cell.lblConnectNoPrice.text = "Cash Out @ " + djTransList[indexPath.section].amount! + " by "
//                        cell.lblConnectNoPrice.text = "Cash Out @ \(djTransList[indexPath.section].amount!) by "
                        
                        cell.lblConnectBy.text = djTransList[indexPath.section].dj_name!
                    }
                }
                return cell
            }
        }else if tableView.tag == 8{
            let cell = tableView.dequeueReusableCell(withIdentifier: "IconInfoCell", for: indexPath) as! IconInfoCell
            cell.lblIconDetail.text = iconDetailArray[indexPath.row]
            cell.imageIcon.image = UIImage(named: iconImagesArray[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DjConnectDetailCell", for: indexPath) as! DjConnectDetailCell
            let appAr = djTransList[indexPath.section].applyed_artist
            let formatter = NumberFormatter()
            formatter.groupingSeparator = "," // or possibly "." / ","
            formatter.numberStyle = .decimal
            
            if appAr![indexPath.section].is_offer! == 0{
                
               // formatter.string(from: appAr![indexPath.section].totalcost_transactionfees! as NSNumber)
                let stri1 = formatter.string(from: appAr![indexPath.section].totalcost_transactionfees! as NSNumber)
                cell.lblDjConnectNoPrice.text = "Connect @ " + stri1! + " by"
                //cell.lblDjConnectNoPrice.text = "Connect @ \(appAr![indexPath.section].totalcost_transactionfees!) by"
                
                cell.lblDjConnectBy.text = appAr![indexPath.section].artist_name!
                return cell
            }else{
               // formatter.string(from: Int(arSubTransList[indexPath.row].original_cost!)! as NSNumber)
                let stri1 = formatter.string(from: Int(arSubTransList[indexPath.row].original_cost!)! as NSNumber)
                cell.lblDjConnectNoPrice.text = "Offer @ " + stri1! + " by "
//                cell.lblDjConnectNoPrice.text = "Offer @ \(arSubTransList[indexPath.row].original_cost!) by "
                
                cell.lblDjConnectBy.text = arSubTransList[indexPath.row].artist_name!
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 7{
            return 40
        }else if tableView.tag == 2{
            return 46
        }
        else if tableView.tag == 3{
//            var myCellNoo = Int()
//            if(indexPath.row == 0){
//            return 0
//            }
//            //else if indexPath.row == (myCellNoo - 1){
//                if UserModel.sharedInstance().userType == "AR"{
//                    return UITableView.automaticDimension
//                }else{
//                    return UITableView.automaticDimension
//                }
            
            if UserModel.sharedInstance().userType == "AR"{
                return UITableView.automaticDimension
            }else{
                return UITableView.automaticDimension
            }

        }else if tableView.tag == 8{
            return 45
        }else{
            return 20
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        if tableView.tag == 7{
            if indexPath.row == 0{
                self.arabic()
            }else if indexPath.row == 1{
                self.english()
            }
        }else if tableView.tag == 3{
            if UserModel.sharedInstance().userType == "DJ"{
                if indexPath.row == 1{
                    if !expandTransaction[indexPath.section]{
                        expandTransaction[indexPath.section] = true
                        if djTransList[indexPath.section].applyed_artist!.count > 0{
                            noOfcellforTrans = djTransList[indexPath.section].applyed_artist!.count + 3
                            expandDataArray[indexPath.section] = noOfcellforTrans
                        }else{
                            noOfcellforTrans = 3
                            expandDataArray[indexPath.section] = 3
                        }
                        tblTransaction.reloadData()
                    }else{
                        expandTransaction[indexPath.section] = false
                        noOfcellforTrans = 3
                        tblTransaction.reloadData()
                    }
                }
            }else{
                if indexPath.row == 2{
                    if transList[indexPath.section].type! == "apply"{
                        print("tapped buy receipt for \(indexPath.section)")
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        if tableView == tblTransaction{
//            if UserModel.sharedInstance().userType == "AR"{
//                if indexPath.row == transList.count - 1{
//                    startIndexTransHis = 10 + startIndexTransHis
//                    callGetArTransHistoryWebservice(start: startIndexTransHis)
//                }
//            }else{
//                if indexPath.row == djTransList.count - 1{
//                    startIndexTransHis = 10 + startIndexTransHis
//                    callGetDjTransHistoryWebservice(start: startIndexTransHis)
//                }
//            }
//        }
    }
}
extension SideMenuHomeVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blockDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlockedProfileCell", for: indexPath) as!
            BlockedProfileCell
        
        let blockimageUrl = URL(string: blockDetail[indexPath.row].profile_image!)
        cell.imgBlockImage.kf.setImage(with: blockimageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        
        cell.lblBlockName.text = blockDetail[indexPath.row].block_user_name!
        cell.btnUnblock.setTitle("unblock?".localize, for: .normal)
        cell.btnUnblock.addTarget(self, action: #selector(btnUnblock_Action(_:)), for: .touchUpInside)
        return cell
    }
    
}
extension SideMenuHomeVC: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
       // if textField == txfSetTime{
            if textField == setRTimeTxtfld{
            btnSave.isHidden = false
            showStartDatePicker()
            return true
        }else{
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txfDjCardNo || textField == txfArCardNo{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            } else if textField.text!.count > 9 {
                return false
            }
        }
        if textField == txfDjExpiryDate || textField == txfArExpiryDate{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            } else if textField.text!.count > 3 {
                return false
            }
        }
        if textField == txfDjCvv || textField == txfArCvv{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            } else if textField.text!.count > 3 {
                return false
            }
        }
        
        if textField == txfDjConnectCash{
            let formatter = NumberFormatter()
                 formatter.numberStyle = .decimal
                // formatter.locale = Locale.current
                 formatter.maximumFractionDigits = 0


                // Uses the grouping separator corresponding to your Locale
                // e.g. "," in the US, a space in France, and so on
                if let groupingSeparator = formatter.groupingSeparator {

                    if string == groupingSeparator {
                        return true
                    }


                    if let textWithoutGroupingSeparator = textField.text?.replacingOccurrences(of: groupingSeparator, with: "") {
                        var totalTextWithoutGroupingSeparators = textWithoutGroupingSeparator + string
                        if string.isEmpty { // pressed Backspace key
                            totalTextWithoutGroupingSeparators.removeLast()
                        }
                        if let numberWithoutGroupingSeparator = formatter.number(from: totalTextWithoutGroupingSeparators),
                            let formattedText = formatter.string(from: numberWithoutGroupingSeparator) {

                            textField.text = formattedText
                            return false
                        }
                    }
                }
        }
        return true
    }
}



