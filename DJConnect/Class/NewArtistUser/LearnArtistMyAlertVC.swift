//
//  LearnArtistMyAlertVC.swift
//  DJConnect
//
//  Created by Techugo on 19/05/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class LearnArtistMyAlertVC: UIViewController {

    @IBOutlet weak var finishedBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        finishedBtn.layer.cornerRadius = finishedBtn.frame.size.height/2
        finishedBtn.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnTaped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func finishedBtnTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}
