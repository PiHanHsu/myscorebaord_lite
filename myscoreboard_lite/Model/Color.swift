//
//  Color.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/9.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class var myBlue: UIColor {
        get{
            return UIColor(red: 4.0/255.0, green: 190.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }

    class var myYellow: UIColor{
        return UIColor(red: 255.0/255.0, green: 210.0/255.0, blue: 0.0/255.0, alpha: 1)
    }
    class var mainLightGray: UIColor {
        return UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1)
    }
    class var backgroundGray: UIColor {
        return UIColor(red: 233.0/255.0, green: 235.0/255.0, blue: 238.0/255.0, alpha: 1)
    }
}
