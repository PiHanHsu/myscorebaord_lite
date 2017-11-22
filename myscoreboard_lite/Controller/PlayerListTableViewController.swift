//
//  PlayerListTableViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/11/21.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

class PlayerListTableViewController: UITableViewController {
    
    var playerList : Array<Player>{
        get {
            return DataSource.sharedInstance.playerBasket
        }
    }
    
    var nextGamePlayers : Array<Player>{
        get {
            return DataSource.sharedInstance.nextGamePlayers
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //nextGamePlayers = DataSource.sharedInstance.nextGamePlayers
        //playerList = DataSource.sharedInstance.playerBasket
        
        // set notivication center
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateData(notification:)), name: .updateData, object: nil)
        
        //set table viewfoot view
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateData(notification: NSNotification) {
        //playerList = DataSource.sharedInstance.playerBasket
        //nextGamePlayers = DataSource.sharedInstance.nextGamePlayers
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if nextGamePlayers.count > 0 {
            return 2
        }else{
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nextGamePlayers.count > 0 {
            switch section {
            case 0 :
                return 4
            case 1:
                return playerList.count
            default:
                return 0
            }
        }else{
            return playerList.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if nextGamePlayers.count > 0 {
            switch section{
            case 0 :
                return "下一場球員"
            case 1:
                return "未上場球員"
            default:
                return ""
            }
        }else{
            return "未上場球員"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerListTableViewCell", for: indexPath) as! PlayerListTableViewCell
        if nextGamePlayers.count > 0 {
            switch indexPath.section {
            case 0:
                let name = nextGamePlayers[indexPath.row].name
                let gameCount = nextGamePlayers[indexPath.row].gamesPlayed
                cell.playerLabel.text = "\(name) - \(gameCount)"
            case 1:
                let name = playerList[indexPath.row].name
                let gameCount = playerList[indexPath.row].gamesPlayed
                cell.playerLabel.text = "\(name) - \(gameCount)"
            default:
                break
            }
        }else{
            let name = playerList[indexPath.row].name
            let gameCount = playerList[indexPath.row].gamesPlayed
            cell.playerLabel.text = "\(name) - \(gameCount)"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
