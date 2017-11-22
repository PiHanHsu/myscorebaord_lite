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

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
    //shuffle
    mutating func shuffle() -> [Element] {
        for _ in 0...self.count {
            let r = Int(arc4random_uniform(UInt32(self.count)))
            self.insert(self.remove(at: r), at: 0)
        }
        return self
    }
}
extension Notification.Name {
    static let updateData = Notification.Name("updateData")
}
