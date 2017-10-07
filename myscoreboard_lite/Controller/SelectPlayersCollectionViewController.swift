//
//  SelectPlayersCollectionViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"


class SelectPlayersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var team : Team?
    var selectedPlayers = [Player]()
    var isPlayingMode = false
    var courtCount: Int = 1

    @IBOutlet weak var gameStartBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        DataSource.sharedInstance.currentPlayingTeam = team
        // Register cell classes
        let nib = UINib(nibName: "PlayerCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "PlayerCollectionViewCell")
 
        // Allouw Multiple Selection
        collectionView?.allowsMultipleSelection = true
        
        // set barbutton title
        if isPlayingMode {
            gameStartBarButton.title = "Continue"
        }else{
            gameStartBarButton.title = "Start Game"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isPlayingMode{
            return DataSource.sharedInstance.selectedPlayers.count
        }else{
             return (team?.players.count)!
        }
       
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as! PlayerCollectionViewCell
        
        if isPlayingMode {
             selectedPlayers = DataSource.sharedInstance.selectedPlayers
            cell.isSelected = false
            cell.playerNameLabel.text = selectedPlayers[indexPath.row].name
            cell.countLabel.text = String(describing: (selectedPlayers[indexPath.row].uWeight))
        }else{
             cell.playerNameLabel.text = team?.players[indexPath.row].name
        }
       
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let player = team?.players[indexPath.row]
         selectedPlayers.append(player!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         print("deselect")
        let player = team?.players[indexPath.row]
        selectedPlayers = selectedPlayers.filter(){$0 != player!}
    }

    
    @IBAction func startGameBarButtonPressed(_ sender: UIBarButtonItem) {
        DataSource.sharedInstance.selectedPlayers = self.selectedPlayers
        
        if isPlayingMode {
            self.dismiss(animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "請選擇場地數", message: nil, preferredStyle: .alert)
            let oneCourt = UIAlertAction(title: "1", style: .default, handler: {_ in
                self.courtCount = 1
                self.performSegue(withIdentifier: "StartGame", sender: Any?.self)
            })
            let twoCourts = UIAlertAction(title: "2", style: .default, handler: {_ in
                self.courtCount = 2
                self.performSegue(withIdentifier: "StartGame", sender: Any?.self)
            })
            let threeCourts = UIAlertAction(title: "3", style: .default, handler: {_ in
                self.courtCount = 3
                self.performSegue(withIdentifier: "StartGame", sender: Any?.self)
            })
            let fourCourts = UIAlertAction(title: "4", style: .default, handler: {_ in
                self.courtCount = 4
                self.performSegue(withIdentifier: "StartGame", sender: Any?.self)
            })
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            alertController.addAction(oneCourt)
            if selectedPlayers.count >= 8 {
                alertController.addAction(twoCourts)
            }
            if selectedPlayers.count >= 12 {
                alertController.addAction(threeCourts)
            }
            if selectedPlayers.count >= 16 {
                  alertController.addAction(fourCourts)
            }
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            let vc = segue.destination as! GameScheduleTableViewController
            vc.courtCount = courtCount
        }
    }
    
}
