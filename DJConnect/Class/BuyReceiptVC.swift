//
//  BuyReceiptVC.swift
//  DJConnect
//
//  Created by mac on 12/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import HCSStarRatingView
import LGSideMenuController

class BuyReceiptStep3Cell: UICollectionViewCell, UITextViewDelegate{
    @IBOutlet weak var vwRating: HCSStarRatingView!
    @IBOutlet weak var btnRateProject: UIButton!
    @IBOutlet weak var lblRateDescriptionTextSize: UILabel!
    @IBOutlet weak var lblRateDescription: UILabel!
    @IBOutlet weak var vwDescription: UIView!
    @IBOutlet weak var tvRatingText: UITextView!
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText newText: String) -> Bool {
        let counter = textView.text.count + (newText.count - range.length)
        lblRateDescriptionTextSize.text = "\(counter)/300"
        
        return counter <= 299
    }
}

class BuyReceiptStep1Cell: UICollectionViewCell{
    @IBOutlet weak var lblProjectPrice: UILabel!
    @IBOutlet weak var lblTransactionFee: UILabel!
    @IBOutlet weak var lblTotalProjPrice: UILabel!
}

class BuyReceiptStep2Cell : UICollectionViewCell{
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongBy: UILabel!
    @IBOutlet weak var lblSongGenre: UILabel!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var AudioSeekBar: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblDjNotify: UILabel! // The Dj has completed your connect for their project // should also change
    @IBOutlet weak var lblStatusHeader: UILabel! // Project Complete - should change status acording to project status
    @IBOutlet weak var imgMusicProfile: imageProperties!
    @IBOutlet weak var btnViewConnect: UIButton!
}

class BuyReceiptVC: UIViewController{
    
    //MARK: - OUTLETS
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var lblByDjName: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventTime: UILabel!
    @IBOutlet weak var lblCurrentDate: UILabel!
    @IBOutlet weak var lblProjectCost: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var index = Int()
    var scroll = Bool()
    var buttonSwipe = Bool()
    var projName = String()
    var djname = String()
    var eventDate = String()
    var projCost = String()
    var djId = String()
    var projId = String()
    var step1ProjPrice =  String()
    var step1TransFee = String()
    var step1TotalPrice = String()
    var currency = String()
    var songName = String()
    var songBy = String()
    var songGenre = String()
    var songMinTime = String()
    var songMaxTime = String()
    var imageUrl: URL?
    var SongURL : URL?
    var djNotify = String()
    var reasonDetail = String()
    var stepStatus = String()
    var rateStatus = String()
    var rateDescrip = String()
    var audioPlayer: AVAudioPlayer?
    var isAudioAdded = Bool()
    var ratingDetail = [String: String]()
    var ratingValueInt = Float()
    
    @IBOutlet weak var pageControlVw: UIPageControl!
    //var pageControl = UIPageControl()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        lblProjectName.text = projName
        lblByDjName.text = djname
        lblProjectCost.text = currency + projCost
        setDate()
        callStep1DataWebService()
        GetBuyProjectDataWebService()
        
        pageControlVw.numberOfPages = 3

    }

    
    //MARK: - ACTIONS
    @IBAction func btnRightAction(_ sender: UIButton) {
        let collectionBounds = self.collectionVw.bounds
        let contentOffset = CGFloat(floor(self.collectionVw.contentOffset.x + collectionBounds.size.width))
        audioPlayer?.pause()
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    @IBAction func btnLeftAction(_ sender: UIButton) {
        let collectionBounds = self.collectionVw.bounds
        let contentOffset = CGFloat(floor(self.collectionVw.contentOffset.x - collectionBounds.size.width))
        audioPlayer?.pause()
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        if UserModel.sharedInstance().userType == "AR"{
//            let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
//            let next1 = storyBoard.instantiateViewController(withIdentifier: "NewArtistHomeVC") as? NewArtistHomeVC
//
//            self.sideMenuController?.hideLeftView()
//            sideMenuController()?.setContentViewController(next1!)
            
            self.navigationController?.popViewController(animated: false)
                                    
        }else{
//            let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
//            let next1 = storyBoard.instantiateViewController(withIdentifier: "NewDJHomeVC") as? NewDJHomeVC
//            self.sideMenuController?.hideLeftView()
//            sideMenuController()?.setContentViewController(next1!)
            self.navigationController?.popViewController(animated: false)
            
        }
    }
    
    //MARK: - OTHER METHODS
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionVw.contentOffset.y ,width : self.collectionVw.frame.width,height : self.collectionVw.frame.height)
        self.collectionVw.scrollRectToVisible(frame, animated: true)
    }
    
    func preparePlayer(_ songurl: URL?) {
        guard let url = songurl else {
            print("Invalid URL")
            return
        }
        do {
            let indexPath1 = IndexPath.init(row: 1, section: 0)
            let cell = collectionVw.cellForItem(at: indexPath1) as! BuyReceiptStep2Cell
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 0.7
            audioPlayer!.delegate = self
            let minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            let secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            cell.lblMinTime.text = String(cell.AudioSeekBar.value)
            cell.lblMaxTime.text = "\(minuteString):\(secondString)"
            self.audioPlayer?.currentTime = Double(cell.AudioSeekBar.value)
            cell.AudioSeekBar.maximumValue = Float(Double(self.audioPlayer!.duration))
        }catch {
            print(error)
        }
    }
    
    func setDate(){
        let dateString = eventDate
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter1.date(from: dateString)
        dateFormatter1.dateFormat = "MMM d, yyyy"
        let date2 = dateFormatter1.string(from: date!)
        let fullDate = date2
        let weekday = Calendar.current.component(.weekday, from: date!)
        var day = String()
        switch weekday {
        case 1:
            day = "Sunday - "
        case 2:
            day = "Monday - "
        case 3:
            day = "Tuesday - "
        case 4:
            day = "Wednesday - "
        case 5:
            day = "Thursday - "
        case 6:
            day = "Friday - "
        case 7:
            day = "Saturday - "
        default:
            day = "Sunday - "
        }
        lblEventDate.text = "Event on:".localize + "\(day + fullDate)"
    }
    
    //MARK: - SELECTOR METHODS
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        let indexPath1 = IndexPath.init(row: 1, section: 0)
        if audioPlayer?.isPlaying == true{
            let cell = collectionVw.cellForItem(at: indexPath1) as! BuyReceiptStep2Cell
            
            cell.lblMaxTime.text = "\(remMin):\(remSec)"
            cell.lblMinTime.text = "\(minCurrent):\(secCurrent)"
            cell.AudioSeekBar.value = Float(Double((audioPlayer?.currentTime)!))
        }
    }
    
    @objc func playAudio(_ sender: UIButton){
        if sender.currentImage == UIImage(named: "audio_pause"){
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "audio-play"), for: .normal)
        }else{
            self.preparePlayer(self.SongURL)
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "audio_pause"), for: .normal)
        }
    }
    
    @objc func btnRateProjectAction(_ sender: UIButton) {
        
        callRatingWebService()
        
//        let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
//        let next1 = homeSB.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
//        sideMenuController()?.setContentViewController(next1!)
    }
    
    //MARK: - WEB SERVICES
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id=\(projId)&token=\(UserModel.sharedInstance().token!)&dj_id=\(djId)&type=project"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
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
                        self.collectionVw.reloadData()
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
    
    func GetBuyProjectDataWebService(){
        if getReachabilityStatus(){
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getStepsProjectAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&project_id=\(projId)&user_type=\(UserModel.sharedInstance().userType!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetBuyProjStepsModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let buyStepModel = response.result.value!
                    if buyStepModel.success == 1{
                        if buyStepModel.step2 == "1"{
                            self.isAudioAdded = true
                            self.songBy = "By ".localize + "\(buyStepModel.step3!.artist_name!)"
                            self.songName = buyStepModel.step3!.artist_applied_audio_name!
                            self.songGenre = buyStepModel.step3!.artist_genre!
                            self.imageUrl = URL(string : buyStepModel.step3!.artist_photo!)
                            self.SongURL = URL(string: buyStepModel.step3!.audio_file!)
                            if buyStepModel.is_completed! == 1{
                                self.stepStatus = "is_Complete"
                                if buyStepModel.step3!.is_video_verify == 1{
                                    self.stepStatus = "Video_verify"
                                }
                            }
                        }
                        //ashitesh
//                        if buyStepModel.step5!.status == "1"{
//                            self.rateDescrip = buyStepModel.step5!.review!
//                            self.rateStatus = "Rating"
//                        }else{
//                            self.rateStatus = "NotRated"
//                        }
                        if buyStepModel.step5!.review != ""{
                            self.rateDescrip = buyStepModel.step5!.review!
                            self.ratingValueInt = Float(buyStepModel.step5!.rate_value ?? "") ?? 0.0
                            self.rateStatus = "Rating"
                        }else{
                            self.rateStatus = "NotRated"
                        }
                        self.collectionVw.reloadData()
                    }else{
                        Loader.shared.hide()
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                }
            }
        }else{
            self.view.makeToast("Please Check your Internet Connection")
        }
    }
    
    func callRatingWebService(){
        if getReachabilityStatus(){
            
            let indexPath1 = IndexPath.init(row: 2, section: 0)
            let cell = collectionVw.cellForItem(at: indexPath1) as! BuyReceiptStep3Cell
            let rating = cell.vwRating.value
            let ratingStr = String(format: "%.2f", rating) // "3.14"
            let reviewText = cell.tvRatingText.text!
            if reviewText == ""{
                self.view.makeToast("Review Text can not be empty.")
                return
            }
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "rating_by":"\(UserModel.sharedInstance().userId!)",
                "rating_to":"\(projId)",
                "rating_value":ratingStr,
                "review":reviewText,
                "token":"\(UserModel.sharedInstance().token!)",
            ]
            
            print("rating parameters1", parameters)
            print("rating URL1", Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addProjectRating)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil))
            
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addProjectRating)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let ratingModel = response.result.value!
                    if ratingModel.success == 1{
                        ////ashitesh
                        self.view.makeToast(ratingModel.message)
//                        let homeSB = UIStoryboard(name: "ArtistHome", bundle: nil)
//                        let next1 = homeSB.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
//                        self.sideMenuController()?.setContentViewController(next1!)
                        self.view.makeToast("You have rated this project successfully")
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            
                            if UserModel.sharedInstance().userType == "AR"{
                                guard let centerController = UIStoryboard.init(name: "ArtistHome", bundle: nil).instantiateViewController(withIdentifier: "NewArtistHomeVC") as? NewArtistHomeVC else { return }
                                guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
                            
                                    let navigation = UINavigationController.init(rootViewController: centerController)
                                    navigation.setNavigationBarHidden(true, animated: false)
                                    let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                                                  leftViewController: sideController,
                                                                                  rightViewController: nil)
                                sideMenuController.leftViewPresentationStyle = .scaleFromLittle
                               
                              self.view.window?.rootViewController = sideMenuController
                              self.view.window?.makeKeyAndVisible()
                                
                            }else{
                                guard let centerController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "NewDJHomeVC") as? NewDJHomeVC else { return }
                                guard let sideController = UIStoryboard.init(name: "DJHome", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController else { return }
                            
                                    let navigation = UINavigationController.init(rootViewController: centerController)
                                    navigation.setNavigationBarHidden(true, animated: false)
                                    let sideMenuController = LGSideMenuController(rootViewController: navigation,
                                                                                  leftViewController: sideController,
                                                                                  rightViewController: nil)
                                    //sideMenuController.leftViewWidth = 280.0
                                sideMenuController.leftViewPresentationStyle = .scaleFromLittle
                               
                              self.view.window?.rootViewController = sideMenuController
                              self.view.window?.makeKeyAndVisible()
                                
                            }
                        })
                        
                        
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
            self.view.makeToast("Please check your Internet Connection")
        }
    }
}

//MARK: - EXTENSIONS
extension BuyReceiptVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuyReceiptStep1Cell", for: indexPath) as! BuyReceiptStep1Cell
            cell.lblProjectPrice.text = "Project Price = \(self.step1ProjPrice)"
            cell.lblTransactionFee.text = "Transaction Fee = \(self.step1TransFee)"
            cell.lblTotalProjPrice.text = "Total Project Price = \(self.step1TotalPrice)"
            return cell
            
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuyReceiptStep2Cell", for: indexPath) as! BuyReceiptStep2Cell
            if self.isAudioAdded == true{
                cell.lblSongName.text = self.songName
                cell.lblSongBy.text = self.songBy
                cell.lblSongGenre.text = self.songGenre
                cell.lblMinTime.text = "00:00"
                cell.lblMaxTime.text = "01:00"
                cell.AudioSeekBar.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
                cell.imgMusicProfile.kf.setImage(with: imageUrl, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                cell.btnPlay.tag = indexPath.row
                cell.btnPlay.addTarget(self, action: #selector(playAudio(_:)), for: .touchUpInside)
            }
            //            if stepStatus == "Video_verify"{
            //                cell.btnViewConnect.isEnabled = true
            //            }
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BuyReceiptStep3Cell", for: indexPath) as! BuyReceiptStep3Cell
            
            if rateStatus == "Rating"{
                cell.vwRating.isUserInteractionEnabled = false
                cell.btnRateProject.isEnabled = false
                cell.vwDescription.isHidden = true
                cell.btnRateProject.isHidden = true
                cell.lblRateDescription.text = self.rateDescrip
                cell.vwRating.value = CGFloat(self.ratingValueInt)
                    
                    //let rating = cell.vwRating.value
                cell.lblRateDescription.isHidden = false
            }
            else if rateStatus == "NotRated" && stepStatus == "Video_verify"{
                cell.vwRating.isUserInteractionEnabled = true
                cell.btnRateProject.isEnabled = true
                cell.vwDescription.isHidden = false
                //cell.btnRateProject.isHidden = false
                cell.lblRateDescription.isHidden = true
                cell.btnRateProject.tag = indexPath.row
                cell.btnRateProject.addTarget(self, action: #selector(btnRateProjectAction(_:)), for: .touchUpInside)
            }
            else{
                cell.vwRating.isUserInteractionEnabled = false
                cell.btnRateProject.isEnabled = false
                cell.vwDescription.isHidden = false
                cell.btnRateProject.isHidden = false
                cell.lblRateDescription.isHidden = true
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == 2{
            btnRight.isHidden = true
        }else{
            btnRight.isHidden = false
        }
        if indexPath.row == 0 {
            btnLeft.isHidden = true
        }else{
            btnLeft.isHidden = false
        }
        self.pageControlVw.currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: collectionView.frame.width, height: 300)
        }else if indexPath.row == 1{
            return CGSize(width: collectionView.frame.width, height: 500)
        }else{
            return CGSize(width: collectionView.frame.width, height: 500)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scroll = true
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        index = currentPage
        audioPlayer?.pause()
    }
    
}
extension BuyReceiptVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let indexPath1 = IndexPath.init(row: 1, section: 0)
        let cell = collectionVw.cellForItem(at: indexPath1) as! BuyReceiptStep2Cell
        cell.btnPlay.setImage(UIImage(named:"audio-play"),for: .normal)
    }
}
