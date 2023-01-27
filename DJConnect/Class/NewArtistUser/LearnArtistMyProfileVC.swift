//
//  LearnArtistMyProfileVC.swift
//  DJConnect
//
//  Created by Techugo on 19/05/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class LearnArtistMyProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtntapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "fourthPV") as? LearnArtistMyAlertVC
        navigationController?.pushViewController(next1!, animated: true)
    }
    
}
