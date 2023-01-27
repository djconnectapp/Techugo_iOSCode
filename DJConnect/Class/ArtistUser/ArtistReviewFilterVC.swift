//
//  ArtistReviewFilterVC.swift
//  DJConnect
//
//  Created by My Mac on 19/03/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class ArtistReviewFilterVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet var vwFilter: UIView!
    @IBOutlet weak var tblGenre: UITableView!
    @IBOutlet weak var btnMiles: buttonProperties!
    @IBOutlet weak var songGenreTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lblMaxPrice: UILabel!
    @IBOutlet weak var pickerMaximumValue: UIPickerView!
    @IBOutlet weak var lblMAxConnect: UILabel!
    @IBOutlet weak var connectLimitPickerHeight: NSLayoutConstraint!
    @IBOutlet weak var btnFilterReset: UIButton!
    @IBOutlet weak var btnFilterSave: UIButton!
    @IBOutlet weak var btnBackGround: UIButton!
    
    @IBOutlet weak var vwFilterLeading: NSLayoutConstraint!
    //MARK:- GLOBAL VARIABLE
    var milesDropDown = DropDown()
    var filterMiles = String()
    var arrgenrelist = [GenreData]()
    var connectLimit = ["$80,000","$90,000","$100,000","no limit","$10","$20","$30"]
    var filterPrice = String()
    var filtergenreIndex = [String]()
    var genreArrayCleaned = String()
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnFilterSave.isEnabled = true
        //self.btnMiles.setTitle("All", for: .normal)
        setupData()
        //self.btnMiles.setTitle("All", for: .normal)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if UserModel.sharedInstance().appLanguage == "1"{
            UIView.animate(withDuration: 0.35, animations: {
                let moveLeft = CGAffineTransform(translationX: 0.0, y: 0.0)
                self.vwFilter.transform = moveLeft
            })
        }else{
            popupAnimation_Action(vwFilterLeading)
        }
        
    }
    
    func popupAnimation_Action(_ con : NSLayoutConstraint){
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.0, animations: {
            con.constant = 0
            self.view.layoutIfNeeded()
        }) { (completion) in
            
        }
    }
    
    //MARK:- BUTTON ACTION
    @IBAction func btnFilterSave_Action(_ sender: UIButton) {
        //btnFilterSave.isEnabled = false
        btnFilterReset.isEnabled = false
        genreArrayCleaned = filtergenreIndex.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
        if UserModel.sharedInstance().userType == "AR"{
            
            let url = "userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&usertype=\(UserModel.sharedInstance().userType!)&latitude=\(UserModel.sharedInstance().currentLatitude ?? 0)&longitude=\(UserModel.sharedInstance().currentLongitude ?? 0)&radius=\(filterMiles)&genre=\(genreArrayCleaned)&maxPrice=\(filterPrice)&minPrice=0"
            let userdic = ["url" : url]
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "saveReviewMapFilter"), object: nil, userInfo: userdic)
        }
        UIView.animate(withDuration: 0.35, animations: {
            let moveRight = CGAffineTransform(translationX: -(self.vwFilter.bounds.width), y: 0.0)
            self.vwFilter.transform = moveRight
        }, completion: {
            (value: Bool) in
            self.dismiss(animated: false, completion: nil)
        })
        
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnFilterResetAction(_ sender: UIButton) {
        lblMaxPrice.text = "click to enter"
        filterPrice = ""
        //ashitesh
        //self.btnMiles.setTitle("10 miles", for: .normal)
        self.btnMiles.setTitle("All", for: .normal)
        for i in 0..<arrgenrelist.count{
            let indexPath1 = IndexPath(row: i, section: 0)
            let cell = tblGenre.cellForRow(at: indexPath1) as? FilterSongGenreTableViewCell
            
            if(cell != nil)
            {
                cell!.imgSongeGenre.image = UIImage(named: "ArtistFilter3")
            }
        }
    }
    
    @IBAction func btnBack_Action(_ sender: Any) {
        UIView.animate(withDuration: 0.35, animations: {
            let moveRight = CGAffineTransform(translationX: -(self.vwFilter.bounds.width), y: 0.0)
            self.vwFilter.transform = moveRight
        }, completion: {
            (value: Bool) in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func btnClose_Action(_ sender: UIButton) {
        UIView.animate(withDuration: 0.35, animations: {
            let moveRight = CGAffineTransform(translationX: -(self.vwFilter.bounds.width), y: 0.0)
            self.vwFilter.transform = moveRight
        }, completion: {
            (value: Bool) in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func btnSetMilesAction(_ sender: buttonProperties) {
        milesDropDown.anchorView = btnMiles
        milesDropDown.dataSource = ["10 Miles".localize,"20 Miles".localize,"30 Miles".localize,"40 miles".localize,"50 Miles".localize,"All"]
        milesDropDown.show()
        milesDropDown.width = btnMiles.frame.width
        milesDropDown.direction = .bottom
        milesDropDown.bottomOffset = CGPoint(x: 0, y:(milesDropDown.anchorView?.plainView.bounds.height)!)
    }
    
    //MARK:- OTHER ACTIONS
    func filterAnimation(){
        UIView.animate(withDuration: 0.35, animations: {
            let moveLeft = CGAffineTransform(translationX: -(self.vwFilter.bounds.width), y: 0.0)
            self.vwFilter.transform = moveLeft
        })
    }
    
    func setupData(){
//        self.btnMiles.setTitle("10 miles", for: .normal)
        self.btnMiles.setTitle("All", for: .normal)
        filterAnimation()
        GetGenreList()
        milesDropDownSelection()
    }
    
    func milesDropDownSelection(){
        milesDropDown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.btnFilterSave.isUserInteractionEnabled = true
            self.btnFilterSave.isEnabled = true
            self.btnMiles.setTitle(self.milesDropDown.selectedItem, for: .normal)
            if index == 0{
                self.filterMiles = "10"
            }else if index == 1{
                self.filterMiles = "20"
            }else if index == 2{
                self.filterMiles = "30"
            }else if index == 3{
                self.filterMiles = "40"
            }else if index == 4{
                self.filterMiles = "50"
            }else if index == 5{
                self.filterMiles = "all"
            }else{
                self.filterMiles = "10"
            }
        }
    }
    
    //MARK:- WEBSERVICE CALLING
    func GetGenreList() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.getGenreAPI)?token=\(UserModel.sharedInstance().token!)&userid=\(UserModel.sharedInstance().userId!)"
            
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GenreModel>) in
                
                switch response.result {
                case .success(_):
                    let GenreModel = response.result.value!
                    if GenreModel.success == 1{
                        Loader.shared.hide()
                        self.arrgenrelist = GenreModel.genreList!
                        self.tblGenre.reloadData()
                        self.songGenreTableHeight.constant = self.tblGenre.contentSize.height
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
}

extension ArtistReviewFilterVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrgenrelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songGenrecell", for: indexPath) as? FilterSongGenreTableViewCell else {
            return UITableViewCell()
        }
        cell.lblSongGenre.text = arrgenrelist[indexPath.row].title!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterSongGenreTableViewCell
        cell.selectionStyle = .none
        
        if (cell.imgSongeGenre.image == UIImage(named: "ArtistFilter4")){
            cell.imgSongeGenre.image = UIImage(named: "ArtistFilter3")
            cell.lblSongGenre.textColor = .white
            filtergenreIndex = filtergenreIndex.filter{ $0 != "\(arrgenrelist[indexPath.row].id!)" }
            tableView.deselectRow(at: indexPath, animated: true)
        }else{
            filtergenreIndex.append("\(self.arrgenrelist[indexPath.row].id!)")
            cell.imgSongeGenre.image = UIImage(named: "ArtistFilter4")
            cell.lblSongGenre.textColor = .white
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        btnFilterSave.isEnabled = true
        btnFilterReset.isEnabled = true
    }
}

extension ArtistReviewFilterVC : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return connectLimit.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return connectLimit[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblMAxConnect.text = "Connect limit - The most I would like to pay for a connect is:                                 .                            "
        lblMaxPrice.text = connectLimit[row]
        filterPrice = connectLimit[row]
        pickerMaximumValue.isHidden = true
        connectLimitPickerHeight.constant = 10
    }
}
