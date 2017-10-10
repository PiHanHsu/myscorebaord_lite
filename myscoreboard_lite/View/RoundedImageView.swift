//
//  RoundedImageView.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/10.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView, RoundedView{
    
    override func awakeFromNib() {
        self.roundedView()
    }
}
