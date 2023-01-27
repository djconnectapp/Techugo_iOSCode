//
//  ProjectInfoViewController.swift
//  DJConnect
//
//  Created by Techugo on 29/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import AlamofireObjectMapper

class ProjectInfoViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var projectInfoLbl: UILabel!
    @IBOutlet weak var projctTypeBgVw: UIView!
    @IBOutlet weak var expctdAudinceBgVw: UIView!
    @IBOutlet weak var projectTypeTxtFld: UITextField!
    @IBOutlet weak var projctTypeBtn: UIButton!
    @IBOutlet weak var expectedAudienceTxtFld: UITextField!
    
    @IBOutlet weak var projectDownArwImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var projectTypeInstance = DropDown()
    var projectTypeIndex = Int()
    var projectTypeList = [projectTypeDataDetail]()
    var projecttypeName = String ()
    
    var getPrjectNameStr = String()
    var getPrjectDEtailStr = String()
    var getProjImage:UIImage?
    
    var projectId = String()
    var txtProjectTypeStr = String()
    var txtProjectTypeNameStr = String()
    var txtExpcaudStr = String()
    var txtVenueNameStr = String()
    var txtEventDateStr = String()
    var txtStartTimeStr = String()
    var txtVenueAdrsStr = String()
    var txtLatStr = String()
    var txtLongStr = String()
    var txtpriceStr = String()
    var txtRestricStr = String()
    var txtAdditnlInfoStr = String()
    var txtaddFlag = String()
    var txtofferFlag = String()
    var txteditfullAddress = String()
    var txteditsortAddress = String()
    var genreNames = String()
    var genreIds = String()
    
    @IBOutlet weak var projectTypeColctnVw: UIView!
    @IBOutlet weak var projectTypeColctn: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        projectTypeColctnVw.isHidden = true
        projectTypeColctnVw.backgroundColor = .black.withAlphaComponent(0.7)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: projectTypeColctn.frame.size.width / 4, height: 70)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        projectTypeColctn!.collectionViewLayout = layout
        
        
        projectTypeTxtFld.delegate = self
        
        projectTypeTxtFld.isEnabled = false
        expectedAudienceTxtFld.delegate = self
        
        projectTypeInstance.selectionAction = { [unowned self] (index: Int, item: String) in
            self.projectTypeIndex = index + 1
            if self.projectTypeInstance.selectedItem! == "Other"{
                self.projctTypeBtn.isHidden = true
                self.projectTypeTxtFld.isUserInteractionEnabled = true
                self.projectTypeTxtFld.isEnabled = true
                self.projectTypeTxtFld.text = ""
            }else{
                self.projctTypeBtn.isHidden = false
                self.projectTypeTxtFld.isEnabled = false
                self.projectTypeTxtFld.text = self.projectTypeInstance.selectedItem
            }
        }
        setUpVw()
        if GlobalId.id == "1"{
            projectTypeTxtFld.text = txtProjectTypeStr
            expectedAudienceTxtFld.text = txtExpcaudStr
        }
        callProjectTypeWebService()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        //callCurrencyListWebService()
        
//        picker1.minimumDate = postDate
//        picker1.maximumDate = getMaximumDate(startDate: postDate, addbyUnit: .day, value: 7)
//        if UserModel.sharedInstance().appLanguage == "0"{
//            btnBack.setImage(UIImage(named: "back_arrow_arabic"), for: .normal)
//        }else{
//            btnBack.setImage(UIImage(named: "back_arrow_english"), for: .normal)
//        }
    }
    
    func setUpVw(){
         
        projctTypeBgVw.layer.cornerRadius = 10.0
        projctTypeBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        projctTypeBgVw.layer.borderWidth = 0.5
        projctTypeBgVw.clipsToBounds = true
        
        expctdAudinceBgVw.layer.cornerRadius = 10.0
        expctdAudinceBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        expctdAudinceBgVw.layer.borderWidth = 0.5
        expctdAudinceBgVw.clipsToBounds = true
        
        projectTypeTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Enter Your Type",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        
        expectedAudienceTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Expected Audience",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
        expectedAudienceTxtFld.keyboardType = .numberPad
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == expectedAudienceTxtFld{
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
    
    func callProjectTypeWebService(){
        if getReachabilityStatus(){
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectTypeAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetProjectTypeList>) in
                
                switch response.result {
                case .success(_):
                    let projectTypeProfile = response.result.value!
                    if projectTypeProfile.success == 1{
                        self.projectTypeList = projectTypeProfile.projectTypeData!
                        let EditData = [String]()
                        let editDataName = self.txtProjectTypeNameStr
                        print("editProjectType",editDataName)
                        if(editDataName == ""){
                            self.projectTypeTxtFld.text = self.projectTypeList[0].project_type
                            self.projectTypeIndex = 0 + 1
                        }
                        for i in 0..<self.projectTypeList.count{
                            
                            if editDataName == "\(self.projectTypeList[i].project_type!)"{
                                self.projectTypeIndex = Int((self.projectTypeList[i].project_type_id!))
                            }else{
                                
                            }
                           
                        }
                        self.projectTypeInstance.dataSource = EditData
                        var data = [String]()
                        for i in 0..<self.projectTypeList.count{
                            data.append(self.projectTypeList[i].project_type!)
                        }
                        self.projectTypeInstance.dataSource = data
                        //self.projectTypeColctn.reloadData()
                    }else{
                        //self.view.makeToast(projectTypeProfile.message)
                        if projectTypeProfile.success == 0{
                            if(projectTypeProfile.message == "You are not authorised. Please login again."){
                                                        self.view.makeToast("You are not authorised. Please login again.")
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                                                self.userLogout("\(UserModel.sharedInstance().userId!)", "\(UserModel.sharedInstance().token!)")
                                                            })
                            }else{
                                self.view.makeToast(projectTypeProfile.message)
                            }
                        }
                    }
                case .failure(let error):
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
    
    @IBAction func nxtBtnTapped(_ sender: Any) {
        if(projectTypeTxtFld.text?.isEmpty == true){
            self.view.makeToast("Enter Project Type".localize)
        }else if(expectedAudienceTxtFld.text?.isEmpty == true){
            self.view.makeToast("Enter Expected Audiance".localize)
        }
        else{
        let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "VenuInfoViewController") as! VenuInfoViewController
        desiredViewController.getPrjectNameStr = getPrjectNameStr
        desiredViewController.getPrjectDEtailStr = getPrjectDEtailStr
        desiredViewController.getProjImage = getProjImage
        desiredViewController.prjectTypeStr = projectTypeTxtFld.text!
        desiredViewController.expectedAudienceStr = expectedAudienceTxtFld.text!
        desiredViewController.projectTypeIndex = String(projectTypeIndex)
            
            
            desiredViewController.projectId = projectId
           // desiredViewController.txtProjectTypeStr = txtProjectTypeStr
           // desiredViewController.txtProjectTypeNameStr = txtProjectTypeNameStr
           // desiredViewController.txtExpcaudStr = txtExpcaudStr
            desiredViewController.txtVenueNameStr = txtVenueNameStr
            desiredViewController.txtEventDateStr = txtEventDateStr
            desiredViewController.txtStartTimeStr = txtStartTimeStr
            desiredViewController.txtVenueAdrsStr = txtVenueAdrsStr
            desiredViewController.txtLatStr = txtLatStr
            desiredViewController.txtLongStr = txtLongStr
            desiredViewController.txtpriceStr = txtpriceStr
            desiredViewController.txtRestricStr = txtRestricStr
            desiredViewController.txtAdditnlInfoStr = txtAdditnlInfoStr
            desiredViewController.txtaddFlag = txtaddFlag
            desiredViewController.txtofferFlag = txtofferFlag
            desiredViewController.txteditfullAddress = txteditfullAddress
            desiredViewController.txteditsortAddress = txteditsortAddress
            desiredViewController.genreNames = genreNames
            desiredViewController.genreIds = genreIds
            
        navigationController?.pushViewController(desiredViewController, animated: false)
        }
    }
    
    @IBAction func projctTypeBtnTapped(_ sender: Any) {
        self.view.endEditing(true)
        projectTypeInstance.width = projctTypeBgVw.frame.size.width
        projectTypeInstance.show()
        projectTypeInstance.direction = .any
        projectTypeInstance.bottomOffset = CGPoint(x: 0, y: -50)
        //projectTypeColctnVw.isHidden = false
    }
}

extension ProjectInfoViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.projectTypeList.count
            
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectTypeGenreCVC", for: indexPath) as! ProjectTypeGenreCVC
        
        cell.projcrTypeLbl.text = self.projectTypeList[indexPath.row].project_type ?? ""
       
        cell.projctTypeColctnBgVw.layer.cornerRadius = cell.projctTypeColctnBgVw.frame.size.height/2
        cell.projctTypeColctnBgVw.layer.borderColor = UIColor.white.cgColor
        cell.projctTypeColctnBgVw.layer.borderWidth = 1
        cell.projctTypeColctnBgVw.clipsToBounds = true
        //cell.projctTypeColctnBgVw.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        self.projectTypeIndex = indexPath.row + 1
        if self.projectTypeList[indexPath.row].project_type == "Other"{
            self.projctTypeBtn.isHidden = true
            self.projectTypeTxtFld.isUserInteractionEnabled = true
            self.projectTypeTxtFld.isEnabled = true
            self.projectTypeTxtFld.text = ""
            projectTypeColctnVw.isHidden = true
        }else{
            self.projctTypeBtn.isHidden = false
            self.projectTypeTxtFld.isEnabled = false
            self.projectTypeTxtFld.text = self.projectTypeList[indexPath.row].project_type
            projectTypeColctnVw.isHidden = true
        }
    }

}

