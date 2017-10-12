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
    var playerBasket = [Player]()
    var courtCount: Int = 1
    var gameByCourt = [[Player]]()
    var gameHistory = [[Player]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        selectedPlayers = DataSource.sharedInstance.selectedPlayers
        createGamePlayList()
        // Register cell classes
        let nib = UINib(nibName: "GameScheduleTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "GameScheduleTableViewCell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courtCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! ) / 4.0
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
        gameHistory.append(gameByCourt[index])
        for player in gameByCourt[index]{
            player.uWeight += 1
            selectedPlayers.append(player)
        }
        selectedPlayers = selectedPlayers.shuffle()
        selectedPlayers.sort { $0.uWeight < $1.uWeight}
        
        let newGamePlayers = Array(selectedPlayers[0...3])
        gameByCourt[index] = newGamePlayers
        selectedPlayers = Array(selectedPlayers.dropFirst(4))
        tableView.reloadData()
       
    }
    
    
    func createGamePlayList(){
        selectedPlayers = selectedPlayers.shuffle()
        for _ in 1...courtCount {
            let playersInOneGame = Array(selectedPlayers[0...3])
            gameByCourt.append(playersInOneGame)
            selectedPlayers = Array(selectedPlayers.dropFirst(4))
        }
    }
    
    @IBAction func finishGame(_ sender: Any) {
        
        let alertController = UIAlertController(title: "結束今日比賽", message: "球員排點紀錄將會重新計算", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: {
            UIAlertAction in
            for vc in (self.navigationController?.viewControllers ?? []) {
                if vc is TeamTableViewController {
                   
                    for player in DataSource.sharedInstance.selectedPlayers {
                        player.uWeight = 0
                    }
                    DataSource.sharedInstance.currentPlayingTeam = nil
                    DataSource.sharedInstance.selectedPlayers = [Player]()
                     _ = self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameHistory" {
            let vc =  segue.destination as! GameHistoryTableViewController
            vc.gameHistory = gameHistory
        }
    }
    
}
