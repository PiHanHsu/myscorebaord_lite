//
//  Gradient.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/9.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
import UIKit

protocol Gradient {}

extension Gradient where Self: UIView {
    
    func addGradient(){
        let gradientLayer = CAGradientLayer()
       gradientLayer.frame = self.bounds
        
       gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        
           layer.insertSublayer(gradientLayer, at: 0) 
        
    }
}
