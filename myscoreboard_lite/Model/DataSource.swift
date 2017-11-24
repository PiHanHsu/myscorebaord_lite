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
    var currentPlayingTeamIndex : Int = 0
    var currentPlayingTeam: Team?
    var courtCount = 1
    var selectedPlayers = [Player]()
    var nextGamePlayers = [Player]()
    var playerBasket = [Player]()
    var gameByCourt = [[Player]]()
    var gameHistory = [[Player]]()
    var auth_token = ""
    
    mutating func createGamePlayList(){
        
        playerBasket = selectedPlayers.shuffle()
        for _ in 1...courtCount {
            let playersInOneGame = Array(playerBasket[0...3])
            gameByCourt.append(playersInOneGame)
            playerBasket = Array(playerBasket.dropFirst(4))
        }
        if playerBasket.count > 4 {
            nextGamePlayers = Array(playerBasket[0...3])
            playerBasket = Array(playerBasket.dropFirst(4))
        }
        notifyToUpdateData()
    }
    
    mutating func createNextGame(finshedIndex index: Int){
        
        gameHistory.append(gameByCourt[index])
        for player in gameByCourt[index]{
            player.uWeight += 1
            player.gamesPlayed += 1
            if selectedPlayers.contains(player){
                playerBasket.append(player)
            }
        }
        
        if nextGamePlayers.count == 0 {
            playerBasket = playerBasket.shuffle()
            playerBasket.sort { $0.uWeight < $1.uWeight}
            
            let newGamePlayers = Array(playerBasket[0...3])
            gameByCourt[index] = newGamePlayers
            playerBasket = Array(playerBasket.dropFirst(4))
        }else{
            gameByCourt[index] = nextGamePlayers
            playerBasket = playerBasket.shuffle()
            playerBasket.sort { $0.uWeight < $1.uWeight}
            nextGamePlayers = Array(playerBasket[0...3])
            playerBasket = Array(playerBasket.dropFirst(4))
        }
        notifyToUpdateData()
    }
    
    func notifyToUpdateData(){
        NotificationCenter.default.post(name: .updateData, object: nil)
    }
    
    func checkPlayer(players: [Player]) {
        for i in 0...2{
            for j in i+1...3{
                if players[i] == players[j]{
                    for player in selectedPlayers {
                        print("Select: \(player.name)")
                    }
                    for player in playerBasket {
                        print("Bakset: \(player.name)")
                    }
                    
                    break
                }
            }
        }
    }
}
