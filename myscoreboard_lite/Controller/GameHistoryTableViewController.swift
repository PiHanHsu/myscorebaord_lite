//
//  GameHistoryTableViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/13.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class GameHistoryTableViewController: UITableViewController {
    
    var gameHistory = [[Player]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
       
        // Register cell classes
        let nib = UINib(nibName: "GameScheduleTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "GameScheduleTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gameHistory.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameScheduleTableViewCell", for: indexPath) as! GameScheduleTableViewCell
        
        cell.player1Label.text = gameHistory[indexPath.row][0].name
        cell.player2Label.text = gameHistory[indexPath.row][1].name
        cell.player3Label.text = gameHistory[indexPath.row][2].name
        cell.player4Label.text = gameHistory[indexPath.row][3].name
        cell.finishButton.isHidden = true
        cell.courtNumLabel.text = ""
        if cell.player1Label.text == "" {
            print("error")
            print("game match: \(gameHistory[indexPath.row])" )
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayGamesCount" {
            let nav = segue.destination as! UINavigationController
            let vc =  nav.topViewController as! SelectPlayersCollectionViewController
            vc.team = DataSource.sharedInstance.currentPlayingTeam
            vc.isPlayingMode = true
        }
    }
    

}
