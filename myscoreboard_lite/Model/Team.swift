//
//  Team.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/21.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Team {
    var players = [Player]()
    var teamImageUrl : String = ""
    var name: String = ""
    var teamId: Int?
    
    init(data:JSON) {
        self.teamImageUrl = data["team"]["logo_original_url"].stringValue
        self.name = data["team"]["name"].stringValue
        self.teamId = data["team"]["id"].intValue
        
        for member in data["team"]["teammembers"].arrayValue {
            var newPlayer = Player()
            let playerData = member.dictionary!
            
            newPlayer.name = (playerData["username"]?.stringValue)!
            newPlayer.user_id = (playerData["id"]?.stringValue)!
            //newPlayer.gender = playerData["gender"]?.stringValue
            newPlayer.imageUrl = (playerData["photo"]?.stringValue)!
            
            self.players.append(newPlayer)
        }
        
        
    }
    
    
}
