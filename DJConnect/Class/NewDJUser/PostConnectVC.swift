//
//  PostConnectVC.swift
//  DJConnect
//
//  Created by Techugo on 29/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import LocationPickerViewController
import MapKit

class PostConnectVC: UIViewController {
    
    @IBOutlet weak var postconnectHdrLbl: UILabel!
    @IBOutlet weak var addImgBgVw: UIView!
    @IBOutlet weak var projectImgVw: UIImageView!
    @IBOutlet weak var projctImgBgVw: UIView!
    @IBOutlet weak var addProjectImgBtn: UIButton!
    @IBOutlet weak var projcttitleVw: UIView!
    @IBOutlet weak var projctTitleTxtFld: UITextField!
    @IBOutlet weak var projctDetailTxtBgVw: UIView!
    @IBOutlet weak var projctDetailTxtVw: UITextView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var postPicker: UIImagePickerController = UIImagePickerController()
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
    
    var genreNames = "Rock"
    var genreIds = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpVw()
        if GlobalId.id == "1"{
            callEditWebService()
        }
        
    }
    
    func setUpVw(){
         
        projctDetailTxtVw.delegate = self
        projctTitleTxtFld.delegate = self
        postPicker.delegate = self
        
       // addImgBgVw.layer.cornerRadius = 10.0
        addImgBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        addImgBgVw.layer.borderWidth = 0.5
        addImgBgVw.clipsToBounds = true
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        projctImgBgVw.addGestureRecognizer(tap1)
        
        projcttitleVw.layer.cornerRadius = 10.0
        projcttitleVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        projcttitleVw.layer.borderWidth = 0.5
        projcttitleVw.clipsToBounds = true
        
        projctDetailTxtBgVw.layer.cornerRadius = 10.0
        projctDetailTxtBgVw.layer.borderColor = UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1).cgColor
        projctDetailTxtBgVw.layer.borderWidth = 0.5
        projctDetailTxtBgVw.clipsToBounds = true
        
        projctTitleTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Project Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 131 / 255, green: 128 / 255, blue: 146 / 255, alpha: 1)]
        )
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        openForToTakePictures()
    }
    
    @IBAction func projectImgBtnTapped(_ sender: Any) {
        openForToTakePictures()
    }
    
    //MARK: - OTHER METHODS
    func openForToTakePictures(){
        let alertController = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let CameraAction = UIAlertAction(title: "Take a Photo", style: .default) { (ACTION) in
            self.openCamera()
        }
        let GalleryAction = UIAlertAction(title: "Open Gallery", style: .default) { (ACTION) in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (ACTION) in
        }
        alertController.addAction(CameraAction)
        alertController.addAction(GalleryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            postPicker.allowsEditing = false
            postPicker.sourceType = UIImagePickerController.SourceType.camera
            postPicker.cameraCaptureMode = .photo
            present(postPicker, animated: true, completion: nil)
        }else{
            self.showAlertView("This device has no Camera", "Camera Not Found")
        }
    }
    
    func openGallary()
    {
        postPicker.allowsEditing = false
        postPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(postPicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelbtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func nxtBtnTapped(_ sender: Any) {
        
//        let isImageUploaded = projectImgVw.image?.isEqualToImage(#imageLiteral(resourceName: "pexels-cesar-de-miranda-2381596play"))
//        if isImageUploaded!{
//            self.view.makeToast("Please select Flyer to continue")
//        }
        if projctTitleTxtFld.text?.isEmpty == true {
            self.view.makeToast("Please enter project title.".localize)
        }else if projctDetailTxtVw.text?.isEmpty == true || projctDetailTxtVw.text == "Project Details"{
            self.view.makeToast("Please enter Project Detail.".localize)
        }
        else {
            moveToNextScreen()
        }
        
    }
    
    func moveToNextScreen(){
        let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "ProjectInfoViewController") as! ProjectInfoViewController
        desiredViewController.getPrjectNameStr = projctTitleTxtFld.text ?? ""
        desiredViewController.getPrjectDEtailStr = projctDetailTxtVw.text ?? ""
        desiredViewController.getProjImage = projectImgVw.image
        
        
        desiredViewController.projectId = projectId
        desiredViewController.txtProjectTypeStr = txtProjectTypeStr
        desiredViewController.txtProjectTypeNameStr = txtProjectTypeNameStr
        desiredViewController.txtExpcaudStr = txtExpcaudStr
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

//MARK: - EXTENSIONS
extension  PostConnectVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as! UIImage
        
        let imgData = NSData(data: chosenImage.jpegData(compressionQuality: 1)!)
        let imageSize: Int = imgData.count

        projectImgVw.image = chosenImage
        projectImgVw.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension PostConnectVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == projctTitleTxtFld{
            if string.count == 0 {
                if textField.text!.count != 0 {
                    return true
                }
            }
            else if textField.text!.count > 50 {
                return false
            }
        }
        return true
    }
    
    func callEditWebService(){
        if getReachabilityStatus(){
            Loader.shared.show()
            projectId = GlobalId.ProjectDetailsId
            Alamofire.request(getServiceURL("\(webservice.url)\(webservice.getProjectDetailsAPI)?userid=\(UserModel.sharedInstance().userId!)&token=\(UserModel.sharedInstance().token!)&projectid=\(projectId)"), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<ProjectDetailModel>) in
                
                switch response.result {
                case .success(_):
                    Loader.shared.hide()
                    let detailProject = response.result.value!
                    if detailProject.success == 1{
                        self.setProjectDetail(detailProject: detailProject)
                    }else{
                        Loader.shared.hide()
                        self.view.makeToast(detailProject.message)
                    }
                case .failure(let error):
                    Loader.shared.hide()
                    debugPrint(error)
                    print("Error")
                }
            }
        }
        else{
            self.view.makeToast("Please check your Internet Connection".localize)
        }
        
    }
    
    func setProjectDetail(detailProject: ProjectDetailModel){
        projctTitleTxtFld.text = detailProject.projectDetails![0].title ?? ""
        projctDetailTxtVw.text = detailProject.projectDetails![0].project_description ?? ""
        
        txtProjectTypeStr = detailProject.projectDetails![0].project_info_type ?? ""
        txtProjectTypeNameStr = detailProject.projectDetails![0].project_info_type!
        txtExpcaudStr =
            detailProject.projectDetails![0].project_info_audiance ?? ""
        txtVenueNameStr =  detailProject.projectDetails![0].venue_name ?? ""
        txtEventDateStr =  detailProject.projectDetails![0].event_date ?? ""

        let startdateFormatter = DateFormatter()
        startdateFormatter.dateFormat = "HH:mm"
        //let startDate24 = startdateFormatter.string(from: picker1.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")

        //end time conversion
        let enddateFormatter = DateFormatter()
        enddateFormatter.dateFormat = "HH:mm"
       // let endDate24 = enddateFormatter.string(from: picker2.date).localToUTC(incomingFormat: "HH:mm", outGoingFormat: "HH:mm")
        txtStartTimeStr = detailProject.projectDetails![0].event_start_time!.UTCToLocal(incomingFormat: "HH:mm", outGoingFormat: "h:mm a")
        txtVenueAdrsStr = detailProject.projectDetails![0].venue_address ?? ""
        txtLatStr = detailProject.projectDetails![0].latitude ?? ""
        txtLongStr = detailProject.projectDetails![0].longitude ?? ""
        //txfCurrency.text = "INR"
        txtpriceStr = detailProject.projectDetails![0].price ?? ""
        txtRestricStr = detailProject.projectDetails![0].regulation ?? ""
        self.genreNames = detailProject.projectDetails![0].genre ?? "Rock"
        self.genreIds = detailProject.projectDetails![0].genre_ids ?? "1"
        //txfSongGener.text = self.genreNames
        txtAdditnlInfoStr = detailProject.projectDetails![0].special_Information ?? ""
        self.projectImgVw.kf.setImage(with: URL(string: (detailProject.projectDetails![0].project_image)!), placeholder: UIImage(named: "djCrowd"),  completionHandler: nil)
        getAddressFromLatLon()
       // callProjectTypeWebService()
        if detailProject.projectDetails![0].venue_address_status == "yes" {
            txtaddFlag = "yes"
            //btnPost_Yes.setImage(UIImage(named: "post_yes"), for: .normal)
            //btnPost_No.setImage(UIImage(named: "post_no"), for: .normal)
        }else{
            txtaddFlag = "no"
           // btnPost_Yes.setImage(UIImage(named: "post_no"), for: .normal)
            //btnPost_No.setImage(UIImage(named: "post_yes"), for: .normal)
        }
        if detailProject.projectDetails![0].artist_offer == "1" {
            txtofferFlag = "yes"

        }else{
            txtofferFlag = "no"
        }
        
    }
    
    func getAddressFromLatLon() {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(txtLatStr)")!
        //21.228124
        let lon: Double = Double("\(txtLongStr)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country)
                                            print(pm.locality)
                                            print(pm.subLocality)
                                            print(pm.thoroughfare)
                                            print(pm.postalCode)
                                            print(pm.subThoroughfare)
                                            
                                            var addressSort : String = ""
                                            
                                            if pm.thoroughfare != nil {
                                                addressSort = addressSort + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressSort = addressSort + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressSort = addressSort + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressSort = addressSort + pm.postalCode! + " "
                                            }
                                            print(addressSort)
                                            self.txteditsortAddress = addressSort
                                            var addressString : String = ""
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                addressString = addressString + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressString = addressString + pm.postalCode! + " "
                                            }
                                            self.txteditfullAddress = addressString
                                            print(addressString)
                                        }
                                    })
        
    }
    

}

//MARK: - EXTENSIONS
extension PostConnectVC : UITextViewDelegate{
//    func textViewDidChange(_ textView: UITextView) {
//       // lbltextviewPlaceholder.isHidden = true
//        let len = textView.text.count
//        lblWordCounter.text = "\(len)/200"
//        print(String(format: "%i", 200 - len))
//    }
//
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.count == 0 {
            //lbltextviewPlaceholder.isHidden = false
            if textView.text.count != 0 {
                return true
            }
        } else if textView.text.count > 199 {
            return false
        }
        return true
    }
}


