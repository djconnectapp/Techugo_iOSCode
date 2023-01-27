//
//  djFavoriteMenuVC.swift
//  DJConnect
//
//  Created by mac on 11/12/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

//common cv
class djCVDetails : UICollectionViewCell {
    
    @IBOutlet weak var imgImage1: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnUserProfile: UIButton!
}
//project cv
class artistCVDetails : UICollectionViewCell{
    
    @IBOutlet weak var imageViewOutlet: imageProperties!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnViewProject: UIButton!
}

//faved me cv
class favedMeDetails : UICollectionViewCell{
    @IBOutlet weak var imgProfileImage: imageProperties!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnAddAdded: UIButton!
    @IBOutlet weak var btnUserProfile: UIButton!
}

class FavoriteMenuVC: UIViewController{
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblReflectSelection: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var btnFirst: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    @IBOutlet weak var lblThird: UILabel!
    
    @IBOutlet weak var cvDj: UICollectionView!
    @IBOutlet weak var cvProject: UICollectionView!
    @IBOutlet weak var cvFavedMe: UICollectionView!
    @IBOutlet weak var lblFavMain: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblline1: UILabel!
    @IBOutlet weak var lblline2: UILabel!
    @IBOutlet weak var lblline3: UILabel!
    @IBOutlet weak var lblMenuNotifyNumber: labelProperties!
    
    //MARK: - ENUM
    enum selectLabel {
        case dj
        case artist
    }
    
    //MARK: - GLOBAL VARIABLES
    
    var selectedLabel = selectLabel.artist
    
    //dj cv variables
    let imgArray = ["user-profile","user-profile","user-profile","user-profile"]
    let nameArray = ["Martin", "Zyan", "Snake","Zedd"]
    
    //artist cv variables
    var typeofUser = String()
    var favData = [FavoriteData]()
    var projData = [FavoriteData]()
    var favedMeData = [favedMeDataDetail]()
    var removeId = String()
    var projectIdStr = String()
    var profileId = String()
    var FavUserId = String()
    var FavedMeUserId = String()
    var AddUserId = String()
    var AddUserType = String()
    var indexPathRow = Int()
    var vc2 = ArtistProjectDetailVC()
    var isFromNotification = false
    
    //MARK: - UIView Controller Life Cycles.
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFavMain.text = "favorite main".localize
        userSelection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        lblMenuNotifyNumber.addGestureRecognizer(tap)
        lblline1.isHidden = false
        lblline2.isHidden = true
        lblline3.isHidden = true
        cvFavedMe.isHidden = true
        cvDj.isHidden = false
        cvProject.isHidden = true
        
        if UserModel.sharedInstance().userType == "DJ"{
            callFavoriteWebservice(type: "AR")
        }else{
            callFavoriteWebservice(type: "DJ")
        }
        
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
    
    //MARK: - OTHER METHODS
    func userSelection() {
        if UserModel.sharedInstance().userType == "DJ" {
            btnFirst.setTitle("fav artist".localize, for: .normal)
            btnSecond.setTitle("fav dj".localize, for: .normal)
            lblThird.text = "Faved Me".localize
        }else {
            btnFirst.setTitle("fav dj".localize, for: .normal)
            btnSecond.setTitle("fav project".localize, for: .normal)
            lblThird.text = "Faved Me".localize
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnBackAction(_ sender: UIButton) {
        if isFromNotification{
            backNotificationView()
        }else{
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
    }
    
    @IBAction func btnMenu_Action(_ sender: UIButton) {
        toggleSideMenuView()
    }
    
    @IBAction func btnfirst_Action(_ sender: UIButton) {
        favData.removeAll()
        cvDj.reloadData()
        lblline1.isHidden = false
        lblline2.isHidden = true
        lblline3.isHidden = true
        cvFavedMe.isHidden = true
        cvDj.isHidden = false
        cvProject.isHidden = true
        
        if UserModel.sharedInstance().userType == "DJ" {
            typeofUser = "AR"
            callFavoriteWebservice(type: "AR")
            
        }else {
            typeofUser = "DJ"
            callFavoriteWebservice(type: "DJ")
            
        }
        
    }
    
    @IBAction func btnsecond_Action(_ sender: UIButton) {
        lblline1.isHidden = true
        lblline2.isHidden = false
        lblline3.isHidden = true
        
        if UserModel.sharedInstance().userType == "DJ" {
            favData.removeAll()
            cvDj.reloadData()
            cvFavedMe.isHidden = true
            cvDj.isHidden = false
            cvProject.isHidden = true
            typeofUser = "DJ"
            callFavoriteWebservice(type: "DJ")
        }else {
            cvFavedMe.isHidden = true
            cvDj.isHidden = true
            cvProject.isHidden = false
            typeofUser = "project"
            callFavProjectListWebService(type: "project")
        }
    }
    
    @IBAction func btnthird_Action(_ sender: UIButton) {
        lblline1.isHidden = true
        lblline2.isHidden = true
        lblline3.isHidden = false
        cvProject.isHidden = true
        cvFavedMe.isHidden = false
        cvDj.isHidden = true
        callFavedMeWebService()
    }
    
    //MARK:- SELECTOR METHODS
    @objc func btnRemove_Action(_ sender:UIButton){
        removeId = "\(favData[sender.tag].userid!)"
        projectIdStr = "\(favData[sender.tag].projectid!)"
        print("removeId", removeId)
        callRemovefromfavlistWebService(sender.tag)
    }
    
    @objc func btnRemoveProj_Action(_ sender: UIButton){
        removeId = "\(projData[sender.tag].projectid!)"
       // removeId = "\(projData[sender.tag].userid!)"
       // projectIdStr = "\(favData[sender.tag].projectid!)"
        callRemovefromProjlistWebService(sender.tag)
    }
    
    @objc func btnViewProj_Action(_ sender: UIButton){
        let projectId = projData[sender.tag].projectid!
        let storyboard = UIStoryboard(name: "ArtistProfile", bundle: Bundle.main)
        vc2 = storyboard.instantiateViewController(withIdentifier: "ArtistProjectDetailVC") as! ArtistProjectDetailVC
        vc2.delegate = self
        vc2.projectId = "\(projectId)"
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc2, animated: false)    }
    
    @objc func btnUserProfile_Action(_ sender: UIButton){
        FavUserId = "\(favData[sender.tag].userid!)"
        if typeofUser == "DJ"{
            let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "CalendarVC") as? CalendarVC
            sideMenuController()?.setContentViewController(next1!)
            next1?.viewerId = FavUserId
            next1?.searchUserType = typeofUser
        }else{
            let storyBoard = UIStoryboard(name: "ArtistProfile", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as? ArtistViewProfileVC
            sideMenuController()?.setContentViewController(next1!)
            next1?.viewerId = FavUserId
            next1?.searchUserType = typeofUser
        }
    }
    
    @objc func btnUserProfileFaved_Action(_ sender: UIButton){
        FavedMeUserId = "\(favedMeData[sender.tag].userid!)"
        typeofUser = favedMeData[sender.tag].usertype!
        if typeofUser == "DJ"{
            let storyBoard = UIStoryboard(name: "DJProfile", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "CalendarVC") as? CalendarVC
            next1?.viewerId = FavedMeUserId
            next1?.searchUserType = typeofUser
            next1?.isFromMenu = true
            sideMenuController()?.setContentViewController(next1!)
        }else{
            let storyBoard = UIStoryboard(name: "ArtistProfile", bundle: nil)
            let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistViewProfileVC") as? ArtistViewProfileVC
            next1?.viewerId = FavedMeUserId
            next1?.searchUserType = typeofUser
            sideMenuController()?.setContentViewController(next1!)
        }
    }
    
    @objc func btnAdd_Action(_ sender: UIButton){
        let indexPath = IndexPath(row: indexPathRow, section: 0)
        let cell1 = cvFavedMe.dequeueReusableCell(withReuseIdentifier: "cellFaved", for: indexPath) as! favedMeDetails
        if cell1.btnAddAdded.currentTitle == "Add?"{
            AddUserId = "\(favedMeData[sender.tag].userid!)"
            AddUserType = favedMeData[sender.tag].usertype!
            callFavedMeAddWebservice(id: AddUserId, tag: sender.tag)
        }
    }
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer){
        toggleSideMenuView()
    }
    
    //MARK: - WEBSERVICES
    func callFavoriteWebservice(type: String){
        if getReachabilityStatus(){
            if type == "AR"{
                self.lblReflectSelection.text = "0  " + "fav artist".localize
            }else{
                self.lblReflectSelection.text = "0   " + "fav dj".localize
            }
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getFavouriteDjListAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(type)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FavoriteModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let favoriteProfile = response.result.value!
                    if favoriteProfile.success == 1{
                        self.favData.removeAll()
                        if let data = favoriteProfile.userData{
                            if data.count > 0 {
                                self.favData = data
                                print("self.favData",self.favData)
                                print("self.favData.count",self.favData.count)
                                self.cvDj.reloadData()
                            }else{
                                self.favData.removeAll()
                                self.cvDj.reloadData()
                            }
                        }
                        if type == "AR"{
                            self.lblReflectSelection.text = "\(self.favData.count)   " + "fav artist".localize
                        }else{
                            self.lblReflectSelection.text = "\(self.favData.count)    " + "fav dj".localize
                        }
                    }else{
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callRemovefromfavlistWebService(_ index: Int){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "removeid":"\(removeId)",
                "favorites_type":"user"
                    
            ]
            print("parameters",parameters)
            
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.removeFavoriteAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let removefavProfile = response.result.value!
                    print("removefavProfile:", removefavProfile)
                    if removefavProfile.success == 0{
                        self.favData.remove(at: index)
                        self.cvDj.reloadData()
                        if self.typeofUser == "AR"{
                            self.lblReflectSelection.text = "\(self.favData.count)   " + "fav artist".localize
                            
                            self.callFavoriteWebservice(type: "DJ")
                        }else{
                            self.lblReflectSelection.text = "\(self.favData.count)    " + "fav dj".localize
                            self.callFavoriteWebservice(type: "DJ")
                        }
                    }else{
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callRemovefromProjlistWebService(_ index: Int){
        if getReachabilityStatus(){
            Loader.shared.show()
            
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "removeid":"\(removeId)",
                "favorites_type":"project"
            ]
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.removeFavoriteAPI)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let removefavProfile = response.result.value!
                    if removefavProfile.success == 1{
                        self.projData.remove(at: index)
                        self.cvProject.reloadData()
                        self.lblReflectSelection.text = "\(self.projData.count)    " + "fav project".localize
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(removefavProfile.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callFavedMeWebService(){
        if getReachabilityStatus(){
            self.lblReflectSelection.text = "0   " + "Faved Me".localize
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getFavedMeListAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FavedMeModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let favedMeProfile = response.result.value!
                    if favedMeProfile.success == 1{
                        if let favedData = favedMeProfile.userData{
                            self.favedMeData = favedData
                            self.cvFavedMe.reloadData()
                            self.lblReflectSelection.text = "\(self.favedMeData.count)    " + "Faved Me".localize
                        }
                    }else{
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callFavProjectListWebService(type: String){
        if getReachabilityStatus(){
            self.lblReflectSelection.text = "0   " + "fav project".localize
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getFavouriteDjListAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&user_type=\(type)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FavoriteProjModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let favoriteProfile = response.result.value!
                    if favoriteProfile.success == 1{
                        self.projData.removeAll()
                        if let data = favoriteProfile.userData {
                            
                            for pData in data{
                                let favData = FavoriteData(JSON: pData.toJSON())
                            print("favData:", favData)
                                print("favData.count:", favData)
                                favData!.name = pData.name
                                favData!.profile_pic = pData.profile_pic
                                favData!.userid = pData.userid
                                print("ProJectId",pData.projectid)
                                favData!.projectid = pData.projectid
                                self.projData.append(favData!)
                            }
                            self.cvProject.reloadData()
                            self.lblReflectSelection.text = "\(self.projData.count)    " + "fav project".localize
                        }
                    }else{
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callFavedMeAddWebservice(id: String, tag: Int){
        if getReachabilityStatus(){
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "favorite_by":"\(UserModel.sharedInstance().userId!)",
                "favorite_to":"\(id)",
                "favorite_type":"user"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addFavoriteAPI)?"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let favoriteProfile = response.result.value!
                    if favoriteProfile.success == 1{
                        self.callFavedMeWebService()
                        
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(favoriteProfile.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
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
}


//MARK: - EXTENSIONS
extension FavoriteMenuVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return favData.count
        }else if collectionView.tag == 1{
            return projData.count
        }else{
            return favedMeData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            // for ar/dj
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDj", for: indexPath) as! djCVDetails
            cell.btnRemove.tag = indexPath.row
            cell.btnRemove.addTarget(self, action: #selector(btnRemove_Action(_:)), for: .touchUpInside)
            cell.btnUserProfile.tag = indexPath.row
            cell.btnUserProfile.addTarget(self, action: #selector(btnUserProfile_Action(_:)), for: .touchUpInside)
            let profileImageUrl = URL(string: "\(favData[indexPath.row].profile_pic!)")
            cell.imgImage1.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            cell.lblName.text = favData[indexPath.row].name
            collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
            return cell
        }else if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellArtist", for: indexPath) as! artistCVDetails
            
            cell.btnViewProject.tag = indexPath.row
            cell.btnViewProject.addTarget(self, action: #selector(btnViewProj_Action(_:)), for: .touchUpInside)
            cell.btnRemove.tag = indexPath.row
            cell.btnRemove.addTarget(self, action: #selector(btnRemoveProj_Action(_:)), for: .touchUpInside)
            cell.lblName.text = projData[indexPath.row].name
            let profileImageUrl = URL(string: "\(projData[indexPath.row].profile_pic!)")
            cell.imageViewOutlet.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            
            collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
            return cell
        }else{
            // for faved me
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFaved", for: indexPath) as! favedMeDetails
            let profileImageUrl = URL(string: "\(favedMeData[indexPath.row].profile_pic!)")
            
            cell.btnUserProfile.tag = indexPath.row
            cell.btnUserProfile.addTarget(self, action: #selector(btnUserProfileFaved_Action(_ :)), for: .touchUpInside)
            
            cell.imgProfileImage.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            if favedMeData[indexPath.row].is_favorite! == "no"{
                cell.btnAddAdded.setTitle("Add?", for: .normal)
                cell.btnAddAdded.tag = indexPath.row
                cell.btnAddAdded.addTarget(self, action: #selector(btnAdd_Action(_:)), for: .touchUpInside)
                indexPathRow = indexPath.row
            }else{
                cell.btnAddAdded.setTitle("Added", for: .normal)
            }
            cell.lblName.text = favedMeData[indexPath.row].name
            collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width:(collectionView.frame.width)/2.2, height: 100)
        }else if collectionView.tag == 1{
            return CGSize(width:(collectionView.frame.width)/2.2, height: 160)
        }else{
            return CGSize(width: (collectionView.frame.width)/2.2, height: 120)
        }
    }
    
}

extension FavoriteMenuVC: artistDummyViewDelegate{
    func artistViewBtnCloseClicked() {
        toggleSideMenuView()
    }
    
    func artistViewBtnMenuClicked() {
        UIView.animate(withDuration: 0.5, animations: {
            self.vc2.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }) { (isCompleted) in
            self.vc2.willMove(toParent: nil)
            self.vc2.view.removeFromSuperview()
            self.vc2.removeFromParent()
        }
    }
}
