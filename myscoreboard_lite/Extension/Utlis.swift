//
//  Utlis.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/21.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return
            self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
