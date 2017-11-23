//
//  GameScheduleViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/11/21.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class GameScheduleViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    DataSource.sharedInstance.nextGamePlayers = [Player]()
                    DataSource.sharedInstance.playerBasket = [Player]()
                    DataSource.sharedInstance.gameByCourt = [[Player]]()
                    DataSource.sharedInstance.gameHistory = [[Player]]()
                    
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelecePlayerInPlayingMode" {
            let nav = segue.destination as! UINavigationController
            let vc =  nav.topViewController as! SelectPlayersCollectionViewController
            vc.team = DataSource.sharedInstance.currentPlayingTeam
            vc.isPlayingMode = true
            DataSource.sharedInstance.selectedPlayers.sort { $0.uWeight < $1.uWeight}
            vc.minWeight = DataSource.sharedInstance.selectedPlayers[0].uWeight
        }
       
    }
    

}
