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
    var courtCount: Int = DataSource.sharedInstance.courtCount
    var gameByCourt: Array<Array<Player>> {
        get {
            return DataSource.sharedInstance.gameByCourt
        }
    }
    var gameHistory: Array<Array<Player>> {
        get {
            return DataSource.sharedInstance.gameHistory
        }
    }
    
    var isFirstTimeEnter = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // Register cell classes
        let nib = UINib(nibName: "GameScheduleTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "GameScheduleTableViewCell")
        
        //set notificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateData(notification:)), name: .updateData, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedPlayers = DataSource.sharedInstance.selectedPlayers
            playerBasket = [Player]()
        for player in selectedPlayers {
            playerBasket.append(player)
        }
        if isFirstTimeEnter {
            DataSource.sharedInstance.createGamePlayList()
        }else{
            for currentGame in gameByCourt {
                for player in currentGame{
                    if playerBasket.contains(player){
                        playerBasket.remove(object: player)
                    }
                }
            }
        }
    }
    
    @objc func updateData(notification: NSNotification) {
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courtCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
        //return (self.view.frame.size.height - (self.navigationController?.navigationBar.frame.size.height)! ) / 4.0
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
        let alert = UIAlertController(title: "結束本場比賽？", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { a in
            let index = sender.tag
            DataSource.sharedInstance.createNextGame(finshedIndex: index)
            //self.createNextGame(finshedIndex: index)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func finishGame(_ sender: Any) {
        
        let alertController = UIAlertController(title: "結束今日比賽", message: "球員排點紀錄將會重新計算", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: {
            UIAlertAction in
            for vc in (self.navigationController?.viewControllers ?? []) {
                if vc is TeamTableViewController {
                   
                    for player in (DataSource.sharedInstance.currentPlayingTeam?.players)! {
                        player.uWeight = 0
                        player.gamesPlayed = 0
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
        
        if segue.identifier == "SelecePlayerInPlayingMode" {
            let nav = segue.destination as! UINavigationController
            let vc =  nav.topViewController as! SelectPlayersCollectionViewController
            vc.team = DataSource.sharedInstance.currentPlayingTeam
            vc.isPlayingMode = true
            selectedPlayers.sort { $0.uWeight < $1.uWeight}
            vc.minWeight = selectedPlayers[0].uWeight
        }
        
    }
    
}
