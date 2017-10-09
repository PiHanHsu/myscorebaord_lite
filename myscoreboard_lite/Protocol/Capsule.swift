//
//  Capsule.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/9.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
import UIKit

protocol Capsule{}

extension Capsule where Self: UIView {
    func createCapsuleOutline() {
        layer.cornerRadius = self.frame.size.height * 0.5
        
    }
}
