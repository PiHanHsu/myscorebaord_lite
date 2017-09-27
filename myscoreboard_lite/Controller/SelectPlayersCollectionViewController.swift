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
        return (team?.players.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as! PlayerCollectionViewCell
        cell.playerNameLabel.text = team?.players[indexPath.row].name
        if isPlayingMode{
            selectedPlayers = DataSource.sharedInstance.selectedPlayers
            if selectedPlayers.contains((team?.players[indexPath.row])!){
            }else{
                cell.isSelected = false
            }
            if team?.players[indexPath.row].uWeight != 0 {
                cell.countLabel.text = String(describing: (team?.players[indexPath.row].uWeight)!)
            }
        }
       
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
         let player = team?.players[indexPath.row]
         selectedPlayers.append(player!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let player = team?.players[indexPath.row]
        selectedPlayers = selectedPlayers.filter(){$0 != player!}
    }

    
    @IBAction func startGameBarButtonPressed(_ sender: UIBarButtonItem) {
        DataSource.sharedInstance.selectedPlayers = self.selectedPlayers
        
        if isPlayingMode {
            self.dismiss(animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "StartGame", sender: Any?.self)
        }
    }
    
}
