//
//  DjCommercialAdVC.swift
//  DJConnect
//
//  Created by mac on 27/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import UITextView_Placeholder
import AVFoundation

class DjCommercialAdVC: Main {
    
    //MARK: - OUTLETS
    @IBOutlet weak var vwStep3: UIView!
    @IBOutlet weak var vwStep1CardDetail: UIView!
    @IBOutlet weak var vwStep1PaymentComplete: UIView!
    @IBOutlet weak var lblStep2of3: UILabel!
    @IBOutlet weak var lblEnterTitle: UILabel!
    @IBOutlet weak var lblWordCounter: UILabel!
    @IBOutlet weak var lbltextviewPlaceholder: UILabel!
    @IBOutlet weak var lblClicktoUpload: UILabel!
    @IBOutlet weak var lblUploadAd: UILabel!
    @IBOutlet weak var lblStep3of3: UILabel!
    @IBOutlet weak var txtViewDescrip: UITextView!
    @IBOutlet weak var txfTitle: textFieldProperties!
    @IBOutlet weak var lblAdTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAdDescrip: UILabel!
    @IBOutlet weak var lblByDjName: UILabel!
    @IBOutlet weak var imgVideoPreview: UIImageView!
    
    
    //MARK: - GLOBAL VARIABLES
    var dateSelected = String()
    var songData = NSData()
    var fileName = String()
    var videoUrl = String()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholderString = "Enter ad Description."
        txtViewDescrip.placeholder = placeholderString
    }
    
    //MARK: - OTHER METHODS
    func videoSnapshot(filePathLocal: String) -> UIImage? {
        let vidURL = URL(fileURLWithPath:filePathLocal as String)
        let asset = AVURLAsset(url: vidURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let imageRef = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: imageRef)
        }
        catch let error as NSError
        {
            print("Image generation failed with error \(error)")
            return nil
        }
    }
    
    //MARK: - ACTIONS
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnProcessPaymentAction(_ sender: UIButton) {
        vwStep1PaymentComplete.isHidden = false
        vwStep1CardDetail.isHidden = true
        lblStep2of3.textColor = .black
        lblEnterTitle.textColor = .black
        lblWordCounter.textColor = .black
        lblClicktoUpload.textColor = .black
        lblUploadAd.textColor = .black
    }
    @IBAction func btnUploadAdAction(_ sender: UIButton) {
        vwStep3.isHidden = false
        lblStep3of3.textColor = .black
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.MOV", "public.wav", "public.M4V","public.AAC"], in: .import)
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction func btnAddPostAction(_ sender: UIButton) {
        callCommercialAddApi()
    }
    
    @IBAction func btnBackPostAction(_ sender: UIButton) {
        vwStep3.isHidden = true
        txfTitle.text = ""
        txtViewDescrip.text = ""
    }
    
    @IBAction func btnPlayAction(_ sender: UIButton) {
        let videoURL = URL(string: videoUrl)
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    //MARK: - WEBSERVICES()
    func callCommercialAddApi(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "date":"\(dateSelected)",
                "title":"\(txfTitle.text!)",
                "content":"\(txtViewDescrip.text!)",
                "video_file":"\(songData)"
            ]
            
            Loader.shared.show()
            
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.addCommercialAd)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<FinishProfileModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let commercialAdModel = response.result.value!
                    if commercialAdModel.success == 1{
                        self.view.makeToast(commercialAdModel.message)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(commercialAdModel.message)
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
    
    func callInternalVideoUpdateWebService(){
        if getReachabilityStatus(){
            let parameters = [
                "userid":"\(UserModel.sharedInstance().userId!)",
                "token":"\(UserModel.sharedInstance().token!)",
                "title":"\(txfTitle.text!)",
                "content":"\(txtViewDescrip.text!)",
                "video":"\(songData)"
            ]
            Loader.shared.show()
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.commercialData)"), method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<AddVideoModel>) in
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let videoInternalModel = response.result.value!
                    if videoInternalModel.success == 1{
                        self.view.makeToast(videoInternalModel.message)
                        self.vwStep3.isHidden = false
                        self.lblAdTitle.text = videoInternalModel.ResponseData!.title!
                        self.lblAdDescrip.text = videoInternalModel.ResponseData!.content!
                        self.videoUrl = videoInternalModel.ResponseData!.video!
                        self.imgVideoPreview.image = self.videoSnapshot(filePathLocal: self.videoUrl)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(videoInternalModel.message)
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
extension DjCommercialAdVC : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        lbltextviewPlaceholder.isHidden = true
        let len = textView.text.count
        lblWordCounter.text = "\(len)/200"
        print(String(format: "%i", 200 - len))
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.count == 0 {
            lbltextviewPlaceholder.isHidden = false
            if textView.text.count != 0 {
                return true
            }
        } else if textView.text.count > 199 {
            return false
        }
        return true
    }
    
}
extension DjCommercialAdVC: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        songData = try! Data(contentsOf: url) as NSData
        fileName = url.lastPathComponent
        callInternalVideoUpdateWebService()
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        vwStep3.isHidden = true
    }
}
