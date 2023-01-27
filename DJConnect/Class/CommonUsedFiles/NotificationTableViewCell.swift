//
//  NotificationTableViewCell.swift
//  DJConnect
//
//  Created by Techugo on 04/04/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBgVw: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var separtorLIneVw: UIView!
    
    @IBOutlet weak var chekView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
