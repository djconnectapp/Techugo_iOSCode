//
//  ConnectInfoVC.swift
//  DJConnect
//
//  Created by Techugo on 29/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import AlamofireObjectMapper

class ConnectInfoVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var hdrConctInfoLbl: UILabel!
    //var genreArray = ["Pop", "Rock", "Electro", "Rap" ,"Techno", "Hip Hop", "Reggae", "Gospae", "R&B", "Blues"]
    var arrGenrelist = [GenreData]()
    
    @IBOutlet weak var genreCollectionVw: UICollectionView!
    @IBOutlet weak var genrecollectionVwHght: NSLayoutConstraint!
    @IBOutlet weak var currencyVw: UIView!
    @IBOutlet weak var currencyTxtFld: UITextField!
    @IBOutlet weak var priceVw: UIView!
    @IBOutlet weak var priceTxtFld: UITextField!
    @IBOutlet weak var restrictionVw: UIView!
    @IBOutlet weak var restrictionTxtFld: UITextField!
    @IBOutlet weak var genreVw: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var lblCurrencySymbol: UILabel!
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
    
    var currencyIndex = String()
    var restriction = DropDown()
    var arrSelectedIndex = [Int]()
    var setGenreIdStr : String?
    var dateSelected = String()
    var addFlag = String()
    
    var txtpriceStr = String()
    var txtRestricStr = String()
    var txtAdditnlInfoStr = String()
    var genreNames = String()
    var genreIds : String!
    var txtLatStr = String()
    var txtLongStr = String()
    
    //var addedGenreArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.GetGenreList()
        
                let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: genreCollectionVw.frame.size.width / 4, height: 54)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
        genreCollectionVw!.collectionViewLayout = layout
        
        currencyTxtFld.isUserInteractionEnabled = false
        setUpVw()
        
        restriction.selectionAction = { [unowned self] (index: Int, item: String) in
            self.restrictionTxtFld.text = self.restriction.selectedItem
        }
        
        if GlobalId.id == "1"{
            
            priceTxtFld.text = txtpriceStr
            restrictionTxtFld.text = txtRestricStr
            
           // var getGenreId = genreIds  //"3, 6, 9"
//            let fullNameArr1 = fullName1!.components(separatedBy: ", ")
            
            guard let getGenreId = genreIds?.components(separatedBy: ", ").map({Int($0) ?? 0}) else {
                return
            }

            print("getGenreId",getGenreId) /// ["3", "6", "9"]
            arrSelectedIndex = getGenreId
            setGenreIdStr = arrSelectedIndex.map(String.init).joined(separator: ", ")
            
        }
        
        //NotificationCenter.default.addObserver(self, selector: #selector(genreList(_:)), name: Notification.Name(rawValue: "genreAddPost"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        callCurrencyListWebService()
        
    }
    
    func setUpVw(){
         
        currencyVw.layer.cornerRadius = 10.0
        currencyVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        currencyVw.layer.borderWidth = 0.5
        currencyVw.clipsToBounds = true
        
        priceVw.layer.cornerRadius = 10.0
        priceVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        priceVw.layer.borderWidth = 0.5
        priceVw.clipsToBounds = true
        
        restrictionVw.layer.cornerRadius = 10.0
        restrictionVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        restrictionVw.layer.borderWidth = 0.5
        restrictionVw.clipsToBounds = true
        
        genreVw.layer.cornerRadius = 10.0
        genreVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        genreVw.layer.borderWidth = 0.5
        genreVw.clipsToBounds = true
        
        currencyTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Currency",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        priceTxtFld.delegate = self
        priceTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Price",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        restrictionTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Restrictions",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == priceTxtFld{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            }
            else if textField.text!.count > 5 {
                return false
            }
        }
        return true
    }
    
    func callCurrencyListWebService(){
//        if(UserModel.sharedInstance().currency_name == ""){
//            if(UserModel.sharedInstance().setCurrencyNameSt == "$"){
//                UserModel.sharedInstance().currency_name = "$"
//            }
//            else{
//                UserModel.sharedInstance().currency_name = "₹"
//            }
//        }
        
        if(UserModel.sharedInstance().currency_name == ""){
            self.currencyTxtFld.text = "USD"
            self.lblCurrencySymbol.text = "$"
            UserModel.sharedInstance().currency_name = "USD"
            UserModel.sharedInstance().userCurrency = "$"
            UserModel.sharedInstance().currency_id  = "1"
            self.currencyIndex = "1"
            UserModel.sharedInstance().synchroniseData()
        }
        else{
        if(UserModel.sharedInstance().currency_name == "IN"){
            UserModel.sharedInstance().currency_name = "INR"
            self.currencyTxtFld.text = "INR"
        }
        else{
        self.currencyTxtFld.text = UserModel.sharedInstance().currency_name
        }
        //self.lblPrice.text = "Price(" + self.txfCurrency.text! + ")"
        self.lblCurrencySymbol.text = UserModel.sharedInstance().userCurrency
        
        print("currency",UserModel.sharedInstance().currency_id ?? "")
        self.currencyIndex = UserModel.sharedInstance().currency_id ?? ""
        }
    }
    
    //MARK: - OTHER METHODS
    func GetGenreList() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.getGenreAPI)?token=&userid="
            
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GenreModel>) in
                
                switch response.result {
                case .success(_):
                    let GenreModel = response.result.value!
                    if GenreModel.success == 1{
                        Loader.shared.hide()
                        self.arrGenrelist = GenreModel.genreList!
                        self.genreCollectionVw.reloadData()
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(GenreModel.message)
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
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        
        var sendDate = String()
        if dateSelected != "" {
            let formatter = DateFormatter()
            formatter.dateFormat =  "MMM d, yyyy"
            let date = formatter.date(from: dateSelected)
            formatter.dateFormat = "yyyy-MM-dd"
            sendDate = formatter.string(from: date!).localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            sendDate = formatter.string(from: Date ()).localToUTC(incomingFormat: "yyyy-MM-dd", outGoingFormat: "yyyy-MM-dd")
        }
        
        if(priceTxtFld.text?.isEmpty == true){
            self.view.makeToast("Enter Price".localize)
        }
        else if(restrictionTxtFld.text?.isEmpty == true){
            self.view.makeToast("Enter Restriction".localize)
        }
        //setGenreIdStr
        else if(setGenreIdStr == nil){
            self.view.makeToast("Enter Song Genre".localize)
        }
        else{
        if GlobalId.id == "1" {
            if(priceTxtFld.text?.isEmpty != true && UserModel.sharedInstance().userCurrency == "₹"){
                let txtPrice = priceTxtFld.text
                let setSprice = Int(txtPrice!)
                if(setSprice! < 50){
                    self.view.makeToast("Price atleast ₹50".localize)
                }
                else{
                    //callSaveProjectWebService()
                    moveToAddPostScreen(sendDate: sendDate)
                }
            }
            else if(priceTxtFld.text?.isEmpty != true){
                let txtPrice = priceTxtFld.text
                let setSprice = Int(txtPrice!)
                if(setSprice! < 1){
                    self.view.makeToast("Price atleast $1".localize)
                }
                else{
                   // callSaveProjectWebService()
                    moveToAddPostScreen(sendDate: sendDate)
                }
            }
        }else
        {
            
            //setGenreIdStr = arrSelectedIndex.joined(separator: ", ")
            //let genre = arrSelectedIndex.map(String.init)
            setGenreIdStr = arrSelectedIndex.map(String.init).joined(separator: ", ")
            print("setGenreIdStr",setGenreIdStr)
            if(priceTxtFld.text?.isEmpty != true && UserModel.sharedInstance().userCurrency == "₹"){
                let txtPrice = priceTxtFld.text
                let setSprice = Int(txtPrice!)
                if(setSprice! < 50){
                    self.view.makeToast("Price atleast ₹50".localize)
                }
                else{
                //callPostProjectWebService()
                    moveToAddPostScreen(sendDate: sendDate)
                }
            }
            else if(priceTxtFld.text?.isEmpty != true){
                let txtPrice = priceTxtFld.text
                let setSprice = Int(txtPrice!)
                if(setSprice! < 1){
                    self.view.makeToast("Price atleast $1".localize)
                }
                else{
                //callPostProjectWebService()
                    moveToAddPostScreen(sendDate: sendDate)
                }
            }
            
        }
        
        }
    }
    
    func moveToAddPostScreen(sendDate : String){
        let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "AdditionalInfoVC") as! AdditionalInfoVC
        
        desiredViewController.getPrjectNameStr = getPrjectNameStr
        desiredViewController.getPrjectDEtailStr = getPrjectDEtailStr
        desiredViewController.getProjImage = getProjImage
        desiredViewController.prjectTypeStr = prjectTypeStr
        desiredViewController.projectTypeIndex = projectTypeIndex
        desiredViewController.expectedAudienceStr = expectedAudienceStr
        desiredViewController.venueName = venueName
        desiredViewController.venueAddrss = venueAddrss
        desiredViewController.strtxfEventDateTime = strtxfEventDateTime
        desiredViewController.newSelecttimee = newSelecttimee
        desiredViewController.priceStr = priceTxtFld.text!
        desiredViewController.currencyIndex = currencyIndex
        desiredViewController.restrictionStr = restrictionTxtFld.text!
        desiredViewController.genreIds = setGenreIdStr!
        desiredViewController.sendDate = sendDate
        desiredViewController.addFlag = addFlag
        desiredViewController.txtAdditnlInfoStr = txtAdditnlInfoStr
        desiredViewController.txtLatStr = txtLatStr
        desiredViewController.txtLongStr = txtLongStr
        navigationController?.pushViewController(desiredViewController, animated: false)
    }
    
    
    @IBAction func btnRestrictnTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        restriction.dataSource = ["No Restrictions (Explicit songs accepted)","No Restrictions (No time limit for song)","Restriction (No explicit material)","Restriction (Time limit for song)"]
        restriction.width = restrictionVw.frame.size.width
        restriction.show()
        restriction.direction = .any
        restriction.bottomOffset = CGPoint(x: 0, y: 65)
    }
    
}

extension ConnectInfoVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrGenrelist.count
            
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        
        cell.genreNameLbl.text = arrGenrelist[indexPath.row].title!
//        cell.btnProjControl.addTarget(self, action: #selector(btnProjControl_Action(_:)), for: .touchUpInside)
       
        cell.cellBgVw.layer.cornerRadius = 22
        cell.cellBgVw.layer.borderColor = UIColor.white.cgColor
        cell.cellBgVw.layer.borderWidth = 1
        cell.cellBgVw.clipsToBounds = true
        cell.cellBgVw.backgroundColor = .clear
        
        if arrSelectedIndex.contains(arrGenrelist[indexPath.row].id!){
            cell.genreNameLbl.backgroundColor = UIColor(red: 155 / 255, green: 70 / 255, blue: 191 / 255, alpha: 1)
        }else{
            cell.genreNameLbl.backgroundColor = UIColor(red: 57/255, green: 36/255, blue: 82/255, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if let genreIndexID = arrSelectedIndex.firstIndex(where: {$0 == arrGenrelist[indexPath.row].id}){
            arrSelectedIndex.remove(at: genreIndexID)
        }else{
            arrSelectedIndex.append(arrGenrelist[indexPath.row].id!)
        }
        print("arrSelectedIndex",arrSelectedIndex)
        genreCollectionVw.reloadData()
        
        setGenreIdStr = arrSelectedIndex.map(String.init).joined(separator: ", ")
        print("setGenreIdStr","\(setGenreIdStr)")
    }

}
