//
//  LearnDJAlertVC.swift
//  DJConnect
//
//  Created by Techugo on 19/05/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class LearnDJAlertVC: UIViewController {

    @IBOutlet weak var finishedBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishedBtn.layer.cornerRadius = finishedBtn.frame.size.height/2
        finishedBtn.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func finishedBtnTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
    }
}
