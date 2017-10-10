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
       gradientLayer.colors = [UIColor.white.cgColor, UIColor.myBlue.cgColor, UIColor.blue.cgColor]
       gradientLayer.locations = [0.0, 0.2, 2.0]
       gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
       gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
       layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
