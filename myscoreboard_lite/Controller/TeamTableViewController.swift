//
//  TeamTableViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class TeamTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
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
        return DataSource.sharedInstance.teams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell
        let teams = DataSource.sharedInstance.teams
        let imageURL = URL(string: teams[indexPath.row].teamImageUrl)
        
        cell.nameLabel.text = teams[indexPath.row].name
        cell.memberCountLabel.text = "球隊人數： \(teams[indexPath.row].players.count)"
        cell.teamImageView.sd_setShowActivityIndicatorView(true)
        cell.teamImageView.sd_setIndicatorStyle(.gray)
        cell.teamImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "user_placeholder"), options: .continueInBackground, completed: nil)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DataSource.sharedInstance.currentPlayingTeamIndex = indexPath.row
        performSegue(withIdentifier: "SelectPlayers", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    @IBAction func logout(_ sender: Any) {
        let params = ["auth_token" : DataSource.sharedInstance.auth_token]
        
        Alamofire.request("https://product.myscoreboardapp.com/api/v1/logout", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON{response in
            if response.result.isSuccess{
                DataSource.sharedInstance = DataSource()
                self.navigationController?.popViewController(animated: true)
                
            }else{
                print("can't logout")
            }
        }
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectPlayers" {
            let vc = segue.destination as! SelectPlayersCollectionViewController
            let index = DataSource.sharedInstance.currentPlayingTeamIndex
            vc.team = DataSource.sharedInstance.teams[index]
        }
        if segue.identifier == "GoToTeamViewController" {
            let nav = segue.destination as! UINavigationController
            let vc =  nav.topViewController as! TeamViewController
            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPath(for: cell){
                    print(indexPath.row)
                    vc.team = DataSource.sharedInstance.teams[indexPath.row]
                }
            }
        }
    }
    

}
