//
//  ArtistConnectedVC.swift
//  DJConnect
//
//  Created by mac on 10/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

//class connectedArtistDetails : UITableViewCell {
//
//    @IBOutlet weak var imgArtistProfile: imageProperties!
//    @IBOutlet weak var lblArtistSongName: UILabel!
//    @IBOutlet weak var lblArtistName: UILabel!
//    @IBOutlet weak var lblArtistMusicGenre: UILabel!
//    @IBOutlet weak var btnArtistConnectPlay: UIButton!
//    @IBOutlet weak var btnDownload: UIButton!
//    @IBOutlet weak var btnVerify: UIButton!
//    @IBOutlet weak var lblVideoSongStatus: UILabel!
//    @IBOutlet weak var lblProjectAmount: UILabel!
//    @IBOutlet weak var imgVideoThumbnail: UIImageView!
//    @IBOutlet weak var btnBack: UIButton!
//    @IBOutlet weak var btnKeep: UIButton!
//    @IBOutlet weak var vwBackKeep: UIView!
//
//}

protocol artistConnectedViewDelegate: class {
    func dummyViewBtnCloseClicked()
    func dummyViewBtnMenuClicked()
}

class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = presentingViewController.view.bounds
        let size = CGSize(width: presentingViewController.view.frame.size.width, height: presentingViewController.view.frame.size.height - 100)
        let origin = CGPoint(x: 0, y: 100)
        return CGRect(origin: origin, size: size)
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        presentedView?.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin
        ]

        presentedView?.translatesAutoresizingMaskIntoConstraints = true
    }
}

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class ArtistConnectedVC: UIViewController {
    
    private var customTransitioningDelegate = TransitioningDelegate()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblNoOfArtistConnected: UILabel!
    @IBOutlet weak var tblArtistConnected: UITableView!
    
    
    //MARK: - GLOBAL VARIABLES
    weak var delegate: artistConnectedViewDelegate?
    var projectId = String()
    var acceptArray = [appliedAudioDataDetail]()
    var artist_ID = String()
    var audioID = String()
    var projName = String()
    var widthVC = Int()
    var heightVC = Int()
    var stringArrayCleaned = String()
    var acceptArrayId = [String]()
    var currentCurrency = String()
    var projCost = String()
    var playList = [String]()
    var currentIndex = Int()
    var broadcastId = String()
    var mediaId = String()
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblProjectName.text = projName
//        NotificationCenter.default.addObserver(self, selector: #selector(setRecordedView(_:)), name: Notification.Name(rawValue: "isBroadcast"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(setRecordedView(_:)), name: Notification.Name(rawValue: "isBroadcast"), object: nil)
        callArtistConnectedStatusWebService()

    }
    
    //MARK: - ACTIONS
    @IBAction func btnCloseAction(_ sender: UIButton) {
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.reveal
//        transition.subtype = CATransitionSubtype.fromBottom
//        navigationController?.view.layer.add(transition, forKey: nil)
//        navigationController?.popViewController(animated: false)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnChangeOrder(_ sender: UIButton) {
        tblArtistConnected.isEditing = !tblArtistConnected.isEditing
        if tblArtistConnected.isEditing == false{
            callSetOrderWebservice()
        }
    }
    
    //MARK: - OTHER METHODS

    func setPlayer(index: Int){
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MusicPlayerVC") as! MusicPlayerVC
        controller.playList = playList
        controller.index = index
        //    navigationController?.pushViewController(controller, animated: true)
        self.present(controller, animated: true, completion: {
            //
        })
    }
    
    //MARK: - SELECTOR METHODS
    @objc func btnArtistSongDownload_Action(_ sender: UIButton){
        
        let alert1 = UIAlertController(title: "Download?", message: "Choose download option from below.", preferredStyle: .alert)
        
        let email =  UIAlertAction(title: "Email Song", style: .default) { (ACTION) in
            let song_id = self.acceptArray[sender.tag].audioid!
            self.callEmailSongWebservice(songId: song_id)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (ACTION) in
            
        }
        alert1.addAction(email)
        alert1.addAction(cancel)
        self.present(alert1, animated: true, completion: nil)
        
        
    }
    
    @objc func btnGoLive_Action(_ sender: UIButton){
        currentIndex = sender.tag
        artist_ID = acceptArray[sender.tag].artistid!
        audioID = acceptArray[sender.tag].audioid!
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc1 = storyboard.instantiateViewController(withIdentifier: "VideoVerifyVC") as! VideoVerifyVC
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.moveIn
//        transition.subtype = CATransitionSubtype.fromTop
//        vc1.artist_id = artist_ID
//        vc1.project_id = projectId
//        vc1.media_Id = audioID
//        vc1.modalPresentationStyle = .custom
//        navigationController?.view.layer.add(transition, forKey: nil)
//        navigationController?.pushViewController(vc1, animated: false)
        
          performSegue(withIdentifier: "segueVideoVerify", sender: nil)
    }
    
    @objc func btnArtistAcceptPlay_Action(_ sender: UIButton){
        setPlayer(index: sender.tag)
    }
    
    @objc func setRecordedView(_ notification: Notification){
        if let isBroadcast = notification.userInfo!["isBroadcast"] as? Bool{
            if isBroadcast == true{
                let indexPath1 = IndexPath.init(row: currentIndex, section: 0)
                let cell = tblArtistConnected.cellForRow(at: indexPath1) as! connectedArtistDetails
                cell.vwBackKeep.isHidden = false
                cell.lblVideoSongStatus.isHidden = true
                
            }
        }
    }
    
    @objc func btnKeepAction(_ sender: UIButton){
        mediaId = acceptArray[sender.tag].audioid!
        //set broadcast id
        // broadcast_id =
        callDJLiveWebservice(b_Id: broadcastId, m_Id: mediaId)
    }
    
    @objc func btnBackAction(_ sender: UIButton){
        // send broadcast_id
        // broadcast_id =
        callDeleteWebService("\(broadcastId)")
    }
    
    //MARK: - OVERRIDE METHODS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueVideoVerify" {
            let destinationVC = segue.destination as! VideoVerifyVC
            destinationVC.artist_id = artist_ID
            destinationVC.project_id = projectId
            destinationVC.media_Id = audioID
        }
    }
    
    //MARK:- WEBSERVICES
    
    func callArtistConnectedStatusWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(Constant.web_url)get-applied-artist-audio.php?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)&audio_status=1"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<SongStatusModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let songStatusProfile = response.result.value!
                    if songStatusProfile.success == "1"{
                        self.acceptArray = songStatusProfile.appliedAudioData!
                        
                        //                        for i in 0..<self.acceptArray.count{
                        //                           // self.preparePlayer(URL(string: songStatusProfile.appliedAudioData![i].audiofile!))
                        //                        }
                        self.lblNoOfArtistConnected.text = "\(self.acceptArray.count) Artist Connected"
                        for i in 0..<self.acceptArray.count{
                            self.playList.append(self.acceptArray[i].audiofile!)
                        }
                        self.tblArtistConnected.reloadData()
                        
                    }else{
                        self.lblNoOfArtistConnected.text = "0 Artist Connected"
                        Loader.shared.hide()
                        
                        //    self.view.makeToast(songStatusProfile.message)
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
    
    func callEmailSongWebservice(songId : String){
        if getReachabilityStatus(){

            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "user_type":"\(UserModel.sharedInstance().userType!)",
                "audio_id":"\(songId)",
                "type":"project"
            ]
            Alamofire.request(getServiceURL("\(Constant.web_url)song-email.php"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let sentMailModel = response.result.value!
                    if sentMailModel.success == "1"{
                        self.view.makeToast(sentMailModel.message)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(sentMailModel.message)
                        
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
    
    func callSetOrderWebservice(){
        if getReachabilityStatus(){
            
            for i in 0..<acceptArray.count{
                acceptArrayId.append(acceptArray[i].audioid!)
            }
            
            stringArrayCleaned = acceptArrayId.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ",", with: ",").replacingOccurrences(of: "[", with: " ").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
            print(stringArrayCleaned)
            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "project_id":"\(projectId)",
                "id_order":"\(stringArrayCleaned)"
            ]
            Alamofire.request(getServiceURL("\(Constant.web_url)set-applied_audio_order.php"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let setOrderModel = response.result.value!
                    if setOrderModel.success == "1"{
                        self.view.makeToast(setOrderModel.message)
                        
                        //genre
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(setOrderModel.message)
                        
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
    
    func callDeleteWebService(_ brodcastID : String){
        if getReachabilityStatus(){
           
            let headers = [
                "Accept":"application/vnd.bambuser.v1+json",
                "Authorization":"Bearer GMSWiinwYhbj81RcnuhpP7"
            ]
             
            Loader.shared.show()
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(brodcastID)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                
                self.view.makeToast("Deleted Successfully")
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callDJLiveWebservice(b_Id : String, m_Id : String){
        if getReachabilityStatus(){

            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "dj_id":"\(UserModel.sharedInstance().userId!)",
                "artist_id":"\(artist_ID)",
                "project_id":"\(projectId)",
                "broadcastID":"\(b_Id)",
                "id_for_verify":"\(m_Id)",
                "type":"project"
            ]
            Alamofire.request(getServiceURL("\(Constant.web_url)add-dj-live.php"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let addLiveModel = response.result.value!
                    if addLiveModel.success == "1"{
                        self.view.makeToast(addLiveModel.message)
                        

                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(addLiveModel.message)
                        
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
    
    func callArtistVideoWebService(_ brodcastID : String, video_id : String){
        if getReachabilityStatus(){
            
            let headers = [
                "Content-Type":"application/json",
                "Accept":"application/vnd.bambuser.v1+json",
                "Authorization":"Bearer GMSWiinwYhbj81RcnuhpP7"
            ]
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("https://api.bambuser.com/broadcasts/\(brodcastID)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseObject { (response:DataResponse<VideoVerifyModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let videoModelProfile = response.result.value!
                    
                    let uri = videoModelProfile.resourceUri
                    let next1 = self.storyboard?.instantiateViewController(withIdentifier: "ArtistLiveVideoRecieveVC") as? ArtistLiveVideoRecieveVC
                    next1?.uri = uri!
                 //   next1?.isFromDj = true
                    //  next1?.id = brodcastID
                    next1?.id = video_id
                    self.sideMenuController()?.setContentViewController(next1!)
                case .failure(let error):
                    Loader.shared.hide()
                    self.view.makeToast("This broadcast was removed by user")
                    debugPrint(error)
                    print("Error")
                }
            }
        }else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
    }
    
    func callDeleteWebservice(b_Id : String){
        if getReachabilityStatus(){

            Loader.shared.show()
            let parameters = [
                "token":"\(UserModel.sharedInstance().token!)",
                "userid":"\(UserModel.sharedInstance().userId!)",
                "broadcastID":"\(b_Id)"
            ]
            Alamofire.request(getServiceURL("\(Constant.web_url)remove-dj-live.php"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let deleteModel = response.result.value!
                    if deleteModel.success == "1"{
                        self.view.makeToast(deleteModel.message)
                        

                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(deleteModel.message)
                        
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

//MARK: - EXTENSIONS
extension ArtistConnectedVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acceptArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectedArtistDetails", for: indexPath) as! connectedArtistDetails
        let profileImageUrl = URL(string: "\(acceptArray[indexPath.row].profilepicture!)")
        cell.imgArtistProfile.kf.setImage(with: profileImageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
        //   cell.artistConnectedSlider.setThumbImage(UIImage(named: "vertical-deviderline"), for: .normal)
        cell.btnArtistConnectPlay.tag = indexPath.row
        cell.btnArtistConnectPlay.addTarget(self, action: #selector(btnArtistAcceptPlay_Action(_:)), for: .touchUpInside)
        cell.btnDownload.tag = indexPath.row
        //  cell.btnDownload.setTitle("Song_Download".localize, for: .normal)
        //    cell.btnVerify.setTitle("Song_Verify".localize, for: .normal)
        cell.btnDownload.addTarget(self, action: #selector(btnArtistSongDownload_Action(_:)), for: .touchUpInside)
        cell.btnBack.tag = indexPath.row
        cell.btnBack.addTarget(self, action: #selector(btnBackAction(_:)), for: .touchUpInside)
        cell.btnKeep.tag = indexPath.row
        cell.btnKeep.addTarget(self, action: #selector(btnKeepAction(_:)), for: .touchUpInside)
        cell.lblProjectAmount.text = acceptArray[indexPath.row].project_price!
        cell.lblArtistSongName.text = acceptArray[indexPath.row].audioname!
        cell.lblArtistName.text = acceptArray[indexPath.row].artistname!
        cell.lblArtistMusicGenre.text = acceptArray[indexPath.row].genre!
        //  cell.artistConnectedSlider.maximumValue = Float(SliderValue[indexPath.row])!
        //   cell.lblArtistMinTime.text = String(cell.artistConnectedSlider.value)
        //   cell.lblArtistMaxTime.text = maxtime[indexPath.row]
        cell.btnVerify.tag = indexPath.row
        cell.btnVerify.addTarget(self, action: #selector(btnGoLive_Action(_:)), for: .touchUpInside)
        if acceptArray[indexPath.row].cost!.isEmpty == false{
            cell.lblProjectAmount.text = "\(self.currentCurrency)\(acceptArray[indexPath.row].offering!)"
        }else{
            cell.lblProjectAmount.text = "\(self.projCost)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 184
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = acceptArray[sourceIndexPath.row]
        acceptArray.remove(at: sourceIndexPath.row)
        acceptArray.insert(itemToMove, at: destinationIndexPath.row)
    }
}

private extension ArtistConnectedVC {
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve              // use whatever transition you want
        transitioningDelegate = customTransitioningDelegate
    }
}
