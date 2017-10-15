//
//  TeamViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/10/16.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit
import SDWebImage

class TeamViewController: UIViewController {

    @IBOutlet weak var teamImageButton: UIButton!
    
    @IBOutlet weak var teamNameTextField: UITextField!
    
    var team : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = URL(string: (team?.teamImageUrl)!)
        teamImageButton.sd_setBackgroundImage(with: imageUrl, for: .normal, placeholderImage: UIImage(named: "user_placeholder"), options: .continueInBackground, completed: nil)
        
        teamNameTextField.text = team?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
