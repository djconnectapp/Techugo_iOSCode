//
//  LeftMenuTableViewCell.swift
//  DJConnect
//
//  Created by Techugo on 11/04/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImgVw: UIImageView!
    @IBOutlet weak var iconLblVw: UILabel!
    @IBOutlet weak var cellBgVw: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
