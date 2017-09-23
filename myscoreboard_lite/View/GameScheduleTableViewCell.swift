//
//  GameScheduleTableViewCell.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/23.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class GameScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var courtNumLabel: UILabel!
    
    @IBOutlet weak var player1Label: UILabel!
    
    
    @IBOutlet weak var player2Label: UILabel!
    
    @IBOutlet weak var player3Label: UILabel!
    
    @IBOutlet weak var player4Label: UILabel!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
