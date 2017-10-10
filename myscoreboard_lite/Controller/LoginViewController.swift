//
//  LoginViewController.swift
//  myscoreboard_lite
//
//  Created by PiHan on 2017/9/18.
//  Copyright © 2017年 PiHan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let email = emailTextField.text!.trim()
        let password = passwordTextField.text!.trim()
        
        let params = ["email" : email,
                  "password" : password]
        Alamofire.request("https://product.myscoreboardapp.com/api/v1/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{response in
            if response.result.isSuccess{
                let player = JSON(response.result.value!)
               
                if let user_id = player["user_id"].int {
                    if let auth_token = player["auth_token"].string{
                        self.getTeamList(user_id, token: auth_token)
                    }
                    
                }
            }else{
                print("error")
            }
        }
    }
    
    func getTeamList(_ userID: Int, token token: String){
        
        let params = ["auth_token" : token,
                      "user_id" : userID] as [String : Any]
        Alamofire.request("https://product.myscoreboardapp.com/api/v1/teams", method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON{response in
            if response.result.isSuccess{
                let data = JSON(response.result.value!)
                
                print("success")
                //print(data)
                for team in data["results"].arrayValue {
                    DataSource.sharedInstance.teams.append(Team(data: team))
                }
                
                self.performSegue(withIdentifier: "GoToTeamsPage", sender: self)
            }else{
                print("error")
            }
        }
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
