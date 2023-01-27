//
//  GerneSelectorVC.swift
//  DJConnect
//
//  Created by My Mac on 23/08/21.
//  Copyright © 2021 mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class GerneSelectorVC: UIViewController {
    
    @IBOutlet weak var tblGenre: UITableView!
    //MARK: - GLOBAL VARIABLES
    var arrGenrelist = [GenreData]()
    var arrSelectedIndex = [Int]()
    var arrSelectedGerneName = [String]()
    var oldSelectedIds = ""
    var notificationName = ""
    
    @IBOutlet weak var addAllBtn: UIButton!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    @IBOutlet weak var selectGenreHdrLbl: UILabel!
    
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
//        if !oldSelectedIds.isEmpty{
//            self.arrSelectedIndex = self.get_numbers(stringtext: oldSelectedIds)
//        }
        
        selectGenreHdrLbl.text = "Select Genre".localize
        addAllBtn.setTitle("Add All".localize, for: .normal)
        finishBtn.setTitle("Finish".localize, for: .normal)
        
        self.GetGenreList()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnAddAll_Action(_ sender: UIButton) {
        arrSelectedIndex.removeAll()
        for g in arrGenrelist{
            arrSelectedIndex.append(g.id!)
        }
        self.tblGenre.reloadData()
    }
    
    @IBAction func btnFinish_Action(_ sender: UIButton) {
        arrSelectedIndex.sort()
        arrSelectedGerneName.removeAll()
        for _genre in arrSelectedIndex{
            if let genreIndexID = arrGenrelist.firstIndex(where: {$0.id == _genre}){
                arrSelectedGerneName.append(arrGenrelist[genreIndexID].title!)
            }
        }
        let stringArray = arrSelectedIndex.map(String.init)
        let userdic = ["names" : arrSelectedGerneName.joined(separator: ", "), "ids" : stringArray.joined(separator: ",")] as [String : Any]
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationName), object: nil, userInfo: userdic)
        print(arrSelectedGerneName.joined(separator: ", "))
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func get_numbers(stringtext:String) -> [Int] {
        let StringRecordedArr = stringtext.components(separatedBy: ",")
        return StringRecordedArr.map { Int($0)!}
    }
    
    //MARK: - OTHER METHODS
    func GetGenreList() {
        if getReachabilityStatus(){
            let requestUrl = "\(webservice.url)\(webservice.getGenreAPI)?token=&userid="
            
            Loader.shared.show()
            Alamofire.request(getServiceURL(requestUrl), method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseObject { (response:DataResponse<GenreModel>) in
                
                switch response.result {
                case .success(_):
                    let GenreModel = response.result.value!
                    if GenreModel.success == 1{
                        Loader.shared.hide()
                        self.arrGenrelist = GenreModel.genreList!
                        self.tblGenre.reloadData()
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

//MARK: - EXTENSIONS
extension GerneSelectorVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGenrelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genrecell", for: indexPath) as! generecell
        cell.selectionStyle = .none
        cell.lbl_genereName.text = arrGenrelist[indexPath.row].title!
        cell.btn_check.isUserInteractionEnabled = false
        cell.btn_check.tag = indexPath.row

        if arrSelectedIndex.contains(arrGenrelist[indexPath.row].id!){
            cell.btn_check.setImage(UIImage(named: "boxwithmark"), for: UIControl .State .normal)
        }else{
            cell.btn_check.setImage(UIImage(named: "boxwithclear"), for: UIControl .State .normal)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let genreIndexID = arrSelectedIndex.firstIndex(where: {$0 == arrGenrelist[indexPath.row].id}){
            arrSelectedIndex.remove(at: genreIndexID)
        }else{
            arrSelectedIndex.append(arrGenrelist[indexPath.row].id!)
        }
        tableView.reloadData()
    }
}
