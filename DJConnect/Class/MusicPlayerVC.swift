//
//  MusicPlayerVC.swift
//  DJConnect
//
//  Created by mac on 13/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MusicPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let size = CGSize(width: presentingViewController.view.frame.size.width, height: 190)
        let origin = CGPoint(x: 0, y: (presentingViewController.view.frame.size.height) - 190)
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

class MusicTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MusicPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class MusicPlayerVC: UIViewController {
    
    private var customTransitioningDelegate = MusicTransitioningDelegate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    //MARK: - OUTLETS
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var btnClosePlayer: UIButton!
    @IBOutlet weak var lblAlbumName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    //MARK: - GLOBAL VARIABLES
    var audioPlayer: AVAudioPlayer?
    var playList: Array = [String]()
    var index: Int = Int()
    var userDetail = [String]()
    var albumDetail = [String]()
    var dicTest = [String : String]()
    
    var mediaCancelCallback: ((_ Obj: String)->Void)?
    var mediaSongPlayback: ((_ Obj: String)->Void)?
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Loader.shared.show()
        self.view.backgroundColor = .red
        Slider.setThumbImage(UIImage(named: "newPurpleThumb"), for: .normal)
        lblUserName.text = userDetail[index]
        lblAlbumName.text = albumDetail[index]
        self.preparePlayer()
        self.audioPlayer?.play()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnPrevAction(_ sender: UIButton) {
        if index == 0{
            btnPrev.isUserInteractionEnabled = false
        }else{
            index = index - 1
            if index >= 0{
                let status = false
                let userdic = ["status" : status, "index" : index] as [String : Any]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "equalizer"), object: nil, userInfo: userdic)
                lblUserName.text = userDetail[index]
                lblAlbumName.text = albumDetail[index]
                btnPrev.isUserInteractionEnabled = true
                audioPlayer?.prepareToPlay()
                self.preparePlayer()
            }
            if index <= playList.count{
                btnNext.isUserInteractionEnabled = true
            }
        }
        
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        if index == playList.count - 1{
            btnNext.isUserInteractionEnabled = false
        }else{
            index = index + 1
            if index <= playList.count{
                let status = false
                let userdic = ["status" : status, "index" : index] as [String : Any]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "equalizer"), object: nil, userInfo: userdic)
                lblUserName.text = userDetail[index]
                lblAlbumName.text = albumDetail[index]
                btnNext.isUserInteractionEnabled = true
                audioPlayer?.prepareToPlay()
                self.preparePlayer()
            }
            if index >= 0{
                btnPrev.isUserInteractionEnabled = true
            }
        }
        
    }
    
    @IBAction func btnPlayPauseAction(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "playSample"){
            
            audioPlayer?.play()
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }else{
            audioPlayer?.pause()
            sender.setImage(UIImage(named: "playSample"), for: .normal)
        }
    }
    
    @IBAction func btnSliderChanged(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(Slider.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        audioPlayer?.pause()
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0.0
        self.Slider.value = 0.0
        let minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
        let secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
        self.Slider.maximumValue = Float(Double(self.audioPlayer!.duration))
        self.audioPlayer?.currentTime = Double(self.Slider.value)
        lblMin.text = String(self.Slider.value)
        lblMax.text = "\(minuteString):\(secondString)"
        let status = true
        let userdic = ["status" : status, "index" : index] as [String : Any]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "equalizer"), object: nil, userInfo: userdic)
        if let call = self.mediaCancelCallback{
            call("mediaCancel")
            
        }
        
        
        //dismiss(animated: true, completion: nil)
        self.view.removeFromSuperview()
    }
    
    //MARK: - SELECTOR
    @objc func UpdateSeekBar() {
        Loader.shared.hide()
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        lblMax.text = "\(remMin):\(remSec)"
        lblMin.text = "\(minCurrent):\(secCurrent)"
        Slider.value = Float(Double((audioPlayer?.currentTime)!))
//        if audioPlayer?.rate != 0 {
//            print("true")
//            if let call = self.mediaSongPlayback{
//                call("song Play")
//
//            }
//        }
        //if(Slider.value > 0.00){
        if let call = self.mediaSongPlayback{
            call("song Play")
            
        }
       // }
        
    }
    
    //MARK: - OTHER METHODS
    func preparePlayer() {
        guard let url = URL(string: playList[self.index]) else {
            print("Invalid URL")
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback)
            let soundData = try Data(contentsOf: url)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 0.7
            audioPlayer!.delegate = self
            audioPlayer?.currentTime = 0.0
            self.Slider.value = 0.0
            let minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            let secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            self.Slider.maximumValue = Float(Double(self.audioPlayer!.duration))
            self.audioPlayer?.currentTime = Double(self.Slider.value)
            lblMin.text = String(self.Slider.value)
            lblMax.text = "\(minuteString):\(secondString)"
            _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
        } catch {
            print(error)
        }
    }
}
extension MusicPlayerVC : AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlay.setImage(UIImage(named:"playSample"),for: .normal)        
    }
}
private extension MusicPlayerVC {
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
}

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 10))
    }
}
