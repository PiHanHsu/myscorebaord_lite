//
//  DataSource.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/23.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
struct DataSource {
    static var sharedInstance = DataSource()
    
    var teams = [Team]()
    var currentUser = Player()
    var currentPlayingTeamIndex = 0
    
}
