//
//  GenreVC.swift
//  DJConnect
//
//  Created by mac on 06/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class GenreVC: UIViewController {
    @IBOutlet weak var tblGenre: UITableView!
    //MARK: - GLOBAL VARIABLES
    var genreList = [GenreData]()
    var arrTest = [String]()
    var genreIndex = [String]()
    var genreText = String()
    var dicTest = [String : String]()
    var isGenre = true
    var originalGenreIndex = [String]()
    var originalgenreList = [String]()
    var isProfileComplete = Bool()
    var arrSelectedIndex = [Int]()
    
    //MARK: - UI VIEW CONTROLLER LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - ACTIONS
    @IBAction func btnAdd_Action(_ sender: UIButton) {
        if arrSelectedIndex.count > 0{
            let userdic = ["arrGenere" : genreIndex, "genreList" : arrTest, "isgenre" : isGenre, "arrIndex": arrSelectedIndex] as [String : Any]
            NotificationCenter.default.post(name: Notification.Name(rawValue: "genre"), object: nil, userInfo: userdic)
            navigationController?.popViewController(animated: true)
        }else{
            showAlertView("Please select any Genre to add")
        }
    }
    
    @IBAction func btnCancel_Action(_ sender: UIButton) {
        genreIndex = originalGenreIndex
        arrTest = originalgenreList
        let userdic = ["arrGenere" : genreIndex, "genreList" : arrTest, "isgenre" : isGenre, "arrIndex": originalGenreIndex] as [String : Any]
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "genre"), object: nil, userInfo: userdic)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - OTHER METHODS
    
}

//MARK: - EXTENSIONS
extension GenreVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genrecell", for: indexPath) as! generecell
        cell.selectionStyle = .none
        cell.lbl_genereName.text = genreList[indexPath.row].title!
        cell.btn_check.isUserInteractionEnabled = false
        cell.btn_check.tag = indexPath.row
        
        if arrSelectedIndex.contains(indexPath.row){
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "genrecell", for: indexPath) as! generecell
        
        if arrSelectedIndex.contains(indexPath.row){
            if let index = arrSelectedIndex.firstIndex(of: indexPath.row){
                arrSelectedIndex.remove(at: index)
            }

            if let genreIndexID = genreIndex.firstIndex(of: "\(genreList[indexPath.row].id!)"){
                genreIndex.remove(at: genreIndexID)
            }

            if let arrTestId = arrTest.firstIndex(of: genreList[indexPath.row].title!){
                arrTest.remove(at: arrTestId)
            }
            genreText = arrTest.joined(separator: ", ")
        }else{
            arrSelectedIndex.append(indexPath.row)
            genreIndex.append("\(genreList[indexPath.row].id!)")
            arrTest.append(genreList[indexPath.row].title!)
            genreText = arrTest.joined(separator: ", ")
        }
        tableView.reloadData()
    }
}
