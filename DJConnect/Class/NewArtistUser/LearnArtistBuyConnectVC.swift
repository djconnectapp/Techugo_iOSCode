//
//  LearnArtistBuyConnectVC.swift
//  DJConnect
//
//  Created by Techugo on 19/05/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class LearnArtistBuyConnectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ArtistHome", bundle: nil)
        let next1 = storyboard.instantiateViewController(withIdentifier: "secondPV") as? LearnArtistBuyReviewVC
        navigationController?.pushViewController(next1!, animated: true)
    }
    
}
