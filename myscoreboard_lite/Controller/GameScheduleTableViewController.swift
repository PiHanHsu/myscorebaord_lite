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
        createGamePlayList()
        // Register cell classes
        let nib = UINib(nibName: "GameScheduleTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "GameScheduleTableViewCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    var playerBasket = [Player]()
    var gameByCourt = [[Player]]()
    
    func createGamePlayList(){
        selectedPlayers = selectedPlayers.shuffle()
        for _ in 1...courtcount {
            let playersInOneGame = Array(selectedPlayers[0...3])
            gameByCourt.append(playersInOneGame)
            selectedPlayers = Array(selectedPlayers.dropFirst(4))
        }
        
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
