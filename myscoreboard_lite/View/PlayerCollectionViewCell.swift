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
            //playerImageView.layer.borderWidth = isSelected ? 10 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //playerImageView.layer.borderColor = UIColor.red.cgColor
        isSelected = false
    }

}
