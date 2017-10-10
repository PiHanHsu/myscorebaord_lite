//
//  PlayerCollectionViewCell.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    override var isSelected: Bool{
        
        didSet {
            checkMarkImageView.isHidden = !isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSelected = false
    }
    
    override func draw(_ rect: CGRect) {
        playerImageView.roundedView()
    }

}
