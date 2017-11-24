//
//  GameScheduleTableViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class GameScheduleTableViewController: UITableViewController {
 
    var selectedPlayers : Array<Player> {
        get{
            return DataSource.sharedInstance.selectedPlayers
        }
    }
    var playerBasket : Array<Player> {
        get{
            return DataSource.sharedInstance.playerBasket
        }
    }
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
       
        if isFirstTimeEnter {
            DataSource.sharedInstance.createGamePlayList()
            isFirstTimeEnter = false
        }
     }
    
    @objc func updateData(notification: NSNotification) {
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return courtCount
        case 1:
            return DataSource.sharedInstance.gameHistory.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120.0
        case 1:
            return 100.0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "正在進行比賽"
        case 1:
            return "歷史比賽紀錄"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameScheduleTableViewCell", for: indexPath) as! GameScheduleTableViewCell
            
            cell.player1Label.text = gameByCourt[indexPath.row][0].name
            cell.player2Label.text = gameByCourt[indexPath.row][1].name
            cell.player3Label.text = gameByCourt[indexPath.row][2].name
            cell.player4Label.text = gameByCourt[indexPath.row][3].name
            
            cell.courtNumLabel.text = "Court \(indexPath.row + 1)"
            cell.finishButton.isHidden = false
            cell.finishButton.tag = indexPath.row
            cell.finishButton.addTarget(self, action: #selector(gameFinished(sender:)), for: .touchUpInside)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameScheduleTableViewCell", for: indexPath) as! GameScheduleTableViewCell
            
            cell.player1Label.text = gameHistory[indexPath.row][0].name
            cell.player2Label.text = gameHistory[indexPath.row][1].name
            cell.player3Label.text = gameHistory[indexPath.row][2].name
            cell.player4Label.text = gameHistory[indexPath.row][3].name
            cell.finishButton.isHidden = true
            cell.courtNumLabel.text = "Game \(indexPath.row + 1)"
            
            return cell
        default:
            return UITableViewCell()
        }
    }
  
    @objc func gameFinished(sender: UIButton){
        let alert = UIAlertController(title: "結束本場比賽？", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { a in
            let index = sender.tag
            DataSource.sharedInstance.createNextGame(finshedIndex: index)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameHistory" {
            let vc =  segue.destination as! GameHistoryTableViewController
            vc.gameHistory = gameHistory
        }

    }
    
}
