//
//  CapsuleButton.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/9.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class CapsuleButton: UIButton, Capsule, DropShadow {

    override func awakeFromNib() {
        self.createCapsuleOutline()
        self.addDropShadow()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
