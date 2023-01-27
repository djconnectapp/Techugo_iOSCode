//
//  ArtistListTableViewCell.swift
//  DJConnect
//
//  Created by Techugo on 30/03/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class ArtistListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cellBgVw: UIView!
    
    @IBOutlet weak var artistProfilImgVw: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var byNameLbl: UILabel!
    
    @IBOutlet weak var genreColctnVw: UICollectionView!
    
    @IBOutlet weak var playSongBtn: UIButton!
    
    @IBOutlet weak var playSongLbl: UILabel!
    
    @IBOutlet weak var verifyCnctBtn: UIButton!
    
    @IBOutlet weak var downloadSongBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genreColctnVw.delegate = self
        genreColctnVw.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: genreColctnVw.frame.size.width / 2, height: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        genreColctnVw!.collectionViewLayout = layout
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistListCollectionViewCell", for: indexPath) as! ArtistListCollectionViewCell
        
       // cell.genreNameLbl.text = genreArray[indexPath.row]
//        cell.btnProjControl.addTarget(self, action: #selector(btnProjControl_Action(_:)), for: .touchUpInside)
       
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//                return CGSize(width:(collectionView.frame.width)/2, height: 20)
//
//    }

}


