//
//  RoundedView.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/10.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
import UIKit

protocol RoundedView {}

extension RoundedView where Self: UIView {
    func roundedView() {
        if (self.frame.size.height != self.frame.size.width){
            self.frame.size.height = min(self.frame.size.height, self.frame.size.width)
            self.frame.size.width = min(self.frame.size.height, self.frame.size.width)
        }
        layer.cornerRadius = layer.frame.size.height * 0.5
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
