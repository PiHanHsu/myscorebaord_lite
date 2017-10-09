//
//  DropShadow.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/9.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
import UIKit

protocol DropShadow {}

extension DropShadow where Self: UIView{
    
    func addDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 8
    }
}
