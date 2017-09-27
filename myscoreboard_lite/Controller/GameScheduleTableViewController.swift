//
//  GameScheduleTableViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class GameScheduleTableViewController: UITableViewController {
 
    var selectedPlayers = [Player]()
    var courtcount: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedPlayers = DataSource.sharedInstance.selectedPlayers
        createGamePlayList()
        // Register cell classes
        let nib = UINib(nibName: "GameScheduleTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "GameScheduleTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedPlayers = DataSource.sharedInstance.selectedPlayers
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameScheduleTableViewCell", for: indexPath) as! GameScheduleTableViewCell
        
        cell.player1Label.text = gameByCourt[indexPath.row][0].name
        cell.player2Label.text = gameByCourt[indexPath.row][1].name
        cell.player3Label.text = gameByCourt[indexPath.row][2].name
        cell.player4Label.text = gameByCourt[indexPath.row][3].name
        
        cell.courtNumLabel.text = "Court \(indexPath.row + 1)"
       
        cell.finishButton.tag = indexPath.row
        cell.finishButton.addTarget(self, action: #selector(gameFinished(sender:)), for: .touchUpInside)
       
        return cell
    }
    
    @objc func gameFinished(sender: UIButton){
        let index = sender.tag
        for player in gameByCourt[index]{
            player.uWeight += 1
            selectedPlayers.append(player)
        }
        selectedPlayers = selectedPlayers.shuffle()
        selectedPlayers.sort { $0.uWeight < $1.uWeight}
        
        let newGamePlayers = Array(selectedPlayers[0...3])
        gameByCourt[index] = newGamePlayers
        selectedPlayers = Array(selectedPlayers.dropFirst(4))
        print(selectedPlayers.count)
        tableView.reloadData()
       
    }
    var gameByCourt = [[Player]]()
    
    func createGamePlayList(){
        selectedPlayers = selectedPlayers.shuffle()
        for _ in 1...courtcount {
            let playersInOneGame = Array(selectedPlayers[0...3])
            gameByCourt.append(playersInOneGame)
            selectedPlayers = Array(selectedPlayers.dropFirst(4))
        }
    }
    
    @IBAction func finishGame(_ sender: Any) {
        
        for player in selectedPlayers {
            player.uWeight = 0
        }
        DataSource.sharedInstance.currentPlayingTeam = nil
        DataSource.sharedInstance.selectedPlayers = [Player]()
        
        for vc in (self.navigationController?.viewControllers ?? []) {
            if vc is TeamTableViewController {
                _ = self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPlayersInPlayingMode" {
            let nav = segue.destination as! UINavigationController
            let vc =  nav.topViewController as! SelectPlayersCollectionViewController
            vc.team = DataSource.sharedInstance.currentPlayingTeam
            vc.isPlayingMode = true
        }
    }
    
}
