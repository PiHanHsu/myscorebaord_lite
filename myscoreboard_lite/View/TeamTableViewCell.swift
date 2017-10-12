//
//  TeamTableViewCell.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/23.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var memberCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        teamImageView.roundedView()
    }

}
