//
//  Connected.swift
//  DJConnect
//
//  Created by My Mac on 18/01/21.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit
import AVFoundation

class waitingRequestDetails : SwipeTableViewCell,AVAudioPlayerDelegate{
    
    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var lblProjectname: UILabel!
    @IBOutlet weak var lblDjName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblMinTime: UILabel!
    @IBOutlet weak var lblMaxTime: UILabel!
    @IBOutlet weak var waitSlider: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblOffering: UILabel!
    
    @IBOutlet weak var btnLikeWait: UIButton!
    @IBOutlet weak var btnDislikeWait: UIButton!
    
    
    var audioPlayer: AVAudioPlayer?
    
    var minuteString = String()
    var secondString = String()
    
    var url : URL?
    func setupAudioPlayerWithFile()  {
        
        
        do {
            let soundData = try Data(contentsOf:url!)
            audioPlayer = try AVAudioPlayer(data: soundData)
            audioPlayer!.volume = 1.0
            audioPlayer!.delegate = self
            
            minuteString = String(format: "%02d", (Int(audioPlayer!.duration) / 60))
            secondString = String(format: "%02d", (Int(audioPlayer!.duration) % 60))
            
            
            //ashitesh
            lblMinTime.text = String(self.waitSlider.value)
            lblMaxTime.text = "\(minuteString):\(secondString)"
            self.audioPlayer?.currentTime = Double(self.waitSlider.value)
            self.waitSlider.maximumValue = Float(Double(self.audioPlayer!.duration))
            
            
        } catch {
            print("Player not available")
        }
    }
    
    
    
    @IBAction func waitPlayButtonAction(_ sender: UIButton) { // ashitesh dj side
        if audioPlayer != nil{
            if sender.currentImage == UIImage(named: "audio_pause"){
                audioPlayer?.pause()
                sender.setImage(UIImage(named: "Button - Play"), for: .normal)
                
            }else{
                audioPlayer?.play()
                _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateSeekBar), userInfo: nil, repeats: true)
                sender.setImage(UIImage(named: "audio_pause"), for: .normal)
            }
        }else{
            setupAudioPlayerWithFile()
        }
        
    }
    
    @objc func UpdateSeekBar() {
        let minCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) / 60))
        let secCurrent = String(format: "%02d", (Int(audioPlayer!.currentTime) % 60))
        let total = Int(audioPlayer!.duration) - Int(audioPlayer!.currentTime)
        let remMin = String(format: "%02d", (total / 60))
        let remSec = String(format: "%02d", (total % 60))
        
        lblMaxTime.text = "\(remMin):\(remSec)"
        lblMinTime.text = "\(minCurrent):\(secCurrent)"
        waitSlider.value = Float(Double((audioPlayer?.currentTime)!))
        
    }
    
    
//    @IBAction func slider_Action(_ sender: UISlider){
//        audioPlayer?.currentTime = TimeInterval(waitSlider.value)
//    }
//    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlay.setImage(UIImage(named:"Button - Play"),for: .normal)
    }    
}
