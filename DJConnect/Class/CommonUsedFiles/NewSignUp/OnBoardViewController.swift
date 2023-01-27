//
//  OnBoardViewController.swift
//  DJConnect
//
//  Created by Techugo on 16/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class OnBoardViewController: UIViewController {
    
    @IBOutlet weak var artistBtn: UIButton!
    @IBOutlet weak var djBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpVw()
    }
    
    func setUpVw(){
        
        artistBtn.layer.borderColor = UIColor.white.cgColor
        artistBtn.layer.borderWidth = 2
//        artistBtn.layer.cornerRadius = 15
        artistBtn.layer.cornerRadius = artistBtn.frame.size.height/2
        
        djBtn.layer.borderColor = UIColor.white.cgColor
        djBtn.layer.borderWidth = 2
        //djBtn.layer.cornerRadius = 15
        djBtn.layer.cornerRadius = djBtn.frame.size.height/2
        
    }
    
    @IBAction func artistBtnTaped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "NewSignInViewController") as! NewSignInViewController
        desiredViewController.onboardType = "artist"
        UserModel.sharedInstance().userType = "AR"
        navigationController?.pushViewController(desiredViewController, animated: false)
        
//        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
//        let next1 = storyBoard.instantiateViewController(withIdentifier: "AddSubscribeVC") as? AddSubscribeVC
//        self.navigationController?.pushViewController(next1!, animated: true)
        
    }
    
    @IBAction func djBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "SignIn", bundle: nil)
        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "NewSignInViewController") as! NewSignInViewController
        desiredViewController.onboardType = "DJ"
        UserModel.sharedInstance().userType = "DJ"
        navigationController?.pushViewController(desiredViewController, animated: false)
        
//        let storyBoard = UIStoryboard(name: "DJHome", bundle: nil)
//        let desiredViewController = storyBoard.instantiateViewController(withIdentifier: "VenuInfoViewController") as! VenuInfoViewController
//        desiredViewController.getPrjectNameStr = "getPrjectNameStr"
//        desiredViewController.getPrjectDEtailStr = "getPrjectDEtailStr"
//        //desiredViewController.getProjImage = ""
//        desiredViewController.prjectTypeStr = "projectTypeTxtFld"
//        desiredViewController.expectedAudienceStr = "expectedAudienceTxtFld"
//        desiredViewController.projectTypeIndex = String(2)
//        navigationController?.pushViewController(desiredViewController, animated: false)
        
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
