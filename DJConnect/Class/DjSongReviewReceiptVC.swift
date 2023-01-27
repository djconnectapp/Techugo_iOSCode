//
//  DjSongReviewReceiptVC.swift
//  DJConnect
//
//  Created by mac on 13/05/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire

class DjSongReviewReceiptStep1Cell: UICollectionViewCell{
    @IBOutlet weak var lblProjPrice: UILabel!
    @IBOutlet weak var lblTransFee: UILabel!
    @IBOutlet weak var lblTotProjPrice: UILabel!
}

class DjSongReviewReceiptCell : UICollectionViewCell{
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongBy: UILabel!
    @IBOutlet weak var lblSongGenre: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var audioSeekbar: UISlider!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var lblRemainingTime: UILabel!
    @IBOutlet weak var lblComplete: UILabel!
    @IBOutlet weak var btnViewSongReview: UIButton!
    @IBOutlet weak var lblClickHere: UILabel!
    @IBOutlet weak var imgMusicUserImage: imageProperties!
    
    @IBOutlet weak var imgComplete: UIImageView!
}

class DjSongReviewReceiptVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
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
    var djByData = String()
    var djCostData = String()
    var step2AudioName = String()
    var step2AudioBy = String()
    var step2AudioGenre = String()
    var step2UserImageUrl : URL?
    var step1AudioUserImage : URL?
    var step2RemainingTime = String()
    var isReviewComplete = Bool()
    var audioPlayer: AVAudioPlayer?
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDjName.text = djname
        lblCost.text = projCost
        callStep1DataWebService()
        callGetSongReviewDataWebService()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnLeftAction(_ sender: UIButton) {
        let collectionBounds = self.collectionVw.bounds
        let contentOffset = CGFloat(floor(self.collectionVw.contentOffset.x - collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    @IBAction func btnRightAction(_ sender: UIButton) {
        let collectionBounds = self.collectionVw.bounds
        let contentOffset = CGFloat(floor(self.collectionVw.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    @IBAction func btnBack(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyBoard.instantiateViewController(withIdentifier: "ArtistHomeVC") as? ArtistHomeVC
        sideMenuController()?.setContentViewController(next1!)
    }
    
    //MARK: - OTHER METHODS
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionVw.contentOffset.y ,width : self.collectionVw.frame.width,height : self.collectionVw.frame.height)
        self.collectionVw.scrollRectToVisible(frame, animated: true)
    }
    
    //MARK: - SELECTOR METHODS
    func preparePlayer(_ songurl: URL?) {
        guard let url = songurl else {
            print("Invalid URL")
            return
        }
        do {
            let indexPath1 = IndexPath.init(row: 0, section: 0)
            let cell = collectionVw.cellForItem(at: indexPath1) as! DjSongReviewReceiptCell
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 0.7
            audioPlayer!.delegate = self
            let minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            let secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            cell.lblMinTime.text = String(cell.audioSeekbar.value)
            cell.lblMaxTime.text = "\(minuteString):\(secondString)"
            self.audioPlayer?.currentTime = Double(cell.audioSeekbar.value)
            cell.audioSeekbar.maximumValue = Float(Double(self.audioPlayer!.duration))
        } catch {
            print(error)
        }
    }
    
    func startTimer() {
        let releaseDateString = "\(step2RemainingTime)"
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        let countdown = "\(diffDateComponents.day ?? 0) DAY \(diffDateComponents.hour ?? 0) HR \(diffDateComponents.minute ?? 0) MIN \(diffDateComponents.second ?? 0) SEC"
        let indexPath1 = IndexPath.init(row: 0, section: 0)
        let cell = collectionVw.cellForItem(at: indexPath1) as! DjSongReviewReceiptCell
        cell.lblRemainingTime.text = countdown
        
    }
    
    
    //MARK: - WEBSERVICES
    func callStep1DataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.paymentDataAPI)?userid=\(UserModel.sharedInstance().userId!)&project_id=&dj_id=\(djId)&type=songreview&token=\(UserModel.sharedInstance().token!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<BuyOfferStep1Model>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let step1Model = response.result.value!
                    if step1Model.success == 1{
                        if let price = step1Model.result!.project_price{
                            self.step1ProjPrice =  "  " + self.currency + price
                        }
                        if let transPrice = step1Model.result!.transaction_fees{
                            self.step1TransFee =  "  " + self.currency + transPrice
                        }
                        if let totAmount = step1Model.result!.total_price{
                            self.step1TotalPrice =  "  " + self.currency + totAmount
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
    
    func callGetSongReviewDataWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getSongReviewStepsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&dj_id=\(djId)&apply_user_id=\(UserModel.sharedInstance().userId!)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GetDjSongReviewStepModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let getData = response.result.value!
                    if getData.success == 1{
                        self.djByData = "by \(getData.step2!.dj_name!)"
                        self.djCostData = "COST : \(self.currency)\(getData.step2!.song_review_cost!)"
                        let step1AudioUserImage = URL(string : getData.step2!.dj_pic!)
                        self.imgDjProfile.kf.setImage(with: step1AudioUserImage!, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
                        if getData.step2!.step2_status! == "1"{
                            self.isReviewComplete = false
                            self.step2AudioName = getData.step2!.audio_name!
                            self.step2AudioBy = "by \(getData.step2!.artist_name!)"
                            self.step2AudioGenre = getData.step2!.artist_genre!
                            let step2UserImageUrl = URL(string : getData.step2!.artist_pic!)
                            self.preparePlayer(URL(string: getData.step2!.audio_file!))
                        }
                        if getData.step3!.step3_status! == "1"{
                            self.isReviewComplete = false
                            if getData.step3!.remaining_time!.contains("00:00:00") {
                                self.step2RemainingTime = "TIME EXPIRED".localize
                            }else{
                                self.step2RemainingTime = getData.step3!.remaining_time!.UTCToLocal(incomingFormat: "yyyy-MM-dd HH:mm:ss", outGoingFormat: "yyyy-MM-dd HH:mm:ss")
                                self.startTimer()
                            }
                            if getData.step3!.is_video == "1"{
                                self.isReviewComplete = true
                            }
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
}
//MARK: - EXTENSIONS
extension DjSongReviewReceiptVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DjSongReviewReceiptStep1Cell", for: indexPath) as! DjSongReviewReceiptStep1Cell
            cell.lblProjPrice.text = "Project Price = \(self.step1ProjPrice)"
            cell.lblTransFee.text = "Transaction Fee = \(self.step1TransFee)"
            cell.lblTotProjPrice.text = "Total Project Price = \(self.step1TotalPrice)"
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! DjSongReviewReceiptCell
            cell.lblSongName.text = self.step2AudioName
            cell.lblSongBy.text = "By ".localize + self.step2AudioBy
            cell.lblSongGenre.text = self.step2AudioGenre
            cell.imgMusicUserImage.kf.setImage(with: step2UserImageUrl!, placeholder: UIImage(named: "user-profile"),  completionHandler: nil)
            
            cell.audioSeekbar.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
            if self.isReviewComplete == false{
                cell.lblComplete.isHidden = true
//                cell.lblClickHere.isHidden = true
                cell.imgComplete.isHidden = true
                cell.btnViewSongReview.isHidden = true
            }else{
                cell.lblComplete.isHidden = false
//                cell.lblClickHere.isHidden = false
                cell.imgComplete.isHidden = false
                cell.btnViewSongReview.isHidden = false
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
            return CGSize(width: self.view.frame.width - 80, height: 440)
        }
    }
}
extension DjSongReviewReceiptVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let indexPath1 = IndexPath.init(row: 0, section: 0)
        let cell = collectionVw.cellForItem(at: indexPath1) as! DjSongReviewReceiptCell
        cell.btnPlay.setImage(UIImage(named:"audio-play"),for: .normal)
    }
}
