//
//  SelectPlayersCollectionViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"


class SelectPlayersCollectionViewController: UICollectionViewController {
    
    var team : Team?
    var selectedPlayers = [Player]()
    var isPlayingMode = false
    var courtCount: Int = 1
    var minWeight = 0
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    @IBOutlet weak var gameStartBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        DataSource.sharedInstance.currentPlayingTeam = team
        selectedPlayers = DataSource.sharedInstance.selectedPlayers
        // Register cell classes
        let nib = UINib(nibName: "PlayerCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "PlayerCollectionViewCell")
 
        // Allouw Multiple Selection
        collectionView?.allowsMultipleSelection = true
        
        // set barbutton title
        if isPlayingMode {
            gameStartBarButton.title = "繼續比賽"
            if minWeight != 0 {
                for player in selectedPlayers{
                    player.uWeight -= minWeight
                }
            }
        }else{
            gameStartBarButton.title = "開始比賽"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isPlayingMode{
            
        }
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
        cell.playerImageView.sd_setShowActivityIndicatorView(true)
        cell.playerImageView.sd_setIndicatorStyle(.gray)
        let imageURL = URL(string: (team?.players[indexPath.row].imageUrl)!)
        DispatchQueue.main.async {
           
            cell.playerImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "user_placeholder"), options: .retryFailed, progress: nil, completed: nil)
        }
        
        
        if isPlayingMode {
            
            if let player = team?.players[indexPath.row] {
                if player.gamesPlayed != 0 {
                    cell.countLabel.text = String(player.gamesPlayed)
                }else {
                    cell.countLabel.text = ""
                }
                if selectedPlayers.contains(player){
                    cell.checkMarkImageView.isHidden = false
                }else{
                    cell.checkMarkImageView.isHidden = true
                }
            }
        }
       
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let player = team?.players[indexPath.row] {
            if selectedPlayers.contains(player){
                collectionView.deselectItem(at: indexPath, animated: false)
                selectedPlayers = selectedPlayers.filter(){$0 != player}
            }else{
                selectedPlayers.append(player)
            }
        }
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
            if selectedPlayers.count < 4 {
                 let alertController = UIAlertController(title: "至少選擇4位選手才能開始比賽", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
            if selectedPlayers.count > 8 {
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
                alertController.addAction(twoCourts)
                alertController.addAction(cancelAction)
                
                if selectedPlayers.count > 12 {
                    alertController.addAction(threeCourts)
                }
                if selectedPlayers.count > 16 {
                    alertController.addAction(fourCourts)
                }
            
                self.present(alertController, animated: true, completion: nil)
                
            }else{
                self.performSegue(withIdentifier: "StartGame", sender: Any?.self)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            let vc = segue.destination as! GameScheduleTableViewController
            vc.courtCount = courtCount
        }
    }
}

extension SelectPlayersCollectionViewController:  UICollectionViewDelegateFlowLayout{
    
   
    
    // item size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0
        if self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact {
            
            width = (self.view.frame.size.width - sectionInsets.left * 5) / 3
            height = width * 1.3
        }
        
        if self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular {
            width = (self.view.frame.size.width - sectionInsets.left * 7) / 5
            height = width * 1.1
        }
        
        return CGSize(width: width , height: height)
    }
    
    //insetForSection
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    //min line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}
