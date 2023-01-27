//
//  LearnDJServiceVC.swift
//  DJConnect
//
//  Created by Techugo on 19/05/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class LearnDJServiceVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func nextBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DJHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "thirdDJPV") as? LearnDJProfileVC
        navigationController?.pushViewController(next1!, animated: true)
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
