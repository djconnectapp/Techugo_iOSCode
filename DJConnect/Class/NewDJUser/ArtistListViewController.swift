//
//  ArtistListViewController.swift
//  DJConnect
//
//  Created by Techugo on 30/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class ArtistListViewController: UIViewController {
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .dark)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.5)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
    
    @IBOutlet weak var blurBgVw: UIView!
    @IBOutlet weak var artistListTblVw: UITableView!
    @IBOutlet weak var artistConnectdNoLbl: UILabel!
    @IBOutlet weak var tblSortBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.artistListTblVw.separatorStyle = UITableViewCell.SeparatorStyle.none
        setUpVw()
    }
    
    func setUpVw(){
        
        blurBgVw.addSubview(blurredView)
        blurBgVw.sendSubviewToBack(blurredView)
        
        blurBgVw.layer.cornerRadius = 30
        blurBgVw.clipsToBounds = true
    }
    
    @IBAction func tblSortBtnTapped(_ sender: Any) {
    }

}

extension ArtistListViewController :  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistListTableViewCell", for: indexPath) as! ArtistListTableViewCell
            
        cell.selectionStyle = .none
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 213
        
    }
}
    
